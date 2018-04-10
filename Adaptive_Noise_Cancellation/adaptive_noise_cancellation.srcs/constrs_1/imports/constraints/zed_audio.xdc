# timing constraints
create_clock -period 10.000 -name clk_100 -waveform {0.000 5.000} [get_ports clk_100]

set_false_path -from [get_clocks zed_audio_clk_48M] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks zed_audio_clk_48M_]

set_false_path -from [get_clocks zed_audio_clk_48M_1] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks zed_audio_clk_48M_1]

# 100 mhz clock
set_property PACKAGE_PIN Y9 [get_ports clk_100]

# 24 mhz clock to audio chip
set_property PACKAGE_PIN AB2 [get_ports AC_MCLK]


# I2S transfers audio samples
# i2s bit clock to ADAU1761
set_property PACKAGE_PIN Y8 [get_ports AC_GPIO0]

# i2s bit clock from ADAU1761
set_property PACKAGE_PIN AA7 [get_ports AC_GPIO1]

# i2s bit clock from ADAU1761
set_property PACKAGE_PIN AA6 [get_ports AC_GPIO2]

# i2s l/r 48 khz toggling signal from ADAU1761 (sample clock)
set_property PACKAGE_PIN Y6 [get_ports AC_GPIO3]


# I2C Data Interface to ADAU1761 (for configuration)
set_property PACKAGE_PIN AB4 [get_ports AC_SCK]

set_property PACKAGE_PIN AB5 [get_ports AC_SDA]

set_property PACKAGE_PIN AB1 [get_ports AC_ADR0]

set_property PACKAGE_PIN Y5 [get_ports AC_ADR1]

# ----------------------------------------------------------------------------
# JA Pmod - Bank 13
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN Y11 [get_ports {JA1[0]}]
#set_property PACKAGE_PIN AA8  [get_ports {JA10}];  # "JA10"
set_property PACKAGE_PIN AA11 [get_ports JA2]
set_property PACKAGE_PIN Y10 [get_ports JA3]
set_property PACKAGE_PIN AA9 [get_ports JA4]
#set_property PACKAGE_PIN AB11 [get_ports {JA7}];  # "JA7"
#set_property PACKAGE_PIN AB10 [get_ports {JA8}];  # "JA8"
#set_property PACKAGE_PIN AB9  [get_ports {JA9}];  # "JA9"

## ----------------------------------------------------------------------------
## JB Pmod - Bank 13
## ----------------------------------------------------------------------------
set_property PACKAGE_PIN W12 [get_ports {JB1[0]}]
#set_property PACKAGE_PIN V8 [get_ports {JB10}];  # "JB10"
set_property PACKAGE_PIN W11 [get_ports JB2]
set_property PACKAGE_PIN V10 [get_ports JB3]
set_property PACKAGE_PIN W8 [get_ports JB4]
#set_property PACKAGE_PIN V12 [get_ports {JB7}];  # "JB7"
#set_property PACKAGE_PIN W10 [get_ports {JB8}];  # "JB8"
#set_property PACKAGE_PIN V9 [get_ports {JB9}];  # "JB9"

## ----------------------------------------------------------------------------
## User Push Buttons - Bank 34
## ----------------------------------------------------------------------------
#set_property PACKAGE_PIN P16 [get_ports {BTNC}];  # "BTNC"
set_property PACKAGE_PIN R16 [get_ports BTND];  # "BTND"
#set_property PACKAGE_PIN N15 [get_ports {BTNL}];  # "BTNL"
#set_property PACKAGE_PIN R18 [get_ports {BTNR}];  # "BTNR"
#set_property PACKAGE_PIN T18 [get_ports {BTNU}];  # "BTNU"


## ----------------------------------------------------------------------------
## User DIP Switches - Bank 35
## ----------------------------------------------------------------------------
set_property PACKAGE_PIN F22 [get_ports SW0]
set_property PACKAGE_PIN G22 [get_ports SW1]
set_property PACKAGE_PIN H22 [get_ports SW2]
set_property PACKAGE_PIN F21 [get_ports SW3]
set_property PACKAGE_PIN H19 [get_ports SW4]
set_property PACKAGE_PIN H18 [get_ports SW5]
set_property PACKAGE_PIN H17 [get_ports SW6]
set_property PACKAGE_PIN M15 [get_ports SW7]

## ----------------------------------------------------------------------------
## User LEDs - Bank 33
## ----------------------------------------------------------------------------
set_property PACKAGE_PIN T22 [get_ports LD0]
set_property PACKAGE_PIN T21 [get_ports LD1]
set_property PACKAGE_PIN U22 [get_ports LD2];  # "LD2"
#set_property PACKAGE_PIN U21 [get_ports {LD3}];  # "LD3"
#set_property PACKAGE_PIN V22 [get_ports {LD4}];  # "LD4"
#set_property PACKAGE_PIN W22 [get_ports {LD5}];  # "LD5"
#set_property PACKAGE_PIN U19 [get_ports {LD6}];  # "LD6"
set_property PACKAGE_PIN U14 [get_ports LD7];  # "LD7"


set_property PACKAGE_PIN U10 [get_ports DC]
set_property PACKAGE_PIN U9 [get_ports RES]
set_property PACKAGE_PIN AB12 [get_ports SCLK]
set_property PACKAGE_PIN AA12 [get_ports SDIN]
set_property PACKAGE_PIN U11 [get_ports VBAT]
set_property PACKAGE_PIN U12 [get_ports VDD]
set_property IOSTANDARD LVCMOS33 [get_ports DC]
set_property IOSTANDARD LVCMOS33 [get_ports RES]
set_property IOSTANDARD LVCMOS33 [get_ports SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports SDIN]
set_property IOSTANDARD LVCMOS33 [get_ports VBAT]
set_property IOSTANDARD LVCMOS33 [get_ports VDD]

## Note that the bank voltage for IO Bank 33 is fixed to 3.3V on ZedBoard.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]]

## Set the bank voltage for IO Bank 34 to 1.8V by default.
## set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 34]];
#set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];


## Set the bank voltage for IO Bank 35 to 1.8V by default.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]]
## set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 35]];
#set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]];

## Note that the bank voltage for IO Bank 13 is fixed to 3.3V on ZedBoard.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]]






set_property IOSTANDARD LVCMOS33 [get_ports SW7]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
