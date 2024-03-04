library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IEEElaBinar is
port(
	IEEE : in STD_LOGIC_VECTOR(31 downto 0);
	load, clk : in STD_LOGIC;
	   
	--same sizes as in BCDtoBinary
	binary_integer : out STD_LOGIC_VECTOR(13 downto 0);	
	binary_fractional : out STD_LOGIC_VECTOR(45 downto 0);
	done : out STD_LOGIC
	);
end IEEElaBinar;

architecture Behavioral of IEEElaBinar is

	signal exponent : STD_LOGIC_VECTOR(7 downto 0);
	signal mantissa : STD_LOGIC_VECTOR(22 downto 0);	  
															 
	
	signal binary_integer_signal : STD_LOGIC_VECTOR(13 downto 0);	
	signal binary_fractional_signal : STD_LOGIC_VECTOR(45 downto 0);
	
	signal step, shift_amount : STD_LOGIC_VECTOR(7 downto 0);
	signal sign_of_exp, done_signal : STD_LOGIC;

begin

	exponent <= IEEE(30 downto 23);
	mantissa <= IEEE(22 downto 0);
	
	process(exponent)
	begin		
		if(exponent >= 127) then
			shift_amount <= exponent - 127;
			sign_of_exp <= '0'; --plus
		else
			shift_amount <= 127 - exponent;
			sign_of_exp <= '1';--minus
		end if;
	end process;
	
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(load = '1') then
				--the number is currently of the form 1.mantissa; we shift the dot according to the exponent
				binary_integer_signal(13 downto 1) <= (others => '0');
				binary_integer_signal(0) <= '1';  
				binary_fractional_signal(45 downto 23) <= mantissa;
				binary_fractional_signal(22 downto 0) <= (others => '0');
				step <= shift_amount; 
				done_signal <= '0';
			elsif(step > x"00") then
				step <= step - 1;
				if(sign_of_exp = '0') then
					binary_integer_signal <= binary_integer_signal(12 downto 0) & binary_fractional_signal(45);
					binary_fractional_signal <= binary_fractional_signal(44 downto 0) & '0';
				else
					binary_integer_signal <= (others => '0');
					binary_fractional_signal <= '0' & binary_fractional_signal(45 downto 1);
				end if;
			else
				done_signal <= '1';
			end if;
		end if;
	end process;
	
	binary_integer <= binary_integer_signal;
	binary_fractional <= binary_fractional_signal;
	done <= done_signal;

end Behavioral;