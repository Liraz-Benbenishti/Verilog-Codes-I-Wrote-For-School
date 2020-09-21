module mult (Input_Byte, Output_Byte); // xmult module.

	parameter BYTE = 8; // The size of byte is 8 bits.
	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.
	parameter Nr = 10; // Parameter that holds the number of rounds.

	input [BYTE-1:ZERO] Input_Byte;
	output wire [BYTE-1:ZERO] Output_Byte;

	// checks the MSB of the Input_Byte: if it is 0  shift left
	// if it is a 1  shift to the left and XOR with {1B}.
	assign Output_Byte = (!Input_Byte[BYTE-1]) ? {Input_Byte[BYTE-2:ZERO],1'b0} : {Input_Byte[BYTE-2:ZERO],1'b0} ^ 8'h1B;
endmodule // End of module.
