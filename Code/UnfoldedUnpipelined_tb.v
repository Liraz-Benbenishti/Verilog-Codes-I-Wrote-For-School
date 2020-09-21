`timescale 1ns / 100ps // Set the time scale.
`include "UnfoldedUnpipelined.v" // Include AddRoundKey.v file.

module UnfoldedUnpipelined_tb; // AddRoundKey_tb module.

	parameter ZERO = 0; // Zero.
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.

    // Inputs
    reg [Nb-1:ZERO] PLAIN_TEXT; // State (or plaintext)
    reg [Nb-1:ZERO] ROUND_KEY; // State (or plaintext)
    reg Clk, reset;

    // Outputs
    wire [Nb-1:ZERO] CIPHER_TEXT;

    // Instantiate the Unit Under Test (UUT)
    UnfoldedUnpipelined uut8 (
	.clk(Clk),
	.reset(reset),    
	.plain_text(PLAIN_TEXT), 
    .round_key(ROUND_KEY), .cipher_text(CIPHER_TEXT)
    );

always begin
	#1  Clk = ~Clk; 
end

    initial begin

    	// Initialize Inputs
    	ROUND_KEY = 128'h0; PLAIN_TEXT = 128'h0; reset = 1; Clk = ZERO; // Expected Output: 00000000... .
        
	// Add stimulus here
    	#2 reset = ZERO; ROUND_KEY = 128'h2b7e151628aed2a6abf7158809cf4f3c; PLAIN_TEXT = 128'h3243f6a8885a308d313198a2e0370734; // Expected Output: 3925841D02DC09FBDC118597196A0B32.
 	#2 ROUND_KEY = 128'h000102030405060708090a0b0c0d0e0f; PLAIN_TEXT = 128'h00112233445566778899aabbccddeeff; // Expected Output: 69c4e0d86a7b0430d8cdb78070b4c55a. 

	#2 $finish;

    end 
 
    initial begin
	   $monitor("time=", $time, "ROUND_KEY=%h PLAIN_TEXT=%h, CIPHER_TEXT=%h", ROUND_KEY, PLAIN_TEXT, CIPHER_TEXT);
    end      
endmodule // End of module.

