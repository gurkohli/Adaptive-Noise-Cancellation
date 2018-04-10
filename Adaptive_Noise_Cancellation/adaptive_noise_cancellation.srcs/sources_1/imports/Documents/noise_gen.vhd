--////////////// Pseudo-Random Number Generator with LFSRs //////////////////--
-- ***********************************************************************
-- FileName: LFSR_Plus.vhd
-- FPGA: Lattice ECP2-70E
-- IDE: Lattice Diamond ver 2.0.1
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
-- Version 1.0 1/11/2012 Tony Storey
-- Initial Public Release


-------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-------------------------------------------------------
  
 
-----------------------------------------------------------------------------------------------------------------------------------
entity noise_gen is
	Generic (
				W : integer := 18;				-- LFSR scaleable from 24 down to 4 bits
				V : integer := 18;				-- LFSR for non uniform clocking scalable from 24 down to 18 bit
				g_type : integer := 0;			-- gausian distribution type, 0 = unimodal, 1 = bimodal, from g_noise_out
				u_type : integer := 0			-- uniform distribution type, 0 = uniform, 1 =  ave-uniform, from u_noise_out
			);
    Port ( 
			clk 				: 		in  STD_LOGIC;
			n_reset 			: 		in  STD_LOGIC;
			enable			: 		in  STD_LOGIC;
			g_noise_out 	:		out STD_LOGIC_VECTOR (W-1 downto 0);					-- port for bimodal/unimodal gaussian distributions
			u_noise_out 	: 		out  STD_LOGIC_VECTOR (W-1 downto 0)					-- port for uniform/ave-uniform distributions
			);
end noise_gen;
------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------
architecture arch of noise_gen is

	-- linear feedback shift register for pseudo random number generator
	signal 	seed_word 			: std_logic_vector(23 downto 0) := B"0110_0011_0111_0110_1001_1101";			-- seed for pseudo random number sequencer
	signal 	seed_word0 			: std_logic_vector(23 downto 0) := B"0011_0001_0011_0111_0110_0101";			-- seed for enable timer
	signal 	rand_out 			: std_logic_vector(W-1 downto 0);														-- used as latch for intmdt output
	-- flip flops for shift registers
	signal 	rand_ff 				: std_logic_vector(W-1 downto 0);
	signal 	rand_en_ff 			: std_logic_vector(V-1 downto 0);
	-- signals for gaussian distribution, these form bus wide shift registers
	signal 	temp_u_noise3, temp_u_noise2, temp_u_noise1, temp_u_noise0, temp_g_noise : std_logic_vector(W-1 downto 0);
	signal 	g_noise_out_reg 	:  std_logic_vector(W-1 downto 0);
	
