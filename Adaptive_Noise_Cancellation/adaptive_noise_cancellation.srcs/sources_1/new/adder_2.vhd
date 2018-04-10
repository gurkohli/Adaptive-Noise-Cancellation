library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity adder_full_signed_reg is
generic(
  N             : integer := 24);
port (
  i_clk       : in     std_logic;
  i_add1      : in     std_logic_vector(N-1 downto 0);
  i_add2      : in     std_logic_vector(N-1 downto 0);
  o_sum       : out    std_logic_vector(N-1 downto 0));
end adder_full_signed_reg;
architecture rtl of adder_full_signed_reg is
signal r_add1   : signed(N downto 0);
signal r_add2   : signed(N downto 0);
signal w_sum    : signed(N downto 0);
begin
-- combinatorial adder
  w_sum <= r_add1 + r_add2;
r_process : process(i_clk)
begin
  if(rising_edge(i_clk)) then
  
  -- register input and extend sign
    r_add1      <=  resize(signed(i_add1),N+1);
    r_add2      <=  resize(signed(i_add2),N+1);
    
  -- register output
    o_sum       <= std_logic_vector(resize(w_sum, N));
    
  end if;
end process r_process;
end rtl;