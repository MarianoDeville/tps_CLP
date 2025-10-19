library IEEE;
use 	IEEE.std_logic_1164.all;

-- Declaración de entidad
entity sum_res4b_tb is
end;

-- Cuerpo de arquitectura
architecture sum_res4b_tb_arq of sum_res4b_tb is
	-- Parte declarativa

	signal s_r_tb : std_logic := '0';
	signal a_tb   : std_logic_vector(3 downto 0) := "0010";
	signal b_tb   : std_logic_vector(3 downto 0) := "0100";
	signal ci_tb  : std_logic := '0';
	signal s_tb   : std_logic_vector(3 downto 0);
	signal co_tb  : std_logic;
	
begin
	-- Parte descriptiva
	s_r_tb <= '1' after 10 ns;
	
	sum_res4b_inst: entity work.sum_res4b

		port map(
			s_r  => s_r_tb,
			a_i  => a_tb,
			b_i  => b_tb,
			ci_i => ci_tb,
			s_o  => s_tb,
			co_o => co_tb
		);

end;
