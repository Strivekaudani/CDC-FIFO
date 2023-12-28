`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////
//
// Munya Kaudani
// CDC FIFO two flip flop synchronizer
//
////////////////////////////////////////////////////////////////////////////

module two_flip_flop_sync(
			  input wire	   one_clk,
			  input wire	   two_clk,
			  input wire	   one_rst_n,
			  input wire	   two_rst_n,
			  input wire [3:0] data_in,
			  output reg [3:0] data_out
			  );

   //internal registers
   reg [3:0]				     data_out_internal;
   reg [3:0]				     data_in_internal;

   //sequential logic for one_clk
   always @(posedge one_clk or negedge one_rst_n)
     begin
	if(one_rst_n == 1'b0)begin
	   data_in_internal <= 4'b0000;
	end else begin
	   data_in_internal <= data_in;
	end
     end

   //sequential logic for two_clk
   always @(posedge two_clk or negedge two_rst_n)
     begin
	if(two_rst_n == 1'b0)begin
	   data_out_internal <= 4'b0000;
	   data_out <= 4'b0000;
	end else begin
	   data_out_internal <= data_in_internal;
	   data_out <= data_out_internal;
        end
     end

endmodule // two_flip_flop_sync

	   
			  
