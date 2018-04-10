----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2018 03:20:04 PM
-- Design Name: 
-- Module Name: filter_control - Behavioral
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

entity filter_control is
    Port (
           Filter_Enable_SW : in STD_LOGIC;
           Filter_Control_SW : in STD_LOGIC;
           Filter_Enable_LED : out STD_LOGIC;
           Filter_Control_LED : out STD_LOGIC;

           source_in_l : in STD_LOGIC_VECTOR (23 downto 0);
           source_in_r : in STD_LOGIC_VECTOR (23 downto 0);
           unfiltered_in_l : in STD_LOGIC_VECTOR (23 downto 0);
           unfiltered_in_r : in STD_LOGIC_VECTOR (23 downto 0);
           filtered_in_l : in STD_LOGIC_VECTOR (23 downto 0);
           filtered_in_r : in STD_LOGIC_VECTOR (23 downto 0);
           
           signal_out_l : out STD_LOGIC_VECTOR (23 downto 0);
           signal_out_r : out STD_LOGIC_VECTOR (23 downto 0));
end filter_control;

architecture Behavioral of filter_control is
    signal temp_l : STD_LOGIC_VECTOR (23 downto 0);
    signal temp_r : STD_LOGIC_VECTOR (23 downto 0);
begin
    Filter_Enable_LED <= Filter_Enable_SW;
    Filter_Control_LED <= Filter_Control_SW;
    
    temp_l <= filtered_in_l when (Filter_Control_SW = '1') else unfiltered_in_l;
    temp_r <= filtered_in_r when (Filter_Control_SW = '1') else unfiltered_in_r;
    
    signal_out_l <= temp_l when (Filter_Enable_SW = '1') else source_in_l;
    signal_out_r <= temp_r when (Filter_Enable_SW = '1') else source_in_r; 

end Behavioral;
