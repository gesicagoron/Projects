library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCDsumator_1cifra is
port(
	A, B : in STD_LOGIC_VECTOR(3 downto 0);
	CarryIn : in STD_LOGIC;
	Sum : out STD_LOGIC_VECTOR(3 downto 0);
	CarryOut : out STD_LOGIC
	);
end BCDsumator_1cifra;

architecture Behavioral of BCDsumator_1cifra is

	signal sum_signal, sum_signal_MinusTen : STD_LOGIC_VECTOR(4 downto 0);

begin

	sum_signal <= ('0' & A) + ('0' & B) + ("0000" & CarryIn);
	sum_signal_MinusTen <= sum_signal - "01010";

	process(sum_signal, sum_signal_MinusTen)
	begin
		if(sum_signal >= 10) then
			Sum <= sum_signal_MinusTen(3 downto 0);
			CarryOut <= '1';
		else
			Sum <= sum_signal(3 downto 0);
			CarryOut <= '0';
		end if;
	end process;

end Behavioral;