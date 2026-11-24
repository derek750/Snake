quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../game.v ../../snake_body.v ../../movement_counter.v reset_mid_count.v
vsim -voptargs=+acc work.reset_mid_count
view wave
do wave.do reset_mid_count
run 120 ns
wave zoom full
