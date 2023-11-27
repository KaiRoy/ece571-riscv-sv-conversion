`timescale 1ns / 1ps
//Module for Store instructions - data to be written to reg file is generated by this module




module L_type(instr, daddr, drdata, out);

    input  logic [31:0] instr;
    input  logic [31:0] daddr;
    input  logic [31:0] drdata;
    output logic [31:0] out;
    
	logic [31:0] offset;
	 
    always_comb begin
        offset = (daddr[1:0] << 3);

        unique if (instr[14:12] == 3'b000) begin
            out = {{24{drdata[offset+7]}}, drdata[offset +: 8]};  // LB
        end 
		else if (instr[14:12] == 3'b001) begin
            out = {{16{drdata[offset+15]}}, drdata[offset +: 16]}; // LH
        end 
		else if (instr[14:12] == 3'b010) begin
            out = drdata;                                           // LW
        end 
		else if (instr[14:12] == 3'b100) begin
            out = {24'b0, drdata[offset +: 8]};                     // LBU
        end 
		else (instr[14:12] == 3'b101) begin
            out = {16'b0, drdata[offset +: 16]};                    // LHU
        end
		       
    end
endmodule
