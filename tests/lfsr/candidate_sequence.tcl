quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../lfsr.v candidate_sequence.v
vsim -voptargs=+acc work.candidate_sequence
view wave
do wave.do candidate_sequence
run 5130 ns
wave zoom full
