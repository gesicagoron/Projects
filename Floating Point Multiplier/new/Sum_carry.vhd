library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sum_carry is
port(
	A, B : in STD_LOGIC_VECTOR(15 downto 0);
	Sum : out STD_LOGIC_VECTOR(15 downto 0);
	CarryOut : out STD_LOGIC
	);
end Sum_carry;

architecture Behavioral of Sum_carry is
	signal Carry1, Carry2, Carry3 : STD_LOGIC;

begin

BCDDigitAdder0: entity WORK.Sumator_1cifra port map(A(3 downto 0), B(3 downto 0), '0', Sum(3 downto 0), Carry1);
BCDDigitAdder1: entity WORK.Sumator_1cifra port map(A(7 downto 4), B(7 downto 4), Carry1, Sum(7 downto 4), Carry2);
BCDDigitAdder2: entity WORK.Sumator_1cifra port map(A(11 downto 8), B(11 downto 8), Carry2, Sum(11 downto 8), Carry3);
BCDDigitAdder3: entity WORK.Sumator_1cifra port map(A(15 downto 12), B(15 downto 12), Carry3, Sum(15 downto 12), CarryOut);

end Behavioral;