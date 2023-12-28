`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////
//
// Munya Kaudani
// CDC FIFO read control logic
//
////////////////////////////////////////////////////////////////////////////

module read_control_logic(
			  input wire	   read_clk,
			  input wire	   read_rst_n,
			  input wire	   read_enable,
			  input wire [3:0] w_synchronization,
			  output reg	   empty,
			  output reg [3:0] read_addr_out,
			  output reg	   read_enable_out,
			  output reg [3:0] read_addr_gray
			  );

   //internal registers
   reg [3:0]			     read_pointer;

   //internal combinational logic
   reg [3:0]			     read_pointer_next;
   reg				     empty_next;
   reg [3:0]			     read_addr_out_next;
   reg [3:0]			     read_addr_gray_next;
   reg				     read_enable_out_next;

   reg [3:0]			     write_pointer_next;

   //sequential logic
   always @(posedge read_clk or negedge read_rst_n)
     begin
	if(read_rst_n == 1'b0)begin
	   read_pointer <= 4'b0000;
	   empty <= 1'b1;
	   read_enable_out <= 1'b0;
	   read_addr_out <= 4'b0000;
	   read_addr_gray <= 4'b0000;
	end else begin
	   read_pointer <= read_pointer_next;
	   empty <= empty_next;
	   read_enable_out <= read_enable_out_next;
	   read_addr_gray <= read_addr_gray_next;
	   read_addr_out <= read_addr_out_next;
        end // else: !if(read_rst_n == 1'b0)
     end // always @ (posedge read_clk or negedge read_rst_n)

   //combinational logic
   always @(*)
     begin

	read_pointer_next = read_pointer;
	empty_next = empty;
	read_enable_out_next = read_enable_out;
	read_addr_gray_next = read_addr_gray;
	read_addr_out_next = read_addr_out;

	if( (read_enable == 1'b1) & (empty == 1'b0) )begin
	   read_addr_out_next = read_pointer;
	   read_enable_out_next = 1'b1;
	   read_pointer_next = read_pointer + 1'b1;
	end else begin
	   read_enable_out_next = 1'b0;
	end

	case(read_pointer_next)
	  4'b0000: read_addr_gray_next = 4'b0000;
	  4'b0001: read_addr_gray_next = 4'b0001;
	  4'b0010: read_addr_gray_next = 4'b0011;
	  4'b0011: read_addr_gray_next = 4'b0010;
	  4'b0100: read_addr_gray_next = 4'b0110;
	  4'b0101: read_addr_gray_next = 4'b0111;
	  4'b0110: read_addr_gray_next = 4'b0101;
	  4'b0111: read_addr_gray_next = 4'b0100;
	  4'b1000: read_addr_gray_next = 4'b1100;
	  default: read_addr_gray_next = 4'b0000;
	endcase // case (read_pointer_next)

	case(w_synchronization)
	  4'b0000: write_pointer_next = 4'b0000;
	  4'b0001: write_pointer_next = 4'b0001;
	  4'b0011: write_pointer_next = 4'b0010;
	  4'b0010: write_pointer_next = 4'b0011;
	  4'b0110: write_pointer_next = 4'b0100;
	  4'b0111: write_pointer_next = 4'b0101;
	  4'b0101: write_pointer_next = 4'b0110;
	  4'b0100: write_pointer_next = 4'b0111;
	  4'b1100: write_pointer_next = 4'b1000;
	  default: write_pointer_next = 4'b0000;
	endcase // case (synchronization)

	if( write_pointer_next == read_pointer_next ) begin
	   empty_next = 1'b1;
	   read_enable_out_next = 1'b0;
	end else begin
	   empty_next = 1'b0;
	end

     end // always @ (*)

endmodule // read_control_logic

	   
	
   
			  
