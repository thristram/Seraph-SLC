/**
  ******************************************************************************
  * file main.c
  * brief This file contains the main function for I2C interrupt mode example.
  * author STMicroelectronics - MCD Application Team
  * version V1.0.0
  * date 01/03/2010
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  *                    COPYRIGHT 2009 STMicroelectronics
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "main.h"

#include <string.h>
#include <stdio.h>

#include "uart.h"


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/


SLC slc;


volatile uint8_t channel;
volatile uint8_t channel1 = 0;
volatile uint8_t channel2 = 0;

volatile u8 realtime_bright1;
volatile u8 realtime_bright2;

volatile float aim_bright1;
volatile float aim_bright2;
volatile float last_bright1;
volatile float last_bright2;

volatile float change_step1;
volatile float change_step2;

/***** action dimmer 用标志位********/
union FLAG action_flag;





Sys_TypeDef sys = {0};

/* 控制时间变量 */
tick_timer tick = {0};


/* Private variables ---------------------------------------------------------*/ 
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/



//复制内存
//*des:目的地址
//*src:源地址
//n:需要复制的内存长度(字节为单位)
void mymemcpy(void *des, void *src, u32 n)  
{  
	u8 *xdes = des;
	u8 *xsrc = src; 
  	while(n--) *xdes++ = *xsrc++;  
}  


/*----------------------------------------------------------------------------
	//延时函数delay()，有形参Count用于控制延时函数执行次数，无返回值
-----------------------------------------------------------------------------*/
void delay(u16 Count)
{
	u8 i, j;
	
	//Count形参控制延时次数
	while (Count--){
		for(i=0;i<100;i++)
		for(j=0;j<50;j++);
	}
	
}
 
 
 /*----------------------------------------------------------------------------
	 设置系统时钟 
 -----------------------------------------------------------------------------*/
 void system_clock_set(void)
 {

	 //CLK->CKDIVR = 0; 			   // sys clock /1
	 CLK->SWCR |= 0x02; //开启切换
	 
	 CLK->SWR	= 0xb4; 	  //选择时钟为外部16M
	 while((CLK->SWCR & 0x01) == 0x01);
	 CLK->CKDIVR = 0x80;	//不分频
	 
	 CLK->SWCR	&= ~0x02; //关闭切换

 }

 /*----------------------------------------------------------------------------
	 获取地址 
 -----------------------------------------------------------------------------*/
 u8 system_addr_get(void)
 {
	uint8_t slave_address = 0;

	 //地址IO初始化
	 slave_address = 0; 
	 GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
	 GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
	 GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
	 GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);
//	 GPIO_Init(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
	 
	 delay(100);
	 
	 if(GPIO_ReadInputData(GPIOD) & 0x04)	 slave_address |= 0x08;
	 if(GPIO_ReadInputData(GPIOC) & 0x20)	 slave_address |= 0x04;
	 if(GPIO_ReadInputData(GPIOC) & 0x40)	 slave_address |= 0x02;
	 if(GPIO_ReadInputData(GPIOC) & 0x80)	 slave_address |= 0x01;

	return slave_address;

 }


 /*----------------------------------------------------------------------------
 	EEPROM中写入一个字节
 	dLocal_Addr:EEPROM中的地址，从0x4000
	dLocal_Data:要写入EEPOM中的数据
 -----------------------------------------------------------------------------*/
 void MEEPROM_WriteByte(u16 dLocal_Addr, u8 dLocal_Data)
 {
	FLASH_Unlock(FLASH_MEMTYPE_DATA);
	while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);
	
	FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr, dLocal_Data);
	FLASH_Lock(FLASH_MEMTYPE_DATA);

 }

 
 
  /*----------------------------------------------------------------------------
	 从EEPROM中读取一个字节
	 直接使用FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr);
 -----------------------------------------------------------------------------*/
  u8 MEEPROM_ReadByte(u16 dLocal_Addr)
  {
	  u8 dLocal_1;
	  dLocal_1 = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr);
	  return dLocal_1;
  }

 
 
  /*----------------------------------------------------------------------------
	   保存状态数据
  -----------------------------------------------------------------------------*/
 void channel_status_save(void)
{
	FLASH_Unlock(FLASH_MEMTYPE_DATA);
	while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);

	FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_STATUS_ADDRESS, slc.ch1_status);
	FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH2_STATUS_ADDRESS, slc.ch2_status);

	FLASH_Lock(FLASH_MEMTYPE_DATA);

}




 /*----------------------------------------------------------------------------
	  设置默认的信息
 -----------------------------------------------------------------------------*/
