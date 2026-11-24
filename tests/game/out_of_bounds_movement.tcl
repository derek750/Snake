quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../snake_body.v ../../movement_counter.v out_of_bounds_movement.v
vsim -voptargs=+acc work.out_of_bounds_movement
view wave
do wave.do out_of_bounds_movement
run 1480 ns
wave zoom full
