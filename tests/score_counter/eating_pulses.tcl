quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../score_counter.v eating_pulses.v
vsim -voptargs=+acc work.eating_pulses
view wave
do wave.do eating_pulses
run 100 ns
wave zoom full
