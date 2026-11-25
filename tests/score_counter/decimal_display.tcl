quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../score_counter.v ../../seven_seg_decoder.v decimal_display.v
vsim -voptargs=+acc work.decimal_display
view wave
do wave.do decimal_display
run 2560 ns
wave zoom full
