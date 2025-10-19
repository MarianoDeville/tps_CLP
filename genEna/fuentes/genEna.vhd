-------------------------------------------------------------------------------
--  Project    : Contador controlado por UART
--  Module     : genEna.vhd
--  Components : 
--	Autor      : Mariano Deville
--
library IEEE;
use 	IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;

-- Declaración de entidad
entity genEna is

	port(
		clk_ena: in std_logic;						-- Entrada de Clock
		strobe:  in std_logic;						-- Entrada señal para tomar configuración
		ena:	 in std_logic;						-- Entrada habilitador de pulsos de salida
		vel:	 in std_logic_vector (7 downto 0);	-- Entrada palabra 8 bits de configuración
		
		ena_gen: out std_logic						-- Salida pulso enable
	);
end;

-- Cuerpo de arquitectura
architecture genEna_arq of genEna is
	-- Parte declarativa
	signal seteo: std_logic_vector(7 downto 0) := (others => '0');
	signal q_aux: std_logic := '0';
	
begin
	-- Parte descriptiva
	process(clk_ena)
		variable aux: integer range 0 to 255 := 0;

	begin
		if rising_edge(clk_ena) then

			if ena = '0' then
				q_aux <= '0';
			else
				if strobe = '1' then
					seteo <= vel;
					aux   := 0;
					q_aux <= '0';
				elsif seteo = x"00" then
					q_aux <= not q_aux;
				elsif aux = to_integer(unsigned(seteo)) - 1 then
					q_aux <= '1';
					aux   := 0;
				else
					q_aux <= '0';
					aux   := aux + 1;
				end if;
			end if;
		end if;
	end process;

	ena_gen <= q_aux;
end;
