library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCDinm_cu2_pt_nr_mici is
port(
	fractionalPartInput : in STD_LOGIC_VECTOR(15 downto 0);
	fractionalPartOutput : out STD_LOGIC_VECTOR(15 downto 0);
	integerPartOutput : out STD_LOGIC --can only be 0 or 1 in our case, since we're multypling only numbers < 1
	);
end BCDinm_cu2_pt_nr_mici;				 

architecture Behavioral of BCDinm_cu2_pt_nr_mici is

begin

Adder: entity WORK.Sum_carry port map(fractionalPartInput, fractionalPartInput, fractionalPartOutput, integerPartOutput); --we simply add the number with itself

end;