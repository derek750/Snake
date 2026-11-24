quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../movement_counter.v tick_spacing.v
vsim -voptargs=+acc work.tick_spacing
view wave
do wave.do tick_spacing
run 140 ns
wave zoom full
