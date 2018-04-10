library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity signal_multiplexer is
Port (  clk_100 : in STD_LOGIC;
        hphone_l : out STD_LOGIC_VECTOR(23 downto 0);
        hphone_l_valid : out std_logic;
        hphone_r  : out STD_LOGIC_VECTOR(23 downto 0);
        hphone_r_valid_dummy : out  std_logic;
        
        line_in_l    : in STD_LOGIC_VECTOR(23 downto 0);
        line_in_r    : in STD_LOGIC_VECTOR(23 downto 0)
        );
end signal_multiplexer;

architecture Behavioural of signal_multiplexer is

begin
process (clk_100)
    begin
        if (clk_100'event and clk_100 = '1') then
            
            hphone_valid <= '0';
			hphone_l <= (others => '0');
			hphone_r <= (others => '0');

--            counter <= counter + 1;
            hphone_valid <= '1';

--            LED0 <= BTN0;
--            if BTN0 = '1' then
--                hphone_l(23) <= counter(17);
--                hphone_r(23) <= counter(17);
--            else 
                hphone_l <= line_in_l ;
                hphone_r <= line_in_r;
            end if;
        end if;
    end process;
end Behavioural;