quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../game_state.v ../../snake_body.v ../../movement_counter.v ../../lfsr.v ../../food_placement.v ../../score_counter.v direction_changes_between_ticks.v
vsim -voptargs=+acc work.direction_changes_between_ticks
view wave
do wave.do direction_changes_between_ticks
run 95 ns
wave zoom full
