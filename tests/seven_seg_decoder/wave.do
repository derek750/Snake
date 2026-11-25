set bench sim:/${1}
add wave -label {Decimal digit} -radix unsigned $bench/digit
add wave -label {Active low segments} -radix binary $bench/segments
