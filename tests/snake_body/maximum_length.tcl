quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_body.v maximum_length.v
vsim -voptargs=+acc work.maximum_length
view wave
do wave.do maximum_length
run 5100 ns
wave zoom full
