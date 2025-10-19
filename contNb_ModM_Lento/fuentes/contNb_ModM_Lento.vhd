library IEEE;
use IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;

-- Declaracion de entidad
entity contNb_ModM_Lento is
	generic(
		CICLOS: natural := 4; -- cantidad de siclos para incrementar el contador
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
architecture contNb_ModM_Lento_arq of contNb_ModM_Lento is
	-- Parte declarativa
	signal ena_aux: std_logic;
	signal ena_gen: std_logic;
begin
	-- Parte descriptiva
	contNb_ModM_inst: entity work.contNb_ModM
		generic map(
			N => N,
			M => M
		)
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_aux,
			q_o   => q_o
		);
	genEna_ins: entity work.genEna
		generic map(
			N => CICLOS
		)
		port map(
			clk_i => clk_i,
			rst_i => rst_i,
			q_o => ena_gen 
		);
		
		ena_aux <= ena_i and ena_gen;
end;
