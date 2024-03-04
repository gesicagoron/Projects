library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IntegerBinaryToBCD is
port(
	binary_integer : in STD_LOGIC_VECTOR(13 downto 0);
	clk, load : in STD_LOGIC;
	
	BCDinteger : out STD_LOGIC_VECTOR(15 downto 0);
	done : out STD_LOGIC
	);
end IntegerBinaryToBCD;	

architecture Behavioral of IntegerBinaryToBCD is
	
	signal step : STD_LOGIC_VECTOR(3 downto 0);
	signal BCDnumberToAdd, result, new_result, adder_output : STD_LOGIC_VECTOR(15 downto 0);
	signal almost_done, done_signal : STD_LOGIC;	 

begin

Addr: entity WORK.BCDSumator port map(result, BCDnumberToAdd, adder_output);

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(load = '1') then
				done_signal <= '0';
				almost_done <= '0';
				result <= (others => '0');
				BCDnumberToAdd <= x"0000";
				new_result <= (others => '0');
				step <= "1101";
			else
				if(almost_done = '0') then
					result <= new_result;
					case step is
						when x"D" => --13
							if(binary_integer(13) = '1') then
								BCDnumberToAdd <= x"8192"; --2^13
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"C" => --12
							if(binary_integer(12) = '1') then
								BCDnumberToAdd <= x"4096"; --2^12
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"B" => --11
							if(binary_integer(11) = '1') then
								BCDnumberToAdd <= x"2048"; --2^11
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"A" => --10
							if(binary_integer(10) = '1') then
								BCDnumberToAdd <= x"1024"; --2^10
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"9" =>
							if(binary_integer(9) = '1') then
								BCDnumberToAdd <= x"0512"; --2^9
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"8" =>
							if(binary_integer(8) = '1') then
								BCDnumberToAdd <= x"0256"; --2^8
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"7" =>
							if(binary_integer(7) = '1') then
								BCDnumberToAdd <= x"0128"; --2^7
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"6" =>
							if(binary_integer(6) = '1') then
								BCDnumberToAdd <= x"0064"; --2^6
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"5" =>
							if(binary_integer(5) = '1') then
								BCDnumberToAdd <= x"0032"; --2^5
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"4" =>
							if(binary_integer(4) = '1') then
								BCDnumberToAdd <= x"0016"; --2^4
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"3" =>
							if(binary_integer(3) = '1') then
								BCDnumberToAdd <= x"0008"; --2^3
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"2" =>
							if(binary_integer(2) = '1') then
								BCDnumberToAdd <= x"0004"; --2^2
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"1" =>
							if(binary_integer(1) = '1') then
								BCDnumberToAdd <= x"0002"; --2^1
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when others => --0
							if(binary_integer(0) = '1') then
								BCDnumberToAdd <= x"0001"; --2^0
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
					end case;
					
					if(step = x"0") then
						almost_done <= '1';
					else
						step <= step - 1;
					end if;
				elsif(done_signal = '0') then
					result <= adder_output;
					done_signal <= '1';
				end if;
			end if;
		end if;
	end process;
	
	BCDinteger <= result; 
	done <= done_signal;

end Behavioral;