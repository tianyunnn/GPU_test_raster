`timescale 1ns/1ps

module bram_mask #(
	parameter 	ADDR_WIDTH = 12,
	parameter	DATA_WIDTH = 24,
	parameter	MASK_WIDTH = 11

)(
	input 	clk,
	input	cen,
	input	[(DATA_WIDTH/MASK_WIDTH) - 1:0]wen,
	input 	gwen,
	input	[ADDR_WIDTH -1:0]addr,
	input	[DATA_WIDTH -1:0]din,
	output	[DATA_WIDTH -1:0]dout

);

	localparam DEPTH = 1 << ADDR_WIDTH;
	integer i;
	
	(* ram_style = "block" *) reg [DATA_WIDTH -1:0]mem[0:DEPTH - 1];

	reg [DATA_WIDTH -1:0]mask;

	always@(*)begin
		for(i = 0; i < DATA_WIDTH/MASK_WIDTH; i = i+1)
			mask[i*MASK_WIDTH +: MASK_WIDTH] = {MASK_WIDTH{wen[i]}};

	end



	always @(posedge clk)begin
		if(!cen)begin
			if(gwen)
				mem[addr] <= (mem[addr] & ~mask) | (din & mask); 
			else
				dout <= mem[addr];
		end




    initial begin
        dout = {DATA_WIDTH{1'b0}};
    end






endmodule
