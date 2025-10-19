library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity cont8b_tb is
end;

-- Cuerpo de arquitectura
architecture cont8b_tb_arq of cont8b_tb is
	-- Parte declarativa
	
	signal clk_tb:		std_logic := '0';
	signal rst_tb:		std_logic := '1';
	signal ena_tb:		std_logic := '1';
	signal up_tb:		std_logic := '1';
	signal ld_tb:		std_logic := '0';
	signal value_tb:	std_logic_vector(7 downto 0) := (others => '0');
	
	signal q_tb:		std_logic_vector(7 downto 0);
	
begin
	-- Parte descriptiva
	clk_tb   <= not clk_tb after 1 ns;
	
	up_tb    <= '0' after 30 ns;
	rst_tb   <= '0' after 6 ns, '1' after 16 ns, '0' after 20 ns;
	
	value_tb <= x"0a" after 10 ns;
	ld_tb    <= '1' after 12 ns, '0' after 14 ns;
	
	cont8b_inst: entity work.cont8b

		port map(
			clk_cont	=> clk_tb,
			rst_cont	=> rst_tb,
			ena_cont	=> ena_tb,
			up_cont		=> up_tb,
			ld_cont		=> ld_tb,
			value_i 	=> value_tb,
			word_o		=> q_tb
		);
end;
