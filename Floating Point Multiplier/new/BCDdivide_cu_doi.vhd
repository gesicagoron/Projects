library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCDdivide_cu_doi is
port(
	input : in STD_LOGIC_VECTOR(15 downto 0);
	clk : in STD_LOGIC;
	load : in STD_LOGIC;
	output : out STD_LOGIC_VECTOR(15 downto 0);
	remainder : out STD_LOGIC;
	done : out STD_LOGIC
	);
end BCDdivide_cu_doi;

architecture Behavioral of BCDdivide_cu_doi is

	signal input_signal : STD_LOGIC_VECTOR(15 downto 0);
	signal current_divident, current_divident_PLUS10 : STD_LOGIC_VECTOR(4 downto 0);
	signal step : STD_LOGIC_VECTOR(1 downto 0);
	signal divider_remainder_signal, done_signal : STD_LOGIC;
	type array_type is array(3 downto 0) of STD_LOGIC_VECTOR(3 downto 0);
	signal output_digits : array_type;
	

begin

	current_divident_PLUS10 <= current_divident + "01010";

	process(clk)
	begin
		if(rising_edge(clk)) then  
			if(load = '1') then
				input_signal <= input(11 downto 0) & "0000";
				step <= "11";
				done_signal <= '0';
				current_divident <= '0' & input(15 downto 12);
				divider_remainder_signal <= '0';
			elsif(done_signal = '0') then
				if(divider_remainder_signal = '0') then --even number
					output_digits(conv_integer(step)) <= current_divident(4 downto 1);
				else
					output_digits(conv_integer(step)) <= current_divident_PLUS10(4 downto 1);
				end if;
				divider_remainder_signal <= current_divident(0);
				current_divident <= '0' & input_signal(15 downto 12);
				input_signal <= input_signal(11 downto 0) & "0000";
				if(step = "00") then
					done_signal <= '1';
				else
					step <= step - 1;
				end if;
	 		end if;
		end if;
	end process;
	
	output <= output_digits(3) & output_digits(2) & output_digits(1) & output_digits(0);
	remainder <= divider_remainder_signal;
	done <= done_signal;

end Behavioral;