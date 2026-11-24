set bench sim:/${1}
add wave -label {Clock} $bench/clk
add wave -label {Reset} $bench/reset
add wave -label {Cycle count} -radix unsigned $bench/dut/count
add wave -label {Movement tick} $bench/move_tick
