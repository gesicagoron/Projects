library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegistruProdus is
generic(n : natural);
port(
	input : in STD_LOGIC_VECTOR(2*n-1 downto 0);
	write : in STD_LOGIC;	 
	reset : in STD_LOGIC;
	clk : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(2*n-1 downto 0)
	);
end RegistruProdus;

architecture Behavioral of RegistruProdus is

signal content : STD_LOGIC_VECTOR(2*n-1 downto 0);

begin
	
	process (clk, reset)
		begin		   
			if(reset = '1') then
				content <= (others => '0');
			elsif(rising_edge(clk)) then
				if (write = '1') then
					content <= input;
				end if;
			end if;
		end process;
	
	output <= content;

end Behavioral;