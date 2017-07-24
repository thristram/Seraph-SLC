#include "I2c_slave_interrupt.h"
#include <string.h>
#include <stdio.h>
#define MAX_BUFFER  32

SLC slc;
uint8_t	slave_address;
uint8_t action_done;
uint8_t IIC_RxBuffer[MAX_BUFFER];
uint8_t IIC_TxBuffer[MAX_BUFFER];
uint8_t GetDataIndex = 0;
uint8_t ReceiveState = IIC_STATE_UNKNOWN;
uint8_t SendDataIndex = 0;
extern u8 realtime_bright1;
extern u8 realtime_bright2;
extern float last_bright1;
extern float last_bright2;
uint8_t channel;
//float   aim_bright_float;
float aim_bright1;
float aim_bright2;
uint8_t change_time;
float change_step1;
float change_step2;

/*****action dimmer用标志位********/
union FLAG action_flag;
// ********************** Data link function ****************************
// * These functions must be modified according to your application neeeds *
// * See AN document for more precision
// **********************************************************************

//复制内存
//*des:目的地址
//*src:源地址
//n:需要复制的内存长度(字节为单位)
void mymemcpy(void *des,void *src,u32 n)  
{  
  u8 *xdes=des;
	u8 *xsrc=src; 
  while(n--)*xdes++=*xsrc++;  
}  
/**
  * @brief  check sum(cumulative sum)
  * @param  u8 *sendbuf,u8 length.
  * @retval u8 result
  */
u8 Check_Sum(u8 *buf,u8 length)
{
	u8 i;
	u8 result = *buf++;
	for(i = 1;i < length;i++)
	{
		result ^= *buf++;
	}
	return result;
}


