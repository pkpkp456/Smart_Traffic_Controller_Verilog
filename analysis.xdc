## Clock Input
set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_ports clk]  # optional, if not using dedicated clock pins

## Reset Input
set_property PACKAGE_PIN D3 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

## Traffic density inputs (TA[1:0], TB[1:0], TC[1:0], TD[1:0])
set_property PACKAGE_PIN F4 [get_ports {TA[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TA[0]}]

set_property PACKAGE_PIN F3 [get_ports {TA[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TA[1]}]

set_property PACKAGE_PIN G4 [get_ports {TB[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TB[0]}]

set_property PACKAGE_PIN G3 [get_ports {TB[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TB[1]}]

set_property PACKAGE_PIN H4 [get_ports {TC[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TC[0]}]

set_property PACKAGE_PIN H3 [get_ports {TC[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TC[1]}]

set_property PACKAGE_PIN J4 [get_ports {TD[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TD[0]}]

set_property PACKAGE_PIN J3 [get_ports {TD[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TD[1]}]

## Vehicle presence inputs (VA, VB, VC, VD)
set_property PACKAGE_PIN K4 [get_ports VA]
set_property IOSTANDARD LVCMOS33 [get_ports VA]

set_property PACKAGE_PIN K3 [get_ports VB]
set_property IOSTANDARD LVCMOS33 [get_ports VB]

set_property PACKAGE_PIN L4 [get_ports VC]
set_property IOSTANDARD LVCMOS33 [get_ports VC]

set_property PACKAGE_PIN L3 [get_ports VD]
set_property IOSTANDARD LVCMOS33 [get_ports VD]

## Emergency mode input
set_property PACKAGE_PIN M4 [get_ports emg_mode]
set_property IOSTANDARD LVCMOS33 [get_ports emg_mode]

## Emergency road select inputs (ER[1:0])
set_property PACKAGE_PIN M3 [get_ports ER[0]]
set_property IOSTANDARD LVCMOS33 [get_ports ER[0]]

set_property PACKAGE_PIN N4 [get_ports ER[1]]
set_property IOSTANDARD LVCMOS33 [get_ports ER[1]]

## Green light outputs (GA, GB, GC, GD)
set_property PACKAGE_PIN P4 [get_ports GA]
set_property IOSTANDARD LVCMOS33 [get_ports GA]

set_property PACKAGE_PIN P3 [get_ports GB]
set_property IOSTANDARD LVCMOS33 [get_ports GB]

set_property PACKAGE_PIN R4 [get_ports GC]
set_property IOSTANDARD LVCMOS33 [get_ports GC]

set_property PACKAGE_PIN R3 [get_ports GD]
set_property IOSTANDARD LVCMOS33 [get_ports GD]

## Yellow light outputs (YA, YB, YC, YD)
set_property PACKAGE_PIN T4 [get_ports YA]
set_property IOSTANDARD LVCMOS33 [get_ports YA]

set_property PACKAGE_PIN T3 [get_ports YB]
set_property IOSTANDARD LVCMOS33 [get_ports YB]

set_property PACKAGE_PIN U4 [get_ports YC]
set_property IOSTANDARD LVCMOS33 [get_ports YC]

set_property PACKAGE_PIN U3 [get_ports YD]
set_property IOSTANDARD LVCMOS33 [get_ports YD]

## Red light outputs (RA, RB, RC, RD)
set_property PACKAGE_PIN V4 [get_ports RA]
set_property IOSTANDARD LVCMOS33 [get_ports RA]

set_property PACKAGE_PIN V3 [get_ports RB]
set_property IOSTANDARD LVCMOS33 [get_ports RB]

set_property PACKAGE_PIN W4 [get_ports RC]
set_property IOSTANDARD LVCMOS33 [get_ports RC]

set_property PACKAGE_PIN W3 [get_ports RD]
set_property IOSTANDARD LVCMOS33 [get_ports RD]

## 7-seg display outputs (seg[6:0])
set_property PACKAGE_PIN Y4 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN Y3 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]

set_property PACKAGE_PIN AA4 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]

set_property PACKAGE_PIN AA3 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]

set_property PACKAGE_PIN AB4 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]

set_property PACKAGE_PIN AB3 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]

set_property PACKAGE_PIN AC4 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

## Timer output (timer_out[7:0]) - optional to assign pins, here assigned as example
set_property PACKAGE_PIN AC3 [get_ports {timer_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {timer_out[0]}]

set_property PACKAGE_PIN AD4 [get_ports {timer_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {timer_out[1]}]

set_property PACKAGE_PIN AD3 [get_ports {timer_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {timer_out[2]}]

set_property PACKAGE_PIN AE4 [get_ports {timer_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {timer_out[3]}]

set_property PACKAGE_PIN AE3 [get_ports {timer_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {timer_out[4]}]

set_property PACKAGE_PIN AF4 [get_ports {timer_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {timer_out[5]}]

set_property PACKAGE_PIN AF3 [get_ports {timer_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {timer_out[6]}]

set_property PACKAGE_PIN AG4 [get_ports {timer_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {timer_out[7]}]

create_clock -name clk -period 10.000 [get_ports clk]
