quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../movement_counter.v reset_mid_count.v
vsim -voptargs=+acc work.reset_mid_count
view wave
do wave.do reset_mid_count
run 130 ns
wave zoom full
