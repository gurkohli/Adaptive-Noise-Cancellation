-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:module_ref:pmod_i2s:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_pmod_i2s_1_0 IS
  PORT (
    CLK : IN STD_LOGIC;
    LR_CLK : OUT STD_LOGIC;
    BIT_CLK : OUT STD_LOGIC;
    DIN : IN STD_LOGIC;
    RESET : IN STD_LOGIC;
    DATA_L : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    DATA_R : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END design_1_pmod_i2s_1_0;

ARCHITECTURE design_1_pmod_i2s_1_0_arch OF design_1_pmod_i2s_1_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_pmod_i2s_1_0_arch: ARCHITECTURE IS "yes";
  COMPONENT pmod_i2s IS
    GENERIC (
      width : INTEGER
    );
    PORT (
      CLK : IN STD_LOGIC;
      LR_CLK : OUT STD_LOGIC;
      BIT_CLK : OUT STD_LOGIC;
      DIN : IN STD_LOGIC;
      RESET : IN STD_LOGIC;
      DATA_L : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
      DATA_R : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
    );
  END COMPONENT pmod_i2s;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF RESET: SIGNAL IS "XIL_INTERFACENAME RESET, POLARITY ACTIVE_LOW, PortWidth 2";
  ATTRIBUTE X_INTERFACE_INFO OF RESET: SIGNAL IS "xilinx.com:signal:reset:1.0 RESET RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF BIT_CLK: SIGNAL IS "XIL_INTERFACENAME BIT_CLK, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_pmod_i2s_1_0_BIT_CLK";
  ATTRIBUTE X_INTERFACE_INFO OF BIT_CLK: SIGNAL IS "xilinx.com:signal:clock:1.0 BIT_CLK CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF LR_CLK: SIGNAL IS "XIL_INTERFACENAME LR_CLK, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_pmod_i2s_1_0_LR_CLK";
  ATTRIBUTE X_INTERFACE_INFO OF LR_CLK: SIGNAL IS "xilinx.com:signal:clock:1.0 LR_CLK CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF CLK: SIGNAL IS "XIL_INTERFACENAME CLK, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_1_FCLK_CLK0";
  ATTRIBUTE X_INTERFACE_INFO OF CLK: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK CLK";
BEGIN
  U0 : pmod_i2s
    GENERIC MAP (
      width => 32
    )
    PORT MAP (
      CLK => CLK,
      LR_CLK => LR_CLK,
      BIT_CLK => BIT_CLK,
      DIN => DIN,
      RESET => RESET,
      DATA_L => DATA_L,
      DATA_R => DATA_R
    );
END design_1_pmod_i2s_1_0_arch;
