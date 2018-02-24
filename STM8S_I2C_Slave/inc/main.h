
#ifndef __MAIN_H
#define __MAIN_H

#include "stm8s.h"
#include "stm8s_gpio.h"
#include "stm8s_adc1.h"





#define linear1_begin		action_flag._flag_bit.bit0//接收到Linear调光指令
#define linear2_begin		action_flag._flag_bit.bit1//Linear调光指令执行完成标志
#define eraseIn1_begin		action_flag._flag_bit.bit2//接收到EraseIn调光指令且eraseIn指令有效，即上一次亮度为0
#define eraseIn2_begin		action_flag._flag_bit.bit3
#define eraseOut1_begin	action_flag._flag_bit.bit4//接收到EraseOut调光指令且eraseOut指令有效，即目标亮度为0
#define eraseOut2_begin	action_flag._flag_bit.bit5
#define swing1_begin		action_flag._flag_bit.bit6//接收到Swing调光指令
#define swing2_begin		action_flag._flag_bit.bit7


typedef struct
{
	u8 frame_h1;
	u8 frame_h2;
	u8 message_id;
	u8 payload[30];
	
}I2C_Message;


union f_malfunction   
{
	struct
	{
		uint8_t f_uart:1;
		uint8_t bit1:1;
		uint8_t bit2:1;
		uint8_t f_ac:1;
		uint8_t bit4:1;
		uint8_t bit5:1;
		uint8_t f_chl2:1;
		uint8_t f_chl1:1;
	}bit;
	
	uint8_t byte;
};



typedef struct
{

	u8 				deviceID[4];
	
	u8				model;		//设备型号
	
	u8				firmware_version;
	u8				HW_version;

	union f_malfunction f_mal;

	u8				manaYear;
	u8				manaMonth;
	u8				manaDay;

	u16				bash;		//生产批次号
	u16				meshID;
	u16				GATTmeshID;
	
	
	char				coord[12];	//设备在房间的位置

	u8				MDID;		//用于汇报SLC/SPC的信息，模块ID
	
	u8				savFlag;		//保存状态到eeprom的标志

	u8				ch1_status;
	u8				ch2_status;
	u8				ch3_status;
	u8				ch4_status;
	
	
}SLC;


/*light1 enable gpio definition*/
#define L1_EN_PIN_PORT          	GPIOC
#define L1_EN_PIN               		GPIO_PIN_4
#define L1_EN_ON 				GPIO_WriteLow(L1_EN_PIN_PORT, L1_EN_PIN);\
                                				sys.light1.triacTriggeTime = TRIAC_TRIGGE_TIME
//#define L1_EN_ON 				GPIO_WriteLow(L1_EN_PIN_PORT, L1_EN_PIN)

                                			
#define L1_EN_OFF 				GPIO_WriteHigh(L1_EN_PIN_PORT, L1_EN_PIN)
#define L1_EN_REVERSE			GPIO_WriteReverse(L1_EN_PIN_PORT, L1_EN_PIN)
#define L1_EN_STATUS      	    (GPIO_ReadOutputData(L1_EN_PIN_PORT) & L1_EN_PIN)

/*light2 enable gpio definition*/
#define L2_EN_PIN_PORT          	GPIOC
#define L2_EN_PIN               		GPIO_PIN_3
#define L2_EN_ON 				GPIO_WriteLow(L2_EN_PIN_PORT, L2_EN_PIN);\
                                				sys.light2.triacTriggeTime = TRIAC_TRIGGE_TIME
//#define L2_EN_ON 				GPIO_WriteLow(L2_EN_PIN_PORT, L2_EN_PIN)

#define L2_EN_OFF 			GPIO_WriteHigh(L2_EN_PIN_PORT, L2_EN_PIN)
#define L2_EN_REVERSE		GPIO_WriteReverse(L2_EN_PIN_PORT, L2_EN_PIN)
#define L2_EN_STATUS      	    (GPIO_ReadOutputData(L2_EN_PIN_PORT) & L2_EN_PIN)


/*zero detect input gpio definition */
#define ZD_PIN_PORT          	GPIOD
#define ZD_PIN               	GPIO_PIN_3
#define ZD_STATUS      	    	(GPIO_ReadOutputData(ZD_PIN_PORT) & ZD_PIN)


/*wakeup input gpio definition*/
#define WAKEUP_PIN_PORT          	GPIOD
#define WAKEUP_PIN               		GPIO_PIN_4
#define WAKEUP_PIN_REVERSE		GPIO_WriteReverse(GPIOD, GPIO_PIN_4)
#define WAKEUP_STATUS      	    	(GPIO_ReadOutputData(WAKEUP_PIN_PORT) & WAKEUP_PIN)

/*UART1 gpio definition*/
#define TXD_PIN_PORT          		GPIOD
#define TXD_PIN               		GPIO_PIN_5
#define RXD_PIN_PORT          		GPIOD
#define RXD_PIN               		GPIO_PIN_6


/*the maximume brightness definition*/
#define MAX_BRIGHTNESS				(100) 

/*the light default brightness definition*/
#define DEFAULT_BRIGHTNESS			(0)


/*timer interrupt time is 40us@50Hz, 33us@60Hz, min is approximate 1us with dividing 16*/
#define TIMER2_INT_TIME_50HZ				(100) 
#define TIMER2_INT_TIME_60HZ				(83) 