void default_info_set(void)
{	 
	slc.ch1_status = 0;
	slc.ch2_status = 0;
	slc.ch3_status = 0;
	slc.ch4_status = 0;

	channel_status_save();
	
}


 /*----------------------------------------------------------------------------
	  读取设备信息 
 -----------------------------------------------------------------------------*/
 void device_info_read(void)
 {
	u8 temp = 0;

	slc.savFlag = 0;
 
	slc.model = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MODEL_ADDRESS);
 	slc.firmware_version = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_FW_VERSION_ADDRESS);	
	if(slc.firmware_version == 1){		/* 第一版本，device ID 4个字节  */		
		slc.deviceID[0] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 3);
		slc.deviceID[1] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 2);
		slc.deviceID[2] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 1);
		slc.deviceID[3] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 0);
	}
	slc.HW_version = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_HW_VERSION_ADDRESS);

	temp = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_BASH_ADDRESS + 0);
	slc.bash = temp + 256 * FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_BASH_ADDRESS + 1);
	
	slc.manaYear = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_YEAR_ADDRESS);
	slc.manaMonth = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_MONTH_ADDRESS);
	slc.manaDay = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_DAY_ADDRESS);

	slc.ch1_status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_STATUS_ADDRESS);
	slc.ch2_status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH2_STATUS_ADDRESS);

	realtime_bright1 = slc.ch1_status;
	sys.light1.briVal = realtime_bright1;

	realtime_bright2 = slc.ch2_status;
	sys.light2.briVal = realtime_bright2;

	aim_bright1 = ((float)realtime_bright1) / 100.0;
	aim_bright2 = ((float)realtime_bright2) / 100.0;

	last_bright1 = aim_bright1;
	last_bright2 = aim_bright2;

		
 }

 

 /*----------------------------------------------------------------------------
	 初始化EEPROM
 -----------------------------------------------------------------------------*/
 void MEEPROM_Init(void)
 {
	u8 temp = 0;
 
	FLASH_DeInit();
	temp = MEEPROM_ReadByte(EEPROM_INIT_ADDRESS);
	
	//初次上电设置默认数据
	if(temp == EEPROM_INIT_FLAG) {		
		MEEPROM_WriteByte(EEPROM_INIT_ADDRESS, EEPROM_INIT_FLAG);
		default_info_set();
	}
	
	device_info_read();

 }

 /*----------------------------------------------------------------------------
	 设置中断优先级
 -----------------------------------------------------------------------------*/
 void interrupt_priority_set(void)
 {
 
 //  //中断优先级设置
	 disableInterrupts();
	 
	 ITC_DeInit();
	 
	 ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_3);
	 ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF, ITC_PRIORITYLEVEL_3);
	 ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF, ITC_PRIORITYLEVEL_3);
 
	 ITC_SetSoftwarePriority(ITC_IRQ_UART1_TX, ITC_PRIORITYLEVEL_2);
	 ITC_SetSoftwarePriority(ITC_IRQ_UART1_RX, ITC_PRIORITYLEVEL_2);
	 
	 /* Enable general interrupts */
	 enableInterrupts();

 
 }
 
 /*----------------------------------------------------------------------------
 
 -----------------------------------------------------------------------------*/
 static void Sys_Init(void)
 {
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);

	sys.light1.briVal = DEFAULT_BRIGHTNESS;
	sys.light2.briVal = DEFAULT_BRIGHTNESS; 


	sys.gotHzFlag = FALSE;    
	sys.reqCalHzFlag = FALSE;
	sys.calHzIntCnt = GET_AC_FRE_CNT;
	sys.hzCnt = 0;
	sys.checkAcCnt = CHECK_AC_INPUT_CNT;

	sys.acOkFlag = FALSE;
	sys.acErrFlag = TRUE;

	slc.f_mal.byte = 0;
	
	slc.ch1_status = 0;
	slc.ch2_status = 0;
	slc.ch3_status = 0;
	slc.ch4_status = 0;

	last_bright1	 = 0;
	aim_bright1	 = 0;
	last_bright2	 = 0;
	aim_bright2	 = 0;
		 
 }


 /*
  * Example firmware main entry point.
  * Parameters: None
  * Retval . None
  */	
