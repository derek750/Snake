quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_body.v occupied_candidate.v
vsim -voptargs=+acc work.occupied_candidate
view wave
do wave.do occupied_candidate
run 80 ns
wave zoom full
