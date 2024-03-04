library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FractBCDlaBinar is
port(
	BCD : in STD_LOGIC_VECTOR(15 downto 0);
	clk : in STD_LOGIC;
	load : in STD_LOGIC;
	binary : out STD_LOGIC_VECTOR(45 downto 0); --46 (23+23) bit precision for the fractional part
	done : out STD_LOGIC
	);
end FractBCDlaBinar;

architecture Behavioral of FractBCDlaBinar is

	signal input_signal, output_signal : STD_LOGIC_VECTOR(15 downto 0);
	signal integer_part, done_signal : STD_LOGIC;
	signal binary_signal : STD_LOGIC_VECTOR(51 downto 0); --we compute 52 bits (for approximation), but keep only 46
	signal approximate : STD_LOGIC;
	signal step : STD_LOGIC_VECTOR(5 downto 0);

begin
	
MulByTwo: entity WORK.BCDinm_cu2_pt_nr_mici port map(input_signal, output_signal, integer_part);
	
	approximate <= binary_signal(5) or binary_signal(4) or binary_signal(3) or binary_signal(2) or binary_signal(1) or binary_signal(0);
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(load = '1') then
				input_signal <= BCD;
				binary_signal <= (others => '0'); 
				done_signal <= '0';
				step <= "110011"; 
			elsif(done_signal = '0') then
				if(input_signal = x"0000") then
					binary_signal <= (others => '0');
					done_signal <= '1';
				else
					binary_signal(conv_integer(step)) <= integer_part;
					if((output_signal = x"0000") or (step = "000000")) then --maximum  bits
						if(approximate = '1') then
							binary_signal <= binary_signal + 1;
						end if;
						done_signal <= '1';
					else
						step <= step - 1;	   
					end if;
					input_signal <= output_signal;
				end if;
			end if;
		end if;
	end process;
	
	done <= done_signal;
	binary <= binary_signal(51 downto 6);

end Behavioral;