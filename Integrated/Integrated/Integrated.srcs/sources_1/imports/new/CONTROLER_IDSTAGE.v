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


module CONTROLER_IDSTAGE(
    input [6:0] OPCODE,
    input [9:0] FUNCT, 
    input STALL_STATE,
        // Environment Call and Breakpoints - all 15 bits
        //REG to REG operationd             - First 10bits
        // R I S type                       - First 3 bits 
   // output [4:0] RS1_SEL,
   // output [4:0] RS2_SEL,
    output [2:0] EXT_CNT,
    output WB_VALID_OUT
    
   /* output READ_WRITE_REG,
    output REG_MUX_EN,
    output WRITE_MUX_EN,
    output STALL_EN,
    output SIGNEX_EN*/
    );
    
   // reg [4:0] RS1_SEL_L;
   // reg [4:0] RS2_SEL_L;
    reg [2:0] EXT_CNT_L;
    reg WB_VALID_L;
     always@(OPCODE or FUNCT)
       begin
           case (OPCODE[6:0])
               7'b0110111: //LUI
               begin                   
                   EXT_CNT_L = 3'b011;
                   WB_VALID_L = 1'b1;
               end
               7'b0010111: //AUIPC
               begin
                   EXT_CNT_L = 3'b011;
                   WB_VALID_L = 1'b1;
               end
               7'b1101111: //JAL
               begin
                   EXT_CNT_L = 3'b100;
                   WB_VALID_L = 1'b1;
               end
               7'b1100111: //JALR
               begin
                   EXT_CNT_L = 3'b000;
                   WB_VALID_L = 1'b1;
               end
               7'b1100011:
               begin 
                   EXT_CNT_L = 3'b010;
                   WB_VALID_L = 1'b0;
               end    
               7'b0000011:
               begin //LB,LH,LW,LBU,LHU
                   EXT_CNT_L = 3'b000;
                   WB_VALID_L = 1'b1;
               end
               7'b0100011: //SB, SH, SW
               begin 
                   EXT_CNT_L = 3'b001;
                   WB_VALID_L = 1'b0;
                   /*case (FUNC[2:0])
                       3'b000:; //SB
                       3'b001:; //SH
                       3'b010:; //SW
                       default:;
                   endcase*/ 
               end
               7'b0010011:
               begin 
                   WB_VALID_L = 1'b1;
                   if(FUNCT[2:0] == 3'b011)
                    EXT_CNT_L = 3'b101;
                   else  
                    EXT_CNT_L = 3'b000;
               end
               7'b0110011:
               begin 
                   EXT_CNT_L = 3'b100;
                   WB_VALID_L = 1'b1;
               end
               7'b0001111:
               begin
               
                   EXT_CNT_L = 3'b000;
                   WB_VALID_L = 1'b0;
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
               
                    EXT_CNT_L = 3'b000;
                    WB_VALID_L = 1'b0;
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
                  EXT_CNT_L = 3'b100;
                  WB_VALID_L = 1'b0;
               end      
           endcase
       end
       
       assign EXT_CNT = EXT_CNT_L;
       assign WB_VALID_OUT = WB_VALID_L;
endmodule
