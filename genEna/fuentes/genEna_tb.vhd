library IEEE;
use 	IEEE.std_logic_1164.all;

-- Declaración de entidad
entity genEna_tb is
end;

-- Cuerpo de arquitectura
architecture genEna_tb_arq of genEna_tb is
	-- Parte declarativa
	
	signal clk_tb:	std_logic := '0';
	signal strb_tb: std_logic := '0';
	signal ena_tb:  std_logic := '0';
	signal val_tb:	std_logic_vector (7 downto 0);
	
	signal q_tb:	std_logic;
	
begin
	-- Parte descriptiva
	clk_tb  <= not clk_tb after 1 ns;
	val_tb  <= x"02" after 10 ns;
	strb_tb <= '1' after 10 ns, '0' after 12 ns;
	ena_tb  <= '1' after 25 ns;
	
	genEna_inst: entity work.genEna

		port map(
			clk_ena => clk_tb,
			strobe  => strb_tb,
			ena		=> ena_tb,
			vel		=> val_tb,
			ena_gen => q_tb
		);
end;
