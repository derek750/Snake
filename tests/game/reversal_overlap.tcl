quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../game_state.v ../../snake_body.v ../../movement_counter.v reversal_overlap.v
vsim -voptargs=+acc work.reversal_overlap
view wave
do wave.do reversal_overlap
run 100 ns
wave zoom full
