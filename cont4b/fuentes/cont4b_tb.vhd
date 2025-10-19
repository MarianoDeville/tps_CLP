library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity cont4b_tb is
end;

-- Cuerpo de arquitectura
architecture cont4b_tb_arq of cont4b_tb is
	-- Parte declarativa
	signal clk_tb: std_logic := '0';
	signal q_tb: std_logic_vector(3 downto 0) := "0000";
	
begin
	-- Parte descriptiva
	clk_tb <= not clk_tb after 20 ns;
	
	cont4b_inst: entity work.cont4b
		port map(
			clk_i => clk_tb,
			q_o   => q_tb
		);

end;
