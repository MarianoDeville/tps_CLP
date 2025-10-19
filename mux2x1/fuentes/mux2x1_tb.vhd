library IEEE;
use 	IEEE.std_logic_1164.all;

-- Declaración de entidad
entity mux2x1_tb  is
end;

-- Cuerpo de arquitectura
architecture mux2x1_tb_arq of mux2x1_tb  is
	-- Parte declarativa

    signal a_tb  : std_logic := '0';
    signal b_tb  : std_logic := '0';
    signal sel_tb: std_logic := '0';
    signal q_tb  : std_logic;
	
begin
	-- Parte descriptiva
	a_tb   <= not a_tb after 10 ns;
	b_tb   <= not b_tb after 20 ns;
	sel_tb <= '1' after 20 ns;
	
	mux2x1_inst: entity work.mux2x1

		port map(
            a_i => a_tb,
            b_i => b_tb,
            sel => sel_tb,
            q_o => q_tb
		);
end;
