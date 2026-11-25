quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../game_state.v ../../snake_body.v ../../movement_counter.v ../../lfsr.v ../../food_placement.v ../../score_counter.v eating_growth_and_respawn.v
vsim -voptargs=+acc work.eating_growth_and_respawn
view wave
do wave.do eating_growth_and_respawn
run 140 ns
wave zoom full