u8 i2c_init_message(I2C_Message *tx,u8 payload_len)
{
	IIC_TxBuffer[0] = tx->frame_h1;
	IIC_TxBuffer[1] = tx->frame_h2;
	IIC_TxBuffer[2] = tx->message_id;
	IIC_TxBuffer[3] = 2+payload_len;
	mymemcpy(&IIC_TxBuffer[4],tx->payload,payload_len);
	IIC_TxBuffer[4+payload_len] = Check_Sum(&IIC_TxBuffer[2],IIC_TxBuffer[3]);
	
}

	void I2C_receive_begin(void)
	{
		ReceiveState = IIC_STATE_BEGIN;
	}
	//根据接收的数据返回不同的数据
	void I2C_transaction_begin(void)
	{
		uint8_t cmd;
		uint8_t i;
		SendDataIndex = 0;
		cmd = IIC_RxBuffer[4];
		

		//if((IIC_RxBuffer[0] == 0x7E) && (IIC_RxBuffer[1] == 0x7E)){
			switch(cmd){
				case 0xFE:
					if(IIC_RxBuffer[5] == 0x01)	init_device_info();
				break;
				case 0x03:
					if((IIC_RxBuffer[5] == 0x03)&&(IIC_RxBuffer[6] == slave_address)){
						//校验正确
						if(Check_Sum(&IIC_RxBuffer[2],IIC_RxBuffer[3]) == IIC_RxBuffer[7]){
							rev_heart_breat();
						}
					}
				break;
				case 0x51://Linear
				case 0x52://Erase in
				case 0x53://Erase out
				case 0x54://Swing
					if(((IIC_RxBuffer[5]&0xf0)>>4) == slave_address){
						//处理灯光驱动
						channel = (IIC_RxBuffer[5]&0x0f);
						change_time = IIC_RxBuffer[7];
						if((channel & 0x01) == 0x01)
						{	
							if(IIC_RxBuffer[4] == 0x51)	{linear1_begin = 1;}
							//Erase in:accelerating from zero velocity
							else if((IIC_RxBuffer[4] == 0x52)&& ((realtime_bright1 == 0) || (realtime_bright1 == 1)))	{action_flag._flag_byte |= 0x04;}
							//Erase out:decelerating ro zero velocity
							else if((IIC_RxBuffer[4] == 0x53)&& (IIC_RxBuffer[6]== 0)){action_flag._flag_byte |= 0x10;}
							else if(IIC_RxBuffer[4] == 0x54)	{action_flag._flag_byte |= 0x40;}
							aim_bright1 = ((float)IIC_RxBuffer[6]) / 100;
							change_step1 = (aim_bright1 - last_bright1)/change_time;//change_step1可正可负
						
						}
						if((channel & 0x02) == 0x02)
						{
							if(IIC_RxBuffer[4] == 0x51)	{linear2_begin = 1;}
							else if((IIC_RxBuffer[4] == 0x52)&& ((realtime_bright2 == 0) || (realtime_bright2 == 1)))	{action_flag._flag_byte |= 0x08;}
							else if((IIC_RxBuffer[4] == 0x53)&& (IIC_RxBuffer[6]==0)){action_flag._flag_byte |= 0x20;}
							else if(IIC_RxBuffer[4] == 0x54)	{action_flag._flag_byte |= 0x80;}
							aim_bright2 = ((float)IIC_RxBuffer[6]) / 100;
							change_step2 = (aim_bright2 - last_bright2)/change_time;
						}
						rev_action_dimmer_OK();
					}
				break;
				case 0x59://调光时间结束后SC发送查询ch状态
					if(IIC_RxBuffer[5] == slave_address){//查询action dimmer执行后SLC状态
						rev_action_dimmer_done();
					}
				break;
				default:
				break;
			}
		//}
		
	}
	
	void init_device_info(void)
	{
		I2C_Message di;
		di.frame_h1 = 0x7E;
		di.frame_h2 = 0x7E;
		di.message_id = IIC_RxBuffer[2];
		di.payload[0] = 0xB2;
		di.payload[1] = 0xAA;
		di.payload[2] = 0x55;
		di.payload[3] = 0xAB;
		di.payload[4] = 0x57;
		di.payload[5] = 0x63;
		di.payload[6] = 0x00;
		di.payload[7] = 0xc0;
		di.payload[8] = slave_address;
		i2c_init_message(&di,9);
	}
	
	void rev_heart_breat(void)
	{
		I2C_Message hb;
		hb.frame_h1 = 0x7E;
		hb.frame_h2 = 0x7E;
		hb.message_id = IIC_RxBuffer[2];
		hb.payload[0] = 0x06;
		hb.payload[1] = slc.MDID;
		hb.payload[2] = slc.ch1_status;
		hb.payload[3] = slc.ch2_status;
		hb.payload[4] = slc.ch3_status;
		hb.payload[5] = slc.ch4_status;
		i2c_init_message(&hb,6);
	}
	
	void rev_action_dimmer_OK(void)
	{
		I2C_Message ad;
		ad.frame_h1 = 0x7E;
		ad.frame_h2 = 0x7E;
		ad.message_id = IIC_RxBuffer[2];
		ad.payload[0] = 0xAA;
		ad.payload[1] = 0x02;
		ad.payload[2] = slc.MDID;
		i2c_init_message(&ad,3);
	}
	
	
	void rev_action_dimmer_done(void)
	{
		I2C_Message ad;
		ad.frame_h1 = 0x7E;
		ad.frame_h2 = 0x7E;
		ad.message_id = 66;
		ad.payload[0] = 0xAA;
		ad.payload[1] = 0x05;
		ad.payload[2] = slc.MDID;
		ad.payload[3] = slc.ch1_status;
		ad.payload[4] = slc.ch2_status;
		ad.payload[5] = slc.ch3_status;
		ad.payload[6] = slc.ch4_status;
		i2c_init_message(&ad,7);
	}
	
	
	
	void I2C_transaction_end(void)
	{
		ReceiveState = IIC_STATE_END;
		//ReceiveState = IIC_STATE_UNKNOWN;
			//GetDataIndex = 0;
	}	
	
	void I2C_transaction_receive(void)
	{
		ReceiveState = IIC_STATE_RECEIVEING;
	}
	
	void I2C_byte_received(uint8_t RxData)
	{
		if(GetDataIndex < MAX_BUFFER) {
			IIC_RxBuffer[GetDataIndex++] = RxData;
			ReceiveState = IIC_STATE_RECEIVEING;
		}
	}
	
	uint8_t I2C_byte_write(void)
	{
			return IIC_TxBuffer[SendDataIndex++];
	}


