library IEEE;
use IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;

-- Declaracion de entidad
entity cont8b is

	port(
		clk_cont: in std_logic;						-- Entrada de Clock
		rst_cont: in std_logic;						-- Entarada de reset
		ena_cont: in std_logic;						-- Entrada habilitador conteo
		up_cont:  in std_logic;						-- Entrada selector de sentido de cuenta
		ld_cont:  in std_logic;						-- Entrada señal para tomar configuración del offset
		value_i:  in std_logic_vector(7 downto 0);	-- Entrada palabra 8 bits de configuración del offset
		
		word_o:   out std_logic_vector(7 downto 0)	-- Salida palabra 8 bits 
	);
end;

-- Cuerpo de arquitectura
architecture cont8b_arq of cont8b is
	-- Parte declarativa
	signal estadoActual    : unsigned(7 downto 0) := (others => '0');
	signal estadoSiguiente : unsigned(7 downto 0) := (others => '0');
	signal preset          : unsigned(7 downto 0) := (others => '1');
	
begin
	-- Parte descriptiva
	--Registro de estado
	reg: process(clk_cont)
	begin
		if rising_edge(clk_cont) then
			if rst_cont = '1' then
				estadoActual <= (others => '0');
			else
				estadoActual <= estadoSiguiente;
			end if;
		end if;
	end process;
	
-- Lógica de próximo estado
	process(estadoActual, rst_cont, ena_cont, up_cont, up_cont, value_i, preset)
	
	begin
	
		if rst_cont = '1' then
			estadoSiguiente <= (others => '0');
		elsif up_cont = '1' then
			preset <= unsigned(value_i);
			estadoSiguiente <= unsigned(value_i);
		elsif ena_cont = '1' then
			if up_cont = '1' then

				if estadoActual = preset then
					estadoSiguiente <= (others => '0'); -- vuelve a cero
				else
					estadoSiguiente <= estadoActual + 1;
				end if;
			else

				if estadoActual = 0 then
					estadoSiguiente <= preset; -- vuelve al valor seteado
				else
					estadoSiguiente <= estadoActual - 1;
				end if;
			end if;
		else

			estadoSiguiente <= estadoActual;
		end if;
	end process;

	word_o <= std_logic_vector(estadoActual);

end;


