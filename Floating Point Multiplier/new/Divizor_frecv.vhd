library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Divizor_frecv is
port(
	 CLK : in std_logic;
     CLK0 : out std_logic
	 );
end Divizor_frecv;

architecture Behavioral of Divizor_frecv is
	signal count : INTEGER range 0 to 499999 := 0;
begin
	Divide : process (CLK)
	begin
		if (CLK' event and CLK = '1') then
			if ( count = 499999 ) then
				CLK0 <= '1';
				count <= 0;		  
			else
				count <= count + 1;
				CLK0 <= '0';		  
			end if;
		end if;
	end process Divide;
end Behavioral;