library IEEE;
use IEEE.std_logic_1164.all;

-- Declaración de entidad
entity sum4b_tb is
end;

-- Cuerpo de arquitectura
architecture sum4b_tb_arq of sum4b_tb is
	-- Parte declarativa
	signal a_tb : std_logic_vector(3 downto 0) := "0001";
	signal b_tb : std_logic_vector(3 downto 0) := "0001";
	signal ci_tb: std_logic := '0';
	signal s_tb : std_logic_vector(3 downto 0);
	signal co_tb: std_logic;
	
begin
	-- Parte descriptiva
	
	a_tb <= "0101" after 10 ns, "1000" after 30 ns;
	b_tb <= "1100" after 20 ns;
	ci_tb <= '1' after 40 ns;
	
	sum4b_inst: entity work.sum4b
		port map(
			a_i  => a_tb,
			b_i  => b_tb,
			ci_i => ci_tb,
			s_o  => s_tb,
			co_o => co_tb
		);

end;
