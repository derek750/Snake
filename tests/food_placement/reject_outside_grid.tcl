quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../lfsr.v ../../food_placement.v reject_outside_grid.v
vsim -voptargs=+acc work.reject_outside_grid
view wave
do wave.do reject_outside_grid
run 160 ns
wave zoom full
