###############################################################################
# Created by write_sdc
# Fri May 22 00:57:37 2026
###############################################################################
current_design top
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 37.0400 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {STABLE_CYCLES[0]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {STABLE_CYCLES[1]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {STABLE_CYCLES[2]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {STABLE_CYCLES[3]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {STABLE_CYCLES[4]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {STABLE_CYCLES[5]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {THRESHOLD[0]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {THRESHOLD[1]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {THRESHOLD[2]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {THRESHOLD[3]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {THRESHOLD[4]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {THRESHOLD[5]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {THRESHOLD[6]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {WINDOW_SIZE[0]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {WINDOW_SIZE[1]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {WINDOW_SIZE[2]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {WINDOW_SIZE[3]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {WINDOW_SIZE[4]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {WINDOW_SIZE[5]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {WINDOW_SIZE[6]}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {async_in}]
set_input_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {rst_n}]
set_output_delay 7.4080 -clock [get_clocks {clk}] -add_delay [get_ports {fault_detected}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {fault_detected}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {async_in}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rst_n}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {STABLE_CYCLES[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {STABLE_CYCLES[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {STABLE_CYCLES[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {STABLE_CYCLES[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {STABLE_CYCLES[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {STABLE_CYCLES[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {THRESHOLD[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {THRESHOLD[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {THRESHOLD[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {THRESHOLD[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {THRESHOLD[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {THRESHOLD[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {THRESHOLD[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {WINDOW_SIZE[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {WINDOW_SIZE[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {WINDOW_SIZE[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {WINDOW_SIZE[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {WINDOW_SIZE[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {WINDOW_SIZE[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {WINDOW_SIZE[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]
