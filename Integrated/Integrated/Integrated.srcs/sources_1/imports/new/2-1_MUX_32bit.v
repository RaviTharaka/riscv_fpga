`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 08/02/2016 09:40:13 PM
// Design Name: 
// Module Name: 2-1_MUX_32bit
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


module MUX_2to1_32bit(
    input [31:0] IN1,
    input [31:0] IN2,
    output [31:0] OP,
    input CONTROL
    );
    
    reg [31:0] OP_REG;
    
    always@(*)
    begin
        case(CONTROL)
            1'b0: OP_REG = IN1;
            1'b1: OP_REG = IN2;
        endcase
    end
    
    assign OP = OP_REG;
endmodule

/*module MUX_4to1_32bit(
    input [31:0] IN1,
    input [31:0] IN2,
    input [31:0] IN3,
    input [31:0] IN4,
    output [31:0] OP,
    input [1:0] CONTROL
    );
    
    reg [31:0] OP_REG;
    
    always@(*)
    begin
        case(CONTROL)
            2'b00: OP_REG = IN1;
            2'b01: OP_REG = IN2;
            2'b10: OP_REG = IN3;
            2'b11: OP_REG = IN4;
        endcase
    end
    
    assign OP = OP_REG;
endmodule*/
