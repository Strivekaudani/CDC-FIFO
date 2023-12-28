`timescale 1ns / 1ps

module cdc_fifo_tb(
		   );

   reg           write_clk;
   reg           read_clk;
   reg           write_rst_n;
   reg           read_rst_n;
   reg [7:0]     data_write;
   reg	         enable_write;
   reg	         enable_read;
   wire [7:0]    data_read;
   wire	         fifo_full;
   wire	         fifo_empty;

   reg [8*39:0]	 testcase;

   cdc_fifo DUT(
		   .write_clk(write_clk),
		   .read_clk(read_clk),
		   .write_rst_n(write_rst_n),
		   .read_rst_n(read_rst_n),
		   .write_data_external(data_write),
		   .write_enable_external(enable_write),
		   .read_enable_external(enable_read),
		   .read_data_external(data_read),
		   .full_external(fifo_full),
		   .empty_external(fifo_empty)
		   );

   always #5 write_clk = ~write_clk;
   always #8.5 read_clk = ~read_clk;

   initial begin
      //initial values
      write_clk = 0;
      read_clk = 0;
      write_rst_n = 0;
      read_rst_n = 0;
      data_write = 0;
      enable_write = 0;
      enable_read = 0;

      $monitor("Testcase: %s, read_data = %b, full = %b, empty = %b, Time = %t", testcase, data_read, fifo_full, fifo_empty, $time);

      //reset
      #23
	read_rst_n = 1;
        write_rst_n = 1;
      #10
      
      //write tests
      
      #12
	enable_write = 1;
      #10
	testcase = "writing to 0000";
	data_write = 8'h01;
      #10
	enable_write = 1;
	testcase = "writing to 0001";
	data_write = 8'h02;
      #10
	enable_write = 1;
	testcase = "writing to 0010";
	data_write = 8'h03;
      #10
	enable_write = 1;
	testcase = "writing to 0011";
	data_write = 8'h04;
      #10
	enable_write = 1;
	testcase = "writing to 0100";
	data_write = 8'h05;
      #10
	enable_write = 1;
	testcase = "writing to 0101";
	data_write = 8'h06;
      #10
	enable_write = 1;
	testcase = "writing to 0110";
	data_write = 8'h07;
      #10
	enable_write = 1;
	testcase = "writing to 0111";
	data_write = 8'h08;
      #10
	enable_write = 1;
	testcase = "testing overflow";
	data_write = 8'h09;
      #10
	enable_write = 0;
      #1

      //read tests
      #17
	enable_read = 1;
	testcase = "reading from 0000";
      #17
	enable_read = 1;
	testcase = "reading from 0001";
      #17
	enable_read = 1;
	testcase = "reading from 0010";
      #17
	enable_read = 1;
	testcase = "reading from 0011";
      #17
	enable_read = 1;
	testcase = "reading from 0100";
      #17
	enable_read = 1;
	testcase = "reading from 0101";
      #17
	enable_read = 1;
	testcase = "reading from 0110";
      #17
	enable_read = 1;
	testcase = "reading from 0111";
      #17
	enable_read = 1;
	testcase = "testing overflow";
      #17
	enable_read = 0;
	
      #30
	$finish;
   end // initial begin

endmodule // fifo_memory

      
		   
      

   

   
   