void main(void)
{	

	system_clock_set();

	slc.MDID = system_addr_get();

	GPIO_Config();
	uart1_init();
	Sys_Init();
	ExtInterrupt_Config();
	TIMER4_Init();	

	/* 设置中断优先级 */
	interrupt_priority_set();

//	 /*waiting for the main power input and calculate the main AC Hz*/
//	 while(!sys.gotHzFlag)
//	 {
//		 if (sys.checkAcCnt == 0)
//		 {
//			 /*no main AC input or fuse has been fused and respone a message to
//			 master*/
//			 //SendOnePkg(AC_ERR);			 
//			 // while (1);
//			 /*remonitor the main AC input and calculate the Hz*/
//			 
//			sys.gotHzFlag = FALSE;    
//			sys.reqCalHzFlag = FALSE;
//			sys.calHzIntCnt = GET_AC_FRE_CNT;
//			sys.hzCnt = 0;
//			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
//			break;
//		 }
//	 }

//	 while(!sys.gotHzFlag){
//	 	
//		 if (sys.checkAcCnt == 0){		
//			sys.gotHzFlag = FALSE;    
//			sys.reqCalHzFlag = FALSE;
//			sys.calHzIntCnt = GET_AC_FRE_CNT;
//			sys.hzCnt = 0;
//			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
//		 }
//		 
//	 }
	  
	TIMER2_Init();

	MEEPROM_Init();
	 
  	while(1)
	{		
		/* monitor main AC */
		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE){			/* 在已经检测出强电之后再检测到故障 */
			
			 /*notification master when main AC lost or fuse has been fused*/
			 //SendOnePkg(AC_ERR);
			 sys.acErrFlag = TRUE;
			 sys.acOkFlag = FALSE;
			 slc.f_mal.bit.f_ac = 1;
			 
			/* 要重新计算交流频率 */
			sys.gotHzFlag = FALSE;    
			 
		}

		if(!sys.gotHzFlag){				/* 还未计算出频率 */

			if (sys.checkAcCnt == 0){	   	/* 第一次没有检测到故障 */
				sys.gotHzFlag = FALSE;	 
				sys.reqCalHzFlag = FALSE;
				sys.calHzIntCnt = GET_AC_FRE_CNT;
				sys.hzCnt = 0;
				sys.checkAcCnt = CHECK_AC_INPUT_CNT;				
				slc.f_mal.bit.f_ac = 1;
			}
		}

		if (sys.acOkFlag == FALSE && sys.acErrFlag == FALSE){
			
			/*notification maser that AC is restored and start working gain*/
			//SendOnePkg(AC_OK);
			if(sys.gotHzFlag){
				sys.acOkFlag = TRUE;
				slc.f_mal.bit.f_ac = 0;
				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
			}			
			sys.cnt1s = CNT_1S;
		}


		/* uart1 recv a total package needed */
		if(uart1_frame.rxflag == 1){
			uart1_frame.rxflag = 0;
			uart1_recv_handle();
		}


		
//		if(tick.f_100ms){
//			tick.f_100ms = 0;
//			lightCtrl100ms();		
//		}

		if(tick.f_50ms){
			tick.f_50ms = 0;
			lightCtrl_50ms();		
		}
		
//		//调节Dimmer1
//		if((channel & 0x01) == 0x01){
//			sys.light1.briVal = realtime_bright1;
//			//slc.ch1_status = (u8)(last_bright1*100);
//			slc.ch1_status = realtime_bright1;
//		}
//		//调节Dimmer2
//		if((channel & 0x02) == 0x02){
//			sys.light2.briVal = realtime_bright2;
//			//slc.ch2_status = (u8)(last_bright2*100);
//			slc.ch2_status = realtime_bright2;
//		}


		//调节Dimmer1
		if(channel1){
			sys.light1.briVal = realtime_bright1;
			slc.ch1_status = realtime_bright1;
		}
		//调节Dimmer2
		if(channel2){
			sys.light2.briVal = realtime_bright2;
			slc.ch2_status = realtime_bright2;
		}


		if(slc.savFlag == 1){
			slc.savFlag = 0;
			channel_status_save();
		}

		if (sys.acOkFlag && sys.cnt1s == 0)
		{
			/*it indicates the system is working via UART sends a 
			IS_RUNNING to master every 1s */
			//SendOnePkg(IS_RUNNING);
			sys.cnt1s = CNT_1S;
		}
		
	}
	
}



