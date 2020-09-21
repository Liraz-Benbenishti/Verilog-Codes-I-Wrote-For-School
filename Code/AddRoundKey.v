// plaintext - 128 bit
//  roundkey - 128 bit
// divided into segments of bytes (16 bytes). (4x4 matrix)

module AddRoundKey(in1, in2, out); // AddRoundKey moudle.

	parameter Nb=128; // Number of bits for key and word. (DO NOT CHANGE!).
	parameter ZERO=0; // Zero. (DO NOT CHANGE!).

	input [Nb-1:ZERO] in1; 	// 4 bytes from the StateArray
	input [Nb-1:ZERO] in2;	// 4 corelating bytes from the KeySchedule
	output [Nb-1:ZERO] out;

	assign out = in1 ^ in2; // XOR the two inputs. 

endmodule // End of module.

