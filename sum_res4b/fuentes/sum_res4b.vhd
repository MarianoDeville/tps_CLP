	library IEEE;
use 	IEEE.std_logic_1164.all;

-- Declaración de entidad
entity sum_res4b is
	port(
		s_r : in std_logic;
		a_i : in std_logic_vector(3 downto 0);
		b_i : in std_logic_vector(3 downto 0);
		ci_i: in std_logic;
		s_o : out std_logic_vector(3 downto 0);
		co_o: out std_logic
	);
end;

-- Cuerpo de arquitectura
architecture sum_res4b_arq of sum_res4b is
	-- Parte declarativa
	signal b_xor: std_logic_vector(3 downto 0);
	
begin
	-- Parte descriptiva
	b_xor <= b_i xor (3 downto 0 => s_r);
	
	sum4b_inst: entity work.sum4b

		port map(
			a_i  => a_i,
			b_i  => b_xor,
			ci_i => s_r,
			s_o  => s_o,
			co_o => co_o
		);
end;
