----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2018 03:19:20 PM
-- Design Name: 
-- Module Name: simple_noise_filter - Behavioral
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

entity simple_noise_filter is
    Port ( input_sig : in STD_LOGIC_VECTOR (23 downto 0);
           desired_sig : in STD_LOGIC_VECTOR (23 downto 0);
           output_sig: out STD_LOGIC_VECTOR (23 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end simple_noise_filter;

architecture Behavioral of simple_noise_filter is
    signal err : signed(23 downto 0);
begin
    process(clk, reset)
    begin
        if (reset = '0') then
            output_sig <= (others => '0');
        elsif (clk'event and clk = '1') then
            err <= signed(input_sig) - signed(desired_sig);
            output_sig <= std_logic_vector(err);
        end if;
    end process;
end Behavioral;
