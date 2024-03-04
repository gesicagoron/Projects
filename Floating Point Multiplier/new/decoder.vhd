library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder is
    Port (
        clk_100MHz: in STD_LOGIC;
        row: in STD_LOGIC_VECTOR(3 downto 0);       -- 4 buttons per row
        col: out STD_LOGIC_VECTOR(3 downto 0);      -- 4 columns on keypad
        dec_out: out STD_LOGIC_VECTOR(3 downto 0)   -- binary value of button press
    );
end decoder;

architecture Behavioral of decoder is
    constant LAG : integer := 10;                  -- 100MHz / 10 = 10M -> 1/10M = 100ns

    signal scan_timer : unsigned(19 downto 0) := (others => '0');    -- to count up to 99,999
    signal col_select : unsigned(1 downto 0) := (others => '0');     -- 2 bit counter to select 4 columns

begin

    -- scan timer/column select control
    process(clk_100MHz)
    begin
        if rising_edge(clk_100MHz) then   -- 1ms = 1/1000s
            if scan_timer = 99999 then    -- 100MHz / 100,000 = 1000
                scan_timer <= (others => '0');
                col_select <= col_select + 1;
            else
                scan_timer <= scan_timer + 1;
            end if;
        end if;
    end process;

    -- set columns, check rows
    process(clk_100MHz)
    begin
        if rising_edge(clk_100MHz) then
            case col_select is
                when "00" =>
                    col <= "0111";
                    if scan_timer = LAG then
                        case row is
                            when "0111" => dec_out <= "0001";   -- 1
                            when "1011" => dec_out <= "0100";   -- 4
                            when "1101" => dec_out <= "0111";   -- 7
                            when "1110" => dec_out <= "0000";   -- 0
                            when others => null;
                        end case;
                    end if;
                when "01" =>
                    col <= "1011";
                    if scan_timer = LAG then
                        case row is
                            when "0111" => dec_out <= "0010";   -- 2
                            when "1011" => dec_out <= "0101";   -- 5
                            when "1101" => dec_out <= "1000";   -- 8
                            when "1110" => dec_out <= "1111";   -- F
                            when others => null;
                        end case;
                    end if;
                when "10" =>
                    col <= "1101";
                    if scan_timer = LAG then
                        case row is
                            when "0111" => dec_out <= "0011";   -- 3
                            when "1011" => dec_out <= "0110";   -- 6
                            when "1101" => dec_out <= "1001";   -- 9
                            when "1110" => dec_out <= "1110";   -- E
                            when others => null;
                        end case;
                    end if;
                when "11" =>
                    col <= "1110";
                    if scan_timer = LAG then
                        case row is
                            when "0111" => dec_out <= "1010";   -- A
                            when "1011" => dec_out <= "1011";   -- B
                            when "1101" => dec_out <= "1100";   -- C
                            when "1110" => dec_out <= "1101";   -- D
                            when others => null;
                        end case;
                    end if;
                when others => null;
            end case;
        end if;
    end process;

end Behavioral;
