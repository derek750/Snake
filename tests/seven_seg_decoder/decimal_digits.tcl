quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../seven_seg_decoder.v decimal_digits.v
vsim -voptargs=+acc work.decimal_digits
view wave
do wave.do decimal_digits
run 120 ns
wave zoom full
