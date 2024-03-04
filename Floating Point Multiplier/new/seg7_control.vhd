library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seg7_control is
    Port (
        dec: in STD_LOGIC_VECTOR(3 downto 0);     -- from decoder
        an: out STD_LOGIC_VECTOR(3 downto 0);     -- anodes
        seg: out STD_LOGIC_VECTOR(6 downto 0)     -- cathodes
    );
end seg7_control;

architecture Behavioral of seg7_control is
begin

    -- Assigning anodes
    an <= "1110";   -- only using far right digit

    -- Segment patterns based on decoder value
    process(dec)
    begin
        case dec is
            when "0000" => seg <= "1000000";   -- 0
            when "0001" => seg <= "1111001";   -- 1
            when "0010" => seg <= "0100100";   -- 2
            when "0011" => seg <= "0110000";   -- 3
            when "0100" => seg <= "0011001";   -- 4
            when "0101" => seg <= "0010010";   -- 5
            when "0110" => seg <= "0000010";   -- 6
            when "0111" => seg <= "1111000";   -- 7
            when "1000" => seg <= "0000000";   -- 8
            when "1001" => seg <= "0010000";   -- 9
            when "1010" => seg <= "0001000";   -- A
            when "1011" => seg <= "0000011";   -- B
            when "1100" => seg <= "1000110";   -- C
            when "1101" => seg <= "0100001";   -- D
            when "1110" => seg <= "0000110";   -- E
            when "1111" => seg <= "0001110";   -- F
            when others => null;
        end case;
    end process;

end Behavioral;
