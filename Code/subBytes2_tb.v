`timescale 1ns/1ns
`include "subBytes2.v"

module subBytes2_tb;

	parameter WORD = 32; // The size of word is 32 bits.
	parameter ZERO = 0; // Zero.
	parameter Nb = 128;

reg  [Nb-1:ZERO]  state_in;
wire [Nb-1:ZERO]  state_out;
reg Clk;

subBytes2 subBytes2_unit(state_in, state_out);

initial 
begin 
	state_in = 128'h0; Clk = 1'b0;
    
    #2 state_in = 128'h89d810e8855ace682d1843d8cb128fe4;
    // expeted: a761ca9b97be8b45d8ad1a611fc97369

    #2 state_in = 128'h4915598f55e5d7a0daca94fa1f0a63f7;
    // expected: 3b59cb73fcd90ee05774222dc067fb68

    #2 state_in = 128'hfa636a2825b339c940668a3157244d17;
    // expected: 2dfb02343f6d12dd09337ec75b36e3f0

    #2 state_in = 128'h247240236966b3fa6ed2753288425b6c;
    // expected: 36400926f9336d2d9fb59d23c42c3950

    #2 state_in = 128'hc81677bc9b7ac93b25027992b0261996;
    // expected: e847f56514dadde23f77b64fe7f7d490

   #2 $finish;
end

// Clock

always Clk = #1 ~Clk;


initial begin
		$monitor("state_in=%h, state_out)=%h", state_in, state_out);
	end

endmodule
