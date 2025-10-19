library IEEE;
use IEEE.std_logic_1164.all;

entity cont_ctl_tb is
end;

-- Cuerpo de arquitectura
architecture cont_ctl_tb_arq of cont_ctl_tb is
	-- Parte declarativa

	signal clk_tb: std_logic := '0';
	signal rst_tb: std_logic := '1';
	signal data_rdy_tb: std_logic := '0';
	signal char_data_tb: std_logic_vector(7 downto 0) := (others => '0');

	signal data_o_tb: std_logic_vector(7 downto 0);

begin
	-- Parte descriptiva
	clk_tb <= not clk_tb after 1 ns;
	rst_tb <= '0' after 2 ns;

	char_data_tb <= x"4f" after 4 ns,					-- Seteo offset
					x"0a" after 10 ns,					-- Valor del offset
					x"43" after 20 ns,					-- Arranco contador
					x"44" after 70 ns,					-- seteo cuenta descendente
					x"50" after 100 ns;					-- Parar
					
--	char_data_tb <= x"56" after 4 ns,					-- Seteo velocidad de cuenta
--					x"15" after 10 ns,					-- Valor de la velocidad
--					x"4f" after 20 ns,					-- Seteo offset
--					x"0a" after 70 ns,					-- Valor del offset
--					x"43" after 100 ns;					-- Arranco contador
					
	data_rdy_tb  <= '1' after 4 ns, '0' after 6 ns,		-- Strobe offset
					'1' after 10 ns, '0' after 12 ns,	-- Strobe Valor offset
					'1' after 20 ns, '0' after 22 ns,	-- Strobe arranque
					'1' after 70 ns, '0' after 72 ns,	-- Strobe descendente
					'1' after 100 ns, '0' after 102 ns;	-- Strobe parar
	
	cont_top_inst: entity work.cont_top

		port map(
			clk_in 		=> clk_tb,
			rst_in 		=> rst_tb,
			rxd_rdy_in	=> data_rdy_tb,
			rxd_in 		=> char_data_tb,

			data_o 		=> data_o_tb
		);
end;



