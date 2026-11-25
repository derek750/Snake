set bench sim:/${1}
add wave -label {Clock} $bench/clk
add wave -label {Reset} $bench/reset
add wave -label {Switch seed} -radix unsigned $bench/SW
add wave -label {Request new food} $bench/new_food
add wave -label {Occupied length} -radix unsigned $bench/length
add wave -label {LFSR value} -radix unsigned $bench/dut.random_generator.random_value
add wave -label {Candidate X} -radix unsigned $bench/candidate_x
add wave -label {Candidate Y} -radix unsigned $bench/candidate_y
add wave -label {Inside grid} $bench/dut.candidate_valid
add wave -label {Tile occupied} $bench/candidate_occupied
add wave -label {Food X} -radix unsigned $bench/food_x
add wave -label {Food Y} -radix unsigned $bench/food_y
add wave -label {Food ready} $bench/food_ready
