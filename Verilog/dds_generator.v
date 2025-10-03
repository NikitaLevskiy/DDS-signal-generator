`timescale 1ns/1ps;

module dds_generator
(
	 input wire        rst_i,
	 input wire        clk_i,
	 input wire [31:0] freq_i,
	 
	output wire  [7:0] data_o
);

	/*
	** Localparams
	*/

	localparam DATA_WIDTH = 8;
	localparam ADDR_WIDTH = 8;
	

	/*
	** Phase Accumulator
	*/

	reg [31:0] phase_acc;
	
	always @(posedge clk_i or posedge rst_i) begin
	
		if (rst_i) begin
		
			phase_acc <= 'd0;
		
		end else begin
		
			phase_acc <= phase_acc + freq_i;
		
		end
	
	end
	
	
	/*
	** Read only memory
	*/
	
	 reg [DATA_WIDTH-1:0] rom [(2**ADDR_WIDTH)-1:0];
	 reg [DATA_WIDTH-1:0] rom_output;
	wire [ADDR_WIDTH-1:0] memory_addr = phase_acc[31:32-ADDR_WIDTH];
	
	initial begin
	
		$readmemb("rom_data_file_bin.txt", rom, 0, (2**ADDR_WIDTH)-1);
	
	end
	
	always @(posedge clk_i or posedge rst_i) begin
	
		if (rst_i) begin
		
			rom_output <= 'd0;
		
		end else begin
		
			rom_output <= rom[memory_addr];
		
		end
	
	end
	
	
	/*
	** Output
	*/
	
	assign data_o = rom_output;

endmodule