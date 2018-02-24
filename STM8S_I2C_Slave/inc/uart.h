#ifndef __UART_H
#define __UART_H

#include "stm8s.h"

#ifndef _UART_GLOBAL
#define UART_EXT	extern
#else
#define UART_EXT
#endif


#define MAX              255             	//��������ֵ  
#define MIN              1              	//�������Сֵ 

#define Uart2_Send_Len	 40
#define Uart2_Rec_Len	 	 40

#define UART1_SEND_LEN	 40
#define UART1_RECV_LEN	 40


typedef struct
{
	u8	addr;
	u8	rxflag;

	u16 	rxlen;		//�ѽ��յ��ֽ���
	u16 	txlen;		//����Ҫ���͵��ֽ���
	u16 	txhas;		//�ѷ��͵��ֽ���
	
	u8 	rxbuf[UART1_RECV_LEN];
	u8 	txbuf[UART1_SEND_LEN];
	
}uart1_frame_t;	//SICP�����ݽṹ


typedef struct
{
	u8 	frame_h1;
	u8 	frame_h2;
	u8	addr;
	u8 	msg_id;
	u8 	msg_len;
	u8 	*payload;
	
}uart1_msg_t;





extern uart1_frame_t uart1_frame;


#define UART1_POSITION_LENGTH	 	4
#define UART1_POSITION_COMMAND	 	5
#define UART1_POSITION_TYPE			6

#define UART1_AFTER_LENGTH_BYTES	 5

u8 get_message_id(void);

void uart1_init(void);
void uart1_Send(u8 *buf, u16 len);
void uart1_recv_handle(void);

@interrupt void UART1_TX_ISR(void);
@interrupt void UART1_RX_ISR(void);



#endif


