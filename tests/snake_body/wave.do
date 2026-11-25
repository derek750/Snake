set bench sim:/${1}
add wave -label {Clock} $bench/clk
add wave -label {Reset} $bench/reset
add wave -label {Movement tick} $bench/move_tick
add wave -label {Grow} $bench/grow
add wave -label {Next head X} -radix unsigned $bench/next_head_x
add wave -label {Next head Y} -radix unsigned $bench/next_head_y
add wave -label {Current head X} -radix unsigned $bench/head_x
add wave -label {Current head Y} -radix unsigned $bench/head_y
add wave -label {Snake length} -radix unsigned $bench/length
add wave -label {Segment index} -radix unsigned $bench/read_index
add wave -label {Segment read valid} $bench/read_valid
add wave -label {Segment X} -radix unsigned $bench/read_x
add wave -label {Segment Y} -radix unsigned $bench/read_y
add wave -label {Body collision} $bench/body_collision
add wave -label {Candidate X} -radix unsigned $bench/candidate_x
add wave -label {Candidate Y} -radix unsigned $bench/candidate_y
add wave -label {Tile occupied} $bench/candidate_occupied
