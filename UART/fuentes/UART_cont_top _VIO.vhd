-------------------------------------------------------------------------------
--  Project    : Contador controlado por UART
--  Module     : UART_cont_top.vhd
--  Components : UART_cont.vhdl
--	Autor      : Mariano Deville
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaración de entidad
entity UART_cont_top_VIO is

	port(
		clk_pin:		in std_logic;						-- Entrada de Clock
		rxd_pin: 		in std_logic;						-- Entrada RS232 RXD TTL

		txd_pin:		out std_logic;						-- Salida, RS232 TXD TTL
	);
end;
	
-- Cuerpo de arquitectura
architecture UART_cont_top_VIO_arq of UART_cont_top_VIO is

begin
	-- Parte descriptiva

	UART_cont_inst: entity work.UART_cont
		port map(
			clk_pin		=> clk_pin,
			rst_pin		=> probe_rst,
			rxd_pin		=> rxd_pin,

			txd_pin		=> txd_pin,
			led_pins	=> probe_leds
		);
end;


