# FPGA

Implement FPGA in verilog by using Logic Tile and switch box.

This FPGA is designed to support following three functionalities
1. 4 bit adder, input are two 4 bit numbers and carry_in. Output is a 4 bit number and carry_out.
2. 8 to 1 encoder(assumption only one would be high at one time).
3. 4 bit synchronous counter (two bit input is ‘c’ and ‘d’. If ‘c’ is ‘1’ then counter increments, if ‘d’ is 1 counter decrement.
   Both c and d can not be 1 at the same time. If    both are ‘0’ flip-flops holds their values)

