library IEEE;
use IEEE.std_logic_1164.all;

-- Declaración de entidad
entity cont_top is

	port(

		clk_in:		in std_logic;
		rst_in: 	in std_logic;
		rxd_rdy_in:	in std_logic;
		rxd_in: 	in std_logic_vector(7 downto 0);

		data_o: 	out std_logic_vector(7 downto 0)
	);
end;
	
-- Cuerpo de arquitectura
architecture cont_top_arq of cont_top is

begin
	-- Parte descriptiva
	cont_ctl_inst: entity work.cont_ctl
		port map(
			clk_ctl			=> clk_pin,	-- Entrada de Clock
			rst_ctl_i		=> ,		-- Entrada de reset - sincronizado con el clock
			rx_data_rdy_i	=> ,		-- Entrada de dato listo para leer
			rx_data_i 		=> ,		-- Dato de entrada 8 bits
			
			ena_ctl 		=> ena_aux,	-- Salida habilitador contador
			rst_ctl_o		=> ,		-- Salida reset del contador
			ld_ctl			=> ,		-- Salida señal para cargar offset el contador
			up_ctl			=> ,		-- Salida sentido de cuenta - 1 ascendente, 0 descendente	
			strobe_ctl		=> ,		-- Salida señal para cargar velocidad de cuenta
			val_config_o	=> 			-- defino valor offset del contador
		);
	);
	
	genEna_inst: entity work.genEna
		port map(
			clk_ena			=> clk_pin,	-- Entrada de Clock
			strobe			=> ,		-- Entrada señal para tomar configuración
			ena			=> ,			-- Entrada habilitador de pulsos de salida
			vel 		=> ,			-- Entrada palabra 8 bits de configuración
			
			ena_gen 			=> 		-- Salida pulso enable
		);
	);
		
	cont8b_inst: entity work.cont8b
		port map(
			clk_cont			=> clk_pin,	-- Entrada de Clock
			rst_cont			=> ,	-- Entarada de reset
			ena_cont			=> ,	-- Entrada habilitador conteo
			up_cont	 		=> ,	-- Entrada selector de sentido de cuenta
			ld_cont 			=> ,	-- Entrada señal para tomar configuración del offset
			value_i			=> ,	-- Entrada palabra 8 bits de configuración del offset
			
			word_o				=> 	-- Salida palabra 8 bits 
		);
	);

end;




