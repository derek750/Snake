quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../score_counter.v score_limit.v
vsim -voptargs=+acc work.score_limit
view wave
do wave.do score_limit
run 2600 ns
wave zoom full
