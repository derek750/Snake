quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../game_state.v ../../snake_body.v ../../movement_counter.v ../../lfsr.v ../../food_placement.v ../../score_counter.v restart_after_eating.v
vsim -voptargs=+acc work.restart_after_eating
view wave
do wave.do restart_after_eating
run 140 ns
wave zoom full
