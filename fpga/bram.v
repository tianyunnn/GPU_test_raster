`timescale 1ns/1ps

module bram #(
	parameter 	ADDR_WIDTH = 12,
	parameter	DATA_WIDTH = 24

)(
	input 	clk,
	input	cen,
	input	wen,
	input	[ADDR_WIDTH -1:0]addr,
	input	[DATA_WIDTH -1:0]din,
	output	[DATA_WIDTH -1:0]dout

);

	localparam DEPTH = 1 << ADDR_WIDTH;
	
	(* ram_style = "block" *) reg [DATA_WIDTH -1:0]mem[0:DEPTH - 1];





	always @(posedge clk)begin
		if(!cen)begin
			if(wen)begin
				mem[addr] <= din; 
			end
			dout <= mem[addr];
		
		end

	initial begin
        	dout = {DATA_WIDTH{1'b0}};
    	end






endmodule
