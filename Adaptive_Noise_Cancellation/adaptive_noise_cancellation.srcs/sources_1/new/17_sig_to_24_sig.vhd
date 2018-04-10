----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2018 04:02:04 PM
-- Design Name: 
-- Module Name: 17_sig_to_24_sig - Behavioral
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

entity signal_width_changer is
    Port ( 
        input_sig : in STD_LOGIC_VECTOR (17 downto 0);
        output_sig : out STD_LOGIC_VECTOR (23 downto 0)
    );
end signal_width_changer;

architecture Behavioral of signal_width_changer is

begin
    output_sig <= "00" & input_sig & "0000";
end Behavioral;
