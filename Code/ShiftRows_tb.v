`timescale 1ns / 100ps // Set the time scale.
`include "ShiftRows.v" // Include ShiftRows.v file.

module ShiftRows_tb; // ShiftRows_tb module.

	parameter ZERO = 0; // Zero.
	parameter Nb = 128; // The number of bits in the plain text, cipher, key.

    // Inputs
    reg [Nb-1:ZERO] S; // State (or plaintext)
    reg Clk;

    // Outputs
    wire [Nb-1:ZERO] S_TAB;

    // Instantiate the Unit Under Test (UUT)
    ShiftRows uut (
    .s(S), 
    .s_tab(S_TAB)
    );

always begin
	#1  Clk = ~Clk; 
end

    initial begin

    	// Initialize Inputs
    	S = 128'b0; Clk = ZERO;
        
	// Add stimulus here
 	#2 S=128'h63cab7040953d051cd60e0e7ba70e18c; // Expected Output: 6353e08c0960e104cd70b751bacad0e7. 
 	#2 S=128'ha761ca9b97be8b45d8ad1a611fc97369; // Expected Output: a7be1a6997ad739bd8c9ca451f618b61. 
 	#2 S=128'h3b59cb73fcd90ee05774222dc067fb68; // Expected Output: 3bd92268fc74fb735767cbe0c0590e2d. 
 	#2 S=128'h2dfb02343f6d12dd09337ec75b36e3f0; // Expected Output: 2d6d7ef03f33e334093602dd5bfb12c7. 
 	#2 S=128'h36400926f9336d2d9fb59d23c42c3950; // Expected Output: 36339d50f9b539269f2c092dc4406d23. 
 	#2 S=128'he847f56514dadde23f77b64fe7f7d490; // Expected Output: e8dab6901477d4653ff7f5e2e747dd4f. 
 	#2 S=128'hb415f8016858552e4bb6124c5f998a4c; // Expected Output: b458124c68b68a014b99f82e5f15554c. 
 	#2 S=128'h3e175076b61c04678dfc2295f6a8bfc0; // Expected Output: 3e1c22c0b6fcbf768da85067f6170495. 
 	#2 S=128'h5411f4b56bd9700e96a0902fa1bb9aa1; // Expected Output: 54d990a16ba09ab596bbf40ea111702f. 
 	#2 S=128'h7a9f102789d5f50b2beffd9f3dca4ea7; // Expected Output: 7ad5fda789ef4e272bca100b3d9ff59f.  

	#2 $finish;

    end 
 
    initial begin
	   $monitor("time=", $time, "S=%h S_TAB=%h", S, S_TAB);
    end      
endmodule // End of module.

