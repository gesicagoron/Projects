library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_mod5 is
port(
	moveUp : in STD_LOGIC;
	reset : in STD_LOGIC;
	Q : out STD_LOGIC_VECTOR(2 downto 0)
	);
end Counter_mod5;

architecture Behavioral of Counter_mod5 is

signal tmp : STD_LOGIC_VECTOR(2 downto 0);

begin
	process(moveUp, reset)
		begin
			if(reset = '1') then
				tmp <= "000";
			elsif(rising_edge(moveUp)) then
				if(tmp = "100") then
					tmp <= "000";
				else
					tmp <= tmp + 1;
				end if;
			end if;
		end process;
	Q <= tmp;
end Behavioral;