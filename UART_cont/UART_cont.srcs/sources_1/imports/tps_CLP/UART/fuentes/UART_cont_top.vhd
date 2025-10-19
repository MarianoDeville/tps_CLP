-------------------------------------------------------------------------------
--  Project    : Contador controlado por UART
--  Module     : UART_cont_top.vhd
--  Components : UART_cont.vhdl
--	Autor      : Mariano Deville
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaración de entidad
entity UART_cont_top is

	port(
		clk_pin:		in std_logic;						-- Entrada de Clock
		rst_pin: 		in std_logic;						-- Entrada de reset
		rxd_pin: 		in std_logic;						-- Entrada RS232 RXD TTL

		txd_pin:		out std_logic;						-- Salida, RS232 TXD TTL
		led_pins: 		out std_logic_vector(7 downto 0)	-- Salida del contador, palabra de salida 8 bits
	);
end;
	
-- Cuerpo de arquitectura
architecture UART_cont_top_arq of UART_cont_top is

begin
	-- Parte descriptiva

	UART_cont_inst: entity work.UART_cont
		generic map(
			BAUD_RATE	=> 115200,
			CLOCK_RATE	=> 125E6
		)
		port map(
			clk_in		=> clk_pin,				-- Entrada de Clock
			rst_in		=> rst_pin,				-- Entrada de Clock
			rxd_in		=> rxd_pin,				-- Entrada RS232 RXD TTL

			led_pins	=> led_pins				-- Salida del contador, palabra de salida 8 bits
		);
		
	txd_pin 			<= rxd_pin;
end;


