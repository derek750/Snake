set bench sim:/${1}
add wave -label {Clock} $bench/clk
add wave -label {Reset} $bench/reset
add wave -label {Movement tick} $bench/dut/move_tick
add wave -label {Move allowed} $bench/dut/move_enable
add wave -label {Wall collision} $bench/dut/wall_collision
add wave -label {Body collision} $bench/dut/body_collision
add wave -label {Game over} $bench/dut/game_over
add wave -label {Direction code} -radix binary $bench/movement_direction
add wave -divider {Proposed head}
add wave -label {Next head X} -radix unsigned $bench/dut/next_head_x
add wave -label {Next head Y} -radix unsigned $bench/dut/next_head_y
add wave -divider {Stored head}
add wave -label {Current head X} -radix unsigned $bench/dut/head_x
add wave -label {Current head Y} -radix unsigned $bench/dut/head_y
add wave -divider {Selected segment}
add wave -label {Segment index} -radix unsigned $bench/read_index
add wave -label {Segment X} -radix unsigned $bench/read_x
add wave -label {Segment Y} -radix unsigned $bench/read_y
