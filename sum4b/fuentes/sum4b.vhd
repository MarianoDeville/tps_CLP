library IEEE;
use IEEE.std_logic_1164.all;

-- Declaración de entidad
entity sum4b is

	port(
		a_i : in std_logic_vector(3 downto 0);
		b_i : in std_logic_vector(3 downto 0);
		ci_i: in std_logic;
		s_o : out std_logic_vector(3 downto 0);
		co_o: out std_logic
	);
end;

-- Cuerpo de arquitectura
architecture sum4b_arq of sum4b is
	-- Parte declarativa
	signal c_aux0: std_logic;
	signal c_aux1: std_logic;
	signal c_aux2: std_logic;
	
begin
	-- Parte descriptiva
	
	sum1b_0: entity work.sum1b
		port map(
			a_i  => a_i(0),
			b_i  => b_i(0),
			ci_i => ci_i,
			s_o  => s_o(0),
			co_o => c_aux0
		);
	
	sum1b_1: entity work.sum1b
		port map(
			a_i  => a_i(1),
			b_i  => b_i(1),
			ci_i => c_aux0,
			s_o  => s_o(1),
			co_o => c_aux1
		);

	sum1b_2: entity work.sum1b
		port map(
			a_i  => a_i(2),
			b_i  => b_i(2),
			ci_i => c_aux1,
			s_o  => s_o(2),
			co_o => c_aux2
		);
	
	sum1b_3: entity work.sum1b
		port map(
			a_i  => a_i(3),
			b_i  => b_i(3),
			ci_i => c_aux2,
			s_o  => s_o(3),
			co_o => co_o
		);
end;
