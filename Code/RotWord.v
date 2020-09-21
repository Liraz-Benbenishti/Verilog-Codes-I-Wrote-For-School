// rotates the 32 bit word 8 bits to the left, in a cyclic manner.

module RotWord(word_to_rotate, rotated_word); 	// RotWord module.

	parameter BYTE = 8; // The size of byte is 8 bits.
	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.

	input [WORD-1:ZERO] word_to_rotate;
	output [WORD-1:ZERO] rotated_word;

	assign rotated_word = { word_to_rotate[3*BYTE-1:2*BYTE] , word_to_rotate[2*BYTE-1:BYTE] , word_to_rotate[BYTE-1:ZERO], word_to_rotate[4*BYTE-1:3*BYTE] };

endmodule // End of module.
