----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2018 07:20:18 PM
-- Design Name: 
-- Module Name: slow_clock - Behavioral
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

entity slow_clock is
    generic(
         lsb_val    : integer := 2
    ); 
    Port ( 
           rst  : in std_logic;
           clk_100 : in STD_LOGIC;
           slow_clk_out : out STD_LOGIC);
end slow_clock;

architecture Behavioral of slow_clock is
    signal clk_divider  : unsigned(11 downto 0);
begin
gen_clk: process(rst, clk_100)
	begin
	   if(rst = '0') then
	       clk_divider <= (others => '0');
	   elsif(clk_100'event and clk_100 = '1') then
	       if clk_divider = "111111111111" then
	           clk_divider <= (others => '0');
	       else
	           clk_divider <= clk_divider + 1;
	       end if;
	   end if;
	end process;
slow_clk_out <= clk_divider(lsb_val);
end Behavioral;
