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

-- IP VLNV: xilinx.com:module_ref:filter_control:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_filter_control_0_0 IS
  PORT (
    Filter_Enable_SW : IN STD_LOGIC;
    Filter_Control_SW : IN STD_LOGIC;
    Filter_Enable_LED : OUT STD_LOGIC;
    Filter_Control_LED : OUT STD_LOGIC;
    source_in_l : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    source_in_r : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    unfiltered_in_l : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    unfiltered_in_r : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    filtered_in_l : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    filtered_in_r : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    signal_out_l : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
    signal_out_r : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END design_1_filter_control_0_0;

ARCHITECTURE design_1_filter_control_0_0_arch OF design_1_filter_control_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_filter_control_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT filter_control IS
    PORT (
      Filter_Enable_SW : IN STD_LOGIC;
      Filter_Control_SW : IN STD_LOGIC;
      Filter_Enable_LED : OUT STD_LOGIC;
      Filter_Control_LED : OUT STD_LOGIC;
      source_in_l : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      source_in_r : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      unfiltered_in_l : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      unfiltered_in_r : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      filtered_in_l : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      filtered_in_r : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      signal_out_l : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
      signal_out_r : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
    );
  END COMPONENT filter_control;
BEGIN
  U0 : filter_control
    PORT MAP (
      Filter_Enable_SW => Filter_Enable_SW,
      Filter_Control_SW => Filter_Control_SW,
      Filter_Enable_LED => Filter_Enable_LED,
      Filter_Control_LED => Filter_Control_LED,
      source_in_l => source_in_l,
      source_in_r => source_in_r,
      unfiltered_in_l => unfiltered_in_l,
      unfiltered_in_r => unfiltered_in_r,
      filtered_in_l => filtered_in_l,
      filtered_in_r => filtered_in_r,
      signal_out_l => signal_out_l,
      signal_out_r => signal_out_r
    );
END design_1_filter_control_0_0_arch;
