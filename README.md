# FPGA

Implement FPGA in verilog by using Logic Tile and switch box.

This FPGA is designed to support following three functionalities
1. 4 bit adder, input are two 4 bit numbers and carry_in. Output is a 4 bit number and carry_out.
2. 8 to 1 encoder(assumption only one would be high at one time).
3. 4 bit synchronous counter (two bit input is ‘c’ and ‘d’. If ‘c’ is ‘1’ then counter increments, if ‘d’ is 1 counter decrement.
   Both c and d can not be 1 at the same time. If    both are ‘0’ flip-flops holds their values)

Here is the design of FPGA -

![FPGA Design](https://github.com/tanmayaeron/FPGA/blob/main/FPGA_design.png)

## Dependencies
This project uses [Iverilog by steveicarus](https://github.com/steveicarus/iverilog). 

## Design
first input of FPGA board is connected to first input of first and last switch box and therefore I1 is written there. At output ports, A1,A2 and so on till A20 is writen. 

## Execution
FPGA.v contain instances of logic tile and switch boxes.
In corresponding testbench, enter input in following format - \
adder -  in = 9'b+num1+num2+cin \
counter - in = 9'b+c+d+"0000000" \
encoder - in = 9'b+all 8 inputs + "0" 

In linux system, for adder do the following - \
iverilog FPGA.v testbench_adder.v \
./a.out \
Compile corresponding testbench for other two circuits.
