set bench sim:/${1}
add wave -label {Clock} $bench/clk
add wave -label {Reset} $bench/reset
add wave -label {Food ready} $bench/food_ready
add wave -label {Food X} -radix unsigned $bench/food_x
add wave -label {Food Y} -radix unsigned $bench/food_y
add wave -label {Segment index} -radix unsigned $bench/read_index
add wave -label {Grid cell X} -radix unsigned $bench/dut.cell_x
add wave -label {Grid cell Y} -radix unsigned $bench/dut.cell_y
add wave -label {Pixel within cell X} -radix unsigned $bench/dut.pixel_x
add wave -label {Pixel within cell Y} -radix unsigned $bench/dut.pixel_y
add wave -label {Write pixel} $bench/plot
add wave -label {Screen X} -radix unsigned $bench/vga_x
add wave -label {Screen Y} -radix unsigned $bench/vga_y
add wave -label {Pixel color} -radix hexadecimal $bench/vga_color