#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
	

	while (1)
	{
		
	}
}
#endif


/*----------------------------------------------------------------------------
	调光引脚配置
	过零检测引脚配置
-----------------------------------------------------------------------------*/
static void GPIO_Config(void)
{
	/* Initialize I/Os in Output Mode and disable lights*/
 	GPIO_Init(L1_EN_PIN_PORT, (GPIO_Pin_TypeDef)L1_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
	GPIO_Init(L2_EN_PIN_PORT, (GPIO_Pin_TypeDef)L2_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);   
	L1_EN_OFF;
	L2_EN_OFF;
    	GPIO_Init(ZD_PIN_PORT, (GPIO_Pin_TypeDef)ZD_PIN, GPIO_MODE_IN_FL_IT);  
   	 //GPIO_Init(WAKEUP_PIN_PORT, (GPIO_Pin_TypeDef)WAKEUP_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);   
}


/*----------------------------------------------------------------------------
	过零检测引脚 外部中断配置
-----------------------------------------------------------------------------*/
static void ExtInterrupt_Config(void)
{
	EXTI_DeInit();
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
	//ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_2);
}


/*----------------------------------------------------------------------------
	过零检测引脚 外部中断函数
	强电频率每半周期(50Hz时是10ms)进入一次中断
-----------------------------------------------------------------------------*/
@far @interrupt void Ext_PortD_ISR(void)
{
	/* monitor the AC count is starting */
	if (ZD_STATUS == 0)
	{  		
		sys.checkAcCnt = CHECK_AC_INPUT_CNT;
		sys.acErrFlag = FALSE;
	  	
	  	/*get the main power Hz is 50 or 60 at the power on*/
		if (!sys.gotHzFlag){		/* 还未获取频率值 */	
			if (!sys.reqCalHzFlag){
				TIM4_SetAutoreload(TIMER4_INT_TIME);				
				sys.reqCalHzFlag = TRUE;				/* 强制开始计算频率 */
				sys.hzCnt = 0;						/* fyl: */
				sys.calHzIntCnt = GET_AC_FRE_CNT;
			}
			if (sys.calHzIntCnt == 0){
				
				if ((sys.hzCnt /GET_AC_FRE_CNT) >= HZ_COUNT){
					
					sys.hz50Flag = TRUE;
					
				}else{
				
					sys.hz50Flag = FALSE;
					
				}
				
				sys.gotHzFlag = TRUE;				/* */
				sys.reqCalHzFlag = FALSE;			/* 计算完 */
				
			}else{
			
				sys.calHzIntCnt--;
				
			}
			
		}
		else{  
			if (sys.light1.briVal == MAX_BRIGHTNESS){
				
				/* triac as soon as fast switch on when maser set bright value is 
				maximum */
				L1_EN_ON;
				sys.light1.briCnt = 0;
				sys.light1.onFlag = TRUE;		
				
			}else{			
			
				/* calculate triac switch on time(count) according on master set bright value */
				sys.light1.briCnt = MAX_BRIGHTNESS - sys.light1.briVal;				
				sys.light1.onFlag = FALSE;
				L1_EN_OFF;
			}

			if (sys.light2.briVal == MAX_BRIGHTNESS){
				L2_EN_ON;
				sys.light2.briCnt = 0;
				sys.light2.onFlag = TRUE;		
				
			}else{
				sys.light2.briCnt = MAX_BRIGHTNESS - sys.light2.briVal;
				sys.light2.onFlag = FALSE;				
				L2_EN_OFF;
				
			}
			
			if (sys.light1.briCnt || sys.light2.briCnt){
				/* start timing with Timer2 */
				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
				TIM2_Cmd(ENABLE);
			}
			
		}
		
	}
	
}


#ifdef ENABLE_WDT  
/*watchdog count period is 250ms*/
static void Wdt_Init(void)
{
	IWDG_Enable();
	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
	IWDG_SetPrescaler(IWDG_Prescaler_128);
	IWDG_SetReload(127);
	IWDG_WriteAccessCmd(IWDG_WriteAccess_Disable);
}

static void FeedDog(void)
{
	IWDG_ReloadCounter();
}

#endif


/*----------------------------------------------------------------------------
	timer4 定时50us
-----------------------------------------------------------------------------*/
static void TIMER4_Init(void)
{    
	TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIMER4_INT_TIME);
	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);	
	TIM4_Cmd(ENABLE);
}

