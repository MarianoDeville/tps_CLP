library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity regNb is
	generic(
		N: natural := 4
	);
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		d_i  : in std_logic_vector(N-1 downto 0);
		q_o  : out std_logic_vector(N-1 downto 0)
	);
end;

-- Cuerpo de arquitectura
architecture regNb_arq of regNb is
	-- Parte declarativa
	
begin
	-- Parte descriptiva
	process(clk_i)
	
	begin
	
		if rising_edge(clk_i) then
			if rst_i = '1' then
				q_o <= (N-1 downto 0 => '0');
			elsif ena_i = '1' then
				q_o <= d_i;
			end if;
		end if;
	end process;

end;