// ********************** Data link interrupt handler *******************

#ifdef _RAISONANCE_
void I2C_Slave_check_event(void) interrupt 19 {
#endif
#ifdef _COSMIC_
@far @interrupt void I2C_Slave_check_event(void) {
#endif
	static u8 sr1;					
	static u8 sr2;
	static u8 sr3;
	
	// save the I2C registers configuration
	sr1 = I2C->SR1;
	sr2 = I2C->SR2;
	sr3 = I2C->SR3;

/* Communication error? */
  if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
  {		
    I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
    I2C->SR2= 0;					    // clear all error flags
	}
/* More bytes received ? */
  if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
  {
    I2C_byte_received(I2C->DR);
  }
/* Byte received ? */
  if (sr1 & I2C_SR1_RXNE)
  {
    I2C_byte_received(I2C->DR);
  }
/* NAK? (=end of slave transmit comm) */
  if (sr2 & I2C_SR2_AF)
  {	
    I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
		I2C_transaction_end();
	}
/* Stop bit from Master  (= end of slave receive comm) */
  if (sr1 & I2C_SR1_STOPF) 
  {
    I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
		I2C_transaction_end();
	}
/* Slave address matched (= Start Comm) */
  if (sr1 & I2C_SR1_ADDR)
  {	 
		if(sr3 & I2C_SR3_TRA){//从机发送数据
			I2C_transaction_begin();
		}else{
			I2C_receive_begin();//从机接收数据
		}
	}
/* More bytes to transmit ? */
  if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
  {
		I2C->DR = I2C_byte_write();
  }
/* Byte to transmit ? */
  if (sr1 & I2C_SR1_TXE)
  {
		I2C->DR = I2C_byte_write();
  }	
	//GPIOD->ODR^=1;
}


// ************************* I2C init Function  *************************

void IIC_SlaveConfig (void)
{
	//配置PD1到PD4为从机地址配置引脚
	//GPIOD->DDR &= ~(0xF<<1);
	//GPIOD->CR1 |= (0xF<<1);//上拉
	//GPIOD->CR2 &= ~(0xF<<1);//External interrupt disabled
	//配置PB4，5为I2C引脚
  //GPIOB->ODR |= (1<<4)|(1<<5);                //define SDA, SCL outputs, HiZ, Open drain, Fast
  //GPIOB->DDR |= (1<<4)|(1<<5);
  //GPIOB->CR2 |= (1<<4)|(1<<5);
	#ifdef I2C_slave_7Bits_Address
		/* Set I2C registers for 7Bits Address */
		I2C->CR1 |= 0x01;				        	// Enable I2C peripheral
		I2C->CR2 = 0x04;					      		// Enable I2C acknowledgement
		I2C->FREQR = 16; 					      	// Set I2C Freq value (16MHz)
		//I2C->FREQR = 12;
		I2C->OARL = (SLAVE_ADDRESS << 1) ;	// set slave address to 0x51 (put 0xA2 for the register dues to7bit address) 
		I2C->OARH = 0x40;					      	// Set 7bit address mode

	#endif
	#ifdef I2C_slave_10Bits_Address
	  /* Set I2C registers for 10Bits Address */
	  I2C->CR1 |= 0x01;				  // Enable I2C peripheral
	  I2C->CR2 = 0x04;					// Enable I2C acknowledgement
	  I2C->FREQR = 16; 					// Set I2C Freq value (16MHz)
		//I2C->FREQR = 12;
	  I2C->OARL = (SLAVE_ADDRESS & 0xFF) ;							// set slave address LSB 
	  I2C->OARH = 0xC0 | ((SLAVE_ADDRESS & 0x300) >> 7);	// Set 10bits address mode and address MSB
	#endif
	
	I2C->ITR	= 0x07;					      // all I2C interrupt enable  
}

