set bench sim:/${1}
add wave -label {Clock} $bench/clk
add wave -label {Reset} $bench/reset
add wave -label {Movement tick} $bench/move_tick
add wave -label {Collision} $bench/collision
add wave -label {Move allowed} $bench/move_enable
add wave -label {Game over} $bench/game_over
