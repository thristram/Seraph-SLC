/**
  ******************************************************************************
  * @file    uart.c
  * @author  Seraph
  * @version  V1.0
  * @date     2017-03
  * @brief   This file contains the main function for STM8S003F3 timer operation.
**/


#define  _UART_GLOBAL

#include <stdlib.h>
//#include <string.h>
//#include <stdio.h>
#include "stm8s.h"
#include "uart.h"
#include "main.h"


uart1_frame_t uart1_frame;






/*----------------------------------------------------------------------------
	
-----------------------------------------------------------------------------*/
u8 get_message_id(void)
{
	static u8 id = 0;
	
	id++;

	if(id == 0){
		id = 1;
	}

	return id;
}



/**
  * @brief  产生随机数 1~255
  * @param  None.
  * @retval None
  */

u8 random(u8 xxx)  
{  
	u8 value, iii;  
	for(iii=0; iii<xxx; iii++)  
	{  
		value = rand() % (MAX + 1- MIN) + MIN; //获取一个随机数1~255
	}  
	return value;  
} 


/**
  * @brief  check sum(cumulative sum)
  * @param  u8 *sendbuf,u8 length.
  * @retval u8 result
  */
u8 uart1_check_sum(u8 *buf, u8 length)
{
	u8 i;
	u8 result = *buf++;
	
	for(i = 1; i < length; i++)
	{
		result ^= *buf++;
	}
	
	return result;
}


/**
  * @brief  initializion for uart1
  * @param  None.
  * @retval None
  */
void uart1_init(void)
{
	UART1_DeInit();
	//波特率115200，8位数据位，1位停止位，无校验位，禁用同步模式，允许接收和发送
//	UART1_Init((u32)115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
	UART1_Init((u32)19200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);

	UART1_ITConfig(UART1_IT_TC, ENABLE);//发送完成中断
	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);//接收非空中断
	UART1_Cmd(ENABLE);//启用uart1接口

	uart1_frame.rxflag = 0;
	
}


/**
  * @brief  uart1 send data start
  * @param  none.
  * @retval None
  */
void uart1_Send(u8 *buf, u16 len)
{
	if(len >= UART1_SEND_LEN)	
		len = UART1_SEND_LEN;
	
	mymemcpy(uart1_frame.txbuf, buf, len);
	
	uart1_frame.txlen = len;
	uart1_frame.txhas = 1;
	UART1->DR = uart1_frame.txbuf[0];
	
}


/**
  * @brief  uart1 init_device_info
  * @param  none.
  * @retval None
  */
void uart1_init_device_info(void)
{
	uart1_frame.txbuf[0] = 0x7e;
	uart1_frame.txbuf[1] = 0x7e;
	uart1_frame.txbuf[2] = slc.MDID;		//addr
	uart1_frame.txbuf[3] = uart1_frame.rxbuf[3];	//message id
	uart1_frame.txbuf[4] = 12;	//len
	uart1_frame.txbuf[5] = 0xB2;	//payload
	uart1_frame.txbuf[6] = slc.deviceID[0];
	uart1_frame.txbuf[7] = slc.deviceID[1];
	uart1_frame.txbuf[8] = slc.deviceID[2];
	uart1_frame.txbuf[9] = slc.deviceID[3];
	uart1_frame.txbuf[10] = slc.model;
	uart1_frame.txbuf[11] = slc.firmware_version;
	uart1_frame.txbuf[12] = slc.f_mal.byte;
	uart1_frame.txbuf[13] = slc.MDID;	
	uart1_frame.txbuf[14] = uart1_check_sum(&uart1_frame.txbuf[2], uart1_frame.txbuf[4]);

	uart1_frame.txlen = uart1_frame.txbuf[4] + 3;
	uart1_frame.txhas = 1;
	UART1->DR = uart1_frame.txbuf[0];

	
}

/**
  * @brief  uart1 rev_heart_breat
  * @param  none.
  * @retval None
  */
