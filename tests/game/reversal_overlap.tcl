quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../game_state.v ../../snake_body.v ../../movement_counter.v ../../lfsr.v ../../food_placement.v ../../score_counter.v reversal_overlap.v
vsim -voptargs=+acc work.reversal_overlap
view wave
do wave.do reversal_overlap
run 190 ns
wave zoom full
