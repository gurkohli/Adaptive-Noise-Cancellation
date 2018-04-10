--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
--Date        : Wed Apr  4 20:19:42 2018
--Host        : ensc-pit-16 running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    AC_ADR0 : out STD_LOGIC;
    AC_ADR1 : out STD_LOGIC;
    AC_GPIO0 : out STD_LOGIC;
    AC_GPIO1 : in STD_LOGIC;
    AC_GPIO2 : in STD_LOGIC;
    AC_GPIO3 : in STD_LOGIC;
    AC_MCLK : out STD_LOGIC;
    AC_SCK : out STD_LOGIC;
    AC_SDA : inout STD_LOGIC;
    BTND : in STD_LOGIC;
    DC : out STD_LOGIC;
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    JA1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    JA2 : out STD_LOGIC;
    JA3 : in STD_LOGIC;
    JA4 : out STD_LOGIC;
    JB1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    JB2 : out STD_LOGIC;
    JB3 : in STD_LOGIC;
    JB4 : out STD_LOGIC;
    LD0 : out STD_LOGIC;
    LD1 : out STD_LOGIC;
    LD2 : out STD_LOGIC;
    LD7 : out STD_LOGIC;
    RES : out STD_LOGIC;
    SCLK : out STD_LOGIC;
    SDIN : out STD_LOGIC;
    SW0 : in STD_LOGIC;
    SW1 : in STD_LOGIC;
    SW2 : in STD_LOGIC;
    SW3 : in STD_LOGIC;
    SW4 : in STD_LOGIC;
    SW5 : in STD_LOGIC;
    SW6 : in STD_LOGIC;
    SW7 : in STD_LOGIC;
    VBAT : out STD_LOGIC;
    VDD : out STD_LOGIC;
    clk_100 : in STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    SW4 : in STD_LOGIC;
    SW5 : in STD_LOGIC;
    JA3 : in STD_LOGIC;
    JA4 : out STD_LOGIC;
    JA2 : out STD_LOGIC;
    clk_100 : in STD_LOGIC;
    SW6 : in STD_LOGIC;
    BTND : in STD_LOGIC;
    SW3 : in STD_LOGIC;
    SDIN : out STD_LOGIC;
    SCLK : out STD_LOGIC;
    DC : out STD_LOGIC;
    RES : out STD_LOGIC;
    VBAT : out STD_LOGIC;
    VDD : out STD_LOGIC;
    AC_GPIO1 : in STD_LOGIC;
    AC_GPIO3 : in STD_LOGIC;
    AC_GPIO2 : in STD_LOGIC;
    AC_ADR0 : out STD_LOGIC;
    AC_ADR1 : out STD_LOGIC;
    AC_GPIO0 : out STD_LOGIC;
    AC_MCLK : out STD_LOGIC;
    AC_SCK : out STD_LOGIC;
    AC_SDA : inout STD_LOGIC;
    JB1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    JA1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    SW0 : in STD_LOGIC;
    JB2 : out STD_LOGIC;
    JB4 : out STD_LOGIC;
    JB3 : in STD_LOGIC;
    SW1 : in STD_LOGIC;
    SW2 : in STD_LOGIC;
    LD0 : out STD_LOGIC;
    LD1 : out STD_LOGIC;
    LD2 : out STD_LOGIC;
    SW7 : in STD_LOGIC;
    LD7 : out STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      AC_ADR0 => AC_ADR0,
      AC_ADR1 => AC_ADR1,
      AC_GPIO0 => AC_GPIO0,
      AC_GPIO1 => AC_GPIO1,
      AC_GPIO2 => AC_GPIO2,
      AC_GPIO3 => AC_GPIO3,
      AC_MCLK => AC_MCLK,
      AC_SCK => AC_SCK,
      AC_SDA => AC_SDA,
      BTND => BTND,
      DC => DC,
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      JA1(0) => JA1(0),
      JA2 => JA2,
      JA3 => JA3,
      JA4 => JA4,
      JB1(0) => JB1(0),
      JB2 => JB2,
      JB3 => JB3,
      JB4 => JB4,
      LD0 => LD0,
      LD1 => LD1,
      LD2 => LD2,
      LD7 => LD7,
      RES => RES,
      SCLK => SCLK,
      SDIN => SDIN,
      SW0 => SW0,
      SW1 => SW1,
      SW2 => SW2,
      SW3 => SW3,
      SW4 => SW4,
      SW5 => SW5,
      SW6 => SW6,
      SW7 => SW7,
      VBAT => VBAT,
      VDD => VDD,
      clk_100 => clk_100
    );
end STRUCTURE;
