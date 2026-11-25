quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../game_state.v ../../snake_body.v ../../movement_counter.v ../../lfsr.v ../../food_placement.v ../../score_counter.v starting_segment_reads.v
vsim -voptargs=+acc work.starting_segment_reads
view wave
do wave.do starting_segment_reads
run 65 ns
wave zoom full
