quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../lfsr.v seed_loading.v
vsim -voptargs=+acc work.seed_loading
view wave
do wave.do seed_loading
run 120 ns
wave zoom full
