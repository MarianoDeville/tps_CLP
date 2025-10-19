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

		txd_pin:		out std_logic						-- Salida, RS232 TXD TTL
	);
end;
	
-- Cuerpo de arquitectura
architecture UART_cont_top_VIO_arq of UART_cont_top_VIO is

    signal probe_rst: std_logic;
    signal probe_leds: std_logic_vector(7 downto 0);
    
    COMPONENT vio
    PORT (
        clk : IN STD_LOGIC;
        probe_in0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
    );
    END COMPONENT;

begin
	-- Parte descriptiva

	U0: entity work.UART_cont_top
		port map(
			clk_pin		=> clk_pin,
			rst_pin	    => probe_rst,
			rxd_pin		=> rxd_pin,

			txd_pin		=> txd_pin,
			led_pins	=> probe_leds
		);
		
    vio_inst : vio
        PORT MAP (
            clk           => clk_pin,
            probe_in0     => probe_leds,
            probe_out0(0) => probe_rst
        );
end;


