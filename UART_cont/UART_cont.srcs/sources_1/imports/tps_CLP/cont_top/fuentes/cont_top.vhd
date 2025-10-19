-------------------------------------------------------------------------------
--  Project    : Contador controlado por UART
--  Module     : cont_top.vhd
--  Components : cont_ctl.vhdl and genEna.vhdl and cont8b.vhdl
--	Autor      : Mariano Deville
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaración de entidad
entity cont_top is

	port(
		clk_in:		in std_logic;						-- Entrada de Clock
		rst_in: 	in std_logic;						-- Entrada de reset - sincronizado con el clock
		rxd_rdy_in:	in std_logic;						-- Entrada de dato listo para leer
		rxd_in: 	in std_logic_vector(7 downto 0);	-- Comando de entrada 8 bits

		data_o: 	out std_logic_vector(7 downto 0)	-- Salida del contador, palabra de salida 8 bits
	);
end;
	
-- Cuerpo de arquitectura
architecture cont_top_arq of cont_top is
	-- Señales internas
	signal ena_ctl:		std_logic;
	signal reset:		std_logic;
	signal load:		std_logic;
	signal up:			std_logic;
	signal strobe:		std_logic;
	signal ena_gen:		std_logic;
	signal word_config:	std_logic_vector(7 downto 0);

	
begin
	-- Parte descriptiva
	cont_ctl_inst: entity work.cont_ctl
		port map(
			clk_ctl			=> clk_in,		-- Entrada de Clock
			rst_ctl_i		=> rst_in,		-- Entrada de reset - sincronizado con el clock
			rx_data_rdy_i	=> rxd_rdy_in,	-- Entrada de dato listo para leer
			rx_data_i 		=> rxd_in,		-- Dato de entrada 8 bits
			
			ena_ctl 		=> ena_ctl,		-- Salida habilitador contador
			rst_ctl_o		=> reset,		-- Salida reset del contador
			ld_ctl			=> load,		-- Salida señal para cargar offset el contador
			up_ctl			=> up,			-- Salida sentido de cuenta - 1 ascendente, 0 descendente	
			strobe_ctl		=> strobe,		-- Salida señal para cargar velocidad de cuenta
			val_config_o	=> word_config	-- defino valor offset del contador
		);

	
	genEna_inst: entity work.genEna
		port map(
			clk_ena			=> clk_in,		-- Entrada de Clock
			strobe			=> strobe,		-- Entrada señal para tomar configuración
			ena				=> ena_ctl,		-- Entrada habilitador de pulsos de salida
			vel 			=> word_config,	-- Entrada palabra 8 bits de configuración
			
			ena_gen 		=> ena_gen		-- Salida pulso enable
		);

		
	cont8b_inst: entity work.cont8b
		port map(
			clk_cont		=> clk_in,		-- Entrada de Clock
			rst_cont		=> reset,		-- Entarada de reset
			ena_cont		=> ena_gen,		-- Entrada habilitador conteo
			up_cont	 		=> up,			-- Entrada selector de sentido de cuenta
			ld_cont 		=> load,		-- Entrada señal para tomar configuración del offset
			value_i			=> word_config,	-- Entrada palabra 8 bits de configuración del offset
			
			word_o			=> 	data_o		-- Salida palabra 8 bits 
		);
end;




