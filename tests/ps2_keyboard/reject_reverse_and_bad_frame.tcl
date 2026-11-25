quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../ps2_keyboard.v reject_reverse_and_bad_frame.v
vsim -voptargs=+acc work.reject_reverse_and_bad_frame
view wave
do wave.do reject_reverse_and_bad_frame
run 14200 ns
wave zoom full
