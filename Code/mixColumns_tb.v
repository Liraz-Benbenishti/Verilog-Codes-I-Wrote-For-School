`timescale 1ns/1ns
`include "mixColumns.v"

module mixColumns_tb;

	parameter BYTE = 8; // The size of byte is 8 bits.
	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.
	parameter Nr = 10; // Parameter that holds the number of rounds.

	// Outputs
	wire [Nb-1:ZERO] state_out;

	// Inputs
	reg Clk;
	reg  [Nb-1:ZERO]  state_in;

	mixColumns mixcolumns(state_in, state_out);

initial 
begin 

	state_in = 128'h0; Clk = 1'b0;
	
	#2 state_in = 128'h6353e08c0960e104cd70b751bacad0e7; // expeted resualt: 5f72641557f5bc92f7be3b291db9f91a
    
	#2 state_in = 128'ha7be1a6997ad739bd8c9ca451f618b61; // expeted resualt: ff87968431d86a51645151fa773ad009

	#2 state_in = 128'h3bd92268fc74fb735767cbe0c0590e2d; // expeted resualt: 4c9c1e66f771f0762c3f868e534df256
    
        #2 $finish;
end

// Clock

always Clk = #1 ~Clk;
    	initial begin
		$monitor("state_in=%h, state_out=%h", state_in, state_out);
	end
endmodule
