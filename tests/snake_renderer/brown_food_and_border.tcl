quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_renderer.v brown_food_and_border.v
vsim -voptargs=+acc work.brown_food_and_border
view wave
do wave.do brown_food_and_border
run 530 ns
wave zoom full
