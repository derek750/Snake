quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../game_state.v ../../snake_body.v ../../movement_counter.v body_follows_turns.v
vsim -voptargs=+acc work.body_follows_turns
view wave
do wave.do body_follows_turns
run 160 ns
wave zoom full
