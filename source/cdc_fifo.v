`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////
//
// Munya Kaudani
// CDC FIFO top level module
//
////////////////////////////////////////////////////////////////////////////

module cdc_fifo(
		input wire       write_clk,
		input wire       read_clk,
		input wire       write_rst_n,
		input wire       read_rst_n,
		input wire [7:0] write_data_external,
		input wire       write_enable_external,
		input wire       read_enable_external,
		output reg       full_external,
		output reg [7:0] read_data_external,
		output reg       empty_external
		);

   //internal combinational variables
   wire [7:0]			 read_data_external_next;
   wire				 full_external_next;
   wire				 empty_external_next;

   //internal input signals
   wire [3:0]			 write_addr_internal;
   wire				 write_enable_internal;
   wire [3:0]			 read_addr_internal;
   wire				 read_enable_internal;
   wire [3:0]			 write_addr_gray_internal;
   wire [3:0]			 read_addr_gray_internal;
   wire [3:0]			 w_tffs_out;
   wire [3:0]			 r_tffs_out;
   
   //interfacing
   write_control_logic writer(
			      .write_clk(write_clk),
			      .write_rst_n(write_rst_n),
			      .write_addr_out(write_addr_internal),
			      .write_enable_out(write_enable_internal),
			      .write_enable(write_enable_external),
			      .full(full_external_next),
			      .write_addr_gray(write_addr_gray_internal),
			      .r_synchronization(r_tffs_out)
			      );

   read_control_logic reader(
			     .read_clk(read_clk),
			     .read_rst_n(read_rst_n),
			     .read_addr_out(read_addr_internal),
			     .read_enable_out(read_enable_internal),
			     .read_enable(read_enable_external),
			     .empty(empty_external_next),
			     .read_addr_gray(read_addr_gray_internal),
			     .w_synchronization(w_tffs_out)
			     );

   two_flip_flop_sync r_tffs(
			     .one_clk(read_clk),
			     .two_clk(write_clk),
			     .one_rst_n(read_rst_n),
			     .two_rst_n(write_rst_n),
			     .data_in(read_addr_gray_internal),
			     .data_out(r_tffs_out)
			     );

   two_flip_flop_sync w_tffs(
			     .one_clk(write_clk),
			     .two_clk(read_clk),
			     .one_rst_n(write_rst_n),
			     .two_rst_n(read_rst_n),
			     .data_in(write_addr_gray_internal),
			     .data_out(w_tffs_out)
			     );

   fifo_memory fifo_mem(
			.read_clk(read_clk),
			.write_clk(write_clk),
			.read_rst_n(read_rst_n),
			.write_rst_n(write_rst_n),
			.write_data(write_data_external),
			.write_addr_in(write_addr_internal),
			.write_enable_in(write_enable_internal),
			.read_addr_in(read_addr_internal),
			.read_enable_in(read_enable_internal),
			.read_data(read_data_external_next)
			);


   //sequential logic
   always @(posedge read_clk or negedge read_rst_n)
     begin
	if(read_rst_n == 1'b0)begin
	   empty_external <= 1'b1;
	   read_data_external <= 8'h00;
	end else begin
	   empty_external <= empty_external_next;
	   read_data_external <= read_data_external_next;
	end
     end // always @ (posedge read_clk or negedge read_rst_n)

   always @(posedge write_clk or negedge write_rst_n)
     begin
	if(write_rst_n == 1'b0)begin
	   full_external <= 1'b0;
	end else begin
	   full_external <= full_external_next;
	end
     end
     
endmodule


   
			      
   
		
