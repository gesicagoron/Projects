library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sumator is
generic(n : natural);
port(
	input1 : in STD_LOGIC_VECTOR(2*n-1 downto 0);
	input2: in STD_LOGIC_VECTOR(2*n-1 downto 0);
	add : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(2*n-1 downto 0)
	);
end Sumator;

architecture Behavioral of Sumator is

begin
	 
	output <= (input1 + input2) when add = '1' else input2;

end Behavioral;