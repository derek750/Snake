quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../ps2_keyboard.v wasd_and_releases.v
vsim -voptargs=+acc work.wasd_and_releases
view wave
do wave.do wasd_and_releases
run 16500 ns
wave zoom full