/*----------------------------------------------------------------------------
	timer4 中断服务
-----------------------------------------------------------------------------*/
@far @interrupt void Timer4_ISR(void) 
{
	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);  

	//需要计算频率
	if (sys.reqCalHzFlag){
	 	sys.hzCnt++; 	  
	}

	//triacTriggeTime 有何用?
	if (sys.light1.triacTriggeTime)
	{
		sys.light1.triacTriggeTime--;
		if (sys.light1.triacTriggeTime == 0)
		{
			L1_EN_OFF;
		}
	 }

	 if (sys.light2.triacTriggeTime)
	 {
		sys.light2.triacTriggeTime--;
		 if (sys.light2.triacTriggeTime == 0)
		 {
			 L2_EN_OFF;
		 }
	 }

	//
	 if (sys.checkAcCnt){
		sys.checkAcCnt--;
	 }

	 if (sys.cnt1s){
		sys.cnt1s--;
	 }
	  
	tick.c_50ms++;
	if(tick.c_50ms >= 1000){
		tick.c_50ms = 0;
		tick.f_50ms = 1;
		
		tick.c_100ms++;
		if(tick.c_100ms >= 2){
			tick.c_100ms = 0;
			tick.f_100ms = 1;
		}
		
	}

	
}


/*----------------------------------------------------------------------------
	timer2 控制每中断100次等于一次过零检测的时间
	即50HZ或60HZ的半周期时间
-----------------------------------------------------------------------------*/
static void TIMER2_Init(void)
{    
	TIM2_TimeBaseInit(TIM2_PRESCALER_16, sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
   	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
   	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	   
}

 /*----------------------------------------------------------------------------
	timer2 中断服务程序 
-----------------------------------------------------------------------------*/
@far @interrupt void Timer2_ISR(void) 
{

	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);  

	if (sys.light1.briCnt) {
		sys.light1.briCnt--;			
	}	
	
	if ((sys.light1.briCnt == 0) && (!sys.light1.onFlag)){
		L1_EN_ON;
		sys.light1.onFlag = TRUE;		
	}

	if (sys.light2.briCnt) {
		sys.light2.briCnt--;		
	}
	
	if ((sys.light2.briCnt == 0) && (!sys.light2.onFlag)){
		L2_EN_ON;
		sys.light2.onFlag = TRUE;
		
	}
	
//	if ((sys.light1.briCnt || sys.light2.briCnt) == 0){
//		TIM2_Cmd(DISABLE);
//	}

	if ((sys.light1.briCnt == 0) &&  (sys.light2.briCnt == 0)){
		TIM2_Cmd(DISABLE);
	}



	
}

 /*----------------------------------------------------------------------------
	timer2 中断服务程序 
-----------------------------------------------------------------------------*/
//u8 y_tri_x3(float t)
//{
//	float	temp0 = 0;
//	float 	temp1 = 0;
//	u8	temp2 = 0;

//	if((t >= 0) && (t <= 1)){
//		
//		temp0 = 4 * (t -0.5) * (t -0.5) * (t -0.5) + 0.5;
//		temp1 = temp0 * MAX_BRIGHTNESS;
//		temp2 = (u8)(temp0 * MAX_BRIGHTNESS);
//		
//		if(temp1 - temp2 >= 0.5){
//			return (temp2 + 1);
//		}else{
//			return temp2;
//		}
//			
//	}else{
//	
//		return DEFAULT_BRIGHTNESS;
//	}

//	
//}




//调光函数，t表示调光亮度百分比，范围在[0,1]之间，返回对应的光阶
u8 Linear(float t)
{
	float 	temp1 = t * MAX_BRIGHTNESS;
	u8	temp2 = (u8)(t * MAX_BRIGHTNESS);

	if((t >= 0) && (t <= 1)){
		
		if(temp1 - temp2 >= 0.5){
			return (temp2 + 1);
		}else{
			return temp2;
		}
			
	}else{
	
		return DEFAULT_BRIGHTNESS;
	}

	
}

u8 EraseIn(float t)
{
	if((t >= 0)&&(t <=1))
		return (u8)(t*t*MAX_BRIGHTNESS);
	else
		return DEFAULT_BRIGHTNESS;
}

