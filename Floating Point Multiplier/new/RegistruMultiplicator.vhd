library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegistruMultiplicator is 
generic(n : natural);
port(
	input : in STD_LOGIC_VECTOR(n-1 downto 0);
	write : in STD_LOGIC;
	shift_right : in STD_LOGIC;
	clk : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(n-1 downto 0)
	);
end RegistruMultiplicator;

architecture Behavioral of RegistruMultiplicator is

signal content : STD_LOGIC_VECTOR(n-1 downto 0);

begin
	
	process (clk)
		begin
			if(rising_edge(clk)) then
				if (write = '1') then
					content <= input;
				elsif (shift_right = '1') then
					content <= '0' & content(n-1 downto 1);
				end if;
			end if;
		end process;
	
	output <= content;

end Behavioral;