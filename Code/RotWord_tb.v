`timescale 1ns/1ns
`include "RotWord.v"

module RotWord_tb;

	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.

// Inputs
reg [WORD-1:ZERO] word_to_rotate;
reg Clk;

// Outputs
wire  [WORD-1:ZERO] rotated_word;


RotWord rotword(word_to_rotate, rotated_word); // Instantiate the Unit Under Test

initial 
begin 
    word_to_rotate = 32'h0000; Clk = 1'b0;
    
    #2 word_to_rotate = 32'hffff; // Expected Output: 00FFFF00.

    #2 word_to_rotate = 32'h9999; // Expected Output: 00999900.

    #2 word_to_rotate = 32'h1c444; // Expected Output: 01C44400.

    #2 word_to_rotate = 32'habcd; // Expected Output: 00ABCD00.

    #2 word_to_rotate = 32'h12341; // Expected Output: 01234100.

   #2 $finish;
end

// Clock

always Clk = #1 ~Clk;

initial begin
		$monitor("word_to_rotate=%h, rotated_word=%h", word_to_rotate, rotated_word);
	end
endmodule
