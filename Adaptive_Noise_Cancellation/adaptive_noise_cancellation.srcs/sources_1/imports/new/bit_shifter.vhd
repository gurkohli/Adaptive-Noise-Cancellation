----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2018 10:19:38 PM
-- Design Name: 
-- Module Name: bit_shifter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bit_shifter is
    generic(
         input_width     : integer := 24;
         shift_val    : integer := 8
    ); 
    port (
          input_sig      : in std_logic_vector(input_width-1 downto 0); 
          output_sig   : out std_logic_vector(input_width-1 downto 0)
    ); 
end bit_shifter;

architecture Behavioral of bit_shifter is
--    signal flip_flop : std_logic_vector(input_width-1 downto 0) := (others => '0');
begin
    output_sig <= std_logic_vector(shift_right(signed(input_sig), shift_val));

end Behavioral;
