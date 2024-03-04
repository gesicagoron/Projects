library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IEEElaBCD is
port(
	IEEE : in STD_LOGIC_VECTOR(31 downto 0);
	load : in STD_LOGIC;
	clk : in STD_LOGIC;
	
	sign : out STD_LOGIC; --'0' for +, '1' for -
	BCD : out STD_LOGIC_VECTOR(15 downto 0);
	FractionalPointLocation : out STD_LOGIC_VECTOR(2 downto 0);														  										   							  				   
	done : out STD_LOGIC
	);
end IEEElaBCD;

architecture Behavioral of IEEElaBCD is

	signal binary_integer : STD_LOGIC_VECTOR(13 downto 0);	
	signal binary_fractional : STD_LOGIC_VECTOR(45 downto 0);
	
	signal binary_conversion_done, enable, bcd_int_done, bcd_frac_done : STD_LOGIC;
	
	signal BCD_signal, BCDinteger, BCDfractional : STD_LOGIC_VECTOR(15 downto 0);
	
	signal FractionalPointLocation_signal : STD_LOGIC_VECTOR(2 downto 0);

begin 

	enable <= not binary_conversion_done;

IEEEtoBin: entity WORK.IEEELaBinar port map(IEEE, load, clk, binary_integer, binary_fractional, binary_conversion_done);
BinaryIntToBCD: entity WORK.IntegerBinaryToBCD port map(binary_integer, clk, enable, BCDinteger, bcd_int_done);
BinaryFracToBCD: entity WORK.FractBinarLaBCD port map(binary_fractional, clk, enable, BCDfractional, bcd_frac_done);
	
	process(bcd_int_done, bcd_frac_done)
	begin		
		if (bcd_int_done = '1' and bcd_frac_done = '1') then
			if(BCDinteger(15 downto 12) = x"0") then
				if(BCDinteger(11 downto 8) = x"0") then
					if(BCDinteger(7 downto 4) = x"0") then
						if(BCDinteger(3 downto 0) = x"0") then
							BCD_signal <= BCDfractional;
							FractionalPointLocation_signal <= "100";
						else
							BCD_signal(15 downto 12) <= BCDinteger(3 downto 0);
							BCD_signal(11 downto 0) <= BCDfractional(15 downto 4);
							FractionalPointLocation_signal <= "011";
						end if;
					else
						BCD_signal(15 downto 8) <= BCDinteger(7 downto 0);
						BCD_signal(7 downto 0) <= BCDfractional(15 downto 8);
						FractionalPointLocation_signal <= "010";
					end if;
				else   
					BCD_signal(15 downto 4) <= BCDinteger(11 downto 0);
					BCD_signal(3 downto 0) <= BCDfractional(15 downto 12);
					FractionalPointLocation_signal <= "001";
				end if;
			else
				BCD_signal <= BCDinteger;
				FractionalPointLocation_signal <= "000";
			end if;
		end if;
	end process;
	
	BCD <= BCD_signal;
	FractionalPointLocation <= FractionalPointLocation_signal;
	done <= bcd_int_done and bcd_frac_done;
	

end Behavioral;