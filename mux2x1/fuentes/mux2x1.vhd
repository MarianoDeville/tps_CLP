library IEEE;
use IEEE.std_logic_1164.all;

-- Declaración de entidad
entity mux2x1 is
    port(
        a_i : in  std_logic;
        b_i : in  std_logic;
        sel : in  std_logic;
        q_o : out std_logic
    );
end;

-- Cuerpo de arquitectura
architecture mux2x1_arq of mux2x1 is

begin
	-- Parte descriptiva
    q_o <= (not sel and a_i) or (sel and b_i);
	
end;
