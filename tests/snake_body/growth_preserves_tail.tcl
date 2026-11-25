quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_body.v growth_preserves_tail.v
vsim -voptargs=+acc work.growth_preserves_tail
view wave
do wave.do growth_preserves_tail
run 70 ns
wave zoom full
