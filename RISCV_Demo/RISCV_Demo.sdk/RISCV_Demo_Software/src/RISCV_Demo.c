
/*
 * Integrated_Software.c: BRAM initialize and output results
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   115200
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "stdlib.h"
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "ps7_init.h"
#include "xparameters.h"
#include "xscugic.h"
#include "xil_cache.h"
#include "xil_exception.h"
#include "xgpio.h"
#include "xil_cache_l.h"
#include "xtime_l.h"
#include "ff.h"
#include "xsdps.h"
#include "math.h"

#define NO_ADRRS   					8
#define ARRAY_SIZE 					NO_ADRRS*16
#define DATA_REGION_SIZE 			NO_ADRRS*17
#define WRITE_ADDR_BASE 			0
#define READ_DATA_REGION_BASE_ADDR 	1024
#define intsize						4
#define FIFO_SIZE					1024

       TCHAR  *path = "0:/";     //
	   DIR 	   dir;
	   FILINFO fno;
static FATFS   fatfs;
static FIL     file_obj;		 					//File object
static char    file_name [32] = "/MATL.TXT";	//File Name

char *sequence;
char *sequence_pointer;
int seq_len = 0;
int no_characters = 0;
int Instruction_Array[300];

int SD_card_Mount(){

	FRESULT result;

	// Register volume work area, initialize device
	result = f_mount(&fatfs, path, 0);
	if (result != FR_OK) {
		xil_printf("SD Card: Mount Failed\r\n");
		return XST_FAILURE;
	}

	// Open Directory
	result = f_opendir(&dir, path);
	if (result != FR_OK) {
		xil_printf("SD Card: Directory Open Failed\r\n");
		return XST_FAILURE;
	}

	// Read Directory
	for (;;) {
		result = f_readdir(&dir,&fno);
		if (result != FR_OK || fno.fname[0] == 0) break;  /* Break on error or end of dir */                                      /* It is a file. */
		printf("%s%s\n", path, fno.fname);
	}
	if (result != FR_OK) {
		xil_printf("SD Card: Directory Read Failed\r\n");
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int SD_card_Read(char **seq_pointer){

	FRESULT result;
	UINT 	bytes_read = 32;

	// Open the file
	result = f_open(&file_obj, (char*)file_name, FA_READ);
	if (result) {
		xil_printf("SD Card: Could not open %s\r\n", file_name);
		return XST_FAILURE;
	}

	// Get the file size and allocate a memory to store the sequence
	int fsize = file_size(&file_obj);
	*seq_pointer = (char*)malloc(fsize+1);

	// Bring the pointer to the beginning of the file
	result = f_lseek(&file_obj, 0);
	if (result) {
		xil_printf("SD Card: Pointer Move Failed\r\n");
		return XST_FAILURE;
	}

	// Read data from file to the destination
	result = f_read(&file_obj, (*seq_pointer), fsize, &bytes_read);
	if (result) {
		xil_printf("SD Card: Reading Failed\r\n");
		return XST_FAILURE;
	}
	no_characters = (int)bytes_read;

	// Close file
	result = f_close(&file_obj);
	if (result) {
		xil_printf("SD Card: FIle Closing Failed\r\n");
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int SD_card_Unmount(){
	f_mount(0, path, 0);
	return XST_SUCCESS;
}

void Set_program(char *seq_pointer){
	int i;
	int temp;
	seq_len = 0;
	Instruction_Array[0] = 0;
	xil_printf("No of characters: %d\n\r",no_characters);
	for(i = 0; i < no_characters ; i++){
		if(seq_pointer[i] != '\n' && seq_pointer[i] != '\r'){
			temp = (int)seq_pointer[i];
			if(temp < 58){
				Instruction_Array[seq_len] = (Instruction_Array[seq_len] << 4) + temp - 48;
			}
			else{
				Instruction_Array[seq_len] = (Instruction_Array[seq_len] << 4) + temp - 87;
			}
		}
		else{
			if(seq_pointer[i] != '\r'){
				seq_len++;
				Instruction_Array[seq_len] = 0;
			}
		}
	}
	seq_pointer[seq_len] = '\n';
	seq_pointer[seq_len+1] = '\0';

}

int main()
{
    unsigned int cmd;
    int i;

	xil_printf("Initializing Hardware platform.....\n\r");
    init_platform();
    ps7_post_config();

    xil_printf("Mounting SD Card.....\n\r");
    SD_card_Mount();

    xil_printf("Reading SD Card.....\n\r");
    free(sequence_pointer);
    SD_card_Read(&sequence_pointer);

    xil_printf("Setting SD Card Program.....\n\r");
    Set_program(sequence_pointer);

    for(i = 0;i < seq_len+1;i++){
    	xil_printf("0x%8x\n\r",Instruction_Array[i]);
    }

	for(i = 0; i<15; i++){
		Xil_Out32(XPAR_AXI_BRAM_CTRL_EXT_RAM_S_AXI_BASEADDR + 4*i,0);
	}


    while(1){
    	xil_printf("0-RAM_INITIALIZE & SEND_READY	1-FIFO_READ :");
    	cmd = inbyte();
    	xil_printf("%c\n\r",(char)cmd);

    	if(cmd == 48){ // 0
    		xil_printf("...............DATA in the RAM...............\n\r");
			for (i = 0; i < seq_len+1; i++){
    		//for (i = 0; i < 2048; i++){
				Xil_Out32(XPAR_AXI_BRAM_CTRL_ZYNQ_S_AXI_BASEADDR + 4*i, Instruction_Array[i]);
				//Xil_Out32(XPAR_AXI_BRAM_CTRL_ZYNQ_S_AXI_BASEADDR + 4*i, i);
				xil_printf("%8x\n\r",Xil_In32(XPAR_AXI_BRAM_CTRL_ZYNQ_S_AXI_BASEADDR + 4*i));
				//xil_printf("%d\n\r",Xil_In32(XPAR_AXI_BRAM_CTRL_ZYNQ_S_AXI_BASEADDR + 4*i));
			}
		}
    	else if(cmd == 49){ // 1
    		Xil_Out32(XPAR_AXI_GPIO_ZYNQ_BASEADDR,1);
    	}
    	else if(cmd == 50){ // 2
    		xil_printf("Number of Data: %d\n\r",Xil_In32(XPAR_AXI_GPIO_ZYNQ_BASEADDR));
    		for(i = 0; i<100; i++){
    			xil_printf("%d) %d\n\r",i,Xil_In32(XPAR_AXI_BRAM_CTRL_EXT_RAM_S_AXI_BASEADDR + 4*i));
    		}
/*    		for(i = 0; i < 100;){
    			while(Xil_In32(XPAR_AXI_FIFO_MM_S_RISCV_BASEADDR + 0x1C) == 0);
    			Xil_Out32(XPAR_AXI_FIFO_MM_S_RISCV_BASEADDR + 0x00,0xffffffff);
    			int L = Xil_In32(XPAR_AXI_FIFO_MM_S_RISCV_BASEADDR + 0x24);
    			xil_printf("%d  ",L);
    			xil_printf("%d  ",Xil_In32(XPAR_AXI_FIFO_MM_S_RISCV_BASEADDR + 0x30));
    			int j;
    			for(j = 0;j < L/4;j++){
					xil_printf("%d) ",i);
					xil_printf("%d\n\r",Xil_In32(XPAR_AXI_FIFO_MM_S_RISCV_BASEADDR + 0x20));
					i++;
    			}
    		}*/
    	}
   }
    cleanup_platform();
    return 0;
}



