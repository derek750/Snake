quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../game_state.v ../../snake_body.v ../../movement_counter.v ../../lfsr.v ../../food_placement.v ../../score_counter.v moving_into_old_tail.v
vsim -voptargs=+acc work.moving_into_old_tail
view wave
do wave.do moving_into_old_tail
run 250 ns
wave zoom full
