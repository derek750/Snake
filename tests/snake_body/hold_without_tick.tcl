quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_body.v hold_without_tick.v
vsim -voptargs=+acc work.hold_without_tick
view wave
do wave.do hold_without_tick
run 65 ns
wave zoom full
