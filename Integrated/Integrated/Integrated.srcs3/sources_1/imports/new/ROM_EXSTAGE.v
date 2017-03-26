`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2016 10:27:35 PM
// Design Name: 
// Module Name: ROM_EXSTAGE
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ROM_EXSTAGE(
    input [1:0] SELECT,
    output [31:0] OP
    );
    
    reg [31:0] OP_REG;
       
    always@(SELECT)
    begin
        case(SELECT)
            2'b00: OP_REG = 32'd12;
            2'b01: OP_REG = 32'd20;
            2'b10: OP_REG = 32'd27;
            default: OP_REG = 32'd0;
        endcase
    end
     
    assign OP = OP_REG;
endmodule
