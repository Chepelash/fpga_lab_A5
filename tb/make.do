transcript on


vlib work

vlog -sv ../src/priority_encoder.sv
vlog -sv ./priority_encoder_tb.sv

vsim -novopt priority_encoder_tb

add wave /priority_encoder_tb/clk 
add wave /priority_encoder_tb/rst
add wave /priority_encoder_tb/data_i
add wave /priority_encoder_tb/data_left_o
add wave /priority_encoder_tb/data_right_o

run -all

