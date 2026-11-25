quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_renderer.v snake_over_food.v
vsim -voptargs=+acc work.snake_over_food
view wave
do wave.do snake_over_food
run 530 ns
wave zoom full
