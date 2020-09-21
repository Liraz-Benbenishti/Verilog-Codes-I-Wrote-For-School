module Rcon(round_number, rcon_out); 	// Rcon module.

	parameter BYTE = 8; // The size of byte is 8 bits.
	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.
	parameter THREE = 3; // Do Not Change.
	parameter MAX_ROUNDS = 14; // Max number of rounds (10, 12 or 14).
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.
	parameter Nr = 10; // Parameter that holds the number of rounds.

// Inputs
input [THREE:ZERO] round_number;

// Outputs
output [WORD-1:ZERO] rcon_out;

wire [WORD-1:ZERO] rcon_msb_temp;
wire [BYTE-1:ZERO] Rcon_array[ZERO:MAX_ROUNDS-1];

// For each round, return the corelating number from the Rcon array as the 8 MSB's followed by 24 zeros  

assign Rcon_array[8'h00] = 8'h01;
assign Rcon_array[8'h01] = 8'h02;
assign Rcon_array[8'h02] = 8'h04;
assign Rcon_array[8'h03] = 8'h08;
assign Rcon_array[8'h04] = 8'h10;
assign Rcon_array[8'h05] = 8'h20;
assign Rcon_array[8'h06] = 8'h40;
assign Rcon_array[8'h07] = 8'h80;
assign Rcon_array[8'h08] = 8'h1B;
assign Rcon_array[8'h09] = 8'h36;
assign Rcon_array[8'h0A] = 8'h6C;
assign Rcon_array[8'h0B] = 8'hD8;
assign Rcon_array[8'h0C] = 8'hAB;
assign Rcon_array[8'h0D] = 8'h4D;

assign rcon_out = { Rcon_array[round_number-1], 24'h0 };

endmodule // End of module.
