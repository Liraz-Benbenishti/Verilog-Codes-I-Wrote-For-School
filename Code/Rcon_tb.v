`timescale 1ns / 100ps // Set the time scale.
`include "Rcon.v" // Include AddRoundKey.v file.

module Rcon_tb; // AddRoundKey_tb module.

	parameter BYTE = 8; // The size of byte is 8 bits.
	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.
	parameter THREE = 3; // Do Not Change.
	parameter MAX_ROUNDS = 14; // Max number of rounds (10, 12 or 14).
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.
	parameter Nr = 10; // Parameter that holds the number of rounds.

    // Inputs
    reg [THREE:ZERO] ROUND_NUMBER; // State (or plaintext)
    reg Clk;

    // Outputs
    wire [WORD-1:ZERO] RCON_OUT;

    // Instantiate the Unit Under Test (UUT)
    Rcon uut (
    .round_number(ROUND_NUMBER), 
    .rcon_out(RCON_OUT)
    );

always begin
	#1  Clk = ~Clk; 
end

    initial begin

    	// Initialize Inputs
    	ROUND_NUMBER = 4'b0; Clk = ZERO;
        
	// Add stimulus here
 	#2 ROUND_NUMBER=4'h1; // Expected Output: 01000000. 
 	#2 ROUND_NUMBER=4'h2; // Expected Output: 02000000. 
 	#2 ROUND_NUMBER=4'h3; // Expected Output: 04000000. 
 	#2 ROUND_NUMBER=4'h4; // Expected Output: 08000000. 
 	#2 ROUND_NUMBER=4'h5; // Expected Output: 10000000. 
 	#2 ROUND_NUMBER=4'h6; // Expected Output: 20000000. 
 	#2 ROUND_NUMBER=4'h7; // Expected Output: 40000000. 
 	#2 ROUND_NUMBER=4'h8; // Expected Output: 80000000. 
 	#2 ROUND_NUMBER=4'h9; // Expected Output: 1B000000. 
 	#2 ROUND_NUMBER=4'hA; // Expected Output: 36000000.  

	#2 $finish;

    end 
 
    initial begin
	   $monitor("time=", $time, "ROUND_NUMBER=%h RCON_OUT=%h", ROUND_NUMBER, RCON_OUT);
    end      
endmodule // End of module.
