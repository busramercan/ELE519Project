/*****************************************************
AXI GPIO Demo
Author: F.Mabrouk
****************************************************/

#include <stdio.h>
//#include "platform.h"
#include <xgpio.h>
#include "xparameters.h"
#include "sleep.h"
#include "xuartps.h"
#include <stdlib.h>
#include "xtime_l.h"


#define LENGTH 50
#define HEIGHT 50
#define FILE_SIZE LENGTH*HEIGHT

int maskForLeds = 0;

XGpio input, output;
#define UART_DEVICE_ID              XPAR_PS7_UART_1_DEVICE_ID

#define WRITE_FROM_ZYNQ_COMPLETED 10
#define FILTER_COMPLETED 12

int main()
{

	XGpio_Initialize(&input, XPAR_AXI_GPIO_BTN_DEVICE_ID); //initialize input XGpio variable
	XGpio_SetDataDirection(&input, 1, 0xF); //set first channel tristate buffer to input

	XGpio_Initialize(&output, XPAR_AXI_GPIO_LED_DEVICE_ID); //initialize output XGpio variable
	XGpio_SetDataDirection(&output, 1, 0x0); //set first channel tristate buffer to output


	u32 * bramBase = (u32*)XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR;
	u8 tempArray[2500];
	XUartPs_Config *uartConfig;
	u32 receivedBytes = 0;

	u32 status;
	XUartPs myUart;

	uartConfig = XUartPs_LookupConfig(UART_DEVICE_ID);
	status = XUartPs_CfgInitialize(&myUart, uartConfig, uartConfig->BaseAddress);
	while(status != XST_SUCCESS) {
		printf("Cfg initialize failed\n\r");
	}
	status = XUartPs_SetBaudRate(&myUart, 115200);
	while(status != XST_SUCCESS) {
		printf("Cfg set baud rate failed\n\r");
	}

	XUartPs_SetOperMode(&myUart, XUARTPS_OPER_MODE_NORMAL);


	u32 totalReceived = 0;
	u32 totalSent = 0;
	int imageWaiting = 1;
	while(1){

		while(totalReceived < FILE_SIZE && imageWaiting == 1){
			receivedBytes = XUartPs_Recv(&myUart, (u8*)&tempArray[totalReceived],30);

			for(int i = 0 ; i < receivedBytes ; i++){
				bramBase[totalReceived + 1 + i] = tempArray[i+totalReceived];
			}
			totalReceived  += receivedBytes;
		}
		if(totalReceived >= FILE_SIZE){ //yazma tamamlandi, brambase[0] = 10 verilebilir.

			usleep(1000);
			bramBase[0] = WRITE_FROM_ZYNQ_COMPLETED;
			usleep(10000);
			totalReceived = 0;
			imageWaiting = 0;
		}
		if(bramBase[0] == FILTER_COMPLETED){

			//printf("U8 FORMAT\n\r");
			while(totalSent < FILE_SIZE){
				totalSent += XUartPs_Send(&myUart, (u8*)&bramBase[totalSent + 1], 1);
			}
			totalSent = 0;
			/*printf("\n\r");

			printf("IMAGE FORMAT:\n\r");
			for(int i = 0; i < 2500 ; i++){
				printf("%u ",bramBase[i+1]);
				if(i%LENGTH == 49){
					printf("\n\r");
				}
			}*/
			bramBase[0] = 0;
			imageWaiting = 1;
		}
		usleep(100000);


	}
	return 0;
}


