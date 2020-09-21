// 	Recieves a 32 bit word and sends it to the Sbox module

`include "Sbox.v"

module subBytes(state_in, state_out);

	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.

	input  [WORD-1:ZERO]	state_in;
	output [WORD-1:ZERO]	state_out;

	Sbox sbox_byte_1(.State_in(state_in[WORD-1:ZERO]), .Sbox_new(state_out[WORD-1:ZERO]));
	
endmodule // subBytes
