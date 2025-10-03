`timescale 1ns/1ps;

module dds_generator_tb();

	/*
	** Local parameters of the testbench
	*/

	localparam FREQ = 32'd4_294_967;
	
	
	/*
	** Input/Output signals of the testbench
	*/
	
	 reg              rst_i;
	 reg              clk_i;
	 reg       [31:0] freq_i;
	
	wire signed [7:0] data_o;
	
	
	/*
	** Module instantiation
	*/
	
	dds_generator dds_generator_dut
	(
		.rst_i(rst_i),
		.clk_i(clk_i),
		.freq_i(freq_i),
		.data_o(data_o)
	);
	
	
	/*
	** Clock signals
	*/
	
	always begin
	
		#500 clk_i = ~clk_i;
	
	end
	
	
	initial begin
	
		rst_i = 1'b1;
		clk_i = 1'b1;
		freq_i = FREQ;
		
		#5000;
		rst_i = 1'b0;
	
	end

endmodule