set bench sim:/${1}
add wave -label {Clock} $bench/clk
add wave -label {Reset} $bench/reset
add wave -label {PS2 clock} $bench/ps2_clk
add wave -label {PS2 data} $bench/ps2_dat
add wave -label {Last actual direction} -radix binary $bench/current_direction
add wave -label {Requested direction} -radix binary $bench/movement_direction
add wave -label {Received bit count} -radix unsigned $bench/dut.bit_count
add wave -label {Scan code} -radix hexadecimal $bench/dut.data_byte
add wave -label {Key release prefix} $bench/dut.break_pending
add wave -label {Extended prefix} $bench/dut.extended_pending
