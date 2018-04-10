----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 07:01:08 PM
-- Design Name: 
-- Module Name: noise_mux - Behavioral
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

entity multiplexer_24_bit is
    Port ( 
           Control_SW : in STD_LOGIC;
           SW_High_Val : in STD_LOGIC_VECTOR (23 downto 0);
           SW_Low_Val : in STD_LOGIC_VECTOR (23 downto 0);
           Output_Val : out STD_LOGIC_VECTOR (23 downto 0));
end multiplexer_24_bit;

architecture Behavioral of multiplexer_24_bit is

begin
    Output_Val <= SW_High_Val when (Control_SW = '1') else SW_Low_Val;
end Behavioral;
