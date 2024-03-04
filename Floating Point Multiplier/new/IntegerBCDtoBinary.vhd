library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IntegerBCDtoBinary is
port(
	BCD : in STD_LOGIC_VECTOR(15 downto 0);
	clk : in STD_LOGIC;
	load : in STD_LOGIC;
	binary : out STD_LOGIC_VECTOR(13 downto 0); --9999 (biggest integer number on 4 bits) needs 14 bits to represent
	done : out STD_LOGIC
	);
end IntegerBCDtoBinary;

architecture Behavioral of IntegerBCDtoBinary is
	signal input_signal, output_signal : STD_LOGIC_VECTOR(15 downto 0);
	signal divider_load_signal, divider_remainder_signal, divider_done_signal, done_signal : STD_LOGIC;
	
	signal binary_signal : STD_LOGIC_VECTOR(13 downto 0);
	signal step : STD_LOGIC_VECTOR(3 downto 0); --for each digit of the result; max is 14, which is represented on 4 bits

begin

BCDDivByTwo: entity WORK.BCDdivide_cu_doi port map(input_signal, clk, divider_load_signal, output_signal, divider_remainder_signal, divider_done_signal);
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(load = '1') then
				input_signal <= BCD;
				divider_load_signal <= '1';
				done_signal <= '0';
				binary_signal <= (others => '0');
				step <= "0000";
			elsif(divider_load_signal = '1') then
				divider_load_signal <= '0';
			elsif(done_signal = '0') then
				if(divider_done_signal = '1') then
					binary_signal(conv_integer(step)) <= divider_remainder_signal;
					if(output_signal = x"0000") then
						done_signal <= '1';
					end if;
					input_signal <= output_signal; 
					divider_load_signal <= '1';
					step <= step + 1;
				end if;
			end if;
		end if;
	end process;
	
	done <= done_signal;
	binary <= binary_signal;

end Behavioral;
