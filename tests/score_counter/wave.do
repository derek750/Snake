set bench sim:/${1}
add wave -label {Clock} $bench/clk
add wave -label {Reset} $bench/reset
add wave -label {Food eaten} $bench/food_eaten
add wave -label {Score} -radix unsigned $bench/score

if {${1} eq "decimal_display"} {
    add wave -label {Ones digit} -radix unsigned $bench/ones
    add wave -label {Tens digit} -radix unsigned $bench/tens
    add wave -label {Hundreds digit} -radix unsigned $bench/hundreds
    add wave -label {HEX0 ones segments} -radix binary $bench/HEX0
    add wave -label {HEX1 tens segments} -radix binary $bench/HEX1
    add wave -label {HEX2 hundreds segments} -radix binary $bench/HEX2
}