void uart1_rev_heart_breat(void)
{
	uart1_frame.txbuf[0] = 0x7e;
	uart1_frame.txbuf[1] = 0x7e;
	uart1_frame.txbuf[2] = slc.MDID;		//addr
	uart1_frame.txbuf[3] = uart1_frame.rxbuf[3];	//message id
	uart1_frame.txbuf[4] = 10;	//len
	uart1_frame.txbuf[5] = 0x06;	//payload
	uart1_frame.txbuf[6] = slc.MDID;
	uart1_frame.txbuf[7] = slc.ch1_status;
	uart1_frame.txbuf[8] = slc.ch2_status;
	uart1_frame.txbuf[9] = slc.ch3_status;
	uart1_frame.txbuf[10] = slc.ch4_status;
	uart1_frame.txbuf[11] = slc.f_mal.byte;
	uart1_frame.txbuf[12] = uart1_check_sum(&uart1_frame.txbuf[2], uart1_frame.txbuf[4]);

	uart1_frame.txlen = uart1_frame.txbuf[4] + 3;
	uart1_frame.txhas = 1;
	UART1->DR = uart1_frame.txbuf[0];
	
}


/**
  * @brief  uart1 rev_action_dimmer_OK
  * @param  none.
  * @retval None
  */
void uart1_rev_action_dimmer_OK(void)
{
	uart1_frame.txbuf[0] = 0x7e;
	uart1_frame.txbuf[1] = 0x7e;
	uart1_frame.txbuf[2] = slc.MDID;		//addr
	uart1_frame.txbuf[3] = uart1_frame.rxbuf[3];	//message id
	uart1_frame.txbuf[4] = 6;	//len
	uart1_frame.txbuf[5] = 0xAA;	//payload
	uart1_frame.txbuf[6] = 0x02;
	uart1_frame.txbuf[7] = slc.MDID;
	uart1_frame.txbuf[8] = uart1_check_sum(&uart1_frame.txbuf[2], uart1_frame.txbuf[4]);

	uart1_frame.txlen = uart1_frame.txbuf[4] + 3;
	uart1_frame.txhas = 1;
	UART1->DR = uart1_frame.txbuf[0];

}


/**
  * @brief  uart1 rev_action_dimmer_done
  * @param  none.
  * @retval None
  */
void uart1_rev_action_dimmer_done(void)
{
	uart1_frame.txbuf[0] = 0x7e;
	uart1_frame.txbuf[1] = 0x7e;
	uart1_frame.txbuf[2] = slc.MDID;		//addr
	uart1_frame.txbuf[3] = uart1_frame.rxbuf[3];	//message id
	uart1_frame.txbuf[4] = 10;	//len
	uart1_frame.txbuf[5] = 0xAA;	//payload
	uart1_frame.txbuf[6] = 0x05;	//payload
	uart1_frame.txbuf[7] = slc.MDID;
	uart1_frame.txbuf[8] = slc.ch1_status;
	uart1_frame.txbuf[9] = slc.ch2_status;
	uart1_frame.txbuf[10] = slc.ch3_status;
	uart1_frame.txbuf[11] = slc.ch4_status;
	uart1_frame.txbuf[12] = uart1_check_sum(&uart1_frame.txbuf[2], uart1_frame.txbuf[4]);

	uart1_frame.txlen = uart1_frame.txbuf[4] + 3;
	uart1_frame.txhas = 1;
	UART1->DR = uart1_frame.txbuf[0];
	
}



/**
  * @brief  uart1 recv handle
  * @param  none.
  * @retval None
  */
