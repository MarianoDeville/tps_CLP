library IEEE;
use 	IEEE.std_logic_1164.all;

-- Declaración de entidad
entity sum_resNb is
	generic(
		N: natural := 4
		);
	port(
		s_r : in std_logic;
		a_i : in std_logic_vector(N-1 downto 0);
		b_i : in std_logic_vector(N-1 downto 0);
		ci_i: in std_logic;
		s_o : out std_logic_vector(N-1 downto 0);
		co_o: out std_logic
	);
end;

-- Cuerpo de arquitectura
architecture sum_resNb_arq of sum_resNb is
	-- Parte declarativa
	signal b_xor: std_logic_vector(N-1 downto 0);
	
begin
	-- Parte descriptiva
	b_xor <= b_i xor (N-1 downto 0 => s_r);
	
	sumNb_inst: entity work.sumNb
		generic map(
			N => N
		)
		port map(
			a_i  => a_i,
			b_i  => b_xor,
			ci_i => s_r,
			s_o  => s_o,
			co_o => co_o
		);
end;