u8 EraseOut(float t)
{
	if((t >= 0)&&(t <=1))
		return (u8)((2-t) * t * MAX_BRIGHTNESS);
	else
		return DEFAULT_BRIGHTNESS;
}

u8 Swing(float t)
{
	if((t >= 0)&&(t <=1)){
		if(t < 0.5)
			return (u8)(2 * t * t * MAX_BRIGHTNESS);
		else
			return (u8)(((4-2*t)*t - 1) * MAX_BRIGHTNESS);
	}
	else
		return DEFAULT_BRIGHTNESS;
}



void lightCtrl100ms(void)
{
	/* 线性调光 */
	if(channel & 0x01){
		if(linear1_begin){//channel Linear调光开始

			if(last_bright1 == aim_bright1){
				linear1_begin = 0;
				channel &= ~(0x01);

			}else{

				if(last_bright1 > aim_bright1){
					if((last_bright1 - aim_bright1) < (0 -change_step1)){
						last_bright1 = aim_bright1;
					}else{
						last_bright1 += change_step1;
					}
											
				}else{
					if((aim_bright1 - last_bright1) < change_step1){
						last_bright1 = aim_bright1;
					}else{
						last_bright1 += change_step1;
					}						
				}
				realtime_bright1 = Linear(last_bright1);
			}


//			last_bright1 += change_step1;
//			realtime_bright1 = Linear(last_bright1);
//					
//			if(last_bright1 > aim_bright1){
//				if(((u8)((last_bright1 - aim_bright1) * 250) <= 1)){
//					linear1_begin = 0;
//					channel &= ~(0x01);
//				}
//										
//			}else{
//				if(((u8)((aim_bright1 - last_bright1)*250) <= 1)){
//					linear1_begin = 0;
//					channel &= ~(0x01);

//				}
//			}
			
		}
		
	}
	
	if(channel & 0x02){
		if(linear2_begin){//channel2 Linear调光开始


			if(last_bright2 == aim_bright2){
				linear2_begin = 0;
				channel &= ~(0x02);

			}else{

				if(last_bright2 > aim_bright2){
					if((last_bright2 - aim_bright2) < (0 -change_step2)){
						last_bright2 = aim_bright2;
					}else{
						last_bright2 += change_step2;
					}
											
				}else{
					if((aim_bright2 - last_bright2) < change_step2){
						last_bright2 = aim_bright2;
					}else{
						last_bright2 += change_step2;
					}						
				}
				realtime_bright2 = Linear(last_bright2);
			}


//			last_bright2 += change_step2;
//			realtime_bright2 = Linear(last_bright2);
//			if(last_bright2 > aim_bright2){
//				if(((u8)((last_bright2 - aim_bright2)*250) <= 1)){
//					linear2_begin = 0;
//					channel &= ~(0x02);
//				}
//			}
//			else{
//				if(((u8)((aim_bright2 - last_bright2)*250) <= 1)){
//					linear2_begin = 0;
//					channel &= ~(0x02);				
//				}

//			}
			
		}
		
	}

	
//	if(eraseIn1_begin){//channel1 EraseIn调光开始
//		last_bright1 += change_step1;
//		realtime_bright1 = EraseIn(last_bright1);	
//		if(last_bright1 > aim_bright1){
//			if(((u8)((last_bright1 - aim_bright1) * 250) <= 1))
//				eraseIn1_begin = 0;channel &= ~(0x01);
//		}
//		else{
//			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
//				eraseIn1_begin = 0;
//			channel &= ~(0x01);
//		}
//	}
//	if(eraseIn2_begin){//channel2 EraseIn调光开始
//		last_bright2 += change_step2;
//		realtime_bright2 = EraseIn(last_bright2);
//		if(last_bright2 > aim_bright2){
//			if(((u8)((last_bright2 - aim_bright2)*250) <= 1))
//				eraseIn2_begin = 0;
//			channel &= ~(0x02);
//		}
//		else{
//			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
//				eraseIn2_begin = 0;
//			channel &= ~(0x02);
//		}
//	}
//	if(eraseOut1_begin){//channel1 EraseOut调光开始
//		last_bright1 += change_step1;
//		realtime_bright1 = EraseOut(last_bright1);	
//		if(last_bright1 > aim_bright1){
//			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
//				eraseOut1_begin = 0;
//			channel &= ~(0x01);
//		}
//		else{
//			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
//				eraseOut1_begin = 0;
//			channel &= ~(0x01);
//		}
//	}
//	if(eraseOut2_begin){//channel2 EraseOut调光开始
//		last_bright2 += change_step2;
//		realtime_bright2 = EraseOut(last_bright2);
//		if(last_bright2 > aim_bright2){
//			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
//				eraseOut2_begin = 0;
//			channel &= ~(0x02);
//		}
//		else{
//			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
//				eraseOut2_begin = 0;
//			channel &= ~(0x02);
//		}
//	}
//	if(swing1_begin){//channel1 Swing调光开始
//		last_bright1 += change_step1;
//		realtime_bright1 = Swing(last_bright1);	
//		if(last_bright1 > aim_bright1){
//			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
//				swing1_begin = 0;
//			channel &= ~(0x01);
//		}
//		else{
//			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
//				swing1_begin = 0;
//			channel &= ~(0x01);
//		}
//	}
//	if(swing2_begin){//channel2 Swing调光开始
//		last_bright2 += change_step2;
//		realtime_bright2 = Swing(last_bright2);
//		if(last_bright2 > aim_bright2){
//			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
//				swing2_begin = 0;
//			channel &= ~(0x02);
//		}
//		else{
//			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
//				swing2_begin = 0;
//			channel &= ~(0x02);
//		}
//	}
	
}


