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
#include "I2c_slave_interrupt.h"
//#include "uart_printf.h"

#include <string.h>
#include <stdio.h>
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
extern SLC slc;
extern uint8_t slave_address;
extern uint8_t IIC_RxBuffer[];
extern uint8_t GetDataIndex;
extern uint8_t ReceiveState;
extern uint8_t SendDataIndex;
extern uint8_t IIC_TxBuffer[];

float last_bright1;
float last_bright2;
u8 realtime_bright1;
u8 realtime_bright2;
extern uint8_t channel;
extern float aim_bright1;
extern float aim_bright2;
extern uint8_t change_time;
extern float change_step1;
extern float change_step2;

extern union FLAG action_flag;
Sys_TypeDef sys = {0};
uint16_t Tick100ms;
uint8_t  f_100ms;
uint8_t  tick1s;
/* Private variables ---------------------------------------------------------*/ 
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/

/****************************************************************/
//延时函数delay()，有形参Count用于控制延时函数执行次数，无返回值
/****************************************************************/
void delay(u16 Count)
{
  u8 i,j;
  while (Count--)//Count形参控制延时次数
  {
    for(i=0;i<100;i++)
    for(j=0;j<50;j++);
  }
}

 /*
  * Example firmware main entry point.
  * Parameters: None
  * Retval . None
  */
	