/*timer interrupt time is approximate 50us, min is approximate 1us with dividing 16*/
/* 60hz = 167  50hz = 200，取180作为判断 */
#define HZ_COUNT						(180) //if hzCnt >=180 is 50Hz.
#define TIMER4_INT_TIME				(50) 

/*total detectiong 10 times zero crossing signal for getting the AC freqency*/
#define GET_AC_FRE_CNT				(10)

/*the count of checking 100ms if AC input*/
#define CHECK_AC_INPUT_CNT			(2000)  //2000 = 100ms/50us

/* traic trigge time definition as 2ms */
#define TRIAC_TRIGGE_TIME			(40)  //40 = 2ms/50us

/*1s count definition*/
#define CNT_1S						(20000)  //20000 = 1s/50us


/*UART baud rate definition*/
#define	COMM_BAUD_RATE  			(115200)

/*communication Head definition*/
#define COMM_HEAD					(0x55)

/*communication package maximume length definition*/
#define COMM_MAX_LEN				(6)  // 1 header + 1 length + 1 cmd + data + 2bytes crc



enum RSP_CMD
{
	RESET_DONE,
	AC_OK,	
	AC_ERR,
	RSP_RX_CMD_OK,
	UNKNOWN_CMD, 
	IS_RUNNING,
	CRC_ERR,	
	VAL_OVERFLOW
};

typedef struct
{  
	volatile uint8_t briCnt;    
	volatile uint8_t triacTriggeTime;    
	uint8_t briVal;	   
	volatile bool onFlag;
	
}Bri_TypeDef;


typedef struct
{
	Bri_TypeDef light1;
	Bri_TypeDef light2;
	
	volatile bool reqCalHzFlag;		/* 需要计算频率标志，还未计算出交流频率时强制需要  */
	volatile bool gotHzFlag;			/* 已经计算出频率标志 */
	volatile bool hz50Flag;			/* 交流电频率是50Hz标志 */
	volatile uint8_t calHzIntCnt;		/* 计算频率的周期变量，用于控制计算多少个交流周期，目前计算10个半周期 */
	volatile uint16_t hzCnt;			/* 计算频率的计数变量，用于在calHzIntCnt控制的交流周期内计数多少个50us的单位 */
	volatile uint16_t checkAcCnt;		/* 检测强电故障的计数 */
	volatile uint16_t cnt1s;			/* 正常运行时每1s的计时，暂无作用 */

	volatile bool acErrFlag;			/* 检测强电故障的辅助标志 */
	volatile bool acOkFlag;
	
	volatile bool startCtrlLightFlag;	
	volatile uint8_t rxIdx;
	volatile uint8_t rxBuf[COMM_MAX_LEN];
	volatile bool rxDone;
	
	
}Sys_TypeDef;


typedef struct
{
	u16 c_50ms;
	u16 f_50ms;	

	u8 c_100ms;
	u8 f_100ms;	

}tick_timer;




extern tick_timer tick;


extern Sys_TypeDef sys;

extern SLC slc;


extern volatile float last_bright1;
extern volatile float last_bright2;
extern volatile u8 realtime_bright1;
extern volatile u8 realtime_bright2;

extern volatile uint8_t channel;
extern volatile uint8_t channel1;
extern volatile uint8_t channel2;


extern volatile float aim_bright1;
extern volatile float aim_bright2;
extern volatile float change_step1;
extern volatile float change_step2;

/*****action dimmer用标志位********/
extern union FLAG action_flag;











/*functions declaration*/
static void Sys_Init(void);
static void GPIO_Config(void);
static void ExtInterrupt_Config(void);
void lightCtrl100ms(void);


void lightCtrl_50ms(void);

void mymemcpy(void *des, void *src, u32 n);


#ifdef _RAISONANCE_
	void Ext_PortD_ISR(void) interrupt 6;
#endif
#ifdef _COSMIC_ 
	@far @interrupt void Ext_PortD_ISR(void);
#endif

#ifdef ENABLE_WDT  
/*watchdog count period is 250ms*/
void Wdt_Init(void);
void FeedDog(void);
#endif

static void TIMER2_Init(void);

#ifdef _RAISONANCE_
void Timer2_ISR(void) interrupt 13;
#endif
#ifdef _COSMIC_
@far @interrupt void Timer2_ISR(void);
#endif



static void TIMER4_Init(void);
#ifdef _RAISONANCE_
void Timer4_ISR(void) interrupt 23;
#endif
#ifdef _COSMIC_
@far @interrupt void Timer4_ISR(void);
#endif





/*----------------------------------------------------------------------------
	初始化EEPROM
-----------------------------------------------------------------------------*/

#define EEPROM_INIT_FLAG				0x55

#define EEPROM_INIT_ADDRESS			0
#define EEPROM_DEVICEID_ADDRESS		1
#define EEPROM_MODEL_ADDRESS		11

#define EEPROM_FW_VERSION_ADDRESS	13
#define EEPROM_HW_VERSION_ADDRESS	15

#define EEPROM_BASH_ADDRESS			17


#define EEPROM_MANA_YEAR_ADDRESS	19
#define EEPROM_MANA_MONTH_ADDRESS	20
#define EEPROM_MANA_DAY_ADDRESS	21


#define EEPROM_CH1_STATUS_ADDRESS	45
#define EEPROM_CH2_STATUS_ADDRESS	46
#define EEPROM_CH3_STATUS_ADDRESS	47
#define EEPROM_CH4_STATUS_ADDRESS	48
















#endif /* __MAIN_H*/





/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
