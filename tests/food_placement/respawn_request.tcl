quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../lfsr.v ../../food_placement.v respawn_request.v
vsim -voptargs=+acc work.respawn_request
view wave
do wave.do respawn_request
run 160 ns
wave zoom full
