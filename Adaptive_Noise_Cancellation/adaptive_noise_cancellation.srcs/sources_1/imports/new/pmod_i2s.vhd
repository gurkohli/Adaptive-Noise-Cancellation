---------------------------------------------------------------------------------
-- Engineer:      Klimann Wendelin 
--
-- Create Date:   07:25:11 11/Okt/2013
-- Design Name:   i2s_in
--
-- Description:   
-- 
-- This module provides a bridge between an I2S serial device (audio ADC, S/PDIF 
-- Decoded data) and a parallel device (microcontroller, IP block).
--
-- It's coded as a generic VHDL entity, so developer can choose the proper signal
-- width (8/16/24/32 bit)
--
-- Input takes:
-- -I2S Data
-- -I2S Bit Clock
-- -I2S LR Clock (Left/Right channel indication)
--
-- Output provides:
-- -DATA_L / DATA_R parallel inputs
-- -DATA_RDY_L / DATA_RDY_R output ready signals.
-- 
--
-- The data from the parallel inputs is shifted to the I2S data output
--
--------------------------------------------------------------------------------
-- I2S Waveform summary
--
-- BIT_CK     __    __   __    __    __            __    __    __    __   
--           | 1|__| 2|_| 3|__| 4|__| 5|__... ... |32|__| 1|__| 2|__| 3| ...
--
-- LR_CK                                  ... ...     ___________________
--           ____________L_Channel_Data______________|   R Channel Data ...
--
-- DATA      x< 00 ><D24><D22><D21><D20>  ... ...     < 00 ><D24><D23>  ...
--
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity pmod_i2s is 
-- width: How many bits (from MSB) are gathered from the serial I2S input
generic(width : integer := 32);

port(
	--  I2S ports
	CLK       : in  std_logic;
	LR_CLK    : out  std_logic;      --Left/Right indicator clock
	BIT_CLK   : out  std_logic;      --Bit clock
	DIN       : in  std_logic;      --Data Input
	
	-- Control ports
	RESET     : in  std_logic;      --Asynchronous Reset (Active Low)
	
	-- Parallel ports
	DATA_L    : out std_logic_vector(23 downto 0);
	DATA_R    : out std_logic_vector(23 downto 0)
);
end pmod_i2s;


architecture rtl of pmod_i2s is
    
    signal clk_divider         : unsigned(11 downto 0);

	--signals 
	signal shift_reg           : std_logic_vector(width-1 downto 0);
	signal s_current_lr        : std_logic;
	signal s_current_lr_delay  : std_logic;
		
begin
    LR_CLK <= clk_divider(11);
    BIT_CLK <= clk_divider(5);
	-- serial to parallel interface
	gen_clk: process(RESET, CLK)
	begin
	   if(RESET = '0') then
	       clk_divider <= (others => '0');
	   elsif(CLK'event and CLK = '0') then
	       if clk_divider = "111111111111" then
	           clk_divider <= (others => '0');
	       else
	           clk_divider <= clk_divider + 1;
	       end if;
	   end if;
	end process;

	i2s_in: process(RESET, clk_divider(5))
	begin
		if(RESET = '0') then
		
			DATA_L     <= (others => '0');
			DATA_R     <= (others => '0');
			shift_reg  <= (others => '0');
			
			s_current_lr     <= '0';
			s_current_lr_delay <= '0';
			
        elsif(clk_divider(5)'event and clk_divider(5)= '0') then
            s_current_lr <= s_current_lr_delay;
            if(s_current_lr = clk_divider(11)) then
                -- Push data into the shift register
                shift_reg(31 downto 1) <= shift_reg(30 downto 0);
                shift_reg(0) <= DIN;
            else
                if (s_current_lr = '1') then
                    DATA_R <= shift_reg(width-1 downto width-1-17) & shift_reg(width-1 downto width-1-5);
                else
                    DATA_L <= shift_reg(width-1 downto width-1-17) & shift_reg(width-1 downto width-1-5);
                end if;
                s_current_lr_delay <= clk_divider(11);
            end if;
		end if; -- reset / rising_edge
	end process i2s_in;
end rtl;