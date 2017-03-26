`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 08/10/2016 07:33:16 PM
// Design Name: 
// Module Name: CONTROLER_EXSTAGE
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


module CONTROLER_EXSTAGE(
    input [6:0] OPCODE,
    input [9:0] FUNCT, 
        // Environment Call and Breakpoints - all 15 bits
        //REG to REG operationd             - First 10bits
        // R I S type                       - First 3 bits 
    output [3:0] ALU_CNT,
    output [1:0] COMP_CNT,
    output MUX1_CNT,
    output MUX2_CNT,
    output MUX3_CNT
    );
    
    reg [3:0] ALU_CNT_L;      //latches
    reg [1:0] COMP_CNT_L;
    reg MUX1_CNT_L;
    reg MUX2_CNT_L;
    reg MUX3_CNT_L;
    
    always@(*)
    begin
        case (OPCODE[6:0])
            7'b0110111: //LUI
            begin
                ALU_CNT_L         = 4'b1001;
                COMP_CNT_L        = 2'b00;
                MUX1_CNT_L        = 1'b1;
                MUX2_CNT_L        = 1'b0;
                MUX3_CNT_L        = 1'b0;
            end
            7'b0010111: //AUIPC
            begin
                ALU_CNT_L         = 4'b0000;
                COMP_CNT_L        = 2'b00;
                MUX1_CNT_L        = 1'b1;
                MUX2_CNT_L        = 1'b1;
                MUX3_CNT_L        = 1'b0;    //not used
            end
            7'b1101111: //JAL
            begin
                ALU_CNT_L         = 4'b0000;
                COMP_CNT_L        = 2'b00;
                MUX1_CNT_L        = 1'b1;
                MUX2_CNT_L        = 1'b1;
                MUX3_CNT_L        = 1'b0;
            end
            7'b1100111: //JALR
            begin
                ALU_CNT_L         = 4'b0000;
                COMP_CNT_L        = 2'b00;
                MUX1_CNT_L        = 1'b1;
                MUX2_CNT_L        = 1'b0;
                MUX3_CNT_L        = 1'b0;
            end
            7'b1100011:
            begin 
                ALU_CNT_L         = 4'b0000;
                MUX1_CNT_L        = 1'b1;
                MUX2_CNT_L        = 1'b1;
                MUX3_CNT_L        = 1'b1;
                case (FUNCT[2:0])
                    3'b000:  //BEQ
                       COMP_CNT_L        = 2'b00;
                    3'b001:  //BNE
                       COMP_CNT_L        = 2'b01;
                    3'b100: //BLT
                       COMP_CNT_L        = 2'b10;
                    3'b101: //BGE
                       COMP_CNT_L        = 2'b11;
                    3'b110: //BLTU
                       COMP_CNT_L        = 2'b10;
                    3'b111: //BGEU
                       COMP_CNT_L        = 2'b11;
                    default:
                       COMP_CNT_L        = 2'b00;
                endcase
            end    
            7'b0000011:
            begin //LB,LH,LW,LBU,LHU
                ALU_CNT_L         = 4'b0000;
                COMP_CNT_L        = 2'b00;
                MUX1_CNT_L        = 1'b1;
                MUX2_CNT_L        = 1'b0;
                MUX3_CNT_L        = 1'b0;
            end
            7'b0100011: //SB, SH, SW
            begin 
                ALU_CNT_L         = 4'b0000;
                COMP_CNT_L        = 2'b00;
                MUX1_CNT_L        = 1'b1;
                MUX2_CNT_L        = 1'b0;
                MUX3_CNT_L        = 1'b0;
                /*case (FUNC[2:0])
                    3'b000:; //SB
                    3'b001:; //SH
                    3'b010:; //SW
                    default:;
                endcase*/ 
            end
            7'b0010011:
            begin 
                MUX1_CNT_L        = 1'b1;
                MUX2_CNT_L        = 1'b0;
                MUX3_CNT_L        = 1'b0;
                case (FUNCT[2:0])
                    3'b000: //ADDI
                    begin
                        ALU_CNT_L         = 4'b0000;
                        COMP_CNT_L        = 2'b00;
                    end
                    3'b010: //SLTI
                    begin
                        ALU_CNT_L         = 4'b0000;
                        COMP_CNT_L        = 2'b10;
                    end
                    3'b011: //SLTIU
                    begin
                        ALU_CNT_L         = 4'b0000;
                        COMP_CNT_L        = 2'b10;
                    end
                    3'b100: //XORI
                    begin
                        ALU_CNT_L         = 4'b0101;
                        COMP_CNT_L        = 2'b00;
                    end
                    3'b110: //ORI
                    begin
                        ALU_CNT_L         = 4'b0100;
                        COMP_CNT_L        = 2'b00;
                    end
                    3'b111: //ANDI
                    begin
                        ALU_CNT_L         = 4'b0011;
                        COMP_CNT_L        = 2'b00;
                    end
                    3'b001: //SLLI
                    begin
                        ALU_CNT_L         = 4'b0110;
                        COMP_CNT_L        = 2'b00;
                    end
                    3'b101:
                    begin
                       case (FUNCT[9:3])
                            7'b0000000://SRLI
                            begin
                                 ALU_CNT_L         = 4'b0111;
                                 COMP_CNT_L        = 2'b00;
                            end  
                            7'b0100000://SRAI
                            begin
                                 ALU_CNT_L         = 4'b1000;
                                 COMP_CNT_L        = 2'b00;
                            end
                            default:
                            begin
                                  ALU_CNT_L         = 4'b0000;
                                  COMP_CNT_L        = 2'b00;
                            end
                       endcase
                    end
                    default:
                    begin
                         ALU_CNT_L         = 4'b0000;
                         COMP_CNT_L        = 2'b00;
                    end
                endcase
            end
            7'b0110011:
            begin 
                MUX1_CNT_L        = 1'b0;
                MUX2_CNT_L        = 1'b0;
                MUX3_CNT_L        = 1'b1;
                case (FUNCT[2:0])
                    3'b000:
                    begin
                        case (FUNCT[9:3])
                            7'b0000000://ADD
                            begin
                                ALU_CNT_L         = 4'b0000;
                                COMP_CNT_L        = 2'b00;
                            end  
                            7'b0100000://SUB
                            begin
                                ALU_CNT_L         = 4'b0001;
                                COMP_CNT_L        = 2'b00;
                            end
                            default:
                            begin
                                ALU_CNT_L         = 4'b0000;
                                COMP_CNT_L        = 2'b00;                            end

                        endcase
                    end                    
                    3'b001: //SLL
                    begin
                        ALU_CNT_L         = 4'b0110;
                        COMP_CNT_L        = 2'b00;
                    end
                    3'b010: //SLT
                    begin
                        ALU_CNT_L         = 4'b0000;
                        COMP_CNT_L        = 2'b10;
                    end
                    3'b011: //SLTU
                    begin
                        ALU_CNT_L         = 4'b0000;
                        COMP_CNT_L        = 2'b10;
                    end
                    3'b100: //XOR
                    begin
                        ALU_CNT_L         = 4'b0101;
                        COMP_CNT_L        = 2'b00;
                    end
                    3'b101:
                    begin
                       case (FUNCT[9:3])
                          7'b0000000://SRL
                          begin
                            ALU_CNT_L         = 4'b0111;
                            COMP_CNT_L        = 2'b00;
                          end  
                          7'b0100000://SRA
                          begin
                            ALU_CNT_L         = 4'b1000;
                            COMP_CNT_L        = 2'b00;
                          end
                          default:
                          begin
                            ALU_CNT_L         = 4'b0000;
                            COMP_CNT_L        = 2'b00;
                          end
                       endcase
                    end   
                    3'b110: //OR
                    begin
                        ALU_CNT_L         = 4'b0100;
                        COMP_CNT_L        = 2'b00;
                    end
                    3'b111: //AND
                    begin
                        ALU_CNT_L         = 4'b0011;
                        COMP_CNT_L        = 2'b00;
                    end
                    default:
                    begin
                        ALU_CNT_L         = 4'b0000;
                        COMP_CNT_L        = 2'b00;
                    end
                endcase
            end
            7'b0001111:
            begin
            
                 ALU_CNT_L         = 4'b0000;
                 COMP_CNT_L        = 2'b00;
                 MUX1_CNT_L        = 1'b0;
                 MUX2_CNT_L        = 1'b0;
                 MUX3_CNT_L        = 1'b0;
                case (FUNCT[2:0])
                 /*   3'b000:; //FENCE
                    3'b001:; //FENCE.I*/
                    default:
                    begin
                       
                    end
                endcase
            end
            7'b1110011:
            begin 
            
                 ALU_CNT_L         = 4'b0000;
                 COMP_CNT_L        = 2'b00;
                 MUX1_CNT_L        = 1'b0;
                 MUX2_CNT_L        = 1'b0;
                 MUX3_CNT_L        = 1'b0;
               /* case (FUNCT[2:0])
                    3'b000: 
                    begin
                        case (FUNCT[14:3])
                           12'b000000000000:;//ECALL
                            12'b000000000001:;//EBREAK
                            default:
                            begin
                               
                            end
                        endcase
                    end      
                    3'b001: //CSRRW
                    begin
                     
                    end
                    3'b010: //CSRRS
                    begin
                       
                    end
                    3'b011: //CSRRC
                    begin
                     
                    end
                    3'b101: //CSRRWI
                    begin
                       
                    end
                    3'b110: //CSRRSI
                    begin
                       
                    end
                    3'b111: //CSRRCI
                    begin
                       
                    end
                    default:
                    begin
                        
                    end
                endcase*/
            end                
            default:
            begin
               ALU_CNT_L         = 4'b1001;
               COMP_CNT_L        = 2'b00;
               MUX1_CNT_L        = 1'b1;
               MUX2_CNT_L        = 1'b0;
               MUX3_CNT_L        = 1'b0;
            end      
        endcase
    end
    
    assign ALU_CNT = ALU_CNT_L;
    assign COMP_CNT = COMP_CNT_L;
    assign MUX1_CNT = MUX1_CNT_L;
    assign MUX2_CNT = MUX2_CNT_L;
    assign MUX3_CNT = MUX3_CNT_L;
   
endmodule
