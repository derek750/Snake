quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_body.v body_follows_head.v
vsim -voptargs=+acc work.body_follows_head
view wave
do wave.do body_follows_head
run 90 ns
wave zoom full
