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

	signal ena_tb: std_logic;
	signal rst_cont_tb: std_logic;
	signal ld_tb: std_logic;
	signal up_tb: std_logic;
	signal strb_vel_tb: std_logic;
	signal val_config_tb: std_logic_vector(7 downto 0);

begin
	-- Parte descriptiva
	clk_tb <= not clk_tb after 1 ns;
	rst_tb <= '0' after 2 ns;
	--char_data_tb <= x"56" after 4 ns, x"10" after 10 ns, x"43" after 20 ns;
	char_data_tb <= x"44" after 4 ns, x"43" after 10 ns, x"50" after 20 ns;
	data_rdy_tb <= '1' after 4 ns, '0' after 6 ns, '1' after 10 ns, '0' after 12 ns, '1' after 20 ns, '0' after 22 ns;
	
	cont_ctl_inst: entity work.cont_ctl

		port map(
			clk_i 			=> clk_tb,
			rst_i 			=> rst_tb,
			rx_data_rdy_i	=> data_rdy_tb,
			rx_data_i 		=> char_data_tb,

			ena_o 			=> ena_tb,
			rst_o 			=> rst_cont_tb,
			ld_o 			=> ld_tb,
			up_o 			=> up_tb,
			strb_vel_o 		=> strb_vel_tb,
			val_config_o	=> val_config_tb
		);
end;



