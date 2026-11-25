set bench sim:/${1}
add wave -label {Clock} $bench/clk
add wave -label {Reset} $bench/reset
add wave -label {Advance enabled} $bench/enable
add wave -label {Switch seed} -radix unsigned $bench/SW
add wave -label {LFSR value} -radix unsigned $bench/random_value
add wave -label {Candidate X} -radix unsigned $bench/candidate_x
add wave -label {Candidate Y} -radix unsigned $bench/candidate_y
add wave -label {Inside grid} $bench/candidate_valid
