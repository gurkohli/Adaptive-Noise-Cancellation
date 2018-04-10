library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all; 

entity my_alu is
    generic (
        width_g : integer := 24
    );
    port (
    
        clk_i : in std_logic;
        reset_i : in std_logic;
        
        a_i : in std_logic_vector(width_g-1 downto 0);
        b_i : in std_logic_vector(width_g-1 downto 0);
        
        sum_o : out std_logic_vector(width_g-1 downto 0);
        sum_saturation_o : out std_logic
        
    );
end my_alu;

architecture behavioral of my_alu is

    signal sum_s : std_logic_vector(width_g-1 downto 0);
    signal sum_saturation_s : std_logic;

begin

    sum_o <= sum_s;
    sum_saturation_o <= sum_saturation_s;

    process( clk_i )
        variable sum_v : std_logic_vector(width_g downto 0);
    begin
        if ( reset_i = '0' ) then
            sum_s <= (others => '0');
            sum_saturation_s <= '0';
        else
            if ( rising_edge( clk_i ) ) then
                sum_v := ("0" & a_i) + b_i;
                sum_saturation_s <= '0';
                if ( sum_v(width_g) = '1' ) then
                    sum_v := (others => '1');
                    sum_saturation_s <= '1';
                end if;
                sum_s <= sum_v(width_g-1 downto 0);
            end if;
        end if;
    end process;

end behavioral;