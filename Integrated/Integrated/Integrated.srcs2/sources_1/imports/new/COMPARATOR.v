`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 08/01/2016 07:56:02 AM
// Design Name: 
// Module Name: COMPARATOR
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


module COMPARATOR(
    input signed [31:0] COMP1,
    input signed [31:0] COMP2,
    input [1:0] COMP_CONTROL,
    output COMP_OUT
    );
    
    reg OUTPUT_REG;  //latch
    
    always@( COMP1 or COMP2 or COMP_CONTROL)
    begin
           case(COMP_CONTROL)
                2'b00:          // equal
                    OUTPUT_REG = COMP1 == COMP2; 
                2'b01:          // not equal
                    OUTPUT_REG = COMP1 != COMP2;
                2'b10:          // less than
                    OUTPUT_REG = COMP1 < COMP2;
                2'b11:        // greater than or equal
                    OUTPUT_REG = COMP1 >= COMP2;
                default:
                    OUTPUT_REG = 32'd0;
            endcase
    end
    
    assign COMP_OUT = OUTPUT_REG;
    
endmodule
