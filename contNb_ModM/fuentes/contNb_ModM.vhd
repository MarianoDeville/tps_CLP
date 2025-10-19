library IEEE;
use IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;

-- Declaracion de entidad
entity contNb_ModM is
	generic(
		N: natural := 4;  -- Tamaño en bits de la cuenta
		M: natural := 10  -- Módulo de la cuenta
	);
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		q_o  : out std_logic_vector(N-1 downto 0)
	);
end;

-- Cuerpo de arquitectura
architecture contNb_ModM_arq of contNb_ModM is
	-- Parte declarativa
	signal salInc: std_logic_vector(N-1 downto 0);
	signal salQ: std_logic_vector(N-1 downto 0);
	signal salOr: std_logic;
	signal salAnd: std_logic;
	signal salComp: std_logic;
	
begin
	-- Parte descriptiva
	reg_inst: entity work.regNb
		generic map(
			N => N
		)
		port map(
			clk_i => clk_i,
			rst_i => salOr,
			ena_i => ena_i,
			d_i   => salInc,
			q_o   => salQ
		);
		
	salInc <= std_logic_vector(to_unsigned(to_integer(unsigned(salQ)) + 1, N));
	
	salOr <= rst_i or salAnd; 
	
	salAnd <= ena_i and salComp;
	
	salComp <= '1' when (to_integer(unsigned(salQ)) = M-1) else '0';
	
	q_o <= salQ;
end;
