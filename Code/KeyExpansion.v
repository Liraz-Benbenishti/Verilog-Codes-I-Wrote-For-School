`include "Rcon.v"
`include "RotWord.v"
`include "subBytes.v"

module KeyExpansion(round_key, word_out); // KeyExpansion module.

	parameter BYTE = 8; // The size of byte is 8 bits.
	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.
	parameter Nr = 10; // Parameter that holds the number of rounds.

	input 	[Nb-1:ZERO] round_key; // Inputs.
	output 	[Nb*(Nr+1)-1:ZERO] word_out; // Outputs - the key of the different rounds.

wire [WORD-1:ZERO] Rcon_out[ZERO : Nr-1];		// 	the Rcon module result for each instance
wire [WORD-1:ZERO] RotWord_out[ZERO : Nr-1];	//	the RotWord module result for each instance
wire [WORD-1:ZERO] SubWord_out[ZERO : Nr-1];	//	the SubWord module result for each instance
wire [WORD-1:ZERO] xor1[ZERO : Nr-1];			//	xor between Rcon and Subword (Subword uses the result from Rotword) for each instace
wire [WORD-1:ZERO] xor2[ZERO : Nr-1];			//	xor between Xor1 and the respective word higher 32bits [127 : 096]. 
wire [WORD-1:ZERO] xor3[ZERO : Nr-1];			//	xor between Xor2 and the respective word bits: [095 : 064]. 
wire [WORD-1:ZERO] xor4[ZERO : Nr-1];			//	xor between Xor3 and the respective word bits. [063 : 032]. 
wire [WORD-1:ZERO] xor5[ZERO : Nr-1]; 			// 	xor between Xor4 and the respective word lower 32bits [031 : 000]. 

wire [3:ZERO] numbers [ZERO:Nr-1];							// an array to store the round number in order to send it to Rcon

assign numbers[0] = 4'h1;
assign numbers[1] = 4'h2;
assign numbers[2] = 4'h3;
assign numbers[3] = 4'h4;
assign numbers[4] = 4'h5;
assign numbers[5] = 4'h6;
assign numbers[6] = 4'h7;
assign numbers[7] = 4'h8;
assign numbers[8] = 4'h9;
assign numbers[9] = 4'hA;

assign word_out[Nb-1:ZERO] = round_key;

genvar i;	// Variable for the generate.
generate 	// Generate command.
for ( i = ZERO; i < Nr ; i = i+1 ) // Loop to create the KeyExpansion module.
begin : ripple
	Rcon 	rcon_cell (.round_number(numbers[i]), .rcon_out(Rcon_out[i]));
	RotWord rotword_cell (.word_to_rotate(word_out[Nb*i+WORD-1:Nb*i]), .rotated_word(RotWord_out[i]));
	subBytes subword_cell (.state_in(RotWord_out[i]), .state_out(SubWord_out[i]));

	assign xor1[i] = SubWord_out[i] ^ Rcon_out[i];
	assign xor2[i] = xor1[i] ^ word_out[Nb*i+4*WORD-1:Nb*i+3*WORD];
	assign xor3[i] = xor2[i] ^ word_out[Nb*i+3*WORD-1:Nb*i+2*WORD];
	assign xor4[i] = xor3[i] ^ word_out[Nb*i+2*WORD-1:Nb*i+WORD];
	assign xor5[i] = xor4[i] ^ word_out[Nb*i+(WORD-1):Nb*i+ZERO];
	assign word_out[Nb*(i+1)+(Nb-1):Nb*(i+1)] = {xor2[i],xor3[i],xor4[i],xor5[i]};	//	concatenating all the xors when the MSB is from Xor2 and the LSB is from Xor5
end

endgenerate // End generate code.

endmodule 	// End of module.
