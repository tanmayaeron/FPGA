module mux4(out,in,c1,c0);
	input [3:0] in;
	input c0,c1;
	output out;
	wire c0neg,c1neg;
  	assign c0neg=~c0;
    assign c1neg=~c1;
    assign out = (c0neg&c1neg&in[0]) | (c0&c1neg&in[1]) | (c0neg&c1&in[2]) | (c0&c1&in[3]);
endmodule

module flipflop(q,qneg,d,clock);
	output q,qneg;
	input d,clock;
	reg q,qneg;
	initial
		begin
			q = 1'b0;
			qneg = 1'b1;
		end
	always@(posedge clock)
	begin
		q<=d;
		qneg=!d;
	end
endmodule

module logic_tile(out,clock,in1,in2,in3,in4,in5);
	input clock,in1,in2,in3,in4,in5;
	output out;
	wire [9:0] temp;
	reg result,out;
	reg [32:0] mem;
	genvar i;
	generate for(i=0;i<=7;i=i+1)
	    begin: level1mux
			mux4 m1(temp[i],mem[4*i+3:4*i],in2,in1);
		end
	endgenerate
	mux4 m2(temp[8],temp[3:0],in4,in3);
	mux4 m3(temp[9],temp[7:4],in4,in3);
	always@(*)
		begin
			if(in5)
			result = temp[9];
			else
			result = temp[8];
		end
	wire syncresult,syncresultneg;
	flipflop f1(syncresult,syncresultneg,result,clock);
	always@(*)
		begin
			if(mem[32])
			out=syncresult;
			else
			out=result;
		end
endmodule
	
module switch_box_4x4(out,in);
	input [3:0] in;
	output [3:0] out;
	reg [15:0] configure;
	assign out[0]=(configure[0]&in[0])|(configure[1]&in[1])|(configure[2]&in[2])|(configure[3]&in[3]);
	assign out[1]=(configure[4]&in[0])|(configure[5]&in[1])|(configure[6]&in[2])|(configure[7]&in[3]);
	assign out[2]=(configure[8]&in[0])|(configure[9]&in[1])|(configure[10]&in[2])|(configure[11]&in[3]);
	assign out[3]=(configure[12]&in[0])|(configure[13]&in[1])|(configure[14]&in[2])|(configure[15]&in[3]);
endmodule

module fpga(out,in,clock);
	input [8:0] in;
	output [4:0] out;
	input clock;
	wire [19:0] A;
	switch_box_4x4 sb_11(A[3:0],{in[5],in[6],in[7],in[8]});
	switch_box_4x4 sb_12(A[7:4],{in[1],in[2],in[3],in[4]});
	switch_box_4x4 sb_13(A[11:8],{in[0],in[1],in[5],in[4]});
	switch_box_4x4 sb_14(A[15:12],{in[6],in[2],in[3],in[5]});
	switch_box_4x4 sb_15(A[19:16],{in[3],in[4],in[7],in[8]});
	wire [2:0] B;
	logic_tile lt_21(B[0],clock,A[8],A[5],A[4],A[1],A[0]);
	logic_tile lt_22(B[1],clock,A[9],A[7],A[6],A[3],A[2]);
	logic_tile lt_23(B[2],clock,A[13],A[12],A[10],A[7],A[6]);
	wire [15:0] D;
	switch_box_4x4 sb_31(D[3:0],{A[15],B[2],B[1],B[0]});
	switch_box_4x4 sb_32(D[7:4],A[19:16]);
	switch_box_4x4 sb_33(D[11:8],{A[17],A[16],B[1],B[0]});
	switch_box_4x4 sb_34(D[15:12],{A[19],A[18],A[15],B[2]});
	wire [2:0] E;
	logic_tile lt_41(E[0],clock,D[8],D[5],D[4],D[1],D[0]);
	logic_tile lt_42(E[1],clock,D[9],D[7],D[6],D[3],D[2]);
	logic_tile lt_43(E[2],clock,D[14],D[13],D[12],D[11],D[10]);
	wire [4:0] F;
	logic_tile lt_51(F[0],clock,D[15],E[2],F[0],E[1],E[0]);
	logic_tile lt_52(F[1],clock,E[2],F[1],F[0],E[1],E[0]);
	logic_tile lt_53(F[2],clock,F[2],F[1],F[0],E[1],E[2]);
	logic_tile lt_54(F[3],clock,F[2],F[1],F[0],D[15],E[2]);
	logic_tile lt_55(F[4],clock,A[19],F[4],F[3],D[15],E[2]);
	wire [7:0] G;
	switch_box_4x4 sb_61(G[3:0],{F[4],F[2],E[1],E[0]});
	switch_box_4x4 sb_62(G[7:4],{F[1],F[0],B[1],B[0]});
	assign out = {G[0],G[1],G[4],G[5],E[2]};
endmodule
	