quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../snake_body.v starting_segment_reads.v
vsim -voptargs=+acc work.starting_segment_reads
view wave
do wave.do starting_segment_reads
run 65 ns
wave zoom full
