`timescale 1ns / 100ps // Set the time scale.
`include "AddRoundKey.v" // Include AddRoundKey.v file.

module AddRoundKey_tb; // AddRoundKey_tb module.

	parameter Nb=128; // Number of bits for key and word. (DO NOT CHANGE!).
	parameter ZERO=0; // Zero. (DO NOT CHANGE!).

    // Inputs
    reg [Nb-1:ZERO] IN1; // State (or plaintext)
    reg [Nb-1:ZERO] IN2; // Round Key.
    reg Clk;

    // Outputs
    wire [Nb-1:ZERO] OUT;

    // Instantiate the Unit Under Test (UUT)
    AddRoundKey uut (
    .in1(IN1), 
    .in2(IN2), 
    .out(OUT)
    );

always begin
	#1  Clk = ~Clk; 
end

    initial begin

    	// Initialize Inputs
    	IN1 = 128'b0; IN2 = 128'b0; Clk = ZERO;
        
	// Add stimulus here
 	#2 IN1=128'h00112233445566778899aabbccddeeff; IN2=128'h000102030405060708090a0b0c0d0e0f; // Expected Output: 00102030405060708090a0b0c0d0e0f0. 
 	#2 IN1=128'h5f72641557f5bc92f7be3b291db9f91a; IN2=128'hd6aa74fdd2af72fadaa678f1d6ab76fe; // Expected Output: 89d810e8855ace682d1843d8cb128fe4. 
       	
	#2 IN1=128'hff87968431d86a51645151fa773ad009; IN2=128'hb692cf0b643dbdf1be9bc5006830b3fe; // Expected Output: 4915598f55e5d7a0daca94fa1f0a63f7.
 	#2 IN1=128'h4c9c1e66f771f0762c3f868e534df256; IN2=128'hb6ff744ed2c2c9bf6c590cbf0469bf41; // Expected Output: fa636a2825b339c940668a3157244d17.

 	#2 IN1=128'h6385b79ffc538df997be478e7547d691; IN2=128'h47f7f7bc95353e03f96c32bcfd058dfd; // Expected Output: 247240236966b3fa6ed2753288425b6c.
 	#2 IN1=128'hf4bcd45432e554d075f1d6c51dd03b3c; IN2=128'h3caaa3e8a99f9deb50f3af57adf622aa; // Expected Output: c81677bc9b7ac93b25027992b0261996.

 	#2 IN1=128'h9816ee7400f87f556b2c049c8e5ad036; IN2=128'h5e390f7df7a69296a7553dc10aa31f6b; // Expected Output: c62fe109f75eedc3cc79395d84f9cf5d.
 	#2 IN1=128'hc57e1c159a9bd286f05f4be098c63439; IN2=128'h14f9701ae35fe28c440adf4d4ea9c026; // Expected Output: d1876c0f79c4300ab45594add66ff41f.

 	#2 IN1=128'hbaa03de7a1f9b56ed5512cba5f414d23; IN2=128'h47438735a41c65b9e016baf4aebf7ad2; // Expected Output: fde3bad205e5d0d73547964ef1fe37f1.
 	#2 IN1=128'he9f74eec023020f61bf2ccf2353c21c7; IN2=128'h549932d1f08557681093ed9cbe2c974e; // Expected Output: bd6e7c3df2b5779e0b61216e8b10b689.
 	
	#2 IN1=128'h7ad5fda789ef4e272bca100b3d9ff59f; IN2=128'h13111d7fe3944a17f307a78b4d2b30c5; // Expected Output: 69c4e0d86a7b0430d8cdb78070b4c55a.

        #2 IN1=128'b0; IN2=128'h1c7030719db81335a1d0f87a16aaafee; // Expected Output: 1c7030719db81335a1d0f87a16aaafee.
	#2 $finish;

    end 
 
    initial begin
	   $monitor("time=", $time, "IN1=%h IN2=%h OUT=%h", IN1, IN2, OUT);
    end      
endmodule // End of module.

