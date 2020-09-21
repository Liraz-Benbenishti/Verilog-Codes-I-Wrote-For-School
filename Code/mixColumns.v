`include "ColMix.v" // Include the ColMix.v file.
module mixColumns (state_in, state_out); // mixColumns module.
 
	parameter BYTE = 8; // The size of byte is 8 bits.
	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.
	parameter Nr = 10; // Parameter that holds the number of rounds.

	input 	wire	[Nb-1:ZERO]	state_in;	// current column before change
	output 	wire	[Nb-1:ZERO]	state_out;	// the column after the mix

	// temporary wires
	wire [WORD-1:ZERO] col1;
	wire [WORD-1:ZERO] col2;
	wire [WORD-1:ZERO] col3;
	wire [WORD-1:ZERO] col4;
	wire [WORD-1:ZERO] col1m;
	wire [WORD-1:ZERO] col2m;
	wire [WORD-1:ZERO] col3m; 
	wire [WORD-1:ZERO] col4m;

	assign col1 = state_in[4*WORD-1:3*WORD];
	assign col2 = state_in[3*WORD-1:2*WORD];
	assign col3 = state_in[2*WORD-1:WORD];
	assign col4 = state_in[WORD-1:ZERO];

	// activate colMix module on each 32 bit wire
	ColMix colmix1(.col_in(col1), .col_out(col1m));
	ColMix colmix2(.col_in(col2), .col_out(col2m));
	ColMix colmix3(.col_in(col3), .col_out(col3m));
	ColMix colmix4(.col_in(col4), .col_out(col4m));

	assign state_out = {col1m, col2m, col3m, col4m}; // concatenate the mixed columns in the same order 
endmodule // End of module.