/*----------------------------------------------------------------------------
	人眼识别极限每20次，故使用50ms刷新一次
-----------------------------------------------------------------------------*/
void lightCtrl_50ms(void)
{
	/* 线性调光 */
//	if((channel & 0x01) == 0x01){

//		if(last_bright1 == aim_bright1){		//channel1 Linear调光开始
//			channel &= ~(0x01);
//			slc.savFlag = 1;
//		
//		}else{
//		
//			if(last_bright1 > aim_bright1){
//				if((last_bright1 - aim_bright1) <= (0.000001 -change_step1)){
//					last_bright1 = aim_bright1;
//				}else{
//					last_bright1 += change_step1;
//				}
//										
//			}else{
//				if((aim_bright1 - last_bright1) <= (change_step1 + 0.000001)){
//					last_bright1 = aim_bright1;
//				}else{
//					last_bright1 += change_step1;
//				}						
//			}
//			realtime_bright1 = Linear(last_bright1);
//		}	
//		
//	}
//	
//	if((channel & 0x02) == 0x02){
//		
//		if(last_bright2 == aim_bright2){
//			channel &= ~(0x02);
//			slc.savFlag = 1;
//		
//		}else{
//		
//			if(last_bright2 > aim_bright2){
//				if((last_bright2 - aim_bright2) <= (0.000001 -change_step2)){
//					last_bright2 = aim_bright2;
//				}else{
//					last_bright2 += change_step2;
//				}
//										
//			}else{
//				if((aim_bright2 - last_bright2) <= (change_step2 + 0.000001)){
//					last_bright2 = aim_bright2;
//				}else{
//					last_bright2 += change_step2;
//				}						
//			}
//			realtime_bright2 = Linear(last_bright2);
//		}
//		
//	}



	if(channel1){

		if(last_bright1 == aim_bright1){		//channel1 Linear调光开始
			channel1 = 0;
			slc.savFlag = 1;
		
		}else{
		
			if(last_bright1 > aim_bright1){
				if((last_bright1 - aim_bright1) <= (0.000001 -change_step1)){
					last_bright1 = aim_bright1;
				}else{
					last_bright1 += change_step1;
				}
										
			}else{
				if((aim_bright1 - last_bright1) <= (change_step1 + 0.000001)){
					last_bright1 = aim_bright1;
				}else{
					last_bright1 += change_step1;
				}						
			}
			realtime_bright1 = Linear(last_bright1);
		}	
		
	}

	if(channel2){
		
		if(last_bright2 == aim_bright2){
			channel2 = 0;
			slc.savFlag = 1;
		
		}else{
		
			if(last_bright2 > aim_bright2){
				if((last_bright2 - aim_bright2) <= (0.000001 -change_step2)){
					last_bright2 = aim_bright2;
				}else{
					last_bright2 += change_step2;
				}
										
			}else{
				if((aim_bright2 - last_bright2) <= (change_step2 + 0.000001)){
					last_bright2 = aim_bright2;
				}else{
					last_bright2 += change_step2;
				}						
			}
			realtime_bright2 = Linear(last_bright2);
		}
		
	}



	
}



/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
