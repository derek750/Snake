quit -sim
if {![file isdirectory work]} {vlib work}
vlog ../../lfsr.v ../../food_placement.v full_board_search.v
vsim -voptargs=+acc work.full_board_search
view wave
do wave.do full_board_search
run 5200 ns
wave zoom full
