----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2018 02:45:52 PM
-- Design Name: 
-- Module Name: signal_multiplexer - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity signal_processor_multiplexer is
Port (  clk_100 : in STD_LOGIC;
        RESET : in STD_LOGIC;
        
        SW0: in STD_LOGIC;  -- Change source
        SW1: in STD_LOGIC;  -- Turn cancellation on/off
        SW2: in STD_LOGIC;
        SW3: in STD_LOGIC;
        LED0: out STD_LOGIC;
        LED1: out STD_LOGIC;
        
        hphone_l_valid_in : in std_logic;
        hphone_l : out STD_LOGIC_VECTOR(23 downto 0);
        hphone_l_valid : out std_logic;
        hphone_r  : out STD_LOGIC_VECTOR(23 downto 0);
        
        stream_in_l    : in STD_LOGIC_VECTOR(23 downto 0);
        stream_in_r    : in STD_LOGIC_VECTOR(23 downto 0);
        
        line_in_l    : in STD_LOGIC_VECTOR(23 downto 0);
        line_in_r    : in STD_LOGIC_VECTOR(23 downto 0);
        
        filtered_signal_l : in STD_LOGIC_VECTOR(23 downto 0);
        filtered_signal_r : in STD_LOGIC_VECTOR(23 downto 0);
        
        err_sig: in STD_LOGIC_VECTOR(23 downto 0);
        
        lms_err_sig: in STD_LOGIC_VECTOR(23 downto 0)
        );
end signal_processor_multiplexer;

architecture Behavioural of signal_processor_multiplexer is
    signal hphone_out_l         : std_logic_vector(23 downto 0);
    signal hphone_out_r         : std_logic_vector(23 downto 0);
begin
    mux : process (clk_100, RESET)
        begin
            if (RESET = '0') then
                hphone_l_valid <= '0';
                hphone_out_l <= (others => '0');
                hphone_out_r <= (others => '0');
            elsif (clk_100'event and clk_100 = '1') then
                
                hphone_l_valid <= '0';
                hphone_out_l <= (others => '0');
                hphone_out_r <= (others => '0');
    
    --            counter <= counter + 1;
    
                LED0 <= SW0;
                if SW0 = '1' then
                    hphone_out_l <= line_in_l;
                    hphone_out_r <= line_in_r;
                    hphone_l_valid <= '1';
                else 
                    hphone_out_l <= stream_in_l;
                    hphone_out_r <= stream_in_r;
                    hphone_l_valid <= '1';
                end if;
            end if;
        end process;
    
    processor: process (clk_100, RESET)
            variable noise_bin_l: signed(23 downto 0)    := (others => '0');
            variable noise_bin_r: signed(23 downto 0)     := (others => '0');
            
            variable hphone_bin_l: signed(23 downto 0)     := (others => '0');
            variable hphone_bin_r: signed(23 downto 0)     := (others => '0');
        begin
            if (RESET = '0') then
                hphone_l <= (others => '0');
                hphone_r <= (others => '0');
            elsif (clk_100'event and clk_100 = '1') then
                if SW1 = '1' then
                    LED1 <= '1';
--                    noise_bin_l :=  signed(noise_l) when noise_l(23) = '0' else signed(not noise_l) + 1;
--                    noise_bin_r :=  signed(not noise_r);
                    
--                    hphone_bin_l :=  signed(hphone_out_l) + (signed(not noise_l) + 1);
--                    hphone_bin_r :=  signed(hphone_out_r) + (signed(not noise_r) + 1);
--                    hphone_l <= std_logic_vector(hphone_bin_l);
--                    hphone_r <= std_logic_vector(hphone_bin_r);

                    hphone_l <= std_logic_vector(signed(line_in_l) - signed(filtered_signal_l));
                    hphone_r <= std_logic_vector(signed(line_in_r) - signed(filtered_signal_r));
                elsif SW2 = '1' then
                    LED1 <= '1';
                    hphone_l <= err_sig;
                    hphone_r <= err_sig;
                elsif SW3 = '1' then
                    LED1 <= '1';
                    hphone_l <= lms_err_sig;
                    hphone_r <= lms_err_sig;
                else
                    LED1 <= '0';
                    hphone_l <= hphone_out_l;
                    hphone_r <= hphone_out_r;
                end if;
            end if;
        end process;
end Behavioural;