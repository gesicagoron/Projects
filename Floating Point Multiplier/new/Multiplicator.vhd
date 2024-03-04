library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplicator is
generic(n : natural);	
port(
	multiplicand : in STD_LOGIC_VECTOR(2*n-1 downto 0);
	multiplier : in STD_LOGIC_VECTOR(n-1 downto 0);
	load : in STD_LOGIC;
	clk : in STD_LOGIC;
	product : out STD_LOGIC_VECTOR(2*n-1 downto 0);
	done : out STD_LOGIC
	);
	
end Multiplicator;

architecture Structural of Multiplicator is

signal multiplicand_reg, adder_output, product_output : STD_LOGIC_VECTOR(2*n-1 downto 0);
signal multiplier_reg : STD_LOGIC_VECTOR(n-1 downto 0);
signal multiplicand_write_signal, shift_left_signal, multiplier_write_signal, shift_right_signal, product_write_signal, add_signal, reset : STD_LOGIC;

begin

Reg_deinmultit: entity WORK.RegistruDeinmultit generic map (n) port map (multiplicand, multiplicand_write_signal, shift_left_signal, clk, multiplicand_reg);
Reg_inmultitor: entity WORK.RegistruMultiplicator generic map (n) port map (multiplier, multiplier_write_signal, shift_right_signal, clk, multiplier_reg);
Reg_Produs: entity WORK.RegistruProdus generic map (n) port map (adder_output, product_write_signal, reset, clk, product_output);
Addr: entity WORK.Sumator generic map (n) port map (multiplicand_reg, product_output, add_signal, adder_output);
	
	product <= product_output; 
	
	add_signal <= multiplier_reg(0);
	
	process (load, multiplier_reg)
		begin
				if(load = '1') then
					multiplicand_write_signal <= '1';
					shift_left_signal <= '0';
					multiplier_write_signal <= '1';
					shift_right_signal <= '0';
					product_write_signal <= '0';
					done <= '0';
					reset <= '1';
				else 
					reset <= '0';
					multiplicand_write_signal <= '0';
					shift_left_signal <= '1';
					multiplier_write_signal <= '0';
					shift_right_signal <= '1';
					if (multiplier_reg = 0) then
						product_write_signal <= '0';
						done <= '1';
					else
						product_write_signal <= '1';
						done <= '0';
					end if;
				end if;
		end process;
	
end Structural;