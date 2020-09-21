//	Recieves a 128 bit word, sending it to the Sbox module as 4 32 bit words. then recieving an answer parallelly.

`include "Sbox.v"

module subBytes2(state_in,
	state_out);

	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.
	
	// Inputs
	input  [Nb-1:ZERO]	state_in;
	
	// Outputs	
	output [Nb-1:ZERO]	state_out;

	Sbox sbox_byte_1(.State_in(state_in[WORD-1:ZERO]), .Sbox_new(state_out[WORD-1:ZERO]));
	Sbox sbox_byte_2(.State_in(state_in[2*WORD-1:WORD]), .Sbox_new(state_out[2*WORD-1:WORD]));
	Sbox sbox_byte_3(.State_in(state_in[3*WORD-1:2*WORD]), .Sbox_new(state_out[3*WORD-1:2*WORD]));
	Sbox sbox_byte_4(.State_in(state_in[4*WORD-1:3*WORD]), .Sbox_new(state_out[4*WORD-1:3*WORD]));
	
endmodule // subBytes
