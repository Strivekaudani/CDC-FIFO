`timescale 1ns/1ps

////////////////////////////////////////////////////////////////////////////
//
// Munya Kaudani
// CDC FIFO write control logic
//
////////////////////////////////////////////////////////////////////////////

module write_control_logic(
			   input wire	    write_clk,
			   input wire	    write_rst_n,
			   input wire	    write_enable,
			   input wire [3:0] r_synchronization,
			   output reg	    full,
			   output reg [3:0] write_addr_out,
			   output reg	    write_enable_out,
			   output reg [3:0] write_addr_gray
			   );

   //internal registers
   reg [3:0]			      write_pointer;
   
   //internal combinational variables
   reg [3:0]			      write_pointer_next;
   reg				      full_next;
   reg [3:0]			      write_addr_gray_next;
   reg [3:0]			      write_addr_next;
   reg				      write_enable_out_next;

   reg [3:0]			      read_pointer_next;

   //sequential logic
   always @(posedge write_clk or negedge write_rst_n)
     begin
	if(write_rst_n == 1'b0)begin
	   write_pointer <= 4'b0000;
	   full <= 1'b0;
	   write_enable_out <= 1'b0;
	   write_addr_out <= 4'b0000;
	   write_addr_gray <= 4'b0000;
	end else begin
	   write_pointer <= write_pointer_next;
	   full <= full_next;
	   write_enable_out <= write_enable_out_next;
	   write_addr_gray <= write_addr_gray_next;
	   write_addr_out <= write_addr_next;
	end
     end

   //combinational logic
   always @(*)
     begin
	
	write_pointer_next = write_pointer;
	full_next = full;
	write_enable_out_next = write_enable_out;
	write_addr_gray_next = write_addr_gray;
	write_addr_next = write_addr_out;

	if( (write_enable == 1'b1) & (full == 1'b0) )begin
	   write_addr_next = write_pointer;
	   write_enable_out_next = 1'b1;
	   write_pointer_next = write_pointer + 1'b1;
	end else begin
	   write_enable_out_next = 1'b0;
	end

	case(write_pointer_next)
	  4'b0000: write_addr_gray_next = 4'b0000;
	  4'b0001: write_addr_gray_next = 4'b0001;
	  4'b0010: write_addr_gray_next = 4'b0011;
	  4'b0011: write_addr_gray_next = 4'b0010;
	  4'b0100: write_addr_gray_next = 4'b0110;
	  4'b0101: write_addr_gray_next = 4'b0111;
	  4'b0110: write_addr_gray_next = 4'b0101;
	  4'b0111: write_addr_gray_next = 4'b0100;
	  4'b1000: write_addr_gray_next = 4'b1100;
	  default: write_addr_gray_next = 4'b0000;
	endcase // case (write_pointer_next)

	case(r_synchronization)
	  4'b0000: read_pointer_next = 4'b0000;
	  4'b0001: read_pointer_next = 4'b0001;
	  4'b0011: read_pointer_next = 4'b0010;
	  4'b0010: read_pointer_next = 4'b0011;
	  4'b0110: read_pointer_next = 4'b0100;
	  4'b0111: read_pointer_next = 4'b0101;
	  4'b0101: read_pointer_next = 4'b0110;
	  4'b0100: read_pointer_next = 4'b0111;
	  4'b1100: read_pointer_next = 4'b1000;
	  default: read_pointer_next = 4'b0000;
	endcase // case (synchronization)

	if ( (write_pointer_next[2:0] == read_pointer_next[2:0]) && (write_pointer_next[3] != read_pointer_next[3]) ) begin
	   full_next = 1'b1;
	   write_enable_out_next = 1'b0;
	end else begin
	   full_next = 1'b0;
	end
	  
     end // always @ (*)

endmodule // write_control_logic

	   
   
	
	  
   
   


   
