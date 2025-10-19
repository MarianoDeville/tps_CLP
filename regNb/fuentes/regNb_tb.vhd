library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity regNb_tb is
	generic(
		N: natural := 4
	);
end;

-- Cuerpo de arquitectura
architecture regNb_tb_arq of regNb_tb is
	-- Parte declarativa
	signal clk_tb: std_logic := '0';
	signal rst_tb: std_logic := '0';
	signal ena_tb: std_logic := '1';
	signal d_tb: std_logic_vector(N-1 downto 0) := "0000";
	signal q_tb: std_logic_vector(N-1 downto 0);
	
begin
	-- Parte descriptiva
	clk_tb <= not clk_tb after 10 ns;
	d_tb <= "0011" after 60 ns, "1100" after 100 ns, "1001" after 145 ns;
	ena_tb <= '0' after 105 ns, '1' after 129 ns;
	--rst_tb <= '1' after 150 ns;
	regNb_inst: entity work.regNb
		port map(
			clk_i => clk_tb,
			rst_i => rst_tb,
			ena_i => ena_tb,
			d_i   => d_tb,
			q_o   => q_tb
		);
end;