void main(void)
{
	
	uint8_t i;
	uint16_t cmd;
	//CLK->CKDIVR = 0;                // sys clock /1
	CLK->SWCR |= 0x02; //开启切换
  CLK->SWR   = 0xb4;       //选择时钟为外部8M
  while((CLK->SWCR & 0x01)==0x01);
  CLK->CKDIVR = 0x80;    //不分频
  CLK->SWCR  &= ~0x02; //关闭切换
	//disableInterrupts();
	//地址IO初始化
	slave_address = 0x00;
	GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
	delay(100);
	
	if(GPIO_ReadInputData(GPIOD) & 0x04)	slave_address |= 0x08;
	if(GPIO_ReadInputData(GPIOC) & 0x20)	slave_address |= 0x04;
	if(GPIO_ReadInputData(GPIOC) & 0x40)	slave_address |= 0x02;
	if(GPIO_ReadInputData(GPIOC) & 0x80)	slave_address |= 0x01;
	slc.MDID = slave_address;
	GPIO_Config();
	Sys_Init();
	ExtInterrupt_Config();
	TIMER4_Init();
	
	//串口初始化
	//UART_Init(115200);
	
	//printf("Hello World!\n");
	/* Initialise I2C for communication */
	IIC_SlaveConfig();
	
	/* Enable general interrupts */
	enableInterrupts();
	 /*waiting for the main power input and calculate the main AC Hz*/
	 //while(!sys.gotHzFlag)
	 //{
		 //if (sys.checkAcCnt == 0)
		 //{
			 /*no main AC input or fuse has been fused and respone a message to
			 master*/
			 //SendOnePkg(AC_ERR);			 
			 // while (1);
			 /*remonitor the main AC input and calculate the Hz*/
			//sys.gotHzFlag = FALSE;    
			//sys.reqCalHzFlag = FALSE;
			//sys.calHzIntCnt = GET_AC_FRE_CNT;
			//sys.hzCnt = 0;
			//sys.checkAcCnt = CHECK_AC_INPUT_CNT;
			//break;
		 //}
	 //}

	 /*waiting for the main power input and calculate tha main AC Hz*/
	 //while(!sys.gotHzFlag)
	 //{
		 //if (sys.checkAcCnt == 0)
		 //{		
			 /*remonitor the main AC input and calculate the Hz*/
			//sys.gotHzFlag = FALSE;    
			//sys.reqCalHzFlag = FALSE;
			//sys.calHzIntCnt = GET_AC_FRE_CNT;
			//sys.hzCnt = 0;
			//sys.checkAcCnt = CHECK_AC_INPUT_CNT;
		 //}
	 //}
	 sys.acOkFlag = TRUE;
	 TIMER2_Init();
	 
	 
	 
	/*Main Loop */
  while(1)
	{		
		/*if(ReceiveState == IIC_STATE_END)
		{
			//for(i=0;i<GetDataIndex;i++){
				//printf("%02X ",IIC_RxBuffer[i]&0xFF);
			//}
			//printf("\n");
			ReceiveState = IIC_STATE_UNKNOWN;
			GetDataIndex = 0;
		}*/
		/*monitor main AC*/
		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE)
		{
			 /*notification master when main AC lost or fuse has been fused*/
			 //SendOnePkg(AC_ERR);
			 sys.acErrFlag = TRUE;
			 sys.acOkFlag = FALSE;
		}

		if (sys.acErrFlag == FALSE && sys.acOkFlag == FALSE)
		{
			/*notification maser that AC is restored and start working gain*/
			//SendOnePkg(AC_OK);
			sys.acOkFlag = TRUE;
			sys.cnt1s = CNT_1S;
		}
		
		if(f_100ms){
			f_100ms = 0;
			lightCtrl100ms();
		
			
			/*
			tick1s++;
			if(tick1s >= 10){
				tick1s = 0;
				printf("last_bright = %02X, aim_bright = %02X\n",last_bright1&0xFF,aim_bright1&0xFF);
				printf("slc.ch1_status = %02X, slc.ch2_status = %02X\n",slc.ch1_status&0xFF,slc.ch2_status&0xFF);
			}
			*/
		}
		if((channel & 0x01)==0x01)//调节Dimmer1
		{
			sys.light1.briVal = realtime_bright1;
			slc.ch1_status = (u8)(last_bright1*100);
		}
		if((channel & 0x02)==0x02)//调节Dimmer2
		{
			sys.light2.briVal = realtime_bright2;
			slc.ch2_status = (u8)(last_bright2*100);
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

static void Sys_Init(void)
{
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);

    sys.gotHzFlag = FALSE;    
    sys.reqCalHzFlag = FALSE;
    sys.light1.briVal = DEFAULT_BRIGHTNESS;
    sys.light2.briVal = DEFAULT_BRIGHTNESS;    
    sys.calHzIntCnt = GET_AC_FRE_CNT;
    sys.hzCnt = 0;
    sys.checkAcCnt = CHECK_AC_INPUT_CNT;
		last_bright1 = 0.16;
		aim_bright1 = 0;
		last_bright2 = 0.16;
		aim_bright2 = 0;
}

static void ExtInterrupt_Config(void)
{

	EXTI_DeInit();
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
	//ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_2);
}

#ifdef _RAISONANCE_
void Ext_PortD_ISR(void) interrupt 6 {
#endif
#ifdef _COSMIC_
@far @interrupt void Ext_PortD_ISR(void) {
#endif
	/*monitor the AC count is starting*/
	if (ZD_STATUS == 0)
	{  		
		sys.checkAcCnt = CHECK_AC_INPUT_CNT;
		sys.acErrFlag = FALSE;
	  	
	  	/*get the main power Hz is 50 or 60 at the power on*/
		if (!sys.gotHzFlag)
		{			
			if (!sys.reqCalHzFlag)
			{
				TIM4_SetAutoreload(TIMER4_INT_TIME);				
				sys.reqCalHzFlag = TRUE;
			}
			if (sys.calHzIntCnt == 0)
			{
				if ((sys.hzCnt/GET_AC_FRE_CNT) >= HZ_COUNT)
				{
					sys.hz50Flag = TRUE;
				}
				else
				{
					sys.hz50Flag = FALSE;
				}
				
				sys.gotHzFlag = TRUE;
				sys.reqCalHzFlag = FALSE;
			}
			else
			{
				sys.calHzIntCnt--;
			}
		}	
		else
		{  
			if (sys.light1.briVal == MAX_BRIGHTNESS)
			{
				/*triac as soon as fast switch on when maser set bright value is 
				maximum*/
				L1_EN_ON;
				sys.light1.briCnt = 0;
				sys.light1.onFlag = TRUE;			
			}
			else
			{			
				/*calculate triac switch on time(count) according on master set bright value*/
				sys.light1.briCnt = MAX_BRIGHTNESS - sys.light1.briVal;				
				sys.light1.onFlag = FALSE;
				L1_EN_OFF;
			}

			if (sys.light2.briVal == MAX_BRIGHTNESS)
			{
				L2_EN_ON;
				sys.light2.briCnt = 0;
				sys.light2.onFlag = TRUE;			
			}
			else
			{
				sys.light2.briCnt = MAX_BRIGHTNESS - sys.light2.briVal;
				sys.light2.onFlag = FALSE;				
				L2_EN_OFF;
			}
			
			if (sys.light1.briCnt || sys.light2.briCnt)
			{
				/*start timing with Timer2*/
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

static void TIMER4_Init(void)
{    
    TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIMER4_INT_TIME);
    TIM4_ClearFlag(TIM4_FLAG_UPDATE);
    TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);	
    TIM4_Cmd(ENABLE);
}

#ifdef _RAISONANCE_
void Timer4_ISR(void) interrupt 23 {
#endif
#ifdef _COSMIC_
@far @interrupt void Timer4_ISR(void) {
#endif
TIM4_ClearITPendingBit(TIM4_IT_UPDATE);  
  if (sys.reqCalHzFlag)
  {
	  sys.hzCnt++; 	  
  }
  
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

  if (sys.checkAcCnt)
  {
		sys.checkAcCnt--;
  }

  if (sys.cnt1s)
  {
		sys.cnt1s--;
  }
	Tick100ms++;
	if(Tick100ms >= 2000){
		Tick100ms = 0;
		f_100ms = 1;
	}
}

static void TIMER2_Init(void)
{    
	TIM2_TimeBaseInit(TIM2_PRESCALER_16, sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
   	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
   	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	   
}

#ifdef _RAISONANCE_
void Timer2_ISR(void) interrupt 13 {
#endif
#ifdef _COSMIC_
@far @interrupt void Timer2_ISR(void) {
#endif
	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);  
	if (sys.light1.briCnt) 
	{
		sys.light1.briCnt--;			
	}	
	if (sys.light1.briCnt == 0 && !sys.light1.onFlag)
	{
		L1_EN_ON;
		sys.light1.onFlag = TRUE;
		
	}

	if (sys.light2.briCnt) 
	{
		sys.light2.briCnt--;		
	}
	if (sys.light2.briCnt == 0 && !sys.light2.onFlag)
	{
		L2_EN_ON;
		sys.light2.onFlag = TRUE;
		
	}
	if ((sys.light1.briCnt ||  sys.light2.briCnt) == 0)
	{
		TIM2_Cmd(DISABLE);
	}
}
//调光函数，t表示调光亮度百分比，范围在[0,1]之间，返回对应的光阶
u8 Linear(float t)
{
	if((t >= 0)&&(t <=1))
		return (u8)(t*250);
	else
		return 40;
}
u8 EraseIn(float t)
{
	if((t >= 0)&&(t <=1))
		return (u8)(t*t*250);
	else
		return 40;
}
u8 EraseOut(float t)
{
	if((t >= 0)&&(t <=1))
		return (u8)((2-t)*t*250);
	else
		return 40;
}
u8 Swing(float t)
{
	if((t >= 0)&&(t <=1)){
		if(t < 0.5)
			return (u8)(2*t*t*250);
		else
			return (u8)(((4-2*t)*t - 1)*250);
	}
	else
		return 40;
}

void lightCtrl100ms(void)
{
	if(linear1_begin){//channel1 Linear调光开始
		last_bright1 += change_step1;
		realtime_bright1 = Linear(last_bright1);
		if(last_bright1 > aim_bright1){
			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
				linear1_begin = 0;
		}
		else{
			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
				linear1_begin = 0;
		}
	}
	if(linear2_begin){//channel2 Linear调光开始
		last_bright2 += change_step2;
		realtime_bright2 = Linear(last_bright2);
		if(last_bright2 > aim_bright2){
			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
				linear2_begin = 0;
		}
		else{
			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
				linear2_begin = 0;
		}
	}
	if(eraseIn1_begin){//channel1 EraseIn调光开始
		last_bright1 += change_step1;
		realtime_bright1 = EraseIn(last_bright1);	
		if(last_bright1 > aim_bright1){
			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
				eraseIn1_begin = 0;
		}
		else{
			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
				eraseIn1_begin = 0;
		}
	}
	if(eraseIn2_begin){//channel2 EraseIn调光开始
		last_bright2 += change_step2;
		realtime_bright2 = EraseIn(last_bright2);
		if(last_bright2 > aim_bright2){
			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
				eraseIn2_begin = 0;
		}
		else{
			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
				eraseIn2_begin = 0;
		}
	}
	if(eraseOut1_begin){//channel1 EraseOut调光开始
		last_bright1 += change_step1;
		realtime_bright1 = EraseOut(last_bright1);	
		if(last_bright1 > aim_bright1){
			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
				eraseOut1_begin = 0;
		}
		else{
			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
				eraseOut1_begin = 0;
		}
	}
	if(eraseOut2_begin){//channel2 EraseOut调光开始
		last_bright2 += change_step2;
		realtime_bright2 = EraseOut(last_bright2);
		if(last_bright2 > aim_bright2){
			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
				eraseOut2_begin = 0;
		}
		else{
			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
				eraseOut2_begin = 0;
		}
	}
	if(swing1_begin){//channel1 Swing调光开始
		last_bright1 += change_step1;
		realtime_bright1 = Swing(last_bright1);	
		if(last_bright1 > aim_bright1){
			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
				swing1_begin = 0;
		}
		else{
			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
				swing1_begin = 0;
		}
	}
	if(swing2_begin){//channel2 Swing调光开始
		last_bright2 += change_step2;
		realtime_bright2 = Swing(last_bright2);
		if(last_bright2 > aim_bright2){
			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
				swing2_begin = 0;
		}
		else{
			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
				swing2_begin = 0;
		}
	}
}



/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
