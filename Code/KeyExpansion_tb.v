`timescale 1ns / 100ps // Set the time scale.
`include "KeyExpansion.v" // Include AddRoundKey.v file.

module KeyExpansion_tb; // AddRoundKey_tb module.

	parameter ZERO = 0; // Zero.
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.
	parameter Nr = 10; // Parameter that holds the number of rounds.

    // Inputs
    reg [Nb-1:ZERO] ROUND_KEY; // State (or plaintext)
    reg Clk;

    // Outputs
    wire [Nb*(Nr+1)-1:ZERO] WORD_OUT;

    // Instantiate the Unit Under Test (UUT)
    KeyExpansion uut (
    .round_key(ROUND_KEY), 
    .word_out(WORD_OUT)
    );

always begin
	#1  Clk = ~Clk; 
end

    initial begin

    	// Initialize Inputs
    	ROUND_KEY = 128'h2b7e151628aed2a6abf7158809cf4f3c; Clk = ZERO;
        
	// Add stimulus here
 	#2 ROUND_KEY=128'h2b7e151628aed2a6abf7158809cf4f3c;

	#2 $finish;

    end 
 
    initial begin
	   $monitor("time=", $time, "ROUND_KEY=%h WORD_OUT=%h", ROUND_KEY, WORD_OUT);
    end      
endmodule // End of module.

