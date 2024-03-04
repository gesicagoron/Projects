library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FractBinarLaBCD is
port(
	binary_fractional_46bits : in STD_LOGIC_VECTOR(45 downto 0);
	clk, load : in STD_LOGIC;
	
	BCDfractional : out STD_LOGIC_VECTOR(15 downto 0);
	done : out STD_LOGIC
	);
end FractBinarLaBCD;

architecture Behavioral of FractBinarLaBCD is

	signal step : STD_LOGIC_VECTOR(3 downto 0);
	signal BCDnumberToAdd, result, new_result, adder_output : STD_LOGIC_VECTOR(15 downto 0);
	signal almost_done, done_signal : STD_LOGIC;
	signal binary_fractional : STD_LOGIC_VECTOR(13 downto 0);


begin
	
	binary_fractional <= binary_fractional_46bits(45 downto 32);
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
							if(binary_fractional(13) = '1') then
								BCDnumberToAdd <= x"5000"; --2^(-1) = 0.5
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"C" => --12
							if(binary_fractional(12) = '1') then
								BCDnumberToAdd <= x"2500"; --2^(-2) = 0.25
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"B" => --11
							if(binary_fractional(11) = '1') then
								BCDnumberToAdd <= x"1250"; --2^(-3) = 0.125
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"A" => --10
							if(binary_fractional(10) = '1') then
								BCDnumberToAdd <= x"0625"; --2^(-4) = 0.0625
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"9" =>
							if(binary_fractional(9) = '1') then
								BCDnumberToAdd <= x"0313"; --2^(-5) = 0.03125 =~ 0.0313
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"8" =>
							if(binary_fractional(8) = '1') then
								BCDnumberToAdd <= x"0157"; --2^(-6) = 0.015625 =~ 0.0157
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"7" =>
							if(binary_fractional(7) = '1') then
								BCDnumberToAdd <= x"0079"; --2^(-7) = 0.0078125 =~ 0.0079
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"6" =>
							if(binary_fractional(6) = '1') then
								BCDnumberToAdd <= x"0040"; --2^(-8) = 0.00390625 =~ 0.0040
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"5" =>
							if(binary_fractional(5) = '1') then
								BCDnumberToAdd <= x"0020"; --2^(-9) = 0.001953125 =~ 0.0020
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"4" =>
							if(binary_fractional(4) = '1') then
								BCDnumberToAdd <= x"0010"; --2^(-10) = 0.0009765625 =~ 0.0010
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"3" =>
							if(binary_fractional(3) = '1') then
								BCDnumberToAdd <= x"0005"; --2^(-11) = 0.00048828125 =~ 0.0005
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"2" =>
							if(binary_fractional(2) = '1') then
								BCDnumberToAdd <= x"0003"; --2^(-12) = 0.000244140625 =~ 0.0003
 							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when x"1" =>
							if(binary_fractional(1) = '1') then
								BCDnumberToAdd <= x"0002"; --2^(-13) = 0.0001220703125 =~ 0.0002
							else
								BCDnumberToAdd <= x"0000";
							end if;
							result <= adder_output;
						when others => --0
							if(binary_fractional(0) = '1') then
								BCDnumberToAdd <= x"0001"; --2^(-14) = 0.00006103515625 =~ 0.0001
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
	
	BCDfractional <= result; 
	done <= done_signal;

end Behavioral;