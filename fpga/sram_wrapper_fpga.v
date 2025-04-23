`timescale 1ns/1ps
`define DELAY #0.5

module sram_wrapper (
    	input 			clk,

	input	[11:0]	core_index_mem_addr_i,
	input	[10:0]	core_vertex_mem_addr_i,
	input	[10:0]	core_vertex_2d_mem_addr_i,
	input			core_vertex_2d_mem_wr_i,
	input	[28:0]	core_vertex_2d_mem_data_i,
	input	[10:0]	core_vertex_3d_mem_addr_i,
	input			core_vertex_3d_mem_wr_i,
	input	[47:0]	core_vertex_3d_mem_data_i,
	input	[11:0]	core_light_mem_addr_i,
	input			core_light_mem_wr_i,
	input	[9:0]	core_light_mem_data_i,
	input	[11:0]	core_tri_valid_mem_addr_i,
	input			core_tri_valid_mem_wr_i,
	input			core_tri_valid_mem_data_i,
	input	[11:0]	core_color_mem_addr_i,
	input	[3:0]	core_tile_buffer_0_wen_i,
	input			core_tile_buffer_0_gwen_i,
	input	[9:0]	core_tile_buffer_0_addr_i,
	input	[47:0]	core_tile_buffer_0_data_i,
	input	[3:0]	core_tile_buffer_1_wen_i,	
	input			core_tile_buffer_1_gwen_i,
	input	[9:0]	core_tile_buffer_1_addr_i,
	input	[47:0]	core_tile_buffer_1_data_i,
	input	[3:0]	core_depth_buffer_wen_rd_i,
	input			core_depth_buffer_gwen_rd_i,
	input	[9:0]	core_depth_buffer_addr_rd_i,
	input	[3:0]	core_depth_buffer_wen_wr_i,
	input			core_depth_buffer_gwen_wr_i,
	input	[9:0]	core_depth_buffer_addr_wr_i,
	input	[47:0]	core_depth_buffer_data_wr_i,
	output	[47:0]	vertex_mem_data_o,
	output	[32:0]	index_mem_data_o,
	output	[28:0]	vertex_2d_mem_data_o,
	output	[47:0]	vertex_3d_mem_data_o,
	output	[9:0]	light_mem_data_o,
	output			tri_valid_mem_data_o,
	output	[11:0]	color_mem_data_o,
	output	[47:0]	tile_buffer_0_data_o,
	output	[47:0]	tile_buffer_1_data_o,
	output	[47:0]	depth_buffer_data_o
);

	reg 			index_mem_cen;
	reg 			index_mem_wen;
	reg 	[11:0]	index_mem_addr;
	reg 	[32:0]	index_mem_data_in;
	wire 	[32:0]	index_mem_data_out;

	wire 			index_mem_cen_delayed;
	wire 			index_mem_wen_delayed;
	wire 	[11:0]	index_mem_addr_delayed;
	wire 	[32:0]	index_mem_data_in_delayed;

	reg 			vertex_mem_cen;
	reg 			vertex_mem_wen;
	reg 	[10:0]	vertex_mem_addr;
	reg 	[47:0]	vertex_mem_data_in;
	wire 	[47:0]	vertex_mem_data_out;

	wire 			vertex_mem_cen_delayed;
	wire 			vertex_mem_wen_delayed;
	wire 	[10:0]	vertex_mem_addr_delayed;
	wire 	[47:0]	vertex_mem_data_in_delayed;

	reg 			vertex_2d_mem_cen;
	reg 			vertex_2d_mem_wen;
	reg 	[10:0]	vertex_2d_mem_addr;
	reg 	[28:0]	vertex_2d_mem_data_in;
	wire 	[28:0]	vertex_2d_mem_data_out;

	wire 			vertex_2d_mem_cen_delayed;
	wire 			vertex_2d_mem_wen_delayed;
	wire 	[10:0]	vertex_2d_mem_addr_delayed;
	wire 	[28:0]	vertex_2d_mem_data_in_delayed;

	reg 			vertex_3d_mem_cen;
	reg 			vertex_3d_mem_wen;
	reg 	[10:0]	vertex_3d_mem_addr;
	reg 	[47:0]	vertex_3d_mem_data_in;
	wire 	[47:0]	vertex_3d_mem_data_out;

	wire 			vertex_3d_mem_cen_delayed;
	wire 			vertex_3d_mem_wen_delayed;
	wire 	[10:0]	vertex_3d_mem_addr_delayed;
	wire 	[47:0]	vertex_3d_mem_data_in_delayed;

	reg 			light_mem_cen;
	reg 			light_mem_wen;
	reg 	[11:0]	light_mem_addr;
	reg 	[9:0]	light_mem_data_in;
	wire 	[9:0]	light_mem_data_out;

	wire 			light_mem_cen_delayed;
	wire 			light_mem_wen_delayed;
	wire 	[11:0]	light_mem_addr_delayed;
	wire 	[9:0]	light_mem_data_in_delayed;

	reg 			tri_valid_mem_cen;
	reg 			tri_valid_mem_wen;
	reg 	[11:0]	tri_valid_mem_addr;
	reg 			tri_valid_mem_data_in;
	wire 	[1:0]	tri_valid_mem_data_out;

	wire 			tri_valid_mem_cen_delayed;
	wire 			tri_valid_mem_wen_delayed;
	wire 	[11:0]	tri_valid_mem_addr_delayed;
	wire 			tri_valid_mem_data_in_delayed;

	reg 			color_mem_cen;
	reg 			color_mem_wen;
	reg 	[11:0]	color_mem_addr;
	reg 	[11:0]	color_mem_data_in;
	wire 	[11:0]	color_mem_data_out;

	wire 			color_mem_cen_delayed;
	wire 			color_mem_wen_delayed;
	wire 	[11:0]	color_mem_addr_delayed;
	wire 	[11:0]	color_mem_data_in_delayed;

	reg 	[3:0]	tile_buffer_0_wen;
	reg				tile_buffer_0_gwen;
	reg 	[9:0]	tile_buffer_0_addr;
	reg 	[47:0]	tile_buffer_0_data_in;
	wire	[47:0]	tile_buffer_0_data_out;

	reg 	[3:0]	tile_buffer_1_wen;
	reg				tile_buffer_1_gwen;
	reg 	[9:0]	tile_buffer_1_addr;
	reg 	[47:0]	tile_buffer_1_data_in;
	wire	[47:0]	tile_buffer_1_data_out;

	wire 	[3:0]	tile_buffer_0_wen_delayed;
	wire 			tile_buffer_0_gwen_delayed;
	wire 	[9:0]	tile_buffer_0_addr_delayed;
	wire 	[47:0]	tile_buffer_0_data_in_delayed;

	wire 	[3:0]	tile_buffer_1_wen_delayed;
	wire			tile_buffer_1_gwen_delayed;
	wire 	[9:0]	tile_buffer_1_addr_delayed;
	wire 	[47:0]	tile_buffer_1_data_in_delayed;

	reg		[3:0]	depth_buffer_wen_rd;
	reg				depth_buffer_gwen_rd;
	reg		[9:0]	depth_buffer_addr_rd;
	wire	[47:0]	depth_buffer_data_rd;

	reg		[3:0]	depth_buffer_wen_wr;
	reg				depth_buffer_gwen_wr;
	reg		[9:0]	depth_buffer_addr_wr;
	reg		[47:0]	depth_buffer_data_wr;

	wire 	[3:0]	depth_buffer_wen_rd_delayed;
	wire			depth_buffer_gwen_rd_delayed;
	wire	[9:0]	depth_buffer_addr_rd_delayed;

	wire 	[3:0]	depth_buffer_wen_wr_delayed;
	wire			depth_buffer_gwen_wr_delayed;
	wire	[9:0]	depth_buffer_addr_wr_delayed;
	wire	[47:0] 	depth_buffer_data_wr_delayed;

	assign `DELAY vertex_mem_cen_delayed 		= vertex_mem_cen;
	assign `DELAY vertex_mem_wen_delayed 		= vertex_mem_wen;
	assign `DELAY vertex_mem_addr_delayed 		= vertex_mem_addr;
	assign `DELAY vertex_mem_data_in_delayed	= vertex_mem_data_in;

	assign `DELAY index_mem_cen_delayed 		= index_mem_cen;
	assign `DELAY index_mem_wen_delayed 		= index_mem_wen;
	assign `DELAY index_mem_addr_delayed 		= index_mem_addr;
	assign `DELAY index_mem_data_in_delayed		= index_mem_data_in;

	assign `DELAY vertex_2d_mem_cen_delayed 		= vertex_2d_mem_cen;
	assign `DELAY vertex_2d_mem_wen_delayed 		= vertex_2d_mem_wen;
	assign `DELAY vertex_2d_mem_addr_delayed 		= vertex_2d_mem_addr;
	assign `DELAY vertex_2d_mem_data_in_delayed		= vertex_2d_mem_data_in;

	assign `DELAY vertex_3d_mem_cen_delayed 		= vertex_3d_mem_cen;
	assign `DELAY vertex_3d_mem_wen_delayed 		= vertex_3d_mem_wen;
	assign `DELAY vertex_3d_mem_addr_delayed 		= vertex_3d_mem_addr;
	assign `DELAY vertex_3d_mem_data_in_delayed		= vertex_3d_mem_data_in;

	assign `DELAY light_mem_cen_delayed 			= light_mem_cen;
	assign `DELAY light_mem_wen_delayed 			= light_mem_wen;
	assign `DELAY light_mem_addr_delayed 			= light_mem_addr;
	assign `DELAY light_mem_data_in_delayed			= light_mem_data_in;

	assign `DELAY tri_valid_mem_cen_delayed 		= tri_valid_mem_cen;
	assign `DELAY tri_valid_mem_wen_delayed 		= tri_valid_mem_wen;
	assign `DELAY tri_valid_mem_addr_delayed 		= tri_valid_mem_addr;
	assign `DELAY tri_valid_mem_data_in_delayed		= tri_valid_mem_data_in;

	assign `DELAY color_mem_cen_delayed 			= color_mem_cen;
	assign `DELAY color_mem_wen_delayed 			= color_mem_wen;
	assign `DELAY color_mem_addr_delayed 			= color_mem_addr;
	assign `DELAY color_mem_data_in_delayed			= color_mem_data_in;

	assign `DELAY tile_buffer_0_wen_delayed 		= tile_buffer_0_wen;
	assign `DELAY tile_buffer_0_gwen_delayed 		= tile_buffer_0_gwen;
	assign `DELAY tile_buffer_0_addr_delayed 		= tile_buffer_0_addr;
	assign `DELAY tile_buffer_0_data_in_delayed		= tile_buffer_0_data_in;

	assign `DELAY tile_buffer_1_wen_delayed 		= tile_buffer_1_wen;
	assign `DELAY tile_buffer_1_gwen_delayed 		= tile_buffer_1_gwen;
	assign `DELAY tile_buffer_1_addr_delayed 		= tile_buffer_1_addr;
	assign `DELAY tile_buffer_1_data_in_delayed		= tile_buffer_1_data_in;

	assign `DELAY depth_buffer_wen_rd_delayed		= depth_buffer_wen_rd;
	assign `DELAY depth_buffer_gwen_rd_delayed		= depth_buffer_gwen_rd;
	assign `DELAY depth_buffer_addr_rd_delayed		= depth_buffer_addr_rd;

	assign `DELAY depth_buffer_wen_wr_delayed		= depth_buffer_wen_wr;
	assign `DELAY depth_buffer_gwen_wr_delayed		= depth_buffer_gwen_wr;
	assign `DELAY depth_buffer_addr_wr_delayed		= depth_buffer_addr_wr;
	assign `DELAY depth_buffer_data_wr_delayed		= depth_buffer_data_wr;

	assign vertex_mem_data_o = vertex_mem_data_out;
	assign index_mem_data_o = index_mem_data_out;
	assign vertex_2d_mem_data_o = vertex_2d_mem_data_out;
	assign vertex_3d_mem_data_o = vertex_3d_mem_data_out;
	assign light_mem_data_o = light_mem_data_out;
	assign tri_valid_mem_data_o = tri_valid_mem_data_out[0];
	assign color_mem_data_o = color_mem_data_out;
	assign tile_buffer_0_data_o = tile_buffer_0_data_out;
	assign tile_buffer_1_data_o = tile_buffer_1_data_out;
	assign depth_buffer_data_o = depth_buffer_data_rd;



	bram #(
		.ADDR_WIDTH(12),
		.DATA_WIDTH(33)

	)u_index_memory(
		.clk(clk),
		.cen(index_mem_cen_delayed),
		.wen(index_mem_wen_delayed),
		.addr(index_mem_addr_delayed),
		.din(index_mem_data_in_delayed),
		.dout(index_mem_data_out)

	);


	bram #(
		.ADDR_WIDTH(11),
		.DATA_WIDTH(48)

	)u_vertex_memory(
		.clk(clk),
		.cen(vertex_mem_cen_delayed),
		.wen(vertex_mem_wen_delayed),
		.addr(vertex_mem_addr_delayed),
		.din(vertex_mem_data_in_delayed),
		.dout(vertex_mem_data_out)

	);

	bram #(
		.ADDR_WIDTH(11),
		.DATA_WIDTH(29)

	)u_vertex_2d_memory(
		.clk(clk),
		.cen(vertex_2d_mem_cen_delayed),
		.wen(vertex_2d_mem_wen_delayed),
		.addr(vertex_2d_mem_addr_delayed),
		.din(vertex_2d_mem_data_in_delayed),
		.dout(vertex_2d_mem_data_out)

	);

	bram #(
		.ADDR_WIDTH(11),
		.DATA_WIDTH(48)

	)u_vertex_3d_memory(
		.clk(clk),
		.cen(vertex_3d_mem_cen_delayed),
		.wen(vertex_3d_mem_wen_delayed),
		.addr(vertex_3d_mem_addr_delayed),
		.din(vertex_3d_mem_data_in_delayed),
		.dout(vertex_3d_mem_data_out)

	);

	bram #(
		.ADDR_WIDTH(12),
		.DATA_WIDTH(10)

	)u_light_intensity(
		.clk(clk),
		.cen(light_mem_cen_delayed),
		.wen(light_mem_wen_delayed),
		.addr(light_mem_addr_delayed),
		.din(light_mem_data_in_delayed),
		.dout(light_mem_data_out)

	);


	bram #(
		.ADDR_WIDTH(12),
		.DATA_WIDTH(1)

	)u_tri_valid_memory(
		.clk(clk),
		.cen(tri_valid_mem_cen_delayed),
		.wen(tri_valid_mem_wen_delayed),
		.addr(tri_valid_mem_addr_delayed),
		.din({1'b0, tri_valid_mem_data_in_delayed}),
		.dout(tri_valid_mem_data_out)

	);



	bram #(
		.ADDR_WIDTH(12),
		.DATA_WIDTH(12)

	)u_color_memory(
		.clk(clk),
		.cen(color_mem_cen_delayed),
		.wen(color_mem_wen_delayed),
		.addr(color_mem_addr_delayed),
		.din(color_mem_data_in_delayed),
		.dout(color_mem_data_out)

	);


	bram_mask #(
		.ADDR_WIDTH(10),
		.DATA_WIDTH(48),
		.MASK_WIDTH(12)

	)u_tile_buffer_0(
		.clk(clk),
		.cen(0),
		.wen(tile_buffer_0_wen_delayed),
		.gwen(tile_buffer_0_gwen_delayed),
		.addr(tile_buffer_0_addr_delayed),
		.din(tile_buffer_0_data_in_delayed),
		.dout(tile_buffer_0_data_out)

	);


	bram_mask #(
		.ADDR_WIDTH(10),
		.DATA_WIDTH(48),
		.MASK_WIDTH(12)

	)u_tile_buffer_1(
		.clk(clk),
		.cen(0),
		.wen(tile_buffer_1_wen_delayed),
		.gwen(tile_buffer_1_gwen_delayed),
		.addr(tile_buffer_1_addr_delayed),
		.din(tile_buffer_1_data_in_delayed),
		.dout(tile_buffer_1_data_out)

	);


	bram_mask #(
		.ADDR_WIDTH(10),
		.DATA_WIDTH(48),
		.MASK_WIDTH(12)

	)u_depth_buffer(
		.clka(clk),
		.cena(0),
		.wena(depth_buffer_wen_rd_delayed),
		.gwena(depth_buffer_gwen_rd_delayed),
		.addra(depth_buffer_addr_rd_delayed),
		//.dina(),
		.douta(depth_buffer_data_rd),

		.clkb(clk),
		.cenb(0),
		.wenb(depth_buffer_wen_wr_delayed),
		.gwenb(depth_buffer_gwen_wr_delayed),
		.addrb(depth_buffer_addr_wr_delayed),
		.dinb(depth_buffer_data_wr_delayed))
		//.doutb()

	);







    always @(*) begin 
		index_mem_cen 		= 0;
		index_mem_wen 		= 1;
		index_mem_addr 		= 'd0;
		index_mem_data_in 	= 'd0;

		vertex_mem_cen		= 0;
		vertex_mem_wen 		= 1;
		vertex_mem_addr		= 'd0;
		vertex_mem_data_in	= 'd0;

		vertex_3d_mem_cen		= 0;
		vertex_3d_mem_wen		= 1;
		vertex_3d_mem_addr		= 'd0;
		vertex_3d_mem_data_in	= 'd0;

		vertex_2d_mem_cen		= 0;
		vertex_2d_mem_wen		= 1;
		vertex_2d_mem_addr		= 'd0;
		vertex_2d_mem_data_in	= 'd0;

		light_mem_cen			= 0;
		light_mem_wen			= 1;
		light_mem_addr			= 'd0;
		light_mem_data_in		= 'd0;

		tri_valid_mem_cen		= 0;
		tri_valid_mem_wen		= 1;
		tri_valid_mem_addr		= 'd0;
		tri_valid_mem_data_in	= 'd0;

		color_mem_cen			= 0;
		color_mem_wen 			= 1;
		color_mem_addr			= 'd0;
		color_mem_data_in		= 'd0;

		tile_buffer_0_gwen 		= 1;
		tile_buffer_0_wen		= 4'hF;
		tile_buffer_0_addr		= 'd0;
		tile_buffer_0_data_in	= 'd0;

		tile_buffer_1_gwen 		= 1;
		tile_buffer_1_wen		= 4'hF;
		tile_buffer_1_addr		= 'd0;
		tile_buffer_1_data_in	= 'd0;

		depth_buffer_gwen_rd 	= 1;
		depth_buffer_wen_wr		= 4'hF;
		depth_buffer_addr_wr	= 'd0;
		depth_buffer_data_wr	= 'd0;

		depth_buffer_gwen_wr 	= 1;
		depth_buffer_wen_rd		= 4'hF;
		depth_buffer_addr_rd	= 'd0;

		
			index_mem_cen			= 0;
			index_mem_wen			= 1;
			index_mem_addr			= core_index_mem_addr_i;
			index_mem_data_in		= 'd0;

			vertex_mem_cen			= 0;
			vertex_mem_wen			= 1;
			vertex_mem_addr			= core_vertex_mem_addr_i;
			vertex_mem_data_in		= 'd0;

			vertex_2d_mem_cen		= 0;
			vertex_2d_mem_wen		= core_vertex_2d_mem_wr_i ? 0 : 1;
			vertex_2d_mem_addr		= core_vertex_2d_mem_addr_i;
			vertex_2d_mem_data_in	= core_vertex_2d_mem_wr_i ? core_vertex_2d_mem_data_i : 'd0;

			vertex_3d_mem_cen		= 0;
			vertex_3d_mem_wen		= core_vertex_3d_mem_wr_i ? 0 : 1;
			vertex_3d_mem_addr		= core_vertex_3d_mem_addr_i;
			vertex_3d_mem_data_in	= core_vertex_3d_mem_wr_i ? core_vertex_3d_mem_data_i : 'd0;

			light_mem_cen			= 0;
			light_mem_wen			= core_light_mem_wr_i ? 0 : 1;
			light_mem_addr			= core_light_mem_addr_i;
			light_mem_data_in		= core_light_mem_wr_i ? core_light_mem_data_i : 'd0;

			tri_valid_mem_cen		= 0;
			tri_valid_mem_wen		= core_tri_valid_mem_wr_i ? 0 : 1;
			tri_valid_mem_addr		= core_tri_valid_mem_addr_i;
			tri_valid_mem_data_in	= core_tri_valid_mem_wr_i ? core_tri_valid_mem_data_i : 'd0;

			color_mem_cen			= 0;
			color_mem_wen			= 1;
			color_mem_addr			= core_color_mem_addr_i;
			color_mem_data_in		= 'd0;

			tile_buffer_0_wen		= core_tile_buffer_0_wen_i;
			tile_buffer_0_gwen		= core_tile_buffer_0_gwen_i;
			tile_buffer_0_addr		= core_tile_buffer_0_addr_i;
			tile_buffer_0_data_in		= core_tile_buffer_0_data_i;

			tile_buffer_1_wen		= core_tile_buffer_1_wen_i;
			tile_buffer_1_gwen		= core_tile_buffer_1_gwen_i;
			tile_buffer_1_addr		= core_tile_buffer_1_addr_i;
			tile_buffer_1_data_in		= core_tile_buffer_1_data_i;

			depth_buffer_wen_rd		= core_depth_buffer_wen_rd_i;
			depth_buffer_gwen_rd		= core_depth_buffer_gwen_rd_i;
			depth_buffer_addr_rd		= core_depth_buffer_addr_rd_i;

			depth_buffer_wen_wr		= core_depth_buffer_wen_wr_i;
			depth_buffer_gwen_wr		= core_depth_buffer_gwen_wr_i;
			depth_buffer_addr_wr		= core_depth_buffer_addr_wr_i;
			depth_buffer_data_wr		= core_depth_buffer_data_wr_i;

	end

endmodule