begin

	-- LFSR for timing purposes to control output
	-- register can be scaled from 18 up to 24 bit by generic V above
	process( clk, n_reset, seed_word0, enable)
	begin
		if rising_edge(clk) then
			if(n_reset = '0') then
				rand_en_ff(V-1 downto 0) <= seed_word0(V-1 downto 0);
			elsif(enable = '1') then	-- shift reg, shift in new value based on polynomial
				case V is
					when 24 =>
						rand_en_ff <= (rand_en_ff(7) xor rand_en_ff(2) xor rand_en_ff(1) xor rand_en_ff(0)) & rand_en_ff(V-1 downto 1);  	-- x^24 + x^23 + x^22 + x^17 + 1
					when 23 =>
						rand_en_ff <= (rand_en_ff(5) xor rand_en_ff(0)) & rand_en_ff(V-1 downto 1);													-- x^23+ x^18 + 1
					when 22 =>
						rand_en_ff <= (rand_en_ff(1) xor rand_en_ff(0)) & rand_en_ff(V-1 downto 1);	   											-- x^22+ x^21 + 1					
					when 21 =>
						rand_en_ff <= (rand_en_ff(2) xor rand_en_ff(0)) & rand_en_ff(V-1 downto 1);													-- x^21+ x^19 + 1						
					when 20 =>
						rand_en_ff <= (rand_en_ff(3) xor rand_en_ff(0)) & rand_en_ff(V-1 downto 1);     												-- x^20+ x^17 + 1
					when 19 =>
						rand_en_ff <= (rand_en_ff(15) xor rand_en_ff(13) xor rand_en_ff(0)) & rand_en_ff(V-1 downto 1);  						-- x^19 + x^5 + x^2 + 1 
					when others =>
						rand_en_ff <= (rand_en_ff(7) xor rand_en_ff(0)) & rand_en_ff(V-1 downto 1);    												-- x^18 + x^11 + 1	
				end case;
			end if;
		end  if;
	end process;

 
	-- process for random number generator using LINEAR FEEDBACK SHIFT REG with polys for Maximal-length
	-- scaleable between 24 bits down to 4 bits
	process(clk, n_reset, seed_word, enable)
	begin
		if rising_edge(clk) then
			if(n_reset = '0') then
				rand_ff(W-1 downto 0) <= seed_word(W-1 downto 0);
			elsif(enable = '1') then
				case W is        
					when 24 =>
						rand_ff(W-1 downto 0) <= (rand_ff(7) xor rand_ff(2) xor rand_ff(1) xor rand_ff(0)) & rand_ff(W-1 downto 1);    		-- x^24 + x^23 + x^22 + x^17 + 1
						rand_out <=  rand_ff;
					when 23 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(5) xor rand_ff(0) ) & rand_ff(W-1 downto 1);    												-- x^23+ x^18 + 1
						rand_out <=  rand_ff;
					when 22 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(1) xor rand_ff(0) ) & rand_ff(W-1 downto 1);    												-- x^22+ x^21 + 1
						rand_out <=  rand_ff;						
					when 21 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(2) xor rand_ff(0) ) & rand_ff(W-1 downto 1);     											-- x^21+ x^19 + 1
						rand_out <=  rand_ff;								
					when 20 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(3) xor rand_ff(0) ) & rand_ff(W-1 downto 1);      											-- x^20+ x^17 + 1
						rand_out <=  rand_ff;									
					when 19 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(15) xor  rand_ff(13) xor rand_ff(0) ) & rand_ff(W-1 downto 1);     					-- x^19 + x^5 + x^2 + 1  
						rand_out <=  rand_ff;									
					when 18 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(7) xor  rand_ff(0) ) & rand_ff(W-1 downto 1);     											-- x^18 + x^11 + 1
						rand_out <=  rand_ff;							
					when 17 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(3) xor  rand_ff(0) ) & rand_ff(W-1 downto 1);     											-- x^17 + x^14 + 1
						rand_out <=  rand_ff;									
					when 16 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(5) xor rand_ff(3) xor rand_ff(2) xor  rand_ff(0) ) & rand_ff(W-1 downto 1);    	-- x^16 + x^14 + x^13 + x^11 + 1
						rand_out <=  rand_ff;										
					when 15 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(1) xor rand_ff(0) ) & rand_ff(W-1 downto 1);      											-- x^15 + x^14 + 1
						rand_out <=  rand_ff;							
					when 14 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(12) xor rand_ff(2) xor rand_ff(1) xor  rand_ff(0) ) & rand_ff(W-1 downto 1);   	-- x^14 + x^13 + x^12 + x^2 + 1
						rand_out <=  rand_ff;								
					when 13 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(5) xor rand_ff(2) xor rand_ff(1) xor  rand_ff(0) ) & rand_ff(W-1 downto 1);     	-- x^13 + x^12 + x^11 + x^8 + 1
						rand_out <=  rand_ff;							
					when 12 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(8) xor rand_ff(2) xor rand_ff(1) xor  rand_ff(0) ) & rand_ff(W-1 downto 1);			-- x^12 + x^11 + x^10 + x^4 + 1
						rand_out <=  rand_ff;										
					when 11 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(1) xor  rand_ff(0) ) & rand_ff(W-1 downto 1);      											-- x^11 + x^9 + 1
						rand_out <=  rand_ff;								
					when 10 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(3) xor  rand_ff(0) ) & rand_ff(W-1 downto 1);      											-- x^10 + x^7 + 1
						rand_out <=  rand_ff;								
					when 9 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(4) xor  rand_ff(0) ) & rand_ff(W-1 downto 1);      											-- x^9 + x^5 + 1
						rand_out <=  rand_ff;								
					when 8 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(4) xor  rand_ff(3) xor rand_ff(2) xor rand_ff(0) ) & rand_ff(W-1 downto 1);      	-- x^8 + x^6 + x^5 + x^4 + 1
						rand_out <=  rand_ff;								
					when 7 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(1) xor rand_ff(0) ) & rand_ff(W-1 downto 1);      											-- x^7 + x^6 + 1
						rand_out <=  rand_ff;									
					when 6 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(1) xor rand_ff(0) ) & rand_ff(W-1 downto 1);      											-- x^6 + x^5 + 1
						rand_out <=  rand_ff;								
					when 5 =>
						rand_ff(W-1 downto 0) <= ( rand_ff(2) xor rand_ff(0) ) & rand_ff(W-1 downto 1);      											-- x^5 + x^3 + 1
						rand_out <=  rand_ff;									
					when others =>		-- when 4	
						rand_ff(W-1 downto 0) <= (rand_ff(1) xor rand_ff(0)) & rand_ff(W-1 downto 0);														-- x^4 + x^3 + 1
						rand_out <=  rand_ff;										
				end case;
			end if;
		end if;
	end process;
	
	
	
	-- process to create distributions using the central limit theorom, variable duty cycle time multiplexing, and feedback
	process(clk, enable, rand_en_ff)
	begin
		if rising_edge(clk) then
			if (enable = '1') then
				temp_u_noise3<=   rand_out(W-1) & rand_out(W-1) & rand_out(W-1 downto 2); 								-- numbers/4 are shifted in
				temp_u_noise2<= temp_u_noise3;	
				temp_u_noise1<= temp_u_noise2;	
				temp_u_noise0 <= temp_u_noise1;	
				
				case g_type is
					when 1 =>     							-- bimodal
						temp_g_noise <= std_logic_vector(   signed(temp_u_noise3) + signed(temp_u_noise2) + 
									signed(temp_u_noise1) + signed(temp_u_noise0)  + signed(g_noise_out_reg) );  		-- numbers in shift register are added with feedback term
					when others =>  					-- unimodal
						if(rand_en_ff(9) = '1') then
							temp_g_noise <= std_logic_vector(   signed(temp_u_noise3) + signed(temp_u_noise2) + 
								signed(temp_u_noise1) + signed(temp_u_noise0)  + signed(g_noise_out_reg) );  			-- numbers in shift register are added with feedback term
						else
							temp_g_noise <= std_logic_vector(   signed(temp_u_noise3) + signed(temp_u_noise2) + 
								signed(temp_u_noise1) + signed(temp_u_noise0) );  												-- numbers in shift register are added
						end if;
				end case;
				
				case u_type is
					when 1 =>  							-- average-uniform
						if( rand_en_ff(17) = '1') then
								u_noise_out <= rand_out(W-1) & rand_out(W-1 downto 1);
						end if;
					when others =>  				-- uniform
							u_noise_out <= rand_out(W-1) & rand_out(W-1 downto 1);
				end case;	
						
			else
				temp_u_noise3 <= temp_u_noise3;			
				temp_u_noise2 <= temp_u_noise2;
				temp_u_noise1 <= temp_u_noise1;
				temp_u_noise0 <= temp_u_noise0;
				temp_g_noise <= temp_g_noise;
			end if;
		end if;
	end process;
	
	-- The outputs for the number generator, a timer controls an output multiplexer
	-- g_noise_out goes through latch for feedback purposes inlou of using a buffer	
	process(rand_en_ff, clk, enable)
	begin
		if rising_edge(clk) then
			if (enable = '1') then
				if (rand_en_ff(17) = '1') then
					g_noise_out_reg <= temp_g_noise(W-1 downto 0);
				elsif( rand_en_ff(10) = '1') then
					g_noise_out_reg <= rand_out(W-1 downto 0);
				else
					g_noise_out_reg <= g_noise_out_reg;
				end if;
			end if;
		end if;
	end process;
						
	-- latch out output reg
	g_noise_out <= g_noise_out_reg(W-1) & g_noise_out_reg(W-1) & g_noise_out_reg(W-1 downto 2); -- shifted to reduce the noise gain 
end arch;
------------------------------------------------------------------------------------------------------------------------------------