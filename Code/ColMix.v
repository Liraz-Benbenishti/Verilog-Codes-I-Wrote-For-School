`include "mult.v"

module ColMix (col_in, col_out);

	parameter BYTE = 8; // The size of byte is 8 bits.
	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.

	input 	wire	[WORD-1 : ZERO] col_in; 	// the current column
	output 	wire	[WORD-1 : ZERO] col_out;	// the mixed coluomn
	wire 			[BYTE-1 : ZERO] temp1, temp2, temp3, temp4; // temporary wires

	mult mult1(.Input_Byte(col_in[BYTE-1 : ZERO]), .Output_Byte(temp4));	// first byte times two
	mult mult2(.Input_Byte(col_in[2*BYTE-1 : BYTE]), .Output_Byte(temp3));	// second byte times two
	mult mult3(.Input_Byte(col_in[3*BYTE-1 : 2*BYTE]), .Output_Byte(temp2));	// third byte times two
	mult mult4(.Input_Byte(col_in[4*BYTE-1 : 3*BYTE]), .Output_Byte(temp1));	// fourth byte times two


	assign col_out[4*BYTE-1 : 3*BYTE] = temp1 ^ (temp2 ^ col_in[3*BYTE-1 : 2*BYTE]) ^ col_in[2*BYTE-1 : BYTE] ^ col_in[BYTE-1 : ZERO];
	assign col_out[3*BYTE-1 : 2*BYTE] = col_in[4*BYTE-1 : 3*BYTE] ^ temp2 ^ (temp3 ^ col_in[2*BYTE-1 : BYTE]) ^ col_in[BYTE-1 : ZERO];
	assign col_out[2*BYTE-1 : BYTE] = col_in[4*BYTE-1 : 3*BYTE] ^ col_in[3*BYTE-1 : 2*BYTE] ^ temp3 ^ (temp4 ^ col_in[BYTE-1 : ZERO]);
	assign col_out[BYTE-1 : ZERO] = (temp1 ^ col_in[4*BYTE-1 : 3*BYTE]) ^ col_in[3*BYTE-1 : 2*BYTE] ^ col_in[2*BYTE-1 : BYTE] ^ temp4;


endmodule
