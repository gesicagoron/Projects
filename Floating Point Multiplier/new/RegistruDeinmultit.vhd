library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegistruDeinmultit is
generic(n : natural);
port(
	input : in STD_LOGIC_VECTOR(2*n-1 downto 0);
	write : in STD_LOGIC;
	shift_left : in STD_LOGIC;
	clk : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(2*n-1 downto 0)
	);
end RegistruDeinmultit;

architecture Behavioral of RegistruDeinmultit is

signal content : STD_LOGIC_VECTOR(2*n-1 downto 0);

begin
	
	process (clk)
		begin
			if(rising_edge(clk)) then
				if (write = '1') then
					content <= input;
				elsif (shift_left = '1') then
					content <= content(2*n-2 downto 0) & '0';
				end if;
			end if;
		end process;
	
	output <= content;

end Behavioral;