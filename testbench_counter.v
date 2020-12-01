module fpga_tb();
	reg clock;
	reg [8:0] in;
	wire [4:0] out;
	
	reg [31:0] memory [32:0];
	
	initial 
		clock = 1'b0;
		
	always
	    #10 clock=~clock;
		
	initial
		#200 $finish;
	
	
	fpga inst(.out(out),.in(in),.clock(clock));
	initial
		begin
			$readmemh("configure_counter.mem",memory);
          	inst.sb_11.configure=memory[0];
			inst.sb_12.configure=memory[1];
			inst.sb_13.configure=memory[2];
			inst.sb_14.configure=memory[3];
			inst.sb_15.configure=memory[4];
			inst.lt_21.mem[31:0]=memory[5];
			inst.lt_21.mem[32]=memory[6];
          	inst.lt_22.mem[31:0]=memory[7];
			inst.lt_22.mem[32]=memory[8];
			inst.lt_23.mem[31:0]=memory[9];
			inst.lt_23.mem[32]=memory[10];
			inst.sb_31.configure=memory[11];
			inst.sb_32.configure=memory[12];
			inst.sb_33.configure=memory[13];
			inst.sb_34.configure=memory[14];
			inst.lt_41.mem[31:0]=memory[15];
			inst.lt_41.mem[32]=memory[16];
          	inst.lt_42.mem[31:0]=memory[17];
			inst.lt_42.mem[32]=memory[18];
			inst.lt_43.mem[31:0]=memory[19];
			inst.lt_43.mem[32]=memory[20];
			inst.lt_51.mem[31:0]=memory[21];
			inst.lt_51.mem[32]=memory[22];
          	inst.lt_52.mem[31:0]=memory[23];
			inst.lt_52.mem[32]=memory[24];
			inst.lt_53.mem[31:0]=memory[25];
			inst.lt_53.mem[32]=memory[26];
			inst.lt_54.mem[31:0]=memory[27];
			inst.lt_54.mem[32]=memory[28];
			inst.lt_55.mem[31:0]=memory[29];
			inst.lt_55.mem[32]=memory[30];
			inst.sb_61.configure=memory[31];
			inst.sb_62.configure=memory[32];
		end	
		
		
	initial
		begin
			in=9'b100000000;
			#5
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b010000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b100000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b100000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b000000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b100000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b010000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b100000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b100000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b000000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b010000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b000000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
			in=9'b010000000;
			#10
			$display("c: %b, d: %b, counter: %b",in[8],in[7],out[4:1]);
		end
		
		
	initial
		begin
			$dumpfile("fpga.vcd");
			$dumpvars;
		end
	
endmodule
