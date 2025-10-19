library IEEE;
use 	IEEE.std_logic_1164.all;

-- Declaración de entidad
entity sum_resNb_tb is
end;

-- Cuerpo de arquitectura
architecture sum_resNb_tb_arq of sum_resNb_tb is
	-- Parte declarativa
	
	constant N_tb: natural := 5;
	
	signal s_r_tb : std_logic := '0';
	signal a_tb   : std_logic_vector(N_tb-1 downto 0) := "00010";
	signal b_tb   : std_logic_vector(N_tb-1 downto 0) := "00100";
	signal ci_tb  : std_logic := '0';
	signal s_tb   : std_logic_vector(N_tb-1 downto 0);
	signal co_tb  : std_logic;
	
begin
	-- Parte descriptiva
	s_r_tb <= not s_r_tb after 100 ns;
	
	sum_resNb_inst: entity work.sum_resNb
		generic map(
			N => N_tb
		)
		port map(
			s_r  => s_r_tb,
			a_i  => a_tb,
			b_i  => b_tb,
			ci_i => ci_tb,
			s_o  => s_tb,
			co_o => co_tb
		);

end;
