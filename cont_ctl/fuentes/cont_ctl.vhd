library IEEE;
use IEEE.std_logic_1164.all;

-- Declaración de entidad
entity cont_ctl is
	port(
		clk_ctl:		in std_logic;						-- Entrada de Clock
		rst_ctl_i:		in std_logic;						-- Entrada de reset - sincronizado con el clock
		rx_data_rdy_i:	in std_logic;						-- Entrada de dato listo para leer
		rx_data_i:		in std_logic_vector(7 downto 0);	-- Dato de entrada 8 bits

		ena_ctl:		out std_logic := '0';				-- Salida habilitador contador
		rst_ctl_o:		out std_logic := '0';				-- Salida reset del contador
		ld_ctl:			out std_logic := '0';				-- Salida señal para cargar offset el contador
		up_ctl:			out std_logic := '1';				-- Salida sentido de cuenta - 1 ascendente, 0 descendente	
		strobe_ctl:		out std_logic := '0';				-- Salida señal para cargar velocidad de cuenta
		val_config_o:	out std_logic_vector(7 downto 0)	-- Palabra de salida 8 bits con el valor offset del contador ó velocidad de cuenta
	);
end;

-- Cuerpo de arquitectura
architecture cont_ctl_arq of cont_ctl is

	type state_t is (IDLE, WAIT_PARAM, RESET);
	signal state, next_state : state_t := IDLE;

	signal contador: 		integer range 0 to 15 := 0;
	
	signal old_rx_data_rdy: std_logic := '0';
	signal char_data:		std_logic_vector(7 downto 0) := (others => '0');
	signal char_cmd:		std_logic_vector(7 downto 0) := (others => '0');
	
	signal rst_aux:			std_logic := '0';
	signal rst_next:		std_logic := '0';
	signal strb_vel_aux:	std_logic := '0';
	signal ld_aux:			std_logic := '0';
	signal strb_vel_next:	std_logic := '0';
	signal ld_next:			std_logic := '0';
	signal run_temp:		std_logic := '0';
	
begin

	char_recep: process(clk_ctl)
	begin
		if rising_edge(clk_ctl) then
		
			if run_temp = '1' then
				contador <= contador + 1;
			else
				contador <= 0;
			end if;
			
			if rst_ctl_i = '1' then
				state			<= RESET;
				rst_aux       	<= '1';
				ld_aux			<= '0';
				strb_vel_aux	<= '0';
				old_rx_data_rdy <= '0';
				char_data		<= (others => '0');
				char_cmd		<= (others => '0');
			else
				state			<= next_state;
				-- Capture the value of rx_data_rdy for edge detection
				old_rx_data_rdy <= rx_data_rdy_i;
				-- If rising edge of rx_data_rdy_i, capture rx_data
				if (rx_data_rdy_i = '1' and old_rx_data_rdy = '0') then
					char_data		<= rx_data_i;	
					
					if rx_data_i = x"56" or rx_data_i = x"4f" then
						char_cmd	<= rx_data_i;
					end if;
					
					if strb_vel_next = '1' then
						strb_vel_aux <= '1';
					else
						strb_vel_aux <= '0';
					end if;		
									
					if ld_next = '1' then
						ld_aux		<= '1';
					else
						ld_aux		<= '0';
					end if;
					
				end if;

				if rst_next = '1' then
					rst_aux		<= '1';
				else
					rst_aux		<= '0';
				end if;				

			end if;	-- if !rst
		end if; -- if rising_edge
	end process;
	
	process(state, char_data, char_cmd, rst_aux, contador)
	begin

		next_state		<= state;
		ena_ctl			<= '0';
	
		case state is

			when IDLE =>

				if contador >= 3 then
					strb_vel_next	<= '0';
					ld_next			<= '0';
				end if;
				
				if strb_vel_next = '1' or ld_next = '1' then
					run_temp 		<= '1';
				else
					run_temp 		<= '0';
				end if;
				
				case char_data is
					when x"43" =>				-- 'C' Comenzar
						ena_ctl		<= '1';
						rst_next	<= '0';
						next_state	<= IDLE;

					when x"50" =>				-- 'P' Parar
						ena_ctl		<= '0';
						next_state	<= IDLE;

					when x"41" =>				-- 'A' Ascendente
						ena_ctl		<= '0';
						up_ctl		<= '1';
						next_state	<= IDLE;

					when x"44" =>				-- 'D' Descendente
						ena_ctl		<= '0';
						up_ctl		<= '0';
						next_state	<= IDLE;

					when x"52" =>				-- 'R' Reset
						next_state	<= RESET;

					when x"56" | x"4F" =>		-- 'V' o 'O' Configuración de la volocidad ó del offset
						if strb_vel_next = '0' and ld_next = '0' then
							ena_ctl		<= '0';
							next_state	<= WAIT_PARAM;
						end if;
						
					when others =>
						next_state		<= IDLE;
				end case;

			when WAIT_PARAM =>

				if char_cmd = x"56" then      	-- 'V' Espero parámetro de velocidad
					strb_vel_next	<= '1';
				elsif char_cmd = x"4F" then   	-- 'O' Espero parámetro de offset
					ld_next	<= '1';
				end if;

				next_state	<= IDLE;

			when RESET =>
			
				ena_ctl		<= '0';
				up_ctl		<= '1';
				rst_next	<= '1';
				next_state	<= IDLE;

			when others =>
				next_state	<= IDLE;
		end case;
	end process;
	
	val_config_o	<= rx_data_i;
	ld_ctl			<= ld_aux;
	strobe_ctl		<= strb_vel_aux;
	rst_ctl_o		<= rst_aux;
end;

