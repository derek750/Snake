quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_renderer.v redraw_after_food_moves.v
vsim -voptargs=+acc work.redraw_after_food_moves
view wave
do wave.do redraw_after_food_moves
run 270000 ns
wave zoom full
