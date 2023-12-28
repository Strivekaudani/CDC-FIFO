##################################
# Input/Output Constraints File
##################################
set CLK_PERIOD 10.00 
set CLK_LATENCY 3.00
set CLK_SKEW 0.50
set CLK_JITTER 0.20
set SETUP_UNCERTAINTY [expr $CLK_SKEW + $CLK_JITTER]
set INPUT_DELAY 2.00
set OUTPUT_DELAY 2.00

## Clock constraints
create_clock clk -period $CLK_PERIOD -waveform {0.0 5.0}
set_clock_latency $CLK_LATENCY clk
set_clock_uncertainty -setup $SETUP_UNCERTAINTY clk
set_clock_uncertainty -hold $CLK_SKEW clk
set_clock_transition -rise 0.1 clk
set_clock_transition -fall 0.12 clk

# Virtual clock for input/output signals
create_clock -name v_clk -period $CLK_PERIOD -waveform {0.0 5.0}

# Max transition/capacitance
set_max_transition 1.5 [current_design]
set_max_capacitance 0.5 [current_design]

# Input constraints
set_input_delay $INPUT_DELAY -clock v_clk [remove_from_collection [all_inputs] clk]
set_max_fanout 1 [all_inputs]
set_input_transition -rise 0.1 [all_inputs]
set_input_transition -fall 0.12 [all_inputs]

# Outputs constraints
set_output_delay $OUTPUT_DELAY -clock v_clk [all_outputs]
set_load 0.2 [all_outputs]
