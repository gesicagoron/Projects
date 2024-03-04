library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk_100MHz: in STD_LOGIC;      -- from Basys 3
        rows: in STD_LOGIC_VECTOR(3 downto 0);   -- Pmod JB pins 10 to 7
        cols: out STD_LOGIC_VECTOR(3 downto 0);  -- Pmod JB pins 4 to 1
        an: out STD_LOGIC_VECTOR(3 downto 0);    -- 7 segment anodes
        seg: out STD_LOGIC_VECTOR(6 downto 0)    -- 7 segment cathodes
    );
end top;

architecture Behavioral of top is
    signal w_dec: STD_LOGIC_VECTOR(3 downto 0);

begin

    decoder_inst: entity work.decoder
        port map (
            clk_100MHz => clk_100MHz,
            row => rows,
            col => cols,
            dec_out => w_dec
        );

    seg7_control_inst: entity work.seg7_control
        port map (
            dec => w_dec,
            an => an,
            seg => seg
        );

end Behavioral;
