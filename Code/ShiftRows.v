//	Recives a 128 bit word - which we simulate as a 4X4 matrix.
//	the first row is left as it is.
//	the second row is cyclicly shifted left by 8 bits. 
//	the third row is cyclicly shifted left by 16 bits. 
//	the fourth row is cyclicly shifted left by 24 bits. 

module ShiftRows
	(
		s,
		s_tab
	); // ShiftRows module.

	parameter Nb = 128;
	parameter BYTE = 8; 
	parameter ZERO = 0; 

	// Inputs
	input [Nb-1:ZERO] s;

	// Outputs
	output [Nb-1:ZERO] s_tab;
	
	assign s_tab = {s[15*BYTE+(BYTE-1):15*BYTE], s[10*BYTE+(BYTE-1):10*BYTE], s[5*BYTE+(BYTE-1):5*BYTE], s[(BYTE-1):0], s[11*BYTE+(BYTE-1):11*BYTE], s[6*BYTE+(BYTE-1):6*BYTE], s[BYTE+(BYTE-1):BYTE], s[12*BYTE+(BYTE-1):12*BYTE], s[7*BYTE+(BYTE-1):7*BYTE], s[2*BYTE+(BYTE-1):2*BYTE], s[13*BYTE+(BYTE-1):13*BYTE], s[8*BYTE+(BYTE-1):8*BYTE], s[3*BYTE+(BYTE-1):3*BYTE], s[14*BYTE+(BYTE-1):14*BYTE], s[9*BYTE+(BYTE-1):9*BYTE], s[4*BYTE+(BYTE-1):4*BYTE]};


endmodule // End of module.


