library IEEE;
use IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;

-- Declaracion de entidad
entity cont_universal is
	generic(
		N: natural := 4  -- Tamaño en bits de la cuenta
	);
	port(
		clk_i: in std_logic;
		rst_i: in std_logic;
		ena_i: in std_logic;
		up_i: in std_logic;
		ld_i: in std_logic;
		value_i: in std_logic_vector(N-1 downto 0);
		q_o: out std_logic_vector(N-1 downto 0)
	);
end;

-- Cuerpo de arquitectura
architecture cont_universal_arq of cont_universal is
	-- Parte declarativa
	signal estadoActual: std_logic_vector(N-1 downto 0);
	signal estadoSiguiente: std_logic_vector(N-1 downto 0);
	
begin
	-- Parte descriptiva
	
	--Registro de estado
	reg: process(clk_i)
	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				estadoActual <= (others => '0');
			else
				estadoActual <= estadoSiguiente;
			end if;
		end if;
	end process;
	
	-- Logica de próximo estado
	process(estadoActual, rst_i, ena_i, up_i, ld_i)
	begin
		if rst_i = '1' then
			estadoSiguiente <= (others => '0');
		elsif ld_i = '1' then
			estadoSiguiente <= value_i;
		elsif ena_i = '1' and up_i = '1' then
			estadoSiguiente <= std_logic_vector(to_signed(to_integer(unsigned(estadoActual)) + 1, N));
		elsif ena_i = '1' and up_i = '0' then
			estadoSiguiente <= std_logic_vector(to_signed(to_integer(unsigned(estadoActual)) - 1, N));
		else
			estadoSiguiente <= estadoActual;
		end if;
	end process;
	
	q_o <= estadoActual;
end;
