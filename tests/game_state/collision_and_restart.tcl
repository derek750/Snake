quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game_state.v collision_and_restart.v
vsim -voptargs=+acc work.collision_and_restart
view wave
do wave.do collision_and_restart
run 100 ns
wave zoom full
