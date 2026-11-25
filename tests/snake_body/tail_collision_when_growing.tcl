quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_body.v tail_collision_when_growing.v
vsim -voptargs=+acc work.tail_collision_when_growing
view wave
do wave.do tail_collision_when_growing
run 50 ns
wave zoom full
