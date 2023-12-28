`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////
//
// Munya Kaudani
// CDC FIFO memory module
//
////////////////////////////////////////////////////////////////////////////

module fifo_memory(
		input wire       read_clk,
		input wire       write_clk,
		input wire       read_rst_n,
		input wire       write_rst_n,
		input wire [7:0] write_data,
		input wire [3:0] write_addr_in,
		input wire       write_enable_in,
		input wire [3:0] read_addr_in,
		input wire       read_enable_in,
		output reg [7:0] read_data
	);

//internal registers
reg [7:0]	fifo_data_current[0:7];

//internal combinational variables
reg [7:0]   	fifo_data_next[0:7];
reg [7:0]       read_data_next;

//loop variables
integer		i;
integer		j;
  
		
//sequential logic
  always @(posedge write_clk or negedge write_rst_n)
    begin
      if(write_rst_n == 1'b0)begin
	  for(i = 0; i <= 7; i = i + 1)begin
	    fifo_data_current[i] <= 8'h00;
	  end
      end else begin
	  for(i = 0; i <= 7; i = i + 1)begin
	    fifo_data_current[i] <= fifo_data_next[i];
	  end
      end // else: !if(rst_n == 1'b0)
    end // always @ (posedge clk or negedge rst_n)
  
  always @(posedge read_clk or negedge read_rst_n)
    begin
       if(read_rst_n == 1'b0)begin
          read_data <= 8'h00;
       end else begin
          read_data <= read_data_next;
       end 
    end

 always @(*)
   begin
   
      read_data_next = read_data;

      for(j = 0; j <= 7; j = j + 1)begin
	fifo_data_next[j] = fifo_data_current[j];
      end

      if(write_enable_in == 1'b1)begin
	fifo_data_next[write_addr_in[2:0]] = write_data;
      end

      if(read_enable_in == 1'b1)begin
	 read_data_next = fifo_data_current[read_addr_in[2:0]];
      end

   end // always @ (*)

endmodule // fifo_memory

      