void uart1_recv_handle(void)
{
	u8 change_time = 0;
	u8 chl = 0;
	

	//判断指令
	switch(uart1_frame.rxbuf[UART1_POSITION_COMMAND]){
		case 0xFE:
			if(uart1_frame.rxbuf[6] == 0x01)
				uart1_init_device_info();
			break;
		case 0x03:
			if((uart1_frame.rxbuf[6] == 0x03) && (uart1_frame.rxbuf[7] == slc.MDID)){
				//校验正确
				if(uart1_check_sum(&uart1_frame.rxbuf[2], uart1_frame.rxbuf[4]) == uart1_frame.rxbuf[8]){
					uart1_rev_heart_breat();
				}
			}
			break;
		case 0x51://Linear
		case 0x52://Erase in
		case 0x53://Erase out
		case 0x54://Swing
			if(((uart1_frame.rxbuf[6] & 0xf0) >> 4) == slc.MDID){
				//处理灯光驱动
				chl = (uart1_frame.rxbuf[6] & 0x0f);
				change_time = uart1_frame.rxbuf[8];
								
				if((chl & 0x01) == 0x01)
				{	
//					if(uart1_frame.rxbuf[5] == 0x51){
//						linear1_begin = 1;
//					}
//					//Erase in:accelerating from zero velocity
//					else if((uart1_frame.rxbuf[5] == 0x52) && ((realtime_bright1 == 0) || (realtime_bright1 == 1)))	{
//						action_flag._flag_byte |= 0x04;
//					}
//					//Erase out:decelerating ro zero velocity
//					else if((uart1_frame.rxbuf[5] == 0x53) && (uart1_frame.rxbuf[7]== 0)){
//						action_flag._flag_byte |= 0x10;
//					}
//					else if(uart1_frame.rxbuf[5] == 0x54){
//						action_flag._flag_byte |= 0x40;
//					}
					channel1 = 1;
					aim_bright1 = ((float)uart1_frame.rxbuf[7]) / 100.0;
					if(change_time){
						change_step1 = (aim_bright1 - last_bright1) /(change_time * 2); //change_step1可正可负
					}else{
						change_step1 = aim_bright1 - last_bright1;
					}
				
				}
				
				if((chl & 0x02) == 0x02)
				{
//					if(uart1_frame.rxbuf[5] == 0x51){
//						linear2_begin = 1;
//					}
//					else if((uart1_frame.rxbuf[5] == 0x52) && ((realtime_bright2 == 0) || (realtime_bright2 == 1))){
//						action_flag._flag_byte |= 0x08;
//					}
//					else if((uart1_frame.rxbuf[5] == 0x53) && (uart1_frame.rxbuf[7]==0)){
//						action_flag._flag_byte |= 0x20;
//					}
//					else if(uart1_frame.rxbuf[5] == 0x54){
//						action_flag._flag_byte |= 0x80;
//					}
					channel2 = 1;
					aim_bright2 = ((float)uart1_frame.rxbuf[7]) / 100.0;
					change_step2 = (aim_bright2 - last_bright2) /(change_time * 2);

				}
				
				uart1_rev_action_dimmer_OK();
				
			}
			
			break;
			
		case 0x59://调光时间结束后SC发送查询ch状态
		
			if(uart1_frame.rxbuf[6] == slc.MDID){//查询action dimmer执行后SLC状态
				uart1_rev_action_dimmer_done();
			}
			break;
			
		default:
			break;
		
	}

}


/**
  * @brief  uart1tx isr
  * @param  none.
  * @retval None
  */
@interrupt void UART1_TX_ISR(void) 
{
	/* In order to detect unexpected events during development,
	it is recommended to set a breakpoint on the following instruction.
	*/
	
	UART1->SR &= ~0x40; 	//清除发送完成标志位

	if (uart1_frame.txhas < uart1_frame.txlen){
		
		UART1->DR = uart1_frame.txbuf[uart1_frame.txhas];
		uart1_frame.txhas++;
	  
	}else{

		uart1_frame.txhas = 0;
		uart1_frame.txlen = 0;

	}

	
}



/**
  * @brief  uart1 rx isr
  * @param  none.
  * @retval None
  */
@interrupt void UART1_RX_ISR(void)
{
	u8 temp = 0;
	
	temp = UART1->DR;
	uart1_frame.rxbuf[uart1_frame.rxlen] = temp;
	uart1_frame.rxlen++;

	switch(uart1_frame.rxlen){
		
		case 1:
			if (temp != 0x7e) uart1_frame.rxlen = 0;
			break;
			
		case 2:
			if (temp != 0x7e) uart1_frame.rxlen = 0;
			break;
			
		case 3:
			if (temp != slc.MDID) uart1_frame.rxlen = 0;
			break;
			
		default:
			//接收到长度以后再判断数据是否接收完成
			if(uart1_frame.rxlen > UART1_AFTER_LENGTH_BYTES){	

				if (uart1_frame.rxlen >= uart1_frame.rxbuf[UART1_POSITION_LENGTH] + 3){	//接收数据完成					
					//校验正确	
					if (uart1_check_sum(uart1_frame.rxbuf + 2, uart1_frame.rxbuf[UART1_POSITION_LENGTH]) == uart1_frame.rxbuf[uart1_frame.rxlen - 1]){

						uart1_frame.rxflag = 1;
//						uart1_recv_handle();
					}					
					uart1_frame.rxlen = 0;
				}

			}

			//防止接收错误后溢出
			if (uart1_frame.rxlen >= UART1_RECV_LEN){
				uart1_frame.rxlen = 0;
			}

			break;
			
	}
	
	if (UART1->SR & 0x20){
		temp = UART1->DR;
	}	
	
}

























