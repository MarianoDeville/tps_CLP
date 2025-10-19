-------------------------------------------------------------------------------
--  Project    : Contador controlado por UART
--  Module     : UART_cont.vhd
--  Components : uart_rx.vhdl and cont_top.vhdl and meta_harden.vhdl
--	Autor      : Mariano Deville
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaración de entidad
entity UART_cont is

	generic(
		BAUD_RATE:		integer := 115200;   
		CLOCK_RATE:		integer := 125E6
	);
	port(
		clk_in:			in std_logic;						-- Entrada de Clock
		rst_in: 		in std_logic;						-- Entrada de reset - sincronizado con el clock
		rxd_in: 		in std_logic;						-- Entrada RS232 RXD TTL

		led_pins: 		out std_logic_vector(7 downto 0)	-- Salida del contador, palabra de salida 8 bits
	);
end;
	
-- Cuerpo de arquitectura
architecture UART_cont_arq of UART_cont is
	-- Señales internas
	signal rst_aux:			std_logic;
	signal rx_data_rdy_aux:	std_logic;
	signal rx_data_aux: 	std_logic_vector(7 downto 0);
	
begin
	-- Parte descriptiva
	cont_top_inst: entity work.cont_top
		port map(
			clk_in		=> clk_in,				-- Entrada de Clock
			rst_in		=> rst_aux,				-- Entrada de reset - sincronizado con el clock
			rxd_rdy_in	=> rx_data_rdy_aux,		-- Entrada de dato listo para leer
			rxd_in 		=> rx_data_aux,			-- Comando de entrada 8 bits
			
			data_o 		=> led_pins				-- Salida del contador, palabra de salida 8 bits
		);

	uart_rx_inst: entity work.uart_rx
		generic map(
			BAUD_RATE	=> BAUD_RATE,
			CLOCK_RATE	=> CLOCK_RATE
		)
		port map(
			clk_rx		=> clk_in,				-- Clock input
			rst_clk_rx	=> rst_aux,				-- Active HIGH reset - synchronous to clk_rx
			rxd_i		=> rxd_in,				-- RS232 RXD pin - Directly from pad

			rxd_clk_rx 	=> open,				-- RXD pin after synchronization to clk_rx
			rx_data 	=> rx_data_aux,			-- 8 bit data output
			rx_data_rdy => rx_data_rdy_aux,		-- Ready signal for rx_data
			frm_err 	=> open					-- The STOP bit was not detected	
		);

	meta_harden_inst: entity work.meta_harden
		port map(
			clk_dst		=> clk_in,				-- Destination clock
			rst_dst		=> '0',					-- Reset - synchronous to destination clock
			signal_src	=> rst_in,				-- Asynchronous signal to be synchronized
			
			signal_dst	=> rst_aux				-- Synchronized signal	
		);

end;



