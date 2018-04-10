----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2018 03:15:32 PM
-- Design Name: 
-- Module Name: source_mux - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity source_mux is
    Port ( Control_SW : in STD_LOGIC;
           LED_Indicator : out STD_LOGIC;
           
           line_in_l : in STD_LOGIC_VECTOR (23 downto 0);
           line_in_r : in STD_LOGIC_VECTOR (23 downto 0);
           stream_in_l : in STD_LOGIC_VECTOR (23 downto 0);
           stream_in_r : in STD_LOGIC_VECTOR (23 downto 0);
           
           source_out_l : out STD_LOGIC_VECTOR (23 downto 0);
           source_out_r : out STD_LOGIC_VECTOR (23 downto 0));
end source_mux;

architecture Behavioral of source_mux is

begin
    LED_Indicator <= Control_SW;
    source_out_l <= stream_in_l when (Control_SW = '1') else line_in_l;
    source_out_r <= stream_in_r when (Control_SW = '1') else line_in_r;

end Behavioral;
