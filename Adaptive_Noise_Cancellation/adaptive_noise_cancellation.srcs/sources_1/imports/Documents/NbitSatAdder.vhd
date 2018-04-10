-- LOOK AHEAD CARRY ADDER WITH OVERFLOW AND SATURATION
------------------------------------------------------------------------------------
-- ***********************************************************************
-- FileName: NbitSatAdder.vhd
-- FPGA: Xilinx Spartan 6
-- IDE: Xilinx ISE ver 13.1 
--
-- HDL IS PROVIDED "AS IS." DIGI-KEY EXPRESSLY DISCLAIMS ANY
-- WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
-- PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
-- BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
-- DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
-- PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
-- BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
-- ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
-- DIGI-KEY ALSO DISCLAIMS ANY LIABILITY FOR PATENT OR COPYRIGHT
-- INFRINGEMENT.
--
-- Version History
-- Version 1.0 2/6/2012 Tony Storey
-- Initial Public Release
-- N-bit look ahead carry combinational adder with overflow detection and saturated output 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NbitSatAdder is
	Generic(
		W : integer  := 18 						-- specify adder word width
		);
	Port(
			A_in, B_in			: in std_logic_vector(W-1 downto 0);
			sat_sum 				: out std_logic_vector(W-1 downto 0)
		);
end NbitSatAdder;

architecture arch of NbitSatAdder is
	signal Carry 		: 	std_logic_vector(W downto 0);			-- ARRAY OF CARRIES
	signal Temp_Sum 	:	std_logic_vector(W-1 downto 0);		-- TEMPORARY SUM
	signal O_Flow 		:	std_logic;									-- OVERFLOW FLAG
	signal Sat			: std_logic_vector(1 downto 0);			-- CONTROL WORD FOR COMBO LOGIC
	
begin
	
	-- GENERATE EQUATIONNS SLICE BY SLICE FOR CARRIES USING GROUP GENERATE AND GROUP PROPIGATE
	Carry(0) <= '0';		-- initial carry in is 0

	CARRY_EQ:	
		for i in 1 to W generate
			begin	
			-- determine carries by group generate			and group propigate   			and past carry
				Carry(i) <= (A_in(i-1) and B_in(i-1)) or ((A_in(i-1) xor B_in(i-1)) and Carry(i-1));
			-- determine temp_sum by 
				Temp_Sum(i-1) <= A_in(i-1) xor B_in(i-1) xor Carry(i-1);
		end generate;
	
	O_Flow <= Carry(W) xor Carry(W-1);								-- identify an overflow condition by looking at Carry in and Carry out of MSB

	SAT <= O_Flow & Temp_Sum(W-1);									-- concat two bit control word for combo logic below

	-- ASSIGN OUTPUT SUM BASED ON OVERFLOW FLAG AND MSB OF TEMP_SUM
	sat_sum <= Temp_Sum when SAT = "01" else						-- no overflow so assign temp_sum signal as output
					Temp_Sum when SAT = "00" else
					('0', others => '1') when SAT = "11" else		-- overflow with 1 in MSB so we saturate max positve  "011111... ...11"
					('1', others => '0') when SAT = "10" else		-- overflow with 0 in MSB so we saturate max negative	"100000... ...00"
					(others => '0');



end arch;
