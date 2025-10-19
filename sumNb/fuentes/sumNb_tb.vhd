library IEEE;
use 	IEEE.std_logic_1164.all;
use		IEEE.numeric_std.all;

-- Declaración de entidad
entity sumNb_tb is
end;

-- Cuerpo de arquitectura
architecture sumNb_tb_arq of sumNb_tb is
	-- Parte declarativa
	
	constant N_tb: natural := 4;
	
	signal a_tb : std_logic_vector(N_tb-1 downto 0) := std_logic_vector(to_unsigned(3, N_tb));
	signal b_tb : std_logic_vector(N_tb-1 downto 0) := std_logic_vector(to_unsigned(5, N_tb));
	signal ci_tb: std_logic := '0';
	signal s_tb : std_logic_vector(N_tb-1 downto 0);
	signal co_tb: std_logic;
	
begin
	-- Parte descriptiva

	
	sumNb_inst: entity work.sumNb
		generic map(
			N => N_tb
		)
		port map(
		a_i  => a_tb,
		b_i  => b_tb,
		ci_i => ci_tb,
		s_o  => s_tb,
		co_o => co_tb
		);

end;
