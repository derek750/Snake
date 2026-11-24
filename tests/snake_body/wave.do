set bench sim:/${1}
switch -- ${1} {
    body_follows_head {
        add wave -label {Clock} $bench/clk
        add wave -label {Reset} $bench/reset
        add wave -label {Movement tick} $bench/move_tick
        add wave -label {Next head X} -radix unsigned $bench/next_head_x
        add wave -label {Next head Y} -radix unsigned $bench/next_head_y
        add wave -divider {Head position}
        add wave -label {Current head X} -radix unsigned $bench/head_x
        add wave -label {Current head Y} -radix unsigned $bench/head_y
        add wave -divider {Selected body segment}
        add wave -label {Segment index} -radix unsigned $bench/read_index
        add wave -label {Segment X} -radix unsigned $bench/read_x
        add wave -label {Segment Y} -radix unsigned $bench/read_y
    }
    hold_without_tick -
    starting_segment_reads {
        add wave -label {Clock} $bench/clk
        add wave -label {Reset} $bench/reset
        add wave -label {Next head X} -radix unsigned $bench/next_head_x
        add wave -label {Next head Y} -radix unsigned $bench/next_head_y
        add wave -divider {Stored segment read}
        add wave -label {Snake length} -radix unsigned $bench/length
        add wave -label {Segment index} -radix unsigned $bench/read_index
        add wave -label {Segment read valid} $bench/read_valid
        add wave -label {Segment X} -radix unsigned $bench/read_x
        add wave -label {Segment Y} -radix unsigned $bench/read_y
    }
}
