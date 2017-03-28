`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 08/01/2016 04:21:39 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A,     //rs1
    input [31:0] B,     //immediate
    input [3:0] ALU_CONTROL,
    output [31:0] ALU_OUTPUT
    );
    
    reg [31:0] OUTPUT_REG;
    integer COUNTER;
    reg [4:0] SHIFT_AMMOUNT;
    
    always@(*)
    begin
            case (ALU_CONTROL) 
                4'b0000 :                               //ADD(I)
                    OUTPUT_REG = A + B;       
                4'b0001 : 
                    OUTPUT_REG = B +{~A + 1'b1};                 //SUB
                4'b0010 :                               //SLT(I) and SLT(I)U
                    begin
                        if(A<B)
                            OUTPUT_REG = 32'd1;
                        else
                            OUTPUT_REG = 32'd0;
                    end
                4'b0011 :                               //AND(I)
                    OUTPUT_REG = A&B;
                4'b0100 :                               //OR(I)
                    OUTPUT_REG = A|B;
                4'b0101 :                               //XOR(I)
                    OUTPUT_REG = A^B;
                4'b0110 :                               //SLL(I)
                    OUTPUT_REG = B<<A;
                4'b0111 :                               //SRL(I)
                    OUTPUT_REG = B>>A;
                    
                  4'b1000 :                               //SRA(I)
                    OUTPUT_REG = A>>>B;
//                    begin
//                        if(A[31]==0)
//                            OUTPUT_REG = A>>B;
//                        else
//                        begin
//                            COUNTER = 32'd31;
//                            SHIFT_AMMOUNT = B[4:0];
//                            OUTPUT_REG  = A;
//                            while ((SHIFT_AMMOUNT > 5'd0) && (COUNTER > 32'd0))
//                            begin
//                                OUTPUT_REG = OUTPUT_REG>>1;
//                                OUTPUT_REG[31] = 1'b1;
//                                SHIFT_AMMOUNT = SHIFT_AMMOUNT - 1;
//                                COUNTER = COUNTER - 1;
//                            end
//                        end
//                    end
                4'b1001 :                              //ALU_OUT = A
                    OUTPUT_REG = A;
                4'b1010 :                              //ALU_OUT = B
                    OUTPUT_REG = B;
                default : OUTPUT_REG = 32'd0;
            endcase  
    end
    assign ALU_OUTPUT = OUTPUT_REG;
endmodule
