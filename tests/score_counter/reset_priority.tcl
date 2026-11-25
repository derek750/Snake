quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../score_counter.v reset_priority.v
vsim -voptargs=+acc work.reset_priority
view wave
do wave.do reset_priority
run 80 ns
wave zoom full
