quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../lfsr.v ../../food_placement.v reject_occupied_tile.v
vsim -voptargs=+acc work.reject_occupied_tile
view wave
do wave.do reject_occupied_tile
run 180 ns
wave zoom full
