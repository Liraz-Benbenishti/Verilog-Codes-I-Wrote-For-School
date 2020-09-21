// Recives a 128 plain text word and implements the AES cyphering method on it

`include "mixColumns.v"
`include "KeyExpansion.v"
`include "ShiftRows.v"
`include "AddRoundKey.v"
`include "subBytes2.v"

module UnfoldedUnpipelined(clk, reset, plain_text, 
			   round_key,
			   cipher_text
	);// UnfoldedUnpipelined module

	parameter ZERO = 0; // Zero.
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.
	parameter Nr = 10; // Parameter that holds the number of rounds.

	// Inputs
	input [Nb-1:ZERO] plain_text;
	input [Nb-1:ZERO] round_key;
	input clk;
	input reset;	

	// Outputs
	output reg [Nb-1:ZERO] cipher_text;

wire [Nb*(Nr+1)-1:ZERO] rounds_keys;				// Unfolded 11 cyphered words each 128 bit long.
wire [Nb-1:ZERO] after_addroundkey [ZERO:Nr];	// the current word after addRoundKey was implemnted on it.
wire [Nb-1:ZERO] after_subbytes[ZERO:Nr-1];		// the current word after subBytes2 was implemnted on it.
wire [Nb-1:ZERO] after_shiftrows[ZERO:Nr-1];		// the current word after ShiftRows was implemnted on it.
wire [Nb-1:ZERO] after_mixcols[ZERO:Nr-1]; 		// the current word after mixColumns was implemnted on it.

KeyExpansion key_expansion (.round_key(round_key), .word_out(rounds_keys));

// Round 0:
AddRoundKey addroundkey_0 (.in1(plain_text), .in2(rounds_keys[Nb-1:ZERO]), .out(after_addroundkey[ZERO]));

// Rounds 1-9:
genvar i; // Variable for the generate.
generate // Generate command.
for ( i = 1; i <= Nr-1 ; i = i+1 ) // Loop to create the KeyExpansion module.
begin : ripple
	subBytes2 sub_bytes1_9 (.state_in(after_addroundkey[i-1]), .state_out(after_subbytes[i-1]));
	ShiftRows shift_rows1_9 (.s(after_subbytes[i-1]), .s_tab(after_shiftrows[i-1]));
	mixColumns mix_columns1_9 (.state_in(after_shiftrows[i-1]), .state_out(after_mixcols[i-1]));
	AddRoundKey addroundkey_1_9 (.in1(after_mixcols[i-1]), .in2(rounds_keys[Nb*i+Nb-1:Nb*i]), .out(after_addroundkey[i]));
end
endgenerate // End generate code.

// Round 10
	subBytes2 sub_bytes10 (.state_in(after_addroundkey[Nr-1]), .state_out(after_subbytes[Nr-1]));
	ShiftRows shift_rows10 (.s(after_subbytes[Nr-1]), .s_tab(after_shiftrows[Nr-1]));
	AddRoundKey addroundkey_10 (.in1(after_shiftrows[Nr-1]), .in2(rounds_keys[Nb*(Nr+1)-1:Nb * Nr]), .out(after_addroundkey[Nr]));

always @(posedge clk or posedge reset)
begin
	if (reset == 1'b1)
	begin
		cipher_text = 0;
	end
	else
	begin
		cipher_text = after_addroundkey[Nr];
	end
end
endmodule
