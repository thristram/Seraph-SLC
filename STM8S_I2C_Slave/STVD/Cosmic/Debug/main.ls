   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               _sys:
   6  0000 00            	dc.b	0
   7  0001 000000        	ds.b	3
   8  0004 000000000000  	ds.b	25
  66                     ; 64 void delay(u16 Count)
  66                     ; 65 {
  68                     .text:	section	.text,new
  69  0000               _delay:
  71  0000 89            	pushw	x
  72  0001 89            	pushw	x
  73       00000002      OFST:	set	2
  76  0002 2014          	jra	L35
  77  0004               L15:
  78                     ; 69     for(i=0;i<100;i++)
  80  0004 0f01          	clr	(OFST-1,sp)
  81  0006               L75:
  82                     ; 70     for(j=0;j<50;j++);
  84  0006 0f02          	clr	(OFST+0,sp)
  85  0008               L56:
  89  0008 0c02          	inc	(OFST+0,sp)
  92  000a 7b02          	ld	a,(OFST+0,sp)
  93  000c a132          	cp	a,#50
  94  000e 25f8          	jrult	L56
  95                     ; 69     for(i=0;i<100;i++)
  97  0010 0c01          	inc	(OFST-1,sp)
 100  0012 7b01          	ld	a,(OFST-1,sp)
 101  0014 a164          	cp	a,#100
 102  0016 25ee          	jrult	L75
 103  0018               L35:
 104                     ; 67   while (Count--)//Count形参控制延时次数
 106  0018 1e03          	ldw	x,(OFST+1,sp)
 107  001a 1d0001        	subw	x,#1
 108  001d 1f03          	ldw	(OFST+1,sp),x
 109  001f 1c0001        	addw	x,#1
 110  0022 a30000        	cpw	x,#0
 111  0025 26dd          	jrne	L15
 112                     ; 72 }
 115  0027 5b04          	addw	sp,#4
 116  0029 81            	ret
 159                     ; 80 void main(void)
 159                     ; 81 {
 160                     .text:	section	.text,new
 161  0000               _main:
 165                     ; 86 	CLK->SWCR |= 0x02; //开启切换
 167  0000 721250c5      	bset	20677,#1
 168                     ; 87   CLK->SWR   = 0xb4;       //选择时钟为外部8M
 170  0004 35b450c4      	mov	20676,#180
 172  0008               L701:
 173                     ; 88   while((CLK->SWCR & 0x01)==0x01);
 175  0008 c650c5        	ld	a,20677
 176  000b a401          	and	a,#1
 177  000d a101          	cp	a,#1
 178  000f 27f7          	jreq	L701
 179                     ; 89   CLK->CKDIVR = 0x80;    //不分频
 181  0011 358050c6      	mov	20678,#128
 182                     ; 90   CLK->SWCR  &= ~0x02; //关闭切换
 184  0015 721350c5      	bres	20677,#1
 185                     ; 93 	slave_address = 0x00;
 187  0019 3f00          	clr	_slave_address
 188                     ; 94 	GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
 190  001b 4b00          	push	#0
 191  001d 4b04          	push	#4
 192  001f ae500f        	ldw	x,#20495
 193  0022 cd0000        	call	_GPIO_Init
 195  0025 85            	popw	x
 196                     ; 95 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);
 198  0026 4b00          	push	#0
 199  0028 4b80          	push	#128
 200  002a ae500a        	ldw	x,#20490
 201  002d cd0000        	call	_GPIO_Init
 203  0030 85            	popw	x
 204                     ; 96 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 206  0031 4b00          	push	#0
 207  0033 4b40          	push	#64
 208  0035 ae500a        	ldw	x,#20490
 209  0038 cd0000        	call	_GPIO_Init
 211  003b 85            	popw	x
 212                     ; 97 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 214  003c 4b00          	push	#0
 215  003e 4b40          	push	#64
 216  0040 ae500a        	ldw	x,#20490
 217  0043 cd0000        	call	_GPIO_Init
 219  0046 85            	popw	x
 220                     ; 98 	GPIO_Init(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
 222  0047 4b00          	push	#0
 223  0049 4b08          	push	#8
 224  004b ae5000        	ldw	x,#20480
 225  004e cd0000        	call	_GPIO_Init
 227  0051 85            	popw	x
 228                     ; 99 	delay(100);
 230  0052 ae0064        	ldw	x,#100
 231  0055 cd0000        	call	_delay
 233                     ; 101 	if(GPIO_ReadInputData(GPIOD) & 0x04)	slave_address |= 0x08;
 235  0058 ae500f        	ldw	x,#20495
 236  005b cd0000        	call	_GPIO_ReadInputData
 238  005e a504          	bcp	a,#4
 239  0060 2704          	jreq	L311
 242  0062 72160000      	bset	_slave_address,#3
 243  0066               L311:
 244                     ; 102 	if(GPIO_ReadInputData(GPIOC) & 0x20)	slave_address |= 0x04;
 246  0066 ae500a        	ldw	x,#20490
 247  0069 cd0000        	call	_GPIO_ReadInputData
 249  006c a520          	bcp	a,#32
 250  006e 2704          	jreq	L511
 253  0070 72140000      	bset	_slave_address,#2
 254  0074               L511:
 255                     ; 103 	if(GPIO_ReadInputData(GPIOC) & 0x40)	slave_address |= 0x02;
 257  0074 ae500a        	ldw	x,#20490
 258  0077 cd0000        	call	_GPIO_ReadInputData
 260  007a a540          	bcp	a,#64
 261  007c 2704          	jreq	L711
 264  007e 72120000      	bset	_slave_address,#1
 265  0082               L711:
 266                     ; 104 	if(GPIO_ReadInputData(GPIOC) & 0x80)	slave_address |= 0x01;
 268  0082 ae500a        	ldw	x,#20490
 269  0085 cd0000        	call	_GPIO_ReadInputData
 271  0088 a580          	bcp	a,#128
 272  008a 2704          	jreq	L121
 275  008c 72100000      	bset	_slave_address,#0
 276  0090               L121:
 277                     ; 105 	slc.MDID = slave_address;
 279  0090 b600          	ld	a,_slave_address
 280  0092 5f            	clrw	x
 281  0093 97            	ld	xl,a
 282  0094 bf13          	ldw	_slc+19,x
 283                     ; 106 	GPIO_Config();
 285  0096 cd0000        	call	L5_GPIO_Config
 287                     ; 107 	Sys_Init();
 289  0099 cd0000        	call	L3_Sys_Init
 291                     ; 108 	ExtInterrupt_Config();
 293  009c cd0000        	call	L7_ExtInterrupt_Config
 295                     ; 109 	TIMER4_Init();
 297  009f cd0000        	call	L31_TIMER4_Init
 299                     ; 116 	IIC_SlaveConfig();
 301  00a2 cd0000        	call	_IIC_SlaveConfig
 303                     ; 119 	enableInterrupts();
 306  00a5 9a            rim
 308                     ; 152 	 sys.acOkFlag = TRUE;
 311  00a6 35010011      	mov	_sys+17,#1
 312                     ; 153 	 TIMER2_Init();
 314  00aa cd0000        	call	L11_TIMER2_Init
 316  00ad               L321:
 317                     ; 170 		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE)
 319  00ad be0e          	ldw	x,_sys+14
 320  00af 260a          	jrne	L721
 322  00b1 3d10          	tnz	_sys+16
 323  00b3 2606          	jrne	L721
 324                     ; 174 			 sys.acErrFlag = TRUE;
 326  00b5 35010010      	mov	_sys+16,#1
 327                     ; 175 			 sys.acOkFlag = FALSE;
 329  00b9 3f11          	clr	_sys+17
 330  00bb               L721:
 331                     ; 178 		if (sys.acErrFlag == FALSE && sys.acOkFlag == FALSE)
 333  00bb 3d10          	tnz	_sys+16
 334  00bd 260d          	jrne	L131
 336  00bf 3d11          	tnz	_sys+17
 337  00c1 2609          	jrne	L131
 338                     ; 182 			sys.acOkFlag = TRUE;
 340  00c3 35010011      	mov	_sys+17,#1
 341                     ; 183 			sys.cnt1s = CNT_1S;
 343  00c7 ae4e20        	ldw	x,#20000
 344  00ca bf1b          	ldw	_sys+27,x
 345  00cc               L131:
 346                     ; 186 		if(f_100ms){
 348  00cc 3d01          	tnz	_f_100ms
 349  00ce 2705          	jreq	L331
 350                     ; 187 			f_100ms = 0;
 352  00d0 3f01          	clr	_f_100ms
 353                     ; 188 			lightCtrl100ms();
 355  00d2 cd0000        	call	_lightCtrl100ms
 357  00d5               L331:
 358                     ; 200 		if((channel & 0x01)==0x01)//调节Dimmer1
 360  00d5 b600          	ld	a,_channel
 361  00d7 a401          	and	a,#1
 362  00d9 a101          	cp	a,#1
 363  00db 2616          	jrne	L531
 364                     ; 202 			sys.light1.briVal = realtime_bright1;
 366  00dd 450502        	mov	_sys+2,_realtime_bright1
 367                     ; 203 			slc.ch1_status = (u8)(last_bright1*100);
 369  00e0 ae000a        	ldw	x,#_last_bright1
 370  00e3 cd0000        	call	c_ltor
 372  00e6 ae0014        	ldw	x,#L341
 373  00e9 cd0000        	call	c_fmul
 375  00ec cd0000        	call	c_ftol
 377  00ef b603          	ld	a,c_lreg+3
 378  00f1 b715          	ld	_slc+21,a
 379  00f3               L531:
 380                     ; 205 		if((channel & 0x02)==0x02)//调节Dimmer2
 382  00f3 b600          	ld	a,_channel
 383  00f5 a402          	and	a,#2
 384  00f7 a102          	cp	a,#2
 385  00f9 2616          	jrne	L741
 386                     ; 207 			sys.light2.briVal = realtime_bright2;
 388  00fb 450406        	mov	_sys+6,_realtime_bright2
 389                     ; 208 			slc.ch2_status = (u8)(last_bright2*100);
 391  00fe ae0006        	ldw	x,#_last_bright2
 392  0101 cd0000        	call	c_ltor
 394  0104 ae0014        	ldw	x,#L341
 395  0107 cd0000        	call	c_fmul
 397  010a cd0000        	call	c_ftol
 399  010d b603          	ld	a,c_lreg+3
 400  010f b716          	ld	_slc+22,a
 401  0111               L741:
 402                     ; 210 		if (sys.acOkFlag && sys.cnt1s == 0)
 404  0111 3d11          	tnz	_sys+17
 405  0113 2798          	jreq	L321
 407  0115 be1b          	ldw	x,_sys+27
 408  0117 2694          	jrne	L321
 409                     ; 215 			sys.cnt1s = CNT_1S;
 411  0119 ae4e20        	ldw	x,#20000
 412  011c bf1b          	ldw	_sys+27,x
 413  011e 208d          	jra	L321
 448                     ; 229 void assert_failed(uint8_t* file, uint32_t line)
 448                     ; 230 { 
 449                     .text:	section	.text,new
 450  0000               _assert_failed:
 454  0000               L171:
 455  0000 20fe          	jra	L171
 480                     ; 241 static void GPIO_Config(void)
 480                     ; 242 {
 481                     .text:	section	.text,new
 482  0000               L5_GPIO_Config:
 486                     ; 244     GPIO_Init(L1_EN_PIN_PORT, (GPIO_Pin_TypeDef)L1_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
 488  0000 4bd0          	push	#208
 489  0002 4b10          	push	#16
 490  0004 ae500a        	ldw	x,#20490
 491  0007 cd0000        	call	_GPIO_Init
 493  000a 85            	popw	x
 494                     ; 245     GPIO_Init(L2_EN_PIN_PORT, (GPIO_Pin_TypeDef)L2_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);   
 496  000b 4bd0          	push	#208
 497  000d 4b08          	push	#8
 498  000f ae500a        	ldw	x,#20490
 499  0012 cd0000        	call	_GPIO_Init
 501  0015 85            	popw	x
 502                     ; 246     L1_EN_OFF;
 504  0016 4b10          	push	#16
 505  0018 ae500a        	ldw	x,#20490
 506  001b cd0000        	call	_GPIO_WriteHigh
 508  001e 84            	pop	a
 509                     ; 247     L2_EN_OFF;
 511  001f 4b08          	push	#8
 512  0021 ae500a        	ldw	x,#20490
 513  0024 cd0000        	call	_GPIO_WriteHigh
 515  0027 84            	pop	a
 516                     ; 248     GPIO_Init(ZD_PIN_PORT, (GPIO_Pin_TypeDef)ZD_PIN, GPIO_MODE_IN_FL_IT);  
 518  0028 4b20          	push	#32
 519  002a 4b08          	push	#8
 520  002c ae500f        	ldw	x,#20495
 521  002f cd0000        	call	_GPIO_Init
 523  0032 85            	popw	x
 524                     ; 250 }
 527  0033 81            	ret
 556                     ; 252 static void Sys_Init(void)
 556                     ; 253 {
 557                     .text:	section	.text,new
 558  0000               L3_Sys_Init:
 562                     ; 254     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 564  0000 ae0001        	ldw	x,#1
 565  0003 a604          	ld	a,#4
 566  0005 95            	ld	xh,a
 567  0006 cd0000        	call	_CLK_PeripheralClockConfig
 569                     ; 255     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 571  0009 ae0001        	ldw	x,#1
 572  000c a605          	ld	a,#5
 573  000e 95            	ld	xh,a
 574  000f cd0000        	call	_CLK_PeripheralClockConfig
 576                     ; 257     sys.gotHzFlag = FALSE;    
 578  0012 3f09          	clr	_sys+9
 579                     ; 258     sys.reqCalHzFlag = FALSE;
 581  0014 3f08          	clr	_sys+8
 582                     ; 259     sys.light1.briVal = DEFAULT_BRIGHTNESS;
 584  0016 35280002      	mov	_sys+2,#40
 585                     ; 260     sys.light2.briVal = DEFAULT_BRIGHTNESS;    
 587  001a 35280006      	mov	_sys+6,#40
 588                     ; 261     sys.calHzIntCnt = GET_AC_FRE_CNT;
 590  001e 350a000b      	mov	_sys+11,#10
 591                     ; 262     sys.hzCnt = 0;
 593  0022 5f            	clrw	x
 594  0023 bf0c          	ldw	_sys+12,x
 595                     ; 263     sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 597  0025 ae07d0        	ldw	x,#2000
 598  0028 bf0e          	ldw	_sys+14,x
 599                     ; 264 		last_bright1 = 0.16;
 601  002a ce0012        	ldw	x,L122+2
 602  002d bf0c          	ldw	_last_bright1+2,x
 603  002f ce0010        	ldw	x,L122
 604  0032 bf0a          	ldw	_last_bright1,x
 605                     ; 265 		aim_bright1 = 0;
 607  0034 ae0000        	ldw	x,#0
 608  0037 bf02          	ldw	_aim_bright1+2,x
 609  0039 ae0000        	ldw	x,#0
 610  003c bf00          	ldw	_aim_bright1,x
 611                     ; 266 		last_bright2 = 0.16;
 613  003e ce0012        	ldw	x,L122+2
 614  0041 bf08          	ldw	_last_bright2+2,x
 615  0043 ce0010        	ldw	x,L122
 616  0046 bf06          	ldw	_last_bright2,x
 617                     ; 267 		aim_bright2 = 0;
 619  0048 ae0000        	ldw	x,#0
 620  004b bf02          	ldw	_aim_bright2+2,x
 621  004d ae0000        	ldw	x,#0
 622  0050 bf00          	ldw	_aim_bright2,x
 623                     ; 268 }
 626  0052 81            	ret
 652                     ; 270 static void ExtInterrupt_Config(void)
 652                     ; 271 {
 653                     .text:	section	.text,new
 654  0000               L7_ExtInterrupt_Config:
 658                     ; 273 	EXTI_DeInit();
 660  0000 cd0000        	call	_EXTI_DeInit
 662                     ; 274 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 664  0003 ae0002        	ldw	x,#2
 665  0006 a603          	ld	a,#3
 666  0008 95            	ld	xh,a
 667  0009 cd0000        	call	_EXTI_SetExtIntSensitivity
 669                     ; 276 }
 672  000c 81            	ret
 702                     ; 282 @far @interrupt void Ext_PortD_ISR(void) {
 704                     .text:	section	.text,new
 705  0000               f_Ext_PortD_ISR:
 708  0000 3b0002        	push	c_x+2
 709  0003 be00          	ldw	x,c_x
 710  0005 89            	pushw	x
 711  0006 3b0002        	push	c_y+2
 712  0009 be00          	ldw	x,c_y
 713  000b 89            	pushw	x
 716                     ; 285 	if (ZD_STATUS == 0)
 718  000c ae500f        	ldw	x,#20495
 719  000f cd0000        	call	_GPIO_ReadOutputData
 721  0012 a508          	bcp	a,#8
 722  0014 2704          	jreq	L62
 723  0016 acc800c8      	jpf	L542
 724  001a               L62:
 725                     ; 287 		sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 727  001a ae07d0        	ldw	x,#2000
 728  001d bf0e          	ldw	_sys+14,x
 729                     ; 288 		sys.acErrFlag = FALSE;
 731  001f 3f10          	clr	_sys+16
 732                     ; 291 		if (!sys.gotHzFlag)
 734  0021 3d09          	tnz	_sys+9
 735  0023 262f          	jrne	L742
 736                     ; 293 			if (!sys.reqCalHzFlag)
 738  0025 3d08          	tnz	_sys+8
 739  0027 2609          	jrne	L152
 740                     ; 295 				TIM4_SetAutoreload(TIMER4_INT_TIME);				
 742  0029 a632          	ld	a,#50
 743  002b cd0000        	call	_TIM4_SetAutoreload
 745                     ; 296 				sys.reqCalHzFlag = TRUE;
 747  002e 35010008      	mov	_sys+8,#1
 748  0032               L152:
 749                     ; 298 			if (sys.calHzIntCnt == 0)
 751  0032 3d0b          	tnz	_sys+11
 752  0034 261a          	jrne	L352
 753                     ; 300 				if ((sys.hzCnt/GET_AC_FRE_CNT) >= HZ_COUNT)
 755  0036 be0c          	ldw	x,_sys+12
 756  0038 a60a          	ld	a,#10
 757  003a 62            	div	x,a
 758  003b a300b4        	cpw	x,#180
 759  003e 2506          	jrult	L552
 760                     ; 302 					sys.hz50Flag = TRUE;
 762  0040 3501000a      	mov	_sys+10,#1
 764  0044 2002          	jra	L752
 765  0046               L552:
 766                     ; 306 					sys.hz50Flag = FALSE;
 768  0046 3f0a          	clr	_sys+10
 769  0048               L752:
 770                     ; 309 				sys.gotHzFlag = TRUE;
 772  0048 35010009      	mov	_sys+9,#1
 773                     ; 310 				sys.reqCalHzFlag = FALSE;
 775  004c 3f08          	clr	_sys+8
 777  004e 2078          	jra	L542
 778  0050               L352:
 779                     ; 314 				sys.calHzIntCnt--;
 781  0050 3a0b          	dec	_sys+11
 782  0052 2074          	jra	L542
 783  0054               L742:
 784                     ; 319 			if (sys.light1.briVal == MAX_BRIGHTNESS)
 786  0054 b602          	ld	a,_sys+2
 787  0056 a1fa          	cp	a,#250
 788  0058 2615          	jrne	L562
 789                     ; 323 				L1_EN_ON;
 791  005a 4b10          	push	#16
 792  005c ae500a        	ldw	x,#20490
 793  005f cd0000        	call	_GPIO_WriteLow
 795  0062 84            	pop	a
 798  0063 35280001      	mov	_sys+1,#40
 799                     ; 324 				sys.light1.briCnt = 0;
 801  0067 3f00          	clr	_sys
 802                     ; 325 				sys.light1.onFlag = TRUE;			
 804  0069 35010003      	mov	_sys+3,#1
 806  006d 2011          	jra	L762
 807  006f               L562:
 808                     ; 330 				sys.light1.briCnt = MAX_BRIGHTNESS - sys.light1.briVal;				
 810  006f a6fa          	ld	a,#250
 811  0071 b002          	sub	a,_sys+2
 812  0073 b700          	ld	_sys,a
 813                     ; 331 				sys.light1.onFlag = FALSE;
 815  0075 3f03          	clr	_sys+3
 816                     ; 332 				L1_EN_OFF;
 818  0077 4b10          	push	#16
 819  0079 ae500a        	ldw	x,#20490
 820  007c cd0000        	call	_GPIO_WriteHigh
 822  007f 84            	pop	a
 823  0080               L762:
 824                     ; 335 			if (sys.light2.briVal == MAX_BRIGHTNESS)
 826  0080 b606          	ld	a,_sys+6
 827  0082 a1fa          	cp	a,#250
 828  0084 2615          	jrne	L172
 829                     ; 337 				L2_EN_ON;
 831  0086 4b08          	push	#8
 832  0088 ae500a        	ldw	x,#20490
 833  008b cd0000        	call	_GPIO_WriteLow
 835  008e 84            	pop	a
 838  008f 35280005      	mov	_sys+5,#40
 839                     ; 338 				sys.light2.briCnt = 0;
 841  0093 3f04          	clr	_sys+4
 842                     ; 339 				sys.light2.onFlag = TRUE;			
 844  0095 35010007      	mov	_sys+7,#1
 846  0099 2011          	jra	L372
 847  009b               L172:
 848                     ; 343 				sys.light2.briCnt = MAX_BRIGHTNESS - sys.light2.briVal;
 850  009b a6fa          	ld	a,#250
 851  009d b006          	sub	a,_sys+6
 852  009f b704          	ld	_sys+4,a
 853                     ; 344 				sys.light2.onFlag = FALSE;				
 855  00a1 3f07          	clr	_sys+7
 856                     ; 345 				L2_EN_OFF;
 858  00a3 4b08          	push	#8
 859  00a5 ae500a        	ldw	x,#20490
 860  00a8 cd0000        	call	_GPIO_WriteHigh
 862  00ab 84            	pop	a
 863  00ac               L372:
 864                     ; 348 			if (sys.light1.briCnt || sys.light2.briCnt)
 866  00ac 3d00          	tnz	_sys
 867  00ae 2604          	jrne	L772
 869  00b0 3d04          	tnz	_sys+4
 870  00b2 2714          	jreq	L542
 871  00b4               L772:
 872                     ; 351 				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
 874  00b4 3d0a          	tnz	_sys+10
 875  00b6 2705          	jreq	L22
 876  00b8 ae0028        	ldw	x,#40
 877  00bb 2003          	jra	L42
 878  00bd               L22:
 879  00bd ae0021        	ldw	x,#33
 880  00c0               L42:
 881  00c0 cd0000        	call	_TIM2_SetAutoreload
 883                     ; 352 				TIM2_Cmd(ENABLE);
 885  00c3 a601          	ld	a,#1
 886  00c5 cd0000        	call	_TIM2_Cmd
 888  00c8               L542:
 889                     ; 356 }
 892  00c8 85            	popw	x
 893  00c9 bf00          	ldw	c_y,x
 894  00cb 320002        	pop	c_y+2
 895  00ce 85            	popw	x
 896  00cf bf00          	ldw	c_x,x
 897  00d1 320002        	pop	c_x+2
 898  00d4 80            	iret
 924                     ; 376 static void TIMER4_Init(void)
 924                     ; 377 {    
 926                     .text:	section	.text,new
 927  0000               L31_TIMER4_Init:
 931                     ; 378     TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIMER4_INT_TIME);
 933  0000 ae0032        	ldw	x,#50
 934  0003 a604          	ld	a,#4
 935  0005 95            	ld	xh,a
 936  0006 cd0000        	call	_TIM4_TimeBaseInit
 938                     ; 379     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 940  0009 a601          	ld	a,#1
 941  000b cd0000        	call	_TIM4_ClearFlag
 943                     ; 380     TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);	
 945  000e ae0001        	ldw	x,#1
 946  0011 a601          	ld	a,#1
 947  0013 95            	ld	xh,a
 948  0014 cd0000        	call	_TIM4_ITConfig
 950                     ; 381     TIM4_Cmd(ENABLE);
 952  0017 a601          	ld	a,#1
 953  0019 cd0000        	call	_TIM4_Cmd
 955                     ; 382 }
 958  001c 81            	ret
 986                     ; 388 @far @interrupt void Timer4_ISR(void) {
 988                     .text:	section	.text,new
 989  0000               f_Timer4_ISR:
 992  0000 3b0002        	push	c_x+2
 993  0003 be00          	ldw	x,c_x
 994  0005 89            	pushw	x
 995  0006 3b0002        	push	c_y+2
 996  0009 be00          	ldw	x,c_y
 997  000b 89            	pushw	x
1000                     ; 390 TIM4_ClearITPendingBit(TIM4_IT_UPDATE);  
1002  000c a601          	ld	a,#1
1003  000e cd0000        	call	_TIM4_ClearITPendingBit
1005                     ; 391   if (sys.reqCalHzFlag)
1007  0011 3d08          	tnz	_sys+8
1008  0013 2707          	jreq	L123
1009                     ; 393 	  sys.hzCnt++; 	  
1011  0015 be0c          	ldw	x,_sys+12
1012  0017 1c0001        	addw	x,#1
1013  001a bf0c          	ldw	_sys+12,x
1014  001c               L123:
1015                     ; 396   if (sys.light1.triacTriggeTime)
1017  001c 3d01          	tnz	_sys+1
1018  001e 270f          	jreq	L323
1019                     ; 398 	  sys.light1.triacTriggeTime--;
1021  0020 3a01          	dec	_sys+1
1022                     ; 399 	  if (sys.light1.triacTriggeTime == 0)
1024  0022 3d01          	tnz	_sys+1
1025  0024 2609          	jrne	L323
1026                     ; 401 		  L1_EN_OFF;
1028  0026 4b10          	push	#16
1029  0028 ae500a        	ldw	x,#20490
1030  002b cd0000        	call	_GPIO_WriteHigh
1032  002e 84            	pop	a
1033  002f               L323:
1034                     ; 406   if (sys.light2.triacTriggeTime)
1036  002f 3d05          	tnz	_sys+5
1037  0031 270f          	jreq	L723
1038                     ; 408 	  sys.light2.triacTriggeTime--;
1040  0033 3a05          	dec	_sys+5
1041                     ; 409 	  if (sys.light2.triacTriggeTime == 0)
1043  0035 3d05          	tnz	_sys+5
1044  0037 2609          	jrne	L723
1045                     ; 411 		  L2_EN_OFF;
1047  0039 4b08          	push	#8
1048  003b ae500a        	ldw	x,#20490
1049  003e cd0000        	call	_GPIO_WriteHigh
1051  0041 84            	pop	a
1052  0042               L723:
1053                     ; 415   if (sys.checkAcCnt)
1055  0042 be0e          	ldw	x,_sys+14
1056  0044 2707          	jreq	L333
1057                     ; 417 		sys.checkAcCnt--;
1059  0046 be0e          	ldw	x,_sys+14
1060  0048 1d0001        	subw	x,#1
1061  004b bf0e          	ldw	_sys+14,x
1062  004d               L333:
1063                     ; 420   if (sys.cnt1s)
1065  004d be1b          	ldw	x,_sys+27
1066  004f 2707          	jreq	L533
1067                     ; 422 		sys.cnt1s--;
1069  0051 be1b          	ldw	x,_sys+27
1070  0053 1d0001        	subw	x,#1
1071  0056 bf1b          	ldw	_sys+27,x
1072  0058               L533:
1073                     ; 424 	Tick100ms++;
1075  0058 be02          	ldw	x,_Tick100ms
1076  005a 1c0001        	addw	x,#1
1077  005d bf02          	ldw	_Tick100ms,x
1078                     ; 425 	if(Tick100ms >= 2000){
1080  005f be02          	ldw	x,_Tick100ms
1081  0061 a307d0        	cpw	x,#2000
1082  0064 2507          	jrult	L733
1083                     ; 426 		Tick100ms = 0;
1085  0066 5f            	clrw	x
1086  0067 bf02          	ldw	_Tick100ms,x
1087                     ; 427 		f_100ms = 1;
1089  0069 35010001      	mov	_f_100ms,#1
1090  006d               L733:
1091                     ; 429 }
1094  006d 85            	popw	x
1095  006e bf00          	ldw	c_y,x
1096  0070 320002        	pop	c_y+2
1097  0073 85            	popw	x
1098  0074 bf00          	ldw	c_x,x
1099  0076 320002        	pop	c_x+2
1100  0079 80            	iret
1126                     ; 431 static void TIMER2_Init(void)
1126                     ; 432 {    
1128                     .text:	section	.text,new
1129  0000               L11_TIMER2_Init:
1133                     ; 433 	TIM2_TimeBaseInit(TIM2_PRESCALER_16, sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
1135  0000 3d0a          	tnz	_sys+10
1136  0002 2705          	jreq	L63
1137  0004 ae0028        	ldw	x,#40
1138  0007 2003          	jra	L04
1139  0009               L63:
1140  0009 ae0021        	ldw	x,#33
1141  000c               L04:
1142  000c 89            	pushw	x
1143  000d a604          	ld	a,#4
1144  000f cd0000        	call	_TIM2_TimeBaseInit
1146  0012 85            	popw	x
1147                     ; 434    	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
1149  0013 ae0001        	ldw	x,#1
1150  0016 cd0000        	call	_TIM2_ClearFlag
1152                     ; 435    	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	   
1154  0019 ae0001        	ldw	x,#1
1155  001c a601          	ld	a,#1
1156  001e 95            	ld	xh,a
1157  001f cd0000        	call	_TIM2_ITConfig
1159                     ; 436 }
1162  0022 81            	ret
1189                     ; 442 @far @interrupt void Timer2_ISR(void) {
1191                     .text:	section	.text,new
1192  0000               f_Timer2_ISR:
1195  0000 3b0002        	push	c_x+2
1196  0003 be00          	ldw	x,c_x
1197  0005 89            	pushw	x
1198  0006 3b0002        	push	c_y+2
1199  0009 be00          	ldw	x,c_y
1200  000b 89            	pushw	x
1203                     ; 444 	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);  
1205  000c a601          	ld	a,#1
1206  000e cd0000        	call	_TIM2_ClearITPendingBit
1208                     ; 445 	if (sys.light1.briCnt) 
1210  0011 3d00          	tnz	_sys
1211  0013 2702          	jreq	L163
1212                     ; 447 		sys.light1.briCnt--;			
1214  0015 3a00          	dec	_sys
1215  0017               L163:
1216                     ; 449 	if (sys.light1.briCnt == 0 && !sys.light1.onFlag)
1218  0017 3d00          	tnz	_sys
1219  0019 2615          	jrne	L363
1221  001b 3d03          	tnz	_sys+3
1222  001d 2611          	jrne	L363
1223                     ; 451 		L1_EN_ON;
1225  001f 4b10          	push	#16
1226  0021 ae500a        	ldw	x,#20490
1227  0024 cd0000        	call	_GPIO_WriteLow
1229  0027 84            	pop	a
1232  0028 35280001      	mov	_sys+1,#40
1233                     ; 452 		sys.light1.onFlag = TRUE;
1235  002c 35010003      	mov	_sys+3,#1
1236  0030               L363:
1237                     ; 456 	if (sys.light2.briCnt) 
1239  0030 3d04          	tnz	_sys+4
1240  0032 2702          	jreq	L563
1241                     ; 458 		sys.light2.briCnt--;		
1243  0034 3a04          	dec	_sys+4
1244  0036               L563:
1245                     ; 460 	if (sys.light2.briCnt == 0 && !sys.light2.onFlag)
1247  0036 3d04          	tnz	_sys+4
1248  0038 2615          	jrne	L763
1250  003a 3d07          	tnz	_sys+7
1251  003c 2611          	jrne	L763
1252                     ; 462 		L2_EN_ON;
1254  003e 4b08          	push	#8
1255  0040 ae500a        	ldw	x,#20490
1256  0043 cd0000        	call	_GPIO_WriteLow
1258  0046 84            	pop	a
1261  0047 35280005      	mov	_sys+5,#40
1262                     ; 463 		sys.light2.onFlag = TRUE;
1264  004b 35010007      	mov	_sys+7,#1
1265  004f               L763:
1266                     ; 466 	if ((sys.light1.briCnt ||  sys.light2.briCnt) == 0)
1268  004f 3d00          	tnz	_sys
1269  0051 2604          	jrne	L64
1270  0053 3d04          	tnz	_sys+4
1271  0055 2705          	jreq	L44
1272  0057               L64:
1273  0057 ae0001        	ldw	x,#1
1274  005a 2001          	jra	L05
1275  005c               L44:
1276  005c 5f            	clrw	x
1277  005d               L05:
1278  005d a30000        	cpw	x,#0
1279  0060 2604          	jrne	L173
1280                     ; 468 		TIM2_Cmd(DISABLE);
1282  0062 4f            	clr	a
1283  0063 cd0000        	call	_TIM2_Cmd
1285  0066               L173:
1286                     ; 470 }
1289  0066 85            	popw	x
1290  0067 bf00          	ldw	c_y,x
1291  0069 320002        	pop	c_y+2
1292  006c 85            	popw	x
1293  006d bf00          	ldw	c_x,x
1294  006f 320002        	pop	c_x+2
1295  0072 80            	iret
1328                     ; 472 u8 Linear(float t)
1328                     ; 473 {
1330                     .text:	section	.text,new
1331  0000               _Linear:
1333  0000 5204          	subw	sp,#4
1334       00000004      OFST:	set	4
1337                     ; 474 	if((t >= 0)&&(t <=1))
1339  0002 9c            	rvf
1340  0003 0d07          	tnz	(OFST+3,sp)
1341  0005 2f31          	jrslt	L114
1343  0007 9c            	rvf
1344  0008 a601          	ld	a,#1
1345  000a cd0000        	call	c_ctof
1347  000d 96            	ldw	x,sp
1348  000e 1c0001        	addw	x,#OFST-3
1349  0011 cd0000        	call	c_rtol
1351  0014 96            	ldw	x,sp
1352  0015 1c0007        	addw	x,#OFST+3
1353  0018 cd0000        	call	c_ltor
1355  001b 96            	ldw	x,sp
1356  001c 1c0001        	addw	x,#OFST-3
1357  001f cd0000        	call	c_fcmp
1359  0022 2c14          	jrsgt	L114
1360                     ; 475 		return (u8)(t*250);
1362  0024 96            	ldw	x,sp
1363  0025 1c0007        	addw	x,#OFST+3
1364  0028 cd0000        	call	c_ltor
1366  002b ae000c        	ldw	x,#L714
1367  002e cd0000        	call	c_fmul
1369  0031 cd0000        	call	c_ftol
1371  0034 b603          	ld	a,c_lreg+3
1373  0036 2002          	jra	L45
1374  0038               L114:
1375                     ; 477 		return 40;
1377  0038 a628          	ld	a,#40
1379  003a               L45:
1381  003a 5b04          	addw	sp,#4
1382  003c 81            	ret
1416                     ; 479 u8 EraseIn(float t)
1416                     ; 480 {
1417                     .text:	section	.text,new
1418  0000               _EraseIn:
1420  0000 5204          	subw	sp,#4
1421       00000004      OFST:	set	4
1424                     ; 481 	if((t >= 0)&&(t <=1))
1426  0002 9c            	rvf
1427  0003 0d07          	tnz	(OFST+3,sp)
1428  0005 2f38          	jrslt	L344
1430  0007 9c            	rvf
1431  0008 a601          	ld	a,#1
1432  000a cd0000        	call	c_ctof
1434  000d 96            	ldw	x,sp
1435  000e 1c0001        	addw	x,#OFST-3
1436  0011 cd0000        	call	c_rtol
1438  0014 96            	ldw	x,sp
1439  0015 1c0007        	addw	x,#OFST+3
1440  0018 cd0000        	call	c_ltor
1442  001b 96            	ldw	x,sp
1443  001c 1c0001        	addw	x,#OFST-3
1444  001f cd0000        	call	c_fcmp
1446  0022 2c1b          	jrsgt	L344
1447                     ; 482 		return (u8)(t*t*250);
1449  0024 96            	ldw	x,sp
1450  0025 1c0007        	addw	x,#OFST+3
1451  0028 cd0000        	call	c_ltor
1453  002b 96            	ldw	x,sp
1454  002c 1c0007        	addw	x,#OFST+3
1455  002f cd0000        	call	c_fmul
1457  0032 ae000c        	ldw	x,#L714
1458  0035 cd0000        	call	c_fmul
1460  0038 cd0000        	call	c_ftol
1462  003b b603          	ld	a,c_lreg+3
1464  003d 2002          	jra	L06
1465  003f               L344:
1466                     ; 484 		return 40;
1468  003f a628          	ld	a,#40
1470  0041               L06:
1472  0041 5b04          	addw	sp,#4
1473  0043 81            	ret
1507                     ; 486 u8 EraseOut(float t)
1507                     ; 487 {
1508                     .text:	section	.text,new
1509  0000               _EraseOut:
1511  0000 5204          	subw	sp,#4
1512       00000004      OFST:	set	4
1515                     ; 488 	if((t >= 0)&&(t <=1))
1517  0002 9c            	rvf
1518  0003 0d07          	tnz	(OFST+3,sp)
1519  0005 2f3d          	jrslt	L564
1521  0007 9c            	rvf
1522  0008 a601          	ld	a,#1
1523  000a cd0000        	call	c_ctof
1525  000d 96            	ldw	x,sp
1526  000e 1c0001        	addw	x,#OFST-3
1527  0011 cd0000        	call	c_rtol
1529  0014 96            	ldw	x,sp
1530  0015 1c0007        	addw	x,#OFST+3
1531  0018 cd0000        	call	c_ltor
1533  001b 96            	ldw	x,sp
1534  001c 1c0001        	addw	x,#OFST-3
1535  001f cd0000        	call	c_fcmp
1537  0022 2c20          	jrsgt	L564
1538                     ; 489 		return (u8)((2-t)*t*250);
1540  0024 a602          	ld	a,#2
1541  0026 cd0000        	call	c_ctof
1543  0029 96            	ldw	x,sp
1544  002a 1c0007        	addw	x,#OFST+3
1545  002d cd0000        	call	c_fsub
1547  0030 96            	ldw	x,sp
1548  0031 1c0007        	addw	x,#OFST+3
1549  0034 cd0000        	call	c_fmul
1551  0037 ae000c        	ldw	x,#L714
1552  003a cd0000        	call	c_fmul
1554  003d cd0000        	call	c_ftol
1556  0040 b603          	ld	a,c_lreg+3
1558  0042 2002          	jra	L46
1559  0044               L564:
1560                     ; 491 		return 40;
1562  0044 a628          	ld	a,#40
1564  0046               L46:
1566  0046 5b04          	addw	sp,#4
1567  0048 81            	ret
1601                     ; 493 u8 Swing(float t)
1601                     ; 494 {
1602                     .text:	section	.text,new
1603  0000               _Swing:
1605  0000 5204          	subw	sp,#4
1606       00000004      OFST:	set	4
1609                     ; 495 	if((t >= 0)&&(t <=1)){
1611  0002 9c            	rvf
1612  0003 0d07          	tnz	(OFST+3,sp)
1613  0005 2e03          	jrsge	L27
1614  0007 cc0093        	jp	L705
1615  000a               L27:
1617  000a 9c            	rvf
1618  000b a601          	ld	a,#1
1619  000d cd0000        	call	c_ctof
1621  0010 96            	ldw	x,sp
1622  0011 1c0001        	addw	x,#OFST-3
1623  0014 cd0000        	call	c_rtol
1625  0017 96            	ldw	x,sp
1626  0018 1c0007        	addw	x,#OFST+3
1627  001b cd0000        	call	c_ltor
1629  001e 96            	ldw	x,sp
1630  001f 1c0001        	addw	x,#OFST-3
1631  0022 cd0000        	call	c_fcmp
1633  0025 2c6c          	jrsgt	L705
1634                     ; 496 		if(t < 0.5)
1636  0027 9c            	rvf
1637  0028 96            	ldw	x,sp
1638  0029 1c0007        	addw	x,#OFST+3
1639  002c cd0000        	call	c_ltor
1641  002f ae0008        	ldw	x,#L715
1642  0032 cd0000        	call	c_fcmp
1644  0035 2e21          	jrsge	L115
1645                     ; 497 			return (u8)(2*t*t*250);
1647  0037 96            	ldw	x,sp
1648  0038 1c0007        	addw	x,#OFST+3
1649  003b cd0000        	call	c_ltor
1651  003e ae0004        	ldw	x,#L725
1652  0041 cd0000        	call	c_fmul
1654  0044 96            	ldw	x,sp
1655  0045 1c0007        	addw	x,#OFST+3
1656  0048 cd0000        	call	c_fmul
1658  004b ae000c        	ldw	x,#L714
1659  004e cd0000        	call	c_fmul
1661  0051 cd0000        	call	c_ftol
1663  0054 b603          	ld	a,c_lreg+3
1665  0056 2038          	jra	L07
1666  0058               L115:
1667                     ; 499 			return (u8)(((4-2*t)*t - 1)*250);
1669  0058 96            	ldw	x,sp
1670  0059 1c0007        	addw	x,#OFST+3
1671  005c cd0000        	call	c_ltor
1673  005f ae0004        	ldw	x,#L725
1674  0062 cd0000        	call	c_fmul
1676  0065 96            	ldw	x,sp
1677  0066 1c0001        	addw	x,#OFST-3
1678  0069 cd0000        	call	c_rtol
1680  006c a604          	ld	a,#4
1681  006e cd0000        	call	c_ctof
1683  0071 96            	ldw	x,sp
1684  0072 1c0001        	addw	x,#OFST-3
1685  0075 cd0000        	call	c_fsub
1687  0078 96            	ldw	x,sp
1688  0079 1c0007        	addw	x,#OFST+3
1689  007c cd0000        	call	c_fmul
1691  007f ae0000        	ldw	x,#L145
1692  0082 cd0000        	call	c_fsub
1694  0085 ae000c        	ldw	x,#L714
1695  0088 cd0000        	call	c_fmul
1697  008b cd0000        	call	c_ftol
1699  008e b603          	ld	a,c_lreg+3
1701  0090               L07:
1703  0090 5b04          	addw	sp,#4
1704  0092 81            	ret
1705  0093               L705:
1706                     ; 502 		return 40;
1708  0093 a628          	ld	a,#40
1710  0095 20f9          	jra	L07
1746                     ; 505 void lightCtrl100ms(void)
1746                     ; 506 {
1747                     .text:	section	.text,new
1748  0000               _lightCtrl100ms:
1752                     ; 507 	if(linear1_begin){//channel1 Linear调光开始
1754  0000 b600          	ld	a,_action_flag
1755  0002 a501          	bcp	a,#1
1756  0004 2768          	jreq	L755
1757                     ; 508 		last_bright1 += change_step1;
1759  0006 ae0000        	ldw	x,#_change_step1
1760  0009 cd0000        	call	c_ltor
1762  000c ae000a        	ldw	x,#_last_bright1
1763  000f cd0000        	call	c_fgadd
1765                     ; 509 		realtime_bright1 = Linear(last_bright1);
1767  0012 be0c          	ldw	x,_last_bright1+2
1768  0014 89            	pushw	x
1769  0015 be0a          	ldw	x,_last_bright1
1770  0017 89            	pushw	x
1771  0018 cd0000        	call	_Linear
1773  001b 5b04          	addw	sp,#4
1774  001d b705          	ld	_realtime_bright1,a
1775                     ; 510 		if(last_bright1 > aim_bright1){
1777  001f 9c            	rvf
1778  0020 ae000a        	ldw	x,#_last_bright1
1779  0023 cd0000        	call	c_ltor
1781  0026 ae0000        	ldw	x,#_aim_bright1
1782  0029 cd0000        	call	c_fcmp
1784  002c 2d21          	jrsle	L165
1785                     ; 511 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
1787  002e ae000a        	ldw	x,#_last_bright1
1788  0031 cd0000        	call	c_ltor
1790  0034 ae0000        	ldw	x,#_aim_bright1
1791  0037 cd0000        	call	c_fsub
1793  003a ae000c        	ldw	x,#L714
1794  003d cd0000        	call	c_fmul
1796  0040 cd0000        	call	c_ftol
1798  0043 b603          	ld	a,c_lreg+3
1799  0045 a102          	cp	a,#2
1800  0047 2425          	jruge	L755
1801                     ; 512 				linear1_begin = 0;
1803  0049 72110000      	bres	_action_flag,#0
1804  004d 201f          	jra	L755
1805  004f               L165:
1806                     ; 515 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
1808  004f ae0000        	ldw	x,#_aim_bright1
1809  0052 cd0000        	call	c_ltor
1811  0055 ae000a        	ldw	x,#_last_bright1
1812  0058 cd0000        	call	c_fsub
1814  005b ae000c        	ldw	x,#L714
1815  005e cd0000        	call	c_fmul
1817  0061 cd0000        	call	c_ftol
1819  0064 b603          	ld	a,c_lreg+3
1820  0066 a102          	cp	a,#2
1821  0068 2404          	jruge	L755
1822                     ; 516 				linear1_begin = 0;
1824  006a 72110000      	bres	_action_flag,#0
1825  006e               L755:
1826                     ; 519 	if(linear2_begin){//channel2 Linear调光开始
1828  006e b600          	ld	a,_action_flag
1829  0070 a502          	bcp	a,#2
1830  0072 2768          	jreq	L175
1831                     ; 520 		last_bright2 += change_step2;
1833  0074 ae0000        	ldw	x,#_change_step2
1834  0077 cd0000        	call	c_ltor
1836  007a ae0006        	ldw	x,#_last_bright2
1837  007d cd0000        	call	c_fgadd
1839                     ; 521 		realtime_bright2 = Linear(last_bright2);
1841  0080 be08          	ldw	x,_last_bright2+2
1842  0082 89            	pushw	x
1843  0083 be06          	ldw	x,_last_bright2
1844  0085 89            	pushw	x
1845  0086 cd0000        	call	_Linear
1847  0089 5b04          	addw	sp,#4
1848  008b b704          	ld	_realtime_bright2,a
1849                     ; 522 		if(last_bright2 > aim_bright2){
1851  008d 9c            	rvf
1852  008e ae0006        	ldw	x,#_last_bright2
1853  0091 cd0000        	call	c_ltor
1855  0094 ae0000        	ldw	x,#_aim_bright2
1856  0097 cd0000        	call	c_fcmp
1858  009a 2d21          	jrsle	L375
1859                     ; 523 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
1861  009c ae0006        	ldw	x,#_last_bright2
1862  009f cd0000        	call	c_ltor
1864  00a2 ae0000        	ldw	x,#_aim_bright2
1865  00a5 cd0000        	call	c_fsub
1867  00a8 ae000c        	ldw	x,#L714
1868  00ab cd0000        	call	c_fmul
1870  00ae cd0000        	call	c_ftol
1872  00b1 b603          	ld	a,c_lreg+3
1873  00b3 a102          	cp	a,#2
1874  00b5 2425          	jruge	L175
1875                     ; 524 				linear2_begin = 0;
1877  00b7 72130000      	bres	_action_flag,#1
1878  00bb 201f          	jra	L175
1879  00bd               L375:
1880                     ; 527 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
1882  00bd ae0000        	ldw	x,#_aim_bright2
1883  00c0 cd0000        	call	c_ltor
1885  00c3 ae0006        	ldw	x,#_last_bright2
1886  00c6 cd0000        	call	c_fsub
1888  00c9 ae000c        	ldw	x,#L714
1889  00cc cd0000        	call	c_fmul
1891  00cf cd0000        	call	c_ftol
1893  00d2 b603          	ld	a,c_lreg+3
1894  00d4 a102          	cp	a,#2
1895  00d6 2404          	jruge	L175
1896                     ; 528 				linear2_begin = 0;
1898  00d8 72130000      	bres	_action_flag,#1
1899  00dc               L175:
1900                     ; 531 	if(eraseIn1_begin){//channel1 EraseIn调光开始
1902  00dc b600          	ld	a,_action_flag
1903  00de a504          	bcp	a,#4
1904  00e0 2768          	jreq	L306
1905                     ; 532 		last_bright1 += change_step1;
1907  00e2 ae0000        	ldw	x,#_change_step1
1908  00e5 cd0000        	call	c_ltor
1910  00e8 ae000a        	ldw	x,#_last_bright1
1911  00eb cd0000        	call	c_fgadd
1913                     ; 533 		realtime_bright1 = EraseIn(last_bright1);	
1915  00ee be0c          	ldw	x,_last_bright1+2
1916  00f0 89            	pushw	x
1917  00f1 be0a          	ldw	x,_last_bright1
1918  00f3 89            	pushw	x
1919  00f4 cd0000        	call	_EraseIn
1921  00f7 5b04          	addw	sp,#4
1922  00f9 b705          	ld	_realtime_bright1,a
1923                     ; 534 		if(last_bright1 > aim_bright1){
1925  00fb 9c            	rvf
1926  00fc ae000a        	ldw	x,#_last_bright1
1927  00ff cd0000        	call	c_ltor
1929  0102 ae0000        	ldw	x,#_aim_bright1
1930  0105 cd0000        	call	c_fcmp
1932  0108 2d21          	jrsle	L506
1933                     ; 535 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
1935  010a ae000a        	ldw	x,#_last_bright1
1936  010d cd0000        	call	c_ltor
1938  0110 ae0000        	ldw	x,#_aim_bright1
1939  0113 cd0000        	call	c_fsub
1941  0116 ae000c        	ldw	x,#L714
1942  0119 cd0000        	call	c_fmul
1944  011c cd0000        	call	c_ftol
1946  011f b603          	ld	a,c_lreg+3
1947  0121 a102          	cp	a,#2
1948  0123 2425          	jruge	L306
1949                     ; 536 				eraseIn1_begin = 0;
1951  0125 72150000      	bres	_action_flag,#2
1952  0129 201f          	jra	L306
1953  012b               L506:
1954                     ; 539 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
1956  012b ae0000        	ldw	x,#_aim_bright1
1957  012e cd0000        	call	c_ltor
1959  0131 ae000a        	ldw	x,#_last_bright1
1960  0134 cd0000        	call	c_fsub
1962  0137 ae000c        	ldw	x,#L714
1963  013a cd0000        	call	c_fmul
1965  013d cd0000        	call	c_ftol
1967  0140 b603          	ld	a,c_lreg+3
1968  0142 a102          	cp	a,#2
1969  0144 2404          	jruge	L306
1970                     ; 540 				eraseIn1_begin = 0;
1972  0146 72150000      	bres	_action_flag,#2
1973  014a               L306:
1974                     ; 543 	if(eraseIn2_begin){//channel2 EraseIn调光开始
1976  014a b600          	ld	a,_action_flag
1977  014c a508          	bcp	a,#8
1978  014e 2768          	jreq	L516
1979                     ; 544 		last_bright2 += change_step2;
1981  0150 ae0000        	ldw	x,#_change_step2
1982  0153 cd0000        	call	c_ltor
1984  0156 ae0006        	ldw	x,#_last_bright2
1985  0159 cd0000        	call	c_fgadd
1987                     ; 545 		realtime_bright2 = EraseIn(last_bright2);
1989  015c be08          	ldw	x,_last_bright2+2
1990  015e 89            	pushw	x
1991  015f be06          	ldw	x,_last_bright2
1992  0161 89            	pushw	x
1993  0162 cd0000        	call	_EraseIn
1995  0165 5b04          	addw	sp,#4
1996  0167 b704          	ld	_realtime_bright2,a
1997                     ; 546 		if(last_bright2 > aim_bright2){
1999  0169 9c            	rvf
2000  016a ae0006        	ldw	x,#_last_bright2
2001  016d cd0000        	call	c_ltor
2003  0170 ae0000        	ldw	x,#_aim_bright2
2004  0173 cd0000        	call	c_fcmp
2006  0176 2d21          	jrsle	L716
2007                     ; 547 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2009  0178 ae0006        	ldw	x,#_last_bright2
2010  017b cd0000        	call	c_ltor
2012  017e ae0000        	ldw	x,#_aim_bright2
2013  0181 cd0000        	call	c_fsub
2015  0184 ae000c        	ldw	x,#L714
2016  0187 cd0000        	call	c_fmul
2018  018a cd0000        	call	c_ftol
2020  018d b603          	ld	a,c_lreg+3
2021  018f a102          	cp	a,#2
2022  0191 2425          	jruge	L516
2023                     ; 548 				eraseIn2_begin = 0;
2025  0193 72170000      	bres	_action_flag,#3
2026  0197 201f          	jra	L516
2027  0199               L716:
2028                     ; 551 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2030  0199 ae0000        	ldw	x,#_aim_bright2
2031  019c cd0000        	call	c_ltor
2033  019f ae0006        	ldw	x,#_last_bright2
2034  01a2 cd0000        	call	c_fsub
2036  01a5 ae000c        	ldw	x,#L714
2037  01a8 cd0000        	call	c_fmul
2039  01ab cd0000        	call	c_ftol
2041  01ae b603          	ld	a,c_lreg+3
2042  01b0 a102          	cp	a,#2
2043  01b2 2404          	jruge	L516
2044                     ; 552 				eraseIn2_begin = 0;
2046  01b4 72170000      	bres	_action_flag,#3
2047  01b8               L516:
2048                     ; 555 	if(eraseOut1_begin){//channel1 EraseOut调光开始
2050  01b8 b600          	ld	a,_action_flag
2051  01ba a510          	bcp	a,#16
2052  01bc 2768          	jreq	L726
2053                     ; 556 		last_bright1 += change_step1;
2055  01be ae0000        	ldw	x,#_change_step1
2056  01c1 cd0000        	call	c_ltor
2058  01c4 ae000a        	ldw	x,#_last_bright1
2059  01c7 cd0000        	call	c_fgadd
2061                     ; 557 		realtime_bright1 = EraseOut(last_bright1);	
2063  01ca be0c          	ldw	x,_last_bright1+2
2064  01cc 89            	pushw	x
2065  01cd be0a          	ldw	x,_last_bright1
2066  01cf 89            	pushw	x
2067  01d0 cd0000        	call	_EraseOut
2069  01d3 5b04          	addw	sp,#4
2070  01d5 b705          	ld	_realtime_bright1,a
2071                     ; 558 		if(last_bright1 > aim_bright1){
2073  01d7 9c            	rvf
2074  01d8 ae000a        	ldw	x,#_last_bright1
2075  01db cd0000        	call	c_ltor
2077  01de ae0000        	ldw	x,#_aim_bright1
2078  01e1 cd0000        	call	c_fcmp
2080  01e4 2d21          	jrsle	L136
2081                     ; 559 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2083  01e6 ae000a        	ldw	x,#_last_bright1
2084  01e9 cd0000        	call	c_ltor
2086  01ec ae0000        	ldw	x,#_aim_bright1
2087  01ef cd0000        	call	c_fsub
2089  01f2 ae000c        	ldw	x,#L714
2090  01f5 cd0000        	call	c_fmul
2092  01f8 cd0000        	call	c_ftol
2094  01fb b603          	ld	a,c_lreg+3
2095  01fd a102          	cp	a,#2
2096  01ff 2425          	jruge	L726
2097                     ; 560 				eraseOut1_begin = 0;
2099  0201 72190000      	bres	_action_flag,#4
2100  0205 201f          	jra	L726
2101  0207               L136:
2102                     ; 563 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2104  0207 ae0000        	ldw	x,#_aim_bright1
2105  020a cd0000        	call	c_ltor
2107  020d ae000a        	ldw	x,#_last_bright1
2108  0210 cd0000        	call	c_fsub
2110  0213 ae000c        	ldw	x,#L714
2111  0216 cd0000        	call	c_fmul
2113  0219 cd0000        	call	c_ftol
2115  021c b603          	ld	a,c_lreg+3
2116  021e a102          	cp	a,#2
2117  0220 2404          	jruge	L726
2118                     ; 564 				eraseOut1_begin = 0;
2120  0222 72190000      	bres	_action_flag,#4
2121  0226               L726:
2122                     ; 567 	if(eraseOut2_begin){//channel2 EraseOut调光开始
2124  0226 b600          	ld	a,_action_flag
2125  0228 a520          	bcp	a,#32
2126  022a 2768          	jreq	L146
2127                     ; 568 		last_bright2 += change_step2;
2129  022c ae0000        	ldw	x,#_change_step2
2130  022f cd0000        	call	c_ltor
2132  0232 ae0006        	ldw	x,#_last_bright2
2133  0235 cd0000        	call	c_fgadd
2135                     ; 569 		realtime_bright2 = EraseOut(last_bright2);
2137  0238 be08          	ldw	x,_last_bright2+2
2138  023a 89            	pushw	x
2139  023b be06          	ldw	x,_last_bright2
2140  023d 89            	pushw	x
2141  023e cd0000        	call	_EraseOut
2143  0241 5b04          	addw	sp,#4
2144  0243 b704          	ld	_realtime_bright2,a
2145                     ; 570 		if(last_bright2 > aim_bright2){
2147  0245 9c            	rvf
2148  0246 ae0006        	ldw	x,#_last_bright2
2149  0249 cd0000        	call	c_ltor
2151  024c ae0000        	ldw	x,#_aim_bright2
2152  024f cd0000        	call	c_fcmp
2154  0252 2d21          	jrsle	L346
2155                     ; 571 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2157  0254 ae0006        	ldw	x,#_last_bright2
2158  0257 cd0000        	call	c_ltor
2160  025a ae0000        	ldw	x,#_aim_bright2
2161  025d cd0000        	call	c_fsub
2163  0260 ae000c        	ldw	x,#L714
2164  0263 cd0000        	call	c_fmul
2166  0266 cd0000        	call	c_ftol
2168  0269 b603          	ld	a,c_lreg+3
2169  026b a102          	cp	a,#2
2170  026d 2425          	jruge	L146
2171                     ; 572 				eraseOut2_begin = 0;
2173  026f 721b0000      	bres	_action_flag,#5
2174  0273 201f          	jra	L146
2175  0275               L346:
2176                     ; 575 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2178  0275 ae0000        	ldw	x,#_aim_bright2
2179  0278 cd0000        	call	c_ltor
2181  027b ae0006        	ldw	x,#_last_bright2
2182  027e cd0000        	call	c_fsub
2184  0281 ae000c        	ldw	x,#L714
2185  0284 cd0000        	call	c_fmul
2187  0287 cd0000        	call	c_ftol
2189  028a b603          	ld	a,c_lreg+3
2190  028c a102          	cp	a,#2
2191  028e 2404          	jruge	L146
2192                     ; 576 				eraseOut2_begin = 0;
2194  0290 721b0000      	bres	_action_flag,#5
2195  0294               L146:
2196                     ; 579 	if(swing1_begin){//channel1 Swing调光开始
2198  0294 b600          	ld	a,_action_flag
2199  0296 a540          	bcp	a,#64
2200  0298 2768          	jreq	L356
2201                     ; 580 		last_bright1 += change_step1;
2203  029a ae0000        	ldw	x,#_change_step1
2204  029d cd0000        	call	c_ltor
2206  02a0 ae000a        	ldw	x,#_last_bright1
2207  02a3 cd0000        	call	c_fgadd
2209                     ; 581 		realtime_bright1 = Swing(last_bright1);	
2211  02a6 be0c          	ldw	x,_last_bright1+2
2212  02a8 89            	pushw	x
2213  02a9 be0a          	ldw	x,_last_bright1
2214  02ab 89            	pushw	x
2215  02ac cd0000        	call	_Swing
2217  02af 5b04          	addw	sp,#4
2218  02b1 b705          	ld	_realtime_bright1,a
2219                     ; 582 		if(last_bright1 > aim_bright1){
2221  02b3 9c            	rvf
2222  02b4 ae000a        	ldw	x,#_last_bright1
2223  02b7 cd0000        	call	c_ltor
2225  02ba ae0000        	ldw	x,#_aim_bright1
2226  02bd cd0000        	call	c_fcmp
2228  02c0 2d21          	jrsle	L556
2229                     ; 583 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2231  02c2 ae000a        	ldw	x,#_last_bright1
2232  02c5 cd0000        	call	c_ltor
2234  02c8 ae0000        	ldw	x,#_aim_bright1
2235  02cb cd0000        	call	c_fsub
2237  02ce ae000c        	ldw	x,#L714
2238  02d1 cd0000        	call	c_fmul
2240  02d4 cd0000        	call	c_ftol
2242  02d7 b603          	ld	a,c_lreg+3
2243  02d9 a102          	cp	a,#2
2244  02db 2425          	jruge	L356
2245                     ; 584 				swing1_begin = 0;
2247  02dd 721d0000      	bres	_action_flag,#6
2248  02e1 201f          	jra	L356
2249  02e3               L556:
2250                     ; 587 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2252  02e3 ae0000        	ldw	x,#_aim_bright1
2253  02e6 cd0000        	call	c_ltor
2255  02e9 ae000a        	ldw	x,#_last_bright1
2256  02ec cd0000        	call	c_fsub
2258  02ef ae000c        	ldw	x,#L714
2259  02f2 cd0000        	call	c_fmul
2261  02f5 cd0000        	call	c_ftol
2263  02f8 b603          	ld	a,c_lreg+3
2264  02fa a102          	cp	a,#2
2265  02fc 2404          	jruge	L356
2266                     ; 588 				swing1_begin = 0;
2268  02fe 721d0000      	bres	_action_flag,#6
2269  0302               L356:
2270                     ; 591 	if(swing2_begin){//channel2 Swing调光开始
2272  0302 b600          	ld	a,_action_flag
2273  0304 a580          	bcp	a,#128
2274  0306 2768          	jreq	L566
2275                     ; 592 		last_bright2 += change_step2;
2277  0308 ae0000        	ldw	x,#_change_step2
2278  030b cd0000        	call	c_ltor
2280  030e ae0006        	ldw	x,#_last_bright2
2281  0311 cd0000        	call	c_fgadd
2283                     ; 593 		realtime_bright2 = Swing(last_bright2);
2285  0314 be08          	ldw	x,_last_bright2+2
2286  0316 89            	pushw	x
2287  0317 be06          	ldw	x,_last_bright2
2288  0319 89            	pushw	x
2289  031a cd0000        	call	_Swing
2291  031d 5b04          	addw	sp,#4
2292  031f b704          	ld	_realtime_bright2,a
2293                     ; 594 		if(last_bright2 > aim_bright2){
2295  0321 9c            	rvf
2296  0322 ae0006        	ldw	x,#_last_bright2
2297  0325 cd0000        	call	c_ltor
2299  0328 ae0000        	ldw	x,#_aim_bright2
2300  032b cd0000        	call	c_fcmp
2302  032e 2d21          	jrsle	L766
2303                     ; 595 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2305  0330 ae0006        	ldw	x,#_last_bright2
2306  0333 cd0000        	call	c_ltor
2308  0336 ae0000        	ldw	x,#_aim_bright2
2309  0339 cd0000        	call	c_fsub
2311  033c ae000c        	ldw	x,#L714
2312  033f cd0000        	call	c_fmul
2314  0342 cd0000        	call	c_ftol
2316  0345 b603          	ld	a,c_lreg+3
2317  0347 a102          	cp	a,#2
2318  0349 2425          	jruge	L566
2319                     ; 596 				swing2_begin = 0;
2321  034b 721f0000      	bres	_action_flag,#7
2322  034f 201f          	jra	L566
2323  0351               L766:
2324                     ; 599 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2326  0351 ae0000        	ldw	x,#_aim_bright2
2327  0354 cd0000        	call	c_ltor
2329  0357 ae0006        	ldw	x,#_last_bright2
2330  035a cd0000        	call	c_fsub
2332  035d ae000c        	ldw	x,#L714
2333  0360 cd0000        	call	c_fmul
2335  0363 cd0000        	call	c_ftol
2337  0366 b603          	ld	a,c_lreg+3
2338  0368 a102          	cp	a,#2
2339  036a 2404          	jruge	L566
2340                     ; 600 				swing2_begin = 0;
2342  036c 721f0000      	bres	_action_flag,#7
2343  0370               L566:
2344                     ; 603 }
2347  0370 81            	ret
2649                     	xdef	_Swing
2650                     	xdef	_EraseOut
2651                     	xdef	_EraseIn
2652                     	xdef	_Linear
2653                     	xdef	_main
2654                     	xdef	_delay
2655                     	switch	.ubsct
2656  0000               _tick1s:
2657  0000 00            	ds.b	1
2658                     	xdef	_tick1s
2659  0001               _f_100ms:
2660  0001 00            	ds.b	1
2661                     	xdef	_f_100ms
2662  0002               _Tick100ms:
2663  0002 0000          	ds.b	2
2664                     	xdef	_Tick100ms
2665                     	xref.b	_action_flag
2666                     	xref.b	_change_step2
2667                     	xref.b	_change_step1
2668                     	xref.b	_aim_bright2
2669                     	xref.b	_aim_bright1
2670                     	xref.b	_channel
2671  0004               _realtime_bright2:
2672  0004 00            	ds.b	1
2673                     	xdef	_realtime_bright2
2674  0005               _realtime_bright1:
2675  0005 00            	ds.b	1
2676                     	xdef	_realtime_bright1
2677  0006               _last_bright2:
2678  0006 00000000      	ds.b	4
2679                     	xdef	_last_bright2
2680  000a               _last_bright1:
2681  000a 00000000      	ds.b	4
2682                     	xdef	_last_bright1
2683                     	xref.b	_slave_address
2684                     	xref.b	_slc
2685                     	xref	_IIC_SlaveConfig
2686                     	xdef	f_Timer4_ISR
2687                     	xdef	f_Timer2_ISR
2688                     	xdef	f_Ext_PortD_ISR
2689                     	xdef	_lightCtrl100ms
2690                     	xdef	_sys
2691                     	xdef	_assert_failed
2692                     	xref	_TIM4_ClearITPendingBit
2693                     	xref	_TIM4_ClearFlag
2694                     	xref	_TIM4_SetAutoreload
2695                     	xref	_TIM4_ITConfig
2696                     	xref	_TIM4_Cmd
2697                     	xref	_TIM4_TimeBaseInit
2698                     	xref	_TIM2_ClearITPendingBit
2699                     	xref	_TIM2_ClearFlag
2700                     	xref	_TIM2_SetAutoreload
2701                     	xref	_TIM2_ITConfig
2702                     	xref	_TIM2_Cmd
2703                     	xref	_TIM2_TimeBaseInit
2704                     	xref	_GPIO_ReadOutputData
2705                     	xref	_GPIO_ReadInputData
2706                     	xref	_GPIO_WriteLow
2707                     	xref	_GPIO_WriteHigh
2708                     	xref	_GPIO_Init
2709                     	xref	_EXTI_SetExtIntSensitivity
2710                     	xref	_EXTI_DeInit
2711                     	xref	_CLK_PeripheralClockConfig
2712                     .const:	section	.text
2713  0000               L145:
2714  0000 3f800000      	dc.w	16256,0
2715  0004               L725:
2716  0004 40000000      	dc.w	16384,0
2717  0008               L715:
2718  0008 3f000000      	dc.w	16128,0
2719  000c               L714:
2720  000c 437a0000      	dc.w	17274,0
2721  0010               L122:
2722  0010 3e23d70a      	dc.w	15907,-10486
2723  0014               L341:
2724  0014 42c80000      	dc.w	17096,0
2725                     	xref.b	c_lreg
2726                     	xref.b	c_x
2727                     	xref.b	c_y
2747                     	xref	c_fgadd
2748                     	xref	c_fsub
2749                     	xref	c_fcmp
2750                     	xref	c_rtol
2751                     	xref	c_ctof
2752                     	xref	c_ftol
2753                     	xref	c_fmul
2754                     	xref	c_ltor
2755                     	end
