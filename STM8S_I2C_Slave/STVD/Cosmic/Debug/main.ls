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
 162                     ; 80 void main(void)
 162                     ; 81 {
 163                     .text:	section	.text,new
 164  0000               _main:
 168                     ; 86 	CLK->SWCR |= 0x02; //开启切换
 170  0000 721250c5      	bset	20677,#1
 171                     ; 87   CLK->SWR   = 0xb4;       //选择时钟为外部8M
 173  0004 35b450c4      	mov	20676,#180
 175  0008               L701:
 176                     ; 88   while((CLK->SWCR & 0x01)==0x01);
 178  0008 c650c5        	ld	a,20677
 179  000b a401          	and	a,#1
 180  000d a101          	cp	a,#1
 181  000f 27f7          	jreq	L701
 182                     ; 89   CLK->CKDIVR = 0x80;    //不分频
 184  0011 358050c6      	mov	20678,#128
 185                     ; 90   CLK->SWCR  &= ~0x02; //关闭切换
 187  0015 721350c5      	bres	20677,#1
 188                     ; 93 	slave_address = 0x00;
 190  0019 3f00          	clr	_slave_address
 191                     ; 94 	GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
 193  001b 4b00          	push	#0
 194  001d 4b04          	push	#4
 195  001f ae500f        	ldw	x,#20495
 196  0022 cd0000        	call	_GPIO_Init
 198  0025 85            	popw	x
 199                     ; 95 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);
 201  0026 4b00          	push	#0
 202  0028 4b80          	push	#128
 203  002a ae500a        	ldw	x,#20490
 204  002d cd0000        	call	_GPIO_Init
 206  0030 85            	popw	x
 207                     ; 96 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 209  0031 4b00          	push	#0
 210  0033 4b40          	push	#64
 211  0035 ae500a        	ldw	x,#20490
 212  0038 cd0000        	call	_GPIO_Init
 214  003b 85            	popw	x
 215                     ; 97 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 217  003c 4b00          	push	#0
 218  003e 4b40          	push	#64
 219  0040 ae500a        	ldw	x,#20490
 220  0043 cd0000        	call	_GPIO_Init
 222  0046 85            	popw	x
 223                     ; 98 	GPIO_Init(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
 225  0047 4b00          	push	#0
 226  0049 4b08          	push	#8
 227  004b ae5000        	ldw	x,#20480
 228  004e cd0000        	call	_GPIO_Init
 230  0051 85            	popw	x
 231                     ; 99 	delay(100);
 233  0052 ae0064        	ldw	x,#100
 234  0055 cd0000        	call	_delay
 236                     ; 101 	if(GPIO_ReadInputData(GPIOD) & 0x04)	slave_address |= 0x08;
 238  0058 ae500f        	ldw	x,#20495
 239  005b cd0000        	call	_GPIO_ReadInputData
 241  005e a504          	bcp	a,#4
 242  0060 2704          	jreq	L311
 245  0062 72160000      	bset	_slave_address,#3
 246  0066               L311:
 247                     ; 102 	if(GPIO_ReadInputData(GPIOC) & 0x20)	slave_address |= 0x04;
 249  0066 ae500a        	ldw	x,#20490
 250  0069 cd0000        	call	_GPIO_ReadInputData
 252  006c a520          	bcp	a,#32
 253  006e 2704          	jreq	L511
 256  0070 72140000      	bset	_slave_address,#2
 257  0074               L511:
 258                     ; 103 	if(GPIO_ReadInputData(GPIOC) & 0x40)	slave_address |= 0x02;
 260  0074 ae500a        	ldw	x,#20490
 261  0077 cd0000        	call	_GPIO_ReadInputData
 263  007a a540          	bcp	a,#64
 264  007c 2704          	jreq	L711
 267  007e 72120000      	bset	_slave_address,#1
 268  0082               L711:
 269                     ; 104 	if(GPIO_ReadInputData(GPIOC) & 0x80)	slave_address |= 0x01;
 271  0082 ae500a        	ldw	x,#20490
 272  0085 cd0000        	call	_GPIO_ReadInputData
 274  0088 a580          	bcp	a,#128
 275  008a 2704          	jreq	L121
 278  008c 72100000      	bset	_slave_address,#0
 279  0090               L121:
 280                     ; 105 	slc.MDID = slave_address;
 282  0090 b600          	ld	a,_slave_address
 283  0092 5f            	clrw	x
 284  0093 97            	ld	xl,a
 285  0094 bf13          	ldw	_slc+19,x
 286                     ; 106 	GPIO_Config();
 288  0096 cd0000        	call	L5_GPIO_Config
 290                     ; 107 	Sys_Init();
 292  0099 cd0000        	call	L3_Sys_Init
 294                     ; 108 	ExtInterrupt_Config();
 296  009c cd0000        	call	L7_ExtInterrupt_Config
 298                     ; 109 	TIMER4_Init();
 300  009f cd0000        	call	L31_TIMER4_Init
 302                     ; 116 	IIC_SlaveConfig();
 304  00a2 cd0000        	call	_IIC_SlaveConfig
 306                     ; 117 	disableInterrupts();
 309  00a5 9b            sim
 311                     ; 119 	ITC_DeInit();
 314  00a6 cd0000        	call	_ITC_DeInit
 316                     ; 120 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD,ITC_PRIORITYLEVEL_1);
 318  00a9 ae0001        	ldw	x,#1
 319  00ac a606          	ld	a,#6
 320  00ae 95            	ld	xh,a
 321  00af cd0000        	call	_ITC_SetSoftwarePriority
 323                     ; 121 	ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF,ITC_PRIORITYLEVEL_2);
 325  00b2 5f            	clrw	x
 326  00b3 a60d          	ld	a,#13
 327  00b5 95            	ld	xh,a
 328  00b6 cd0000        	call	_ITC_SetSoftwarePriority
 330                     ; 122 	ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF,ITC_PRIORITYLEVEL_2);
 332  00b9 5f            	clrw	x
 333  00ba a617          	ld	a,#23
 334  00bc 95            	ld	xh,a
 335  00bd cd0000        	call	_ITC_SetSoftwarePriority
 337                     ; 123 	ITC_SetSoftwarePriority(ITC_IRQ_I2C,ITC_PRIORITYLEVEL_3);
 339  00c0 ae0003        	ldw	x,#3
 340  00c3 a613          	ld	a,#19
 341  00c5 95            	ld	xh,a
 342  00c6 cd0000        	call	_ITC_SetSoftwarePriority
 344                     ; 126 	enableInterrupts();
 347  00c9 9a            rim
 351  00ca 2016          	jra	L521
 352  00cc               L321:
 353                     ; 130 		 if (sys.checkAcCnt == 0)
 355  00cc be0e          	ldw	x,_sys+14
 356  00ce 2612          	jrne	L521
 357                     ; 137 			sys.gotHzFlag = FALSE;    
 359  00d0 3f09          	clr	_sys+9
 360                     ; 138 			sys.reqCalHzFlag = FALSE;
 362  00d2 3f08          	clr	_sys+8
 363                     ; 139 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 365  00d4 350a000b      	mov	_sys+11,#10
 366                     ; 140 			sys.hzCnt = 0;
 368  00d8 5f            	clrw	x
 369  00d9 bf0c          	ldw	_sys+12,x
 370                     ; 141 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 372  00db ae07d0        	ldw	x,#2000
 373  00de bf0e          	ldw	_sys+14,x
 374                     ; 142 			break;
 376  00e0 201a          	jra	L531
 377  00e2               L521:
 378                     ; 128 	 while(!sys.gotHzFlag)
 380  00e2 3d09          	tnz	_sys+9
 381  00e4 27e6          	jreq	L321
 382  00e6 2014          	jra	L531
 383  00e8               L331:
 384                     ; 149 		 if (sys.checkAcCnt == 0)
 386  00e8 be0e          	ldw	x,_sys+14
 387  00ea 2610          	jrne	L531
 388                     ; 152 			sys.gotHzFlag = FALSE;    
 390  00ec 3f09          	clr	_sys+9
 391                     ; 153 			sys.reqCalHzFlag = FALSE;
 393  00ee 3f08          	clr	_sys+8
 394                     ; 154 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 396  00f0 350a000b      	mov	_sys+11,#10
 397                     ; 155 			sys.hzCnt = 0;
 399  00f4 5f            	clrw	x
 400  00f5 bf0c          	ldw	_sys+12,x
 401                     ; 156 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 403  00f7 ae07d0        	ldw	x,#2000
 404  00fa bf0e          	ldw	_sys+14,x
 405  00fc               L531:
 406                     ; 147 	 while(!sys.gotHzFlag)
 408  00fc 3d09          	tnz	_sys+9
 409  00fe 27e8          	jreq	L331
 410                     ; 159 	 sys.acOkFlag = TRUE;
 412  0100 35010011      	mov	_sys+17,#1
 413                     ; 160 	 TIMER2_Init();
 415  0104 cd0000        	call	L11_TIMER2_Init
 417  0107               L341:
 418                     ; 177 		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE)
 420  0107 be0e          	ldw	x,_sys+14
 421  0109 260a          	jrne	L741
 423  010b 3d10          	tnz	_sys+16
 424  010d 2606          	jrne	L741
 425                     ; 181 			 sys.acErrFlag = TRUE;
 427  010f 35010010      	mov	_sys+16,#1
 428                     ; 182 			 sys.acOkFlag = FALSE;
 430  0113 3f11          	clr	_sys+17
 431  0115               L741:
 432                     ; 185 		if (sys.acErrFlag == FALSE && sys.acOkFlag == FALSE)
 434  0115 3d10          	tnz	_sys+16
 435  0117 260d          	jrne	L151
 437  0119 3d11          	tnz	_sys+17
 438  011b 2609          	jrne	L151
 439                     ; 189 			sys.acOkFlag = TRUE;
 441  011d 35010011      	mov	_sys+17,#1
 442                     ; 190 			sys.cnt1s = CNT_1S;
 444  0121 ae4e20        	ldw	x,#20000
 445  0124 bf1b          	ldw	_sys+27,x
 446  0126               L151:
 447                     ; 193 		if(f_100ms){
 449  0126 3d01          	tnz	_f_100ms
 450  0128 2705          	jreq	L351
 451                     ; 194 			f_100ms = 0;
 453  012a 3f01          	clr	_f_100ms
 454                     ; 195 			lightCtrl100ms();
 456  012c cd0000        	call	_lightCtrl100ms
 458  012f               L351:
 459                     ; 207 		if((channel & 0x01)==0x01)//调节Dimmer1
 461  012f b600          	ld	a,_channel
 462  0131 a401          	and	a,#1
 463  0133 a101          	cp	a,#1
 464  0135 2616          	jrne	L551
 465                     ; 209 			sys.light1.briVal = realtime_bright1;
 467  0137 450502        	mov	_sys+2,_realtime_bright1
 468                     ; 210 			slc.ch1_status = (u8)(last_bright1*100);
 470  013a ae000a        	ldw	x,#_last_bright1
 471  013d cd0000        	call	c_ltor
 473  0140 ae0014        	ldw	x,#L361
 474  0143 cd0000        	call	c_fmul
 476  0146 cd0000        	call	c_ftol
 478  0149 b603          	ld	a,c_lreg+3
 479  014b b715          	ld	_slc+21,a
 480  014d               L551:
 481                     ; 212 		if((channel & 0x02)==0x02)//调节Dimmer2
 483  014d b600          	ld	a,_channel
 484  014f a402          	and	a,#2
 485  0151 a102          	cp	a,#2
 486  0153 2616          	jrne	L761
 487                     ; 214 			sys.light2.briVal = realtime_bright2;
 489  0155 450406        	mov	_sys+6,_realtime_bright2
 490                     ; 215 			slc.ch2_status = (u8)(last_bright2*100);
 492  0158 ae0006        	ldw	x,#_last_bright2
 493  015b cd0000        	call	c_ltor
 495  015e ae0014        	ldw	x,#L361
 496  0161 cd0000        	call	c_fmul
 498  0164 cd0000        	call	c_ftol
 500  0167 b603          	ld	a,c_lreg+3
 501  0169 b716          	ld	_slc+22,a
 502  016b               L761:
 503                     ; 217 		if (sys.acOkFlag && sys.cnt1s == 0)
 505  016b 3d11          	tnz	_sys+17
 506  016d 2798          	jreq	L341
 508  016f be1b          	ldw	x,_sys+27
 509  0171 2694          	jrne	L341
 510                     ; 222 			sys.cnt1s = CNT_1S;
 512  0173 ae4e20        	ldw	x,#20000
 513  0176 bf1b          	ldw	_sys+27,x
 514  0178 208d          	jra	L341
 549                     ; 236 void assert_failed(uint8_t* file, uint32_t line)
 549                     ; 237 { 
 550                     .text:	section	.text,new
 551  0000               _assert_failed:
 555  0000               L112:
 556  0000 20fe          	jra	L112
 581                     ; 248 static void GPIO_Config(void)
 581                     ; 249 {
 582                     .text:	section	.text,new
 583  0000               L5_GPIO_Config:
 587                     ; 251     GPIO_Init(L1_EN_PIN_PORT, (GPIO_Pin_TypeDef)L1_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
 589  0000 4bd0          	push	#208
 590  0002 4b10          	push	#16
 591  0004 ae500a        	ldw	x,#20490
 592  0007 cd0000        	call	_GPIO_Init
 594  000a 85            	popw	x
 595                     ; 252     GPIO_Init(L2_EN_PIN_PORT, (GPIO_Pin_TypeDef)L2_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);   
 597  000b 4bd0          	push	#208
 598  000d 4b08          	push	#8
 599  000f ae500a        	ldw	x,#20490
 600  0012 cd0000        	call	_GPIO_Init
 602  0015 85            	popw	x
 603                     ; 253     L1_EN_OFF;
 605  0016 4b10          	push	#16
 606  0018 ae500a        	ldw	x,#20490
 607  001b cd0000        	call	_GPIO_WriteHigh
 609  001e 84            	pop	a
 610                     ; 254     L2_EN_OFF;
 612  001f 4b08          	push	#8
 613  0021 ae500a        	ldw	x,#20490
 614  0024 cd0000        	call	_GPIO_WriteHigh
 616  0027 84            	pop	a
 617                     ; 255     GPIO_Init(ZD_PIN_PORT, (GPIO_Pin_TypeDef)ZD_PIN, GPIO_MODE_IN_FL_IT);  
 619  0028 4b20          	push	#32
 620  002a 4b08          	push	#8
 621  002c ae500f        	ldw	x,#20495
 622  002f cd0000        	call	_GPIO_Init
 624  0032 85            	popw	x
 625                     ; 257 }
 628  0033 81            	ret
 657                     ; 259 static void Sys_Init(void)
 657                     ; 260 {
 658                     .text:	section	.text,new
 659  0000               L3_Sys_Init:
 663                     ; 261     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 665  0000 ae0001        	ldw	x,#1
 666  0003 a604          	ld	a,#4
 667  0005 95            	ld	xh,a
 668  0006 cd0000        	call	_CLK_PeripheralClockConfig
 670                     ; 262     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 672  0009 ae0001        	ldw	x,#1
 673  000c a605          	ld	a,#5
 674  000e 95            	ld	xh,a
 675  000f cd0000        	call	_CLK_PeripheralClockConfig
 677                     ; 264     sys.gotHzFlag = FALSE;    
 679  0012 3f09          	clr	_sys+9
 680                     ; 265     sys.reqCalHzFlag = FALSE;
 682  0014 3f08          	clr	_sys+8
 683                     ; 266     sys.light1.briVal = DEFAULT_BRIGHTNESS;
 685  0016 35280002      	mov	_sys+2,#40
 686                     ; 267     sys.light2.briVal = DEFAULT_BRIGHTNESS;    
 688  001a 35280006      	mov	_sys+6,#40
 689                     ; 268     sys.calHzIntCnt = GET_AC_FRE_CNT;
 691  001e 350a000b      	mov	_sys+11,#10
 692                     ; 269     sys.hzCnt = 0;
 694  0022 5f            	clrw	x
 695  0023 bf0c          	ldw	_sys+12,x
 696                     ; 270     sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 698  0025 ae07d0        	ldw	x,#2000
 699  0028 bf0e          	ldw	_sys+14,x
 700                     ; 271 		last_bright1 = 0.16;
 702  002a ce0012        	ldw	x,L142+2
 703  002d bf0c          	ldw	_last_bright1+2,x
 704  002f ce0010        	ldw	x,L142
 705  0032 bf0a          	ldw	_last_bright1,x
 706                     ; 272 		aim_bright1 = 0;
 708  0034 ae0000        	ldw	x,#0
 709  0037 bf02          	ldw	_aim_bright1+2,x
 710  0039 ae0000        	ldw	x,#0
 711  003c bf00          	ldw	_aim_bright1,x
 712                     ; 273 		last_bright2 = 0.16;
 714  003e ce0012        	ldw	x,L142+2
 715  0041 bf08          	ldw	_last_bright2+2,x
 716  0043 ce0010        	ldw	x,L142
 717  0046 bf06          	ldw	_last_bright2,x
 718                     ; 274 		aim_bright2 = 0;
 720  0048 ae0000        	ldw	x,#0
 721  004b bf02          	ldw	_aim_bright2+2,x
 722  004d ae0000        	ldw	x,#0
 723  0050 bf00          	ldw	_aim_bright2,x
 724                     ; 275 }
 727  0052 81            	ret
 753                     ; 277 static void ExtInterrupt_Config(void)
 753                     ; 278 {
 754                     .text:	section	.text,new
 755  0000               L7_ExtInterrupt_Config:
 759                     ; 280 	EXTI_DeInit();
 761  0000 cd0000        	call	_EXTI_DeInit
 763                     ; 281 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 765  0003 ae0002        	ldw	x,#2
 766  0006 a603          	ld	a,#3
 767  0008 95            	ld	xh,a
 768  0009 cd0000        	call	_EXTI_SetExtIntSensitivity
 770                     ; 283 }
 773  000c 81            	ret
 803                     ; 289 @far @interrupt void Ext_PortD_ISR(void) {
 805                     .text:	section	.text,new
 806  0000               f_Ext_PortD_ISR:
 809  0000 3b0002        	push	c_x+2
 810  0003 be00          	ldw	x,c_x
 811  0005 89            	pushw	x
 812  0006 3b0002        	push	c_y+2
 813  0009 be00          	ldw	x,c_y
 814  000b 89            	pushw	x
 817                     ; 292 	if (ZD_STATUS == 0)
 819  000c ae500f        	ldw	x,#20495
 820  000f cd0000        	call	_GPIO_ReadOutputData
 822  0012 a508          	bcp	a,#8
 823  0014 2704          	jreq	L62
 824  0016 acc800c8      	jpf	L562
 825  001a               L62:
 826                     ; 294 		sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 828  001a ae07d0        	ldw	x,#2000
 829  001d bf0e          	ldw	_sys+14,x
 830                     ; 295 		sys.acErrFlag = FALSE;
 832  001f 3f10          	clr	_sys+16
 833                     ; 298 		if (!sys.gotHzFlag)
 835  0021 3d09          	tnz	_sys+9
 836  0023 262f          	jrne	L762
 837                     ; 300 			if (!sys.reqCalHzFlag)
 839  0025 3d08          	tnz	_sys+8
 840  0027 2609          	jrne	L172
 841                     ; 302 				TIM4_SetAutoreload(TIMER4_INT_TIME);				
 843  0029 a632          	ld	a,#50
 844  002b cd0000        	call	_TIM4_SetAutoreload
 846                     ; 303 				sys.reqCalHzFlag = TRUE;
 848  002e 35010008      	mov	_sys+8,#1
 849  0032               L172:
 850                     ; 305 			if (sys.calHzIntCnt == 0)
 852  0032 3d0b          	tnz	_sys+11
 853  0034 261a          	jrne	L372
 854                     ; 307 				if ((sys.hzCnt/GET_AC_FRE_CNT) >= HZ_COUNT)
 856  0036 be0c          	ldw	x,_sys+12
 857  0038 a60a          	ld	a,#10
 858  003a 62            	div	x,a
 859  003b a300b4        	cpw	x,#180
 860  003e 2506          	jrult	L572
 861                     ; 309 					sys.hz50Flag = TRUE;
 863  0040 3501000a      	mov	_sys+10,#1
 865  0044 2002          	jra	L772
 866  0046               L572:
 867                     ; 313 					sys.hz50Flag = FALSE;
 869  0046 3f0a          	clr	_sys+10
 870  0048               L772:
 871                     ; 316 				sys.gotHzFlag = TRUE;
 873  0048 35010009      	mov	_sys+9,#1
 874                     ; 317 				sys.reqCalHzFlag = FALSE;
 876  004c 3f08          	clr	_sys+8
 878  004e 2078          	jra	L562
 879  0050               L372:
 880                     ; 321 				sys.calHzIntCnt--;
 882  0050 3a0b          	dec	_sys+11
 883  0052 2074          	jra	L562
 884  0054               L762:
 885                     ; 326 			if (sys.light1.briVal == MAX_BRIGHTNESS)
 887  0054 b602          	ld	a,_sys+2
 888  0056 a1fa          	cp	a,#250
 889  0058 2615          	jrne	L503
 890                     ; 330 				L1_EN_ON;
 892  005a 4b10          	push	#16
 893  005c ae500a        	ldw	x,#20490
 894  005f cd0000        	call	_GPIO_WriteLow
 896  0062 84            	pop	a
 899  0063 35280001      	mov	_sys+1,#40
 900                     ; 331 				sys.light1.briCnt = 0;
 902  0067 3f00          	clr	_sys
 903                     ; 332 				sys.light1.onFlag = TRUE;			
 905  0069 35010003      	mov	_sys+3,#1
 907  006d 2011          	jra	L703
 908  006f               L503:
 909                     ; 337 				sys.light1.briCnt = MAX_BRIGHTNESS - sys.light1.briVal;				
 911  006f a6fa          	ld	a,#250
 912  0071 b002          	sub	a,_sys+2
 913  0073 b700          	ld	_sys,a
 914                     ; 338 				sys.light1.onFlag = FALSE;
 916  0075 3f03          	clr	_sys+3
 917                     ; 339 				L1_EN_OFF;
 919  0077 4b10          	push	#16
 920  0079 ae500a        	ldw	x,#20490
 921  007c cd0000        	call	_GPIO_WriteHigh
 923  007f 84            	pop	a
 924  0080               L703:
 925                     ; 342 			if (sys.light2.briVal == MAX_BRIGHTNESS)
 927  0080 b606          	ld	a,_sys+6
 928  0082 a1fa          	cp	a,#250
 929  0084 2615          	jrne	L113
 930                     ; 344 				L2_EN_ON;
 932  0086 4b08          	push	#8
 933  0088 ae500a        	ldw	x,#20490
 934  008b cd0000        	call	_GPIO_WriteLow
 936  008e 84            	pop	a
 939  008f 35280005      	mov	_sys+5,#40
 940                     ; 345 				sys.light2.briCnt = 0;
 942  0093 3f04          	clr	_sys+4
 943                     ; 346 				sys.light2.onFlag = TRUE;			
 945  0095 35010007      	mov	_sys+7,#1
 947  0099 2011          	jra	L313
 948  009b               L113:
 949                     ; 350 				sys.light2.briCnt = MAX_BRIGHTNESS - sys.light2.briVal;
 951  009b a6fa          	ld	a,#250
 952  009d b006          	sub	a,_sys+6
 953  009f b704          	ld	_sys+4,a
 954                     ; 351 				sys.light2.onFlag = FALSE;				
 956  00a1 3f07          	clr	_sys+7
 957                     ; 352 				L2_EN_OFF;
 959  00a3 4b08          	push	#8
 960  00a5 ae500a        	ldw	x,#20490
 961  00a8 cd0000        	call	_GPIO_WriteHigh
 963  00ab 84            	pop	a
 964  00ac               L313:
 965                     ; 355 			if (sys.light1.briCnt || sys.light2.briCnt)
 967  00ac 3d00          	tnz	_sys
 968  00ae 2604          	jrne	L713
 970  00b0 3d04          	tnz	_sys+4
 971  00b2 2714          	jreq	L562
 972  00b4               L713:
 973                     ; 358 				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
 975  00b4 3d0a          	tnz	_sys+10
 976  00b6 2705          	jreq	L22
 977  00b8 ae0028        	ldw	x,#40
 978  00bb 2003          	jra	L42
 979  00bd               L22:
 980  00bd ae0021        	ldw	x,#33
 981  00c0               L42:
 982  00c0 cd0000        	call	_TIM2_SetAutoreload
 984                     ; 359 				TIM2_Cmd(ENABLE);
 986  00c3 a601          	ld	a,#1
 987  00c5 cd0000        	call	_TIM2_Cmd
 989  00c8               L562:
 990                     ; 363 }
 993  00c8 85            	popw	x
 994  00c9 bf00          	ldw	c_y,x
 995  00cb 320002        	pop	c_y+2
 996  00ce 85            	popw	x
 997  00cf bf00          	ldw	c_x,x
 998  00d1 320002        	pop	c_x+2
 999  00d4 80            	iret
1025                     ; 383 static void TIMER4_Init(void)
1025                     ; 384 {    
1027                     .text:	section	.text,new
1028  0000               L31_TIMER4_Init:
1032                     ; 385     TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIMER4_INT_TIME);
1034  0000 ae0032        	ldw	x,#50
1035  0003 a604          	ld	a,#4
1036  0005 95            	ld	xh,a
1037  0006 cd0000        	call	_TIM4_TimeBaseInit
1039                     ; 386     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
1041  0009 a601          	ld	a,#1
1042  000b cd0000        	call	_TIM4_ClearFlag
1044                     ; 387     TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);	
1046  000e ae0001        	ldw	x,#1
1047  0011 a601          	ld	a,#1
1048  0013 95            	ld	xh,a
1049  0014 cd0000        	call	_TIM4_ITConfig
1051                     ; 388     TIM4_Cmd(ENABLE);
1053  0017 a601          	ld	a,#1
1054  0019 cd0000        	call	_TIM4_Cmd
1056                     ; 389 }
1059  001c 81            	ret
1087                     ; 395 @far @interrupt void Timer4_ISR(void) {
1089                     .text:	section	.text,new
1090  0000               f_Timer4_ISR:
1093  0000 3b0002        	push	c_x+2
1094  0003 be00          	ldw	x,c_x
1095  0005 89            	pushw	x
1096  0006 3b0002        	push	c_y+2
1097  0009 be00          	ldw	x,c_y
1098  000b 89            	pushw	x
1101                     ; 397 TIM4_ClearITPendingBit(TIM4_IT_UPDATE);  
1103  000c a601          	ld	a,#1
1104  000e cd0000        	call	_TIM4_ClearITPendingBit
1106                     ; 398   if (sys.reqCalHzFlag)
1108  0011 3d08          	tnz	_sys+8
1109  0013 2707          	jreq	L143
1110                     ; 400 	  sys.hzCnt++; 	  
1112  0015 be0c          	ldw	x,_sys+12
1113  0017 1c0001        	addw	x,#1
1114  001a bf0c          	ldw	_sys+12,x
1115  001c               L143:
1116                     ; 403   if (sys.light1.triacTriggeTime)
1118  001c 3d01          	tnz	_sys+1
1119  001e 270f          	jreq	L343
1120                     ; 405 	  sys.light1.triacTriggeTime--;
1122  0020 3a01          	dec	_sys+1
1123                     ; 406 	  if (sys.light1.triacTriggeTime == 0)
1125  0022 3d01          	tnz	_sys+1
1126  0024 2609          	jrne	L343
1127                     ; 408 		  L1_EN_OFF;
1129  0026 4b10          	push	#16
1130  0028 ae500a        	ldw	x,#20490
1131  002b cd0000        	call	_GPIO_WriteHigh
1133  002e 84            	pop	a
1134  002f               L343:
1135                     ; 413   if (sys.light2.triacTriggeTime)
1137  002f 3d05          	tnz	_sys+5
1138  0031 270f          	jreq	L743
1139                     ; 415 	  sys.light2.triacTriggeTime--;
1141  0033 3a05          	dec	_sys+5
1142                     ; 416 	  if (sys.light2.triacTriggeTime == 0)
1144  0035 3d05          	tnz	_sys+5
1145  0037 2609          	jrne	L743
1146                     ; 418 		  L2_EN_OFF;
1148  0039 4b08          	push	#8
1149  003b ae500a        	ldw	x,#20490
1150  003e cd0000        	call	_GPIO_WriteHigh
1152  0041 84            	pop	a
1153  0042               L743:
1154                     ; 422   if (sys.checkAcCnt)
1156  0042 be0e          	ldw	x,_sys+14
1157  0044 2707          	jreq	L353
1158                     ; 424 		sys.checkAcCnt--;
1160  0046 be0e          	ldw	x,_sys+14
1161  0048 1d0001        	subw	x,#1
1162  004b bf0e          	ldw	_sys+14,x
1163  004d               L353:
1164                     ; 427   if (sys.cnt1s)
1166  004d be1b          	ldw	x,_sys+27
1167  004f 2707          	jreq	L553
1168                     ; 429 		sys.cnt1s--;
1170  0051 be1b          	ldw	x,_sys+27
1171  0053 1d0001        	subw	x,#1
1172  0056 bf1b          	ldw	_sys+27,x
1173  0058               L553:
1174                     ; 431 	Tick100ms++;
1176  0058 be02          	ldw	x,_Tick100ms
1177  005a 1c0001        	addw	x,#1
1178  005d bf02          	ldw	_Tick100ms,x
1179                     ; 432 	if(Tick100ms >= 2000){
1181  005f be02          	ldw	x,_Tick100ms
1182  0061 a307d0        	cpw	x,#2000
1183  0064 2507          	jrult	L753
1184                     ; 433 		Tick100ms = 0;
1186  0066 5f            	clrw	x
1187  0067 bf02          	ldw	_Tick100ms,x
1188                     ; 434 		f_100ms = 1;
1190  0069 35010001      	mov	_f_100ms,#1
1191  006d               L753:
1192                     ; 436 }
1195  006d 85            	popw	x
1196  006e bf00          	ldw	c_y,x
1197  0070 320002        	pop	c_y+2
1198  0073 85            	popw	x
1199  0074 bf00          	ldw	c_x,x
1200  0076 320002        	pop	c_x+2
1201  0079 80            	iret
1227                     ; 438 static void TIMER2_Init(void)
1227                     ; 439 {    
1229                     .text:	section	.text,new
1230  0000               L11_TIMER2_Init:
1234                     ; 440 	TIM2_TimeBaseInit(TIM2_PRESCALER_16, sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
1236  0000 3d0a          	tnz	_sys+10
1237  0002 2705          	jreq	L63
1238  0004 ae0028        	ldw	x,#40
1239  0007 2003          	jra	L04
1240  0009               L63:
1241  0009 ae0021        	ldw	x,#33
1242  000c               L04:
1243  000c 89            	pushw	x
1244  000d a604          	ld	a,#4
1245  000f cd0000        	call	_TIM2_TimeBaseInit
1247  0012 85            	popw	x
1248                     ; 441    	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
1250  0013 ae0001        	ldw	x,#1
1251  0016 cd0000        	call	_TIM2_ClearFlag
1253                     ; 442    	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	   
1255  0019 ae0001        	ldw	x,#1
1256  001c a601          	ld	a,#1
1257  001e 95            	ld	xh,a
1258  001f cd0000        	call	_TIM2_ITConfig
1260                     ; 443 }
1263  0022 81            	ret
1290                     ; 449 @far @interrupt void Timer2_ISR(void) {
1292                     .text:	section	.text,new
1293  0000               f_Timer2_ISR:
1296  0000 3b0002        	push	c_x+2
1297  0003 be00          	ldw	x,c_x
1298  0005 89            	pushw	x
1299  0006 3b0002        	push	c_y+2
1300  0009 be00          	ldw	x,c_y
1301  000b 89            	pushw	x
1304                     ; 451 	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);  
1306  000c a601          	ld	a,#1
1307  000e cd0000        	call	_TIM2_ClearITPendingBit
1309                     ; 452 	if (sys.light1.briCnt) 
1311  0011 3d00          	tnz	_sys
1312  0013 2702          	jreq	L104
1313                     ; 454 		sys.light1.briCnt--;			
1315  0015 3a00          	dec	_sys
1316  0017               L104:
1317                     ; 456 	if (sys.light1.briCnt == 0 && !sys.light1.onFlag)
1319  0017 3d00          	tnz	_sys
1320  0019 2615          	jrne	L304
1322  001b 3d03          	tnz	_sys+3
1323  001d 2611          	jrne	L304
1324                     ; 458 		L1_EN_ON;
1326  001f 4b10          	push	#16
1327  0021 ae500a        	ldw	x,#20490
1328  0024 cd0000        	call	_GPIO_WriteLow
1330  0027 84            	pop	a
1333  0028 35280001      	mov	_sys+1,#40
1334                     ; 459 		sys.light1.onFlag = TRUE;
1336  002c 35010003      	mov	_sys+3,#1
1337  0030               L304:
1338                     ; 463 	if (sys.light2.briCnt) 
1340  0030 3d04          	tnz	_sys+4
1341  0032 2702          	jreq	L504
1342                     ; 465 		sys.light2.briCnt--;		
1344  0034 3a04          	dec	_sys+4
1345  0036               L504:
1346                     ; 467 	if (sys.light2.briCnt == 0 && !sys.light2.onFlag)
1348  0036 3d04          	tnz	_sys+4
1349  0038 2615          	jrne	L704
1351  003a 3d07          	tnz	_sys+7
1352  003c 2611          	jrne	L704
1353                     ; 469 		L2_EN_ON;
1355  003e 4b08          	push	#8
1356  0040 ae500a        	ldw	x,#20490
1357  0043 cd0000        	call	_GPIO_WriteLow
1359  0046 84            	pop	a
1362  0047 35280005      	mov	_sys+5,#40
1363                     ; 470 		sys.light2.onFlag = TRUE;
1365  004b 35010007      	mov	_sys+7,#1
1366  004f               L704:
1367                     ; 473 	if ((sys.light1.briCnt ||  sys.light2.briCnt) == 0)
1369  004f 3d00          	tnz	_sys
1370  0051 2604          	jrne	L64
1371  0053 3d04          	tnz	_sys+4
1372  0055 2705          	jreq	L44
1373  0057               L64:
1374  0057 ae0001        	ldw	x,#1
1375  005a 2001          	jra	L05
1376  005c               L44:
1377  005c 5f            	clrw	x
1378  005d               L05:
1379  005d a30000        	cpw	x,#0
1380  0060 2604          	jrne	L114
1381                     ; 475 		TIM2_Cmd(DISABLE);
1383  0062 4f            	clr	a
1384  0063 cd0000        	call	_TIM2_Cmd
1386  0066               L114:
1387                     ; 477 }
1390  0066 85            	popw	x
1391  0067 bf00          	ldw	c_y,x
1392  0069 320002        	pop	c_y+2
1393  006c 85            	popw	x
1394  006d bf00          	ldw	c_x,x
1395  006f 320002        	pop	c_x+2
1396  0072 80            	iret
1429                     ; 479 u8 Linear(float t)
1429                     ; 480 {
1431                     .text:	section	.text,new
1432  0000               _Linear:
1434  0000 5204          	subw	sp,#4
1435       00000004      OFST:	set	4
1438                     ; 481 	if((t >= 0)&&(t <=1))
1440  0002 9c            	rvf
1441  0003 0d07          	tnz	(OFST+3,sp)
1442  0005 2f31          	jrslt	L134
1444  0007 9c            	rvf
1445  0008 a601          	ld	a,#1
1446  000a cd0000        	call	c_ctof
1448  000d 96            	ldw	x,sp
1449  000e 1c0001        	addw	x,#OFST-3
1450  0011 cd0000        	call	c_rtol
1452  0014 96            	ldw	x,sp
1453  0015 1c0007        	addw	x,#OFST+3
1454  0018 cd0000        	call	c_ltor
1456  001b 96            	ldw	x,sp
1457  001c 1c0001        	addw	x,#OFST-3
1458  001f cd0000        	call	c_fcmp
1460  0022 2c14          	jrsgt	L134
1461                     ; 482 		return (u8)(t*250);
1463  0024 96            	ldw	x,sp
1464  0025 1c0007        	addw	x,#OFST+3
1465  0028 cd0000        	call	c_ltor
1467  002b ae000c        	ldw	x,#L734
1468  002e cd0000        	call	c_fmul
1470  0031 cd0000        	call	c_ftol
1472  0034 b603          	ld	a,c_lreg+3
1474  0036 2002          	jra	L45
1475  0038               L134:
1476                     ; 484 		return 40;
1478  0038 a628          	ld	a,#40
1480  003a               L45:
1482  003a 5b04          	addw	sp,#4
1483  003c 81            	ret
1517                     ; 486 u8 EraseIn(float t)
1517                     ; 487 {
1518                     .text:	section	.text,new
1519  0000               _EraseIn:
1521  0000 5204          	subw	sp,#4
1522       00000004      OFST:	set	4
1525                     ; 488 	if((t >= 0)&&(t <=1))
1527  0002 9c            	rvf
1528  0003 0d07          	tnz	(OFST+3,sp)
1529  0005 2f38          	jrslt	L364
1531  0007 9c            	rvf
1532  0008 a601          	ld	a,#1
1533  000a cd0000        	call	c_ctof
1535  000d 96            	ldw	x,sp
1536  000e 1c0001        	addw	x,#OFST-3
1537  0011 cd0000        	call	c_rtol
1539  0014 96            	ldw	x,sp
1540  0015 1c0007        	addw	x,#OFST+3
1541  0018 cd0000        	call	c_ltor
1543  001b 96            	ldw	x,sp
1544  001c 1c0001        	addw	x,#OFST-3
1545  001f cd0000        	call	c_fcmp
1547  0022 2c1b          	jrsgt	L364
1548                     ; 489 		return (u8)(t*t*250);
1550  0024 96            	ldw	x,sp
1551  0025 1c0007        	addw	x,#OFST+3
1552  0028 cd0000        	call	c_ltor
1554  002b 96            	ldw	x,sp
1555  002c 1c0007        	addw	x,#OFST+3
1556  002f cd0000        	call	c_fmul
1558  0032 ae000c        	ldw	x,#L734
1559  0035 cd0000        	call	c_fmul
1561  0038 cd0000        	call	c_ftol
1563  003b b603          	ld	a,c_lreg+3
1565  003d 2002          	jra	L06
1566  003f               L364:
1567                     ; 491 		return 40;
1569  003f a628          	ld	a,#40
1571  0041               L06:
1573  0041 5b04          	addw	sp,#4
1574  0043 81            	ret
1608                     ; 493 u8 EraseOut(float t)
1608                     ; 494 {
1609                     .text:	section	.text,new
1610  0000               _EraseOut:
1612  0000 5204          	subw	sp,#4
1613       00000004      OFST:	set	4
1616                     ; 495 	if((t >= 0)&&(t <=1))
1618  0002 9c            	rvf
1619  0003 0d07          	tnz	(OFST+3,sp)
1620  0005 2f3d          	jrslt	L505
1622  0007 9c            	rvf
1623  0008 a601          	ld	a,#1
1624  000a cd0000        	call	c_ctof
1626  000d 96            	ldw	x,sp
1627  000e 1c0001        	addw	x,#OFST-3
1628  0011 cd0000        	call	c_rtol
1630  0014 96            	ldw	x,sp
1631  0015 1c0007        	addw	x,#OFST+3
1632  0018 cd0000        	call	c_ltor
1634  001b 96            	ldw	x,sp
1635  001c 1c0001        	addw	x,#OFST-3
1636  001f cd0000        	call	c_fcmp
1638  0022 2c20          	jrsgt	L505
1639                     ; 496 		return (u8)((2-t)*t*250);
1641  0024 a602          	ld	a,#2
1642  0026 cd0000        	call	c_ctof
1644  0029 96            	ldw	x,sp
1645  002a 1c0007        	addw	x,#OFST+3
1646  002d cd0000        	call	c_fsub
1648  0030 96            	ldw	x,sp
1649  0031 1c0007        	addw	x,#OFST+3
1650  0034 cd0000        	call	c_fmul
1652  0037 ae000c        	ldw	x,#L734
1653  003a cd0000        	call	c_fmul
1655  003d cd0000        	call	c_ftol
1657  0040 b603          	ld	a,c_lreg+3
1659  0042 2002          	jra	L46
1660  0044               L505:
1661                     ; 498 		return 40;
1663  0044 a628          	ld	a,#40
1665  0046               L46:
1667  0046 5b04          	addw	sp,#4
1668  0048 81            	ret
1702                     ; 500 u8 Swing(float t)
1702                     ; 501 {
1703                     .text:	section	.text,new
1704  0000               _Swing:
1706  0000 5204          	subw	sp,#4
1707       00000004      OFST:	set	4
1710                     ; 502 	if((t >= 0)&&(t <=1)){
1712  0002 9c            	rvf
1713  0003 0d07          	tnz	(OFST+3,sp)
1714  0005 2e03          	jrsge	L27
1715  0007 cc0093        	jp	L725
1716  000a               L27:
1718  000a 9c            	rvf
1719  000b a601          	ld	a,#1
1720  000d cd0000        	call	c_ctof
1722  0010 96            	ldw	x,sp
1723  0011 1c0001        	addw	x,#OFST-3
1724  0014 cd0000        	call	c_rtol
1726  0017 96            	ldw	x,sp
1727  0018 1c0007        	addw	x,#OFST+3
1728  001b cd0000        	call	c_ltor
1730  001e 96            	ldw	x,sp
1731  001f 1c0001        	addw	x,#OFST-3
1732  0022 cd0000        	call	c_fcmp
1734  0025 2c6c          	jrsgt	L725
1735                     ; 503 		if(t < 0.5)
1737  0027 9c            	rvf
1738  0028 96            	ldw	x,sp
1739  0029 1c0007        	addw	x,#OFST+3
1740  002c cd0000        	call	c_ltor
1742  002f ae0008        	ldw	x,#L735
1743  0032 cd0000        	call	c_fcmp
1745  0035 2e21          	jrsge	L135
1746                     ; 504 			return (u8)(2*t*t*250);
1748  0037 96            	ldw	x,sp
1749  0038 1c0007        	addw	x,#OFST+3
1750  003b cd0000        	call	c_ltor
1752  003e ae0004        	ldw	x,#L745
1753  0041 cd0000        	call	c_fmul
1755  0044 96            	ldw	x,sp
1756  0045 1c0007        	addw	x,#OFST+3
1757  0048 cd0000        	call	c_fmul
1759  004b ae000c        	ldw	x,#L734
1760  004e cd0000        	call	c_fmul
1762  0051 cd0000        	call	c_ftol
1764  0054 b603          	ld	a,c_lreg+3
1766  0056 2038          	jra	L07
1767  0058               L135:
1768                     ; 506 			return (u8)(((4-2*t)*t - 1)*250);
1770  0058 96            	ldw	x,sp
1771  0059 1c0007        	addw	x,#OFST+3
1772  005c cd0000        	call	c_ltor
1774  005f ae0004        	ldw	x,#L745
1775  0062 cd0000        	call	c_fmul
1777  0065 96            	ldw	x,sp
1778  0066 1c0001        	addw	x,#OFST-3
1779  0069 cd0000        	call	c_rtol
1781  006c a604          	ld	a,#4
1782  006e cd0000        	call	c_ctof
1784  0071 96            	ldw	x,sp
1785  0072 1c0001        	addw	x,#OFST-3
1786  0075 cd0000        	call	c_fsub
1788  0078 96            	ldw	x,sp
1789  0079 1c0007        	addw	x,#OFST+3
1790  007c cd0000        	call	c_fmul
1792  007f ae0000        	ldw	x,#L165
1793  0082 cd0000        	call	c_fsub
1795  0085 ae000c        	ldw	x,#L734
1796  0088 cd0000        	call	c_fmul
1798  008b cd0000        	call	c_ftol
1800  008e b603          	ld	a,c_lreg+3
1802  0090               L07:
1804  0090 5b04          	addw	sp,#4
1805  0092 81            	ret
1806  0093               L725:
1807                     ; 509 		return 40;
1809  0093 a628          	ld	a,#40
1811  0095 20f9          	jra	L07
1847                     ; 512 void lightCtrl100ms(void)
1847                     ; 513 {
1848                     .text:	section	.text,new
1849  0000               _lightCtrl100ms:
1853                     ; 514 	if(linear1_begin){//channel1 Linear调光开始
1855  0000 b600          	ld	a,_action_flag
1856  0002 a501          	bcp	a,#1
1857  0004 2768          	jreq	L775
1858                     ; 515 		last_bright1 += change_step1;
1860  0006 ae0000        	ldw	x,#_change_step1
1861  0009 cd0000        	call	c_ltor
1863  000c ae000a        	ldw	x,#_last_bright1
1864  000f cd0000        	call	c_fgadd
1866                     ; 516 		realtime_bright1 = Linear(last_bright1);
1868  0012 be0c          	ldw	x,_last_bright1+2
1869  0014 89            	pushw	x
1870  0015 be0a          	ldw	x,_last_bright1
1871  0017 89            	pushw	x
1872  0018 cd0000        	call	_Linear
1874  001b 5b04          	addw	sp,#4
1875  001d b705          	ld	_realtime_bright1,a
1876                     ; 517 		if(last_bright1 > aim_bright1){
1878  001f 9c            	rvf
1879  0020 ae000a        	ldw	x,#_last_bright1
1880  0023 cd0000        	call	c_ltor
1882  0026 ae0000        	ldw	x,#_aim_bright1
1883  0029 cd0000        	call	c_fcmp
1885  002c 2d21          	jrsle	L106
1886                     ; 518 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
1888  002e ae000a        	ldw	x,#_last_bright1
1889  0031 cd0000        	call	c_ltor
1891  0034 ae0000        	ldw	x,#_aim_bright1
1892  0037 cd0000        	call	c_fsub
1894  003a ae000c        	ldw	x,#L734
1895  003d cd0000        	call	c_fmul
1897  0040 cd0000        	call	c_ftol
1899  0043 b603          	ld	a,c_lreg+3
1900  0045 a102          	cp	a,#2
1901  0047 2425          	jruge	L775
1902                     ; 519 				linear1_begin = 0;
1904  0049 72110000      	bres	_action_flag,#0
1905  004d 201f          	jra	L775
1906  004f               L106:
1907                     ; 522 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
1909  004f ae0000        	ldw	x,#_aim_bright1
1910  0052 cd0000        	call	c_ltor
1912  0055 ae000a        	ldw	x,#_last_bright1
1913  0058 cd0000        	call	c_fsub
1915  005b ae000c        	ldw	x,#L734
1916  005e cd0000        	call	c_fmul
1918  0061 cd0000        	call	c_ftol
1920  0064 b603          	ld	a,c_lreg+3
1921  0066 a102          	cp	a,#2
1922  0068 2404          	jruge	L775
1923                     ; 523 				linear1_begin = 0;
1925  006a 72110000      	bres	_action_flag,#0
1926  006e               L775:
1927                     ; 526 	if(linear2_begin){//channel2 Linear调光开始
1929  006e b600          	ld	a,_action_flag
1930  0070 a502          	bcp	a,#2
1931  0072 2768          	jreq	L116
1932                     ; 527 		last_bright2 += change_step2;
1934  0074 ae0000        	ldw	x,#_change_step2
1935  0077 cd0000        	call	c_ltor
1937  007a ae0006        	ldw	x,#_last_bright2
1938  007d cd0000        	call	c_fgadd
1940                     ; 528 		realtime_bright2 = Linear(last_bright2);
1942  0080 be08          	ldw	x,_last_bright2+2
1943  0082 89            	pushw	x
1944  0083 be06          	ldw	x,_last_bright2
1945  0085 89            	pushw	x
1946  0086 cd0000        	call	_Linear
1948  0089 5b04          	addw	sp,#4
1949  008b b704          	ld	_realtime_bright2,a
1950                     ; 529 		if(last_bright2 > aim_bright2){
1952  008d 9c            	rvf
1953  008e ae0006        	ldw	x,#_last_bright2
1954  0091 cd0000        	call	c_ltor
1956  0094 ae0000        	ldw	x,#_aim_bright2
1957  0097 cd0000        	call	c_fcmp
1959  009a 2d21          	jrsle	L316
1960                     ; 530 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
1962  009c ae0006        	ldw	x,#_last_bright2
1963  009f cd0000        	call	c_ltor
1965  00a2 ae0000        	ldw	x,#_aim_bright2
1966  00a5 cd0000        	call	c_fsub
1968  00a8 ae000c        	ldw	x,#L734
1969  00ab cd0000        	call	c_fmul
1971  00ae cd0000        	call	c_ftol
1973  00b1 b603          	ld	a,c_lreg+3
1974  00b3 a102          	cp	a,#2
1975  00b5 2425          	jruge	L116
1976                     ; 531 				linear2_begin = 0;
1978  00b7 72130000      	bres	_action_flag,#1
1979  00bb 201f          	jra	L116
1980  00bd               L316:
1981                     ; 534 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
1983  00bd ae0000        	ldw	x,#_aim_bright2
1984  00c0 cd0000        	call	c_ltor
1986  00c3 ae0006        	ldw	x,#_last_bright2
1987  00c6 cd0000        	call	c_fsub
1989  00c9 ae000c        	ldw	x,#L734
1990  00cc cd0000        	call	c_fmul
1992  00cf cd0000        	call	c_ftol
1994  00d2 b603          	ld	a,c_lreg+3
1995  00d4 a102          	cp	a,#2
1996  00d6 2404          	jruge	L116
1997                     ; 535 				linear2_begin = 0;
1999  00d8 72130000      	bres	_action_flag,#1
2000  00dc               L116:
2001                     ; 538 	if(eraseIn1_begin){//channel1 EraseIn调光开始
2003  00dc b600          	ld	a,_action_flag
2004  00de a504          	bcp	a,#4
2005  00e0 2768          	jreq	L326
2006                     ; 539 		last_bright1 += change_step1;
2008  00e2 ae0000        	ldw	x,#_change_step1
2009  00e5 cd0000        	call	c_ltor
2011  00e8 ae000a        	ldw	x,#_last_bright1
2012  00eb cd0000        	call	c_fgadd
2014                     ; 540 		realtime_bright1 = EraseIn(last_bright1);	
2016  00ee be0c          	ldw	x,_last_bright1+2
2017  00f0 89            	pushw	x
2018  00f1 be0a          	ldw	x,_last_bright1
2019  00f3 89            	pushw	x
2020  00f4 cd0000        	call	_EraseIn
2022  00f7 5b04          	addw	sp,#4
2023  00f9 b705          	ld	_realtime_bright1,a
2024                     ; 541 		if(last_bright1 > aim_bright1){
2026  00fb 9c            	rvf
2027  00fc ae000a        	ldw	x,#_last_bright1
2028  00ff cd0000        	call	c_ltor
2030  0102 ae0000        	ldw	x,#_aim_bright1
2031  0105 cd0000        	call	c_fcmp
2033  0108 2d21          	jrsle	L526
2034                     ; 542 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2036  010a ae000a        	ldw	x,#_last_bright1
2037  010d cd0000        	call	c_ltor
2039  0110 ae0000        	ldw	x,#_aim_bright1
2040  0113 cd0000        	call	c_fsub
2042  0116 ae000c        	ldw	x,#L734
2043  0119 cd0000        	call	c_fmul
2045  011c cd0000        	call	c_ftol
2047  011f b603          	ld	a,c_lreg+3
2048  0121 a102          	cp	a,#2
2049  0123 2425          	jruge	L326
2050                     ; 543 				eraseIn1_begin = 0;
2052  0125 72150000      	bres	_action_flag,#2
2053  0129 201f          	jra	L326
2054  012b               L526:
2055                     ; 546 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2057  012b ae0000        	ldw	x,#_aim_bright1
2058  012e cd0000        	call	c_ltor
2060  0131 ae000a        	ldw	x,#_last_bright1
2061  0134 cd0000        	call	c_fsub
2063  0137 ae000c        	ldw	x,#L734
2064  013a cd0000        	call	c_fmul
2066  013d cd0000        	call	c_ftol
2068  0140 b603          	ld	a,c_lreg+3
2069  0142 a102          	cp	a,#2
2070  0144 2404          	jruge	L326
2071                     ; 547 				eraseIn1_begin = 0;
2073  0146 72150000      	bres	_action_flag,#2
2074  014a               L326:
2075                     ; 550 	if(eraseIn2_begin){//channel2 EraseIn调光开始
2077  014a b600          	ld	a,_action_flag
2078  014c a508          	bcp	a,#8
2079  014e 2768          	jreq	L536
2080                     ; 551 		last_bright2 += change_step2;
2082  0150 ae0000        	ldw	x,#_change_step2
2083  0153 cd0000        	call	c_ltor
2085  0156 ae0006        	ldw	x,#_last_bright2
2086  0159 cd0000        	call	c_fgadd
2088                     ; 552 		realtime_bright2 = EraseIn(last_bright2);
2090  015c be08          	ldw	x,_last_bright2+2
2091  015e 89            	pushw	x
2092  015f be06          	ldw	x,_last_bright2
2093  0161 89            	pushw	x
2094  0162 cd0000        	call	_EraseIn
2096  0165 5b04          	addw	sp,#4
2097  0167 b704          	ld	_realtime_bright2,a
2098                     ; 553 		if(last_bright2 > aim_bright2){
2100  0169 9c            	rvf
2101  016a ae0006        	ldw	x,#_last_bright2
2102  016d cd0000        	call	c_ltor
2104  0170 ae0000        	ldw	x,#_aim_bright2
2105  0173 cd0000        	call	c_fcmp
2107  0176 2d21          	jrsle	L736
2108                     ; 554 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2110  0178 ae0006        	ldw	x,#_last_bright2
2111  017b cd0000        	call	c_ltor
2113  017e ae0000        	ldw	x,#_aim_bright2
2114  0181 cd0000        	call	c_fsub
2116  0184 ae000c        	ldw	x,#L734
2117  0187 cd0000        	call	c_fmul
2119  018a cd0000        	call	c_ftol
2121  018d b603          	ld	a,c_lreg+3
2122  018f a102          	cp	a,#2
2123  0191 2425          	jruge	L536
2124                     ; 555 				eraseIn2_begin = 0;
2126  0193 72170000      	bres	_action_flag,#3
2127  0197 201f          	jra	L536
2128  0199               L736:
2129                     ; 558 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2131  0199 ae0000        	ldw	x,#_aim_bright2
2132  019c cd0000        	call	c_ltor
2134  019f ae0006        	ldw	x,#_last_bright2
2135  01a2 cd0000        	call	c_fsub
2137  01a5 ae000c        	ldw	x,#L734
2138  01a8 cd0000        	call	c_fmul
2140  01ab cd0000        	call	c_ftol
2142  01ae b603          	ld	a,c_lreg+3
2143  01b0 a102          	cp	a,#2
2144  01b2 2404          	jruge	L536
2145                     ; 559 				eraseIn2_begin = 0;
2147  01b4 72170000      	bres	_action_flag,#3
2148  01b8               L536:
2149                     ; 562 	if(eraseOut1_begin){//channel1 EraseOut调光开始
2151  01b8 b600          	ld	a,_action_flag
2152  01ba a510          	bcp	a,#16
2153  01bc 2768          	jreq	L746
2154                     ; 563 		last_bright1 += change_step1;
2156  01be ae0000        	ldw	x,#_change_step1
2157  01c1 cd0000        	call	c_ltor
2159  01c4 ae000a        	ldw	x,#_last_bright1
2160  01c7 cd0000        	call	c_fgadd
2162                     ; 564 		realtime_bright1 = EraseOut(last_bright1);	
2164  01ca be0c          	ldw	x,_last_bright1+2
2165  01cc 89            	pushw	x
2166  01cd be0a          	ldw	x,_last_bright1
2167  01cf 89            	pushw	x
2168  01d0 cd0000        	call	_EraseOut
2170  01d3 5b04          	addw	sp,#4
2171  01d5 b705          	ld	_realtime_bright1,a
2172                     ; 565 		if(last_bright1 > aim_bright1){
2174  01d7 9c            	rvf
2175  01d8 ae000a        	ldw	x,#_last_bright1
2176  01db cd0000        	call	c_ltor
2178  01de ae0000        	ldw	x,#_aim_bright1
2179  01e1 cd0000        	call	c_fcmp
2181  01e4 2d21          	jrsle	L156
2182                     ; 566 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2184  01e6 ae000a        	ldw	x,#_last_bright1
2185  01e9 cd0000        	call	c_ltor
2187  01ec ae0000        	ldw	x,#_aim_bright1
2188  01ef cd0000        	call	c_fsub
2190  01f2 ae000c        	ldw	x,#L734
2191  01f5 cd0000        	call	c_fmul
2193  01f8 cd0000        	call	c_ftol
2195  01fb b603          	ld	a,c_lreg+3
2196  01fd a102          	cp	a,#2
2197  01ff 2425          	jruge	L746
2198                     ; 567 				eraseOut1_begin = 0;
2200  0201 72190000      	bres	_action_flag,#4
2201  0205 201f          	jra	L746
2202  0207               L156:
2203                     ; 570 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2205  0207 ae0000        	ldw	x,#_aim_bright1
2206  020a cd0000        	call	c_ltor
2208  020d ae000a        	ldw	x,#_last_bright1
2209  0210 cd0000        	call	c_fsub
2211  0213 ae000c        	ldw	x,#L734
2212  0216 cd0000        	call	c_fmul
2214  0219 cd0000        	call	c_ftol
2216  021c b603          	ld	a,c_lreg+3
2217  021e a102          	cp	a,#2
2218  0220 2404          	jruge	L746
2219                     ; 571 				eraseOut1_begin = 0;
2221  0222 72190000      	bres	_action_flag,#4
2222  0226               L746:
2223                     ; 574 	if(eraseOut2_begin){//channel2 EraseOut调光开始
2225  0226 b600          	ld	a,_action_flag
2226  0228 a520          	bcp	a,#32
2227  022a 2768          	jreq	L166
2228                     ; 575 		last_bright2 += change_step2;
2230  022c ae0000        	ldw	x,#_change_step2
2231  022f cd0000        	call	c_ltor
2233  0232 ae0006        	ldw	x,#_last_bright2
2234  0235 cd0000        	call	c_fgadd
2236                     ; 576 		realtime_bright2 = EraseOut(last_bright2);
2238  0238 be08          	ldw	x,_last_bright2+2
2239  023a 89            	pushw	x
2240  023b be06          	ldw	x,_last_bright2
2241  023d 89            	pushw	x
2242  023e cd0000        	call	_EraseOut
2244  0241 5b04          	addw	sp,#4
2245  0243 b704          	ld	_realtime_bright2,a
2246                     ; 577 		if(last_bright2 > aim_bright2){
2248  0245 9c            	rvf
2249  0246 ae0006        	ldw	x,#_last_bright2
2250  0249 cd0000        	call	c_ltor
2252  024c ae0000        	ldw	x,#_aim_bright2
2253  024f cd0000        	call	c_fcmp
2255  0252 2d21          	jrsle	L366
2256                     ; 578 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2258  0254 ae0006        	ldw	x,#_last_bright2
2259  0257 cd0000        	call	c_ltor
2261  025a ae0000        	ldw	x,#_aim_bright2
2262  025d cd0000        	call	c_fsub
2264  0260 ae000c        	ldw	x,#L734
2265  0263 cd0000        	call	c_fmul
2267  0266 cd0000        	call	c_ftol
2269  0269 b603          	ld	a,c_lreg+3
2270  026b a102          	cp	a,#2
2271  026d 2425          	jruge	L166
2272                     ; 579 				eraseOut2_begin = 0;
2274  026f 721b0000      	bres	_action_flag,#5
2275  0273 201f          	jra	L166
2276  0275               L366:
2277                     ; 582 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2279  0275 ae0000        	ldw	x,#_aim_bright2
2280  0278 cd0000        	call	c_ltor
2282  027b ae0006        	ldw	x,#_last_bright2
2283  027e cd0000        	call	c_fsub
2285  0281 ae000c        	ldw	x,#L734
2286  0284 cd0000        	call	c_fmul
2288  0287 cd0000        	call	c_ftol
2290  028a b603          	ld	a,c_lreg+3
2291  028c a102          	cp	a,#2
2292  028e 2404          	jruge	L166
2293                     ; 583 				eraseOut2_begin = 0;
2295  0290 721b0000      	bres	_action_flag,#5
2296  0294               L166:
2297                     ; 586 	if(swing1_begin){//channel1 Swing调光开始
2299  0294 b600          	ld	a,_action_flag
2300  0296 a540          	bcp	a,#64
2301  0298 2768          	jreq	L376
2302                     ; 587 		last_bright1 += change_step1;
2304  029a ae0000        	ldw	x,#_change_step1
2305  029d cd0000        	call	c_ltor
2307  02a0 ae000a        	ldw	x,#_last_bright1
2308  02a3 cd0000        	call	c_fgadd
2310                     ; 588 		realtime_bright1 = Swing(last_bright1);	
2312  02a6 be0c          	ldw	x,_last_bright1+2
2313  02a8 89            	pushw	x
2314  02a9 be0a          	ldw	x,_last_bright1
2315  02ab 89            	pushw	x
2316  02ac cd0000        	call	_Swing
2318  02af 5b04          	addw	sp,#4
2319  02b1 b705          	ld	_realtime_bright1,a
2320                     ; 589 		if(last_bright1 > aim_bright1){
2322  02b3 9c            	rvf
2323  02b4 ae000a        	ldw	x,#_last_bright1
2324  02b7 cd0000        	call	c_ltor
2326  02ba ae0000        	ldw	x,#_aim_bright1
2327  02bd cd0000        	call	c_fcmp
2329  02c0 2d21          	jrsle	L576
2330                     ; 590 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2332  02c2 ae000a        	ldw	x,#_last_bright1
2333  02c5 cd0000        	call	c_ltor
2335  02c8 ae0000        	ldw	x,#_aim_bright1
2336  02cb cd0000        	call	c_fsub
2338  02ce ae000c        	ldw	x,#L734
2339  02d1 cd0000        	call	c_fmul
2341  02d4 cd0000        	call	c_ftol
2343  02d7 b603          	ld	a,c_lreg+3
2344  02d9 a102          	cp	a,#2
2345  02db 2425          	jruge	L376
2346                     ; 591 				swing1_begin = 0;
2348  02dd 721d0000      	bres	_action_flag,#6
2349  02e1 201f          	jra	L376
2350  02e3               L576:
2351                     ; 594 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2353  02e3 ae0000        	ldw	x,#_aim_bright1
2354  02e6 cd0000        	call	c_ltor
2356  02e9 ae000a        	ldw	x,#_last_bright1
2357  02ec cd0000        	call	c_fsub
2359  02ef ae000c        	ldw	x,#L734
2360  02f2 cd0000        	call	c_fmul
2362  02f5 cd0000        	call	c_ftol
2364  02f8 b603          	ld	a,c_lreg+3
2365  02fa a102          	cp	a,#2
2366  02fc 2404          	jruge	L376
2367                     ; 595 				swing1_begin = 0;
2369  02fe 721d0000      	bres	_action_flag,#6
2370  0302               L376:
2371                     ; 598 	if(swing2_begin){//channel2 Swing调光开始
2373  0302 b600          	ld	a,_action_flag
2374  0304 a580          	bcp	a,#128
2375  0306 2768          	jreq	L507
2376                     ; 599 		last_bright2 += change_step2;
2378  0308 ae0000        	ldw	x,#_change_step2
2379  030b cd0000        	call	c_ltor
2381  030e ae0006        	ldw	x,#_last_bright2
2382  0311 cd0000        	call	c_fgadd
2384                     ; 600 		realtime_bright2 = Swing(last_bright2);
2386  0314 be08          	ldw	x,_last_bright2+2
2387  0316 89            	pushw	x
2388  0317 be06          	ldw	x,_last_bright2
2389  0319 89            	pushw	x
2390  031a cd0000        	call	_Swing
2392  031d 5b04          	addw	sp,#4
2393  031f b704          	ld	_realtime_bright2,a
2394                     ; 601 		if(last_bright2 > aim_bright2){
2396  0321 9c            	rvf
2397  0322 ae0006        	ldw	x,#_last_bright2
2398  0325 cd0000        	call	c_ltor
2400  0328 ae0000        	ldw	x,#_aim_bright2
2401  032b cd0000        	call	c_fcmp
2403  032e 2d21          	jrsle	L707
2404                     ; 602 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2406  0330 ae0006        	ldw	x,#_last_bright2
2407  0333 cd0000        	call	c_ltor
2409  0336 ae0000        	ldw	x,#_aim_bright2
2410  0339 cd0000        	call	c_fsub
2412  033c ae000c        	ldw	x,#L734
2413  033f cd0000        	call	c_fmul
2415  0342 cd0000        	call	c_ftol
2417  0345 b603          	ld	a,c_lreg+3
2418  0347 a102          	cp	a,#2
2419  0349 2425          	jruge	L507
2420                     ; 603 				swing2_begin = 0;
2422  034b 721f0000      	bres	_action_flag,#7
2423  034f 201f          	jra	L507
2424  0351               L707:
2425                     ; 606 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2427  0351 ae0000        	ldw	x,#_aim_bright2
2428  0354 cd0000        	call	c_ltor
2430  0357 ae0006        	ldw	x,#_last_bright2
2431  035a cd0000        	call	c_fsub
2433  035d ae000c        	ldw	x,#L734
2434  0360 cd0000        	call	c_fmul
2436  0363 cd0000        	call	c_ftol
2438  0366 b603          	ld	a,c_lreg+3
2439  0368 a102          	cp	a,#2
2440  036a 2404          	jruge	L507
2441                     ; 607 				swing2_begin = 0;
2443  036c 721f0000      	bres	_action_flag,#7
2444  0370               L507:
2445                     ; 610 }
2448  0370 81            	ret
2750                     	xdef	_Swing
2751                     	xdef	_EraseOut
2752                     	xdef	_EraseIn
2753                     	xdef	_Linear
2754                     	xdef	_main
2755                     	xdef	_delay
2756                     	switch	.ubsct
2757  0000               _tick1s:
2758  0000 00            	ds.b	1
2759                     	xdef	_tick1s
2760  0001               _f_100ms:
2761  0001 00            	ds.b	1
2762                     	xdef	_f_100ms
2763  0002               _Tick100ms:
2764  0002 0000          	ds.b	2
2765                     	xdef	_Tick100ms
2766                     	xref.b	_action_flag
2767                     	xref.b	_change_step2
2768                     	xref.b	_change_step1
2769                     	xref.b	_aim_bright2
2770                     	xref.b	_aim_bright1
2771                     	xref.b	_channel
2772  0004               _realtime_bright2:
2773  0004 00            	ds.b	1
2774                     	xdef	_realtime_bright2
2775  0005               _realtime_bright1:
2776  0005 00            	ds.b	1
2777                     	xdef	_realtime_bright1
2778  0006               _last_bright2:
2779  0006 00000000      	ds.b	4
2780                     	xdef	_last_bright2
2781  000a               _last_bright1:
2782  000a 00000000      	ds.b	4
2783                     	xdef	_last_bright1
2784                     	xref.b	_slave_address
2785                     	xref.b	_slc
2786                     	xref	_IIC_SlaveConfig
2787                     	xdef	f_Timer4_ISR
2788                     	xdef	f_Timer2_ISR
2789                     	xdef	f_Ext_PortD_ISR
2790                     	xdef	_lightCtrl100ms
2791                     	xdef	_sys
2792                     	xdef	_assert_failed
2793                     	xref	_TIM4_ClearITPendingBit
2794                     	xref	_TIM4_ClearFlag
2795                     	xref	_TIM4_SetAutoreload
2796                     	xref	_TIM4_ITConfig
2797                     	xref	_TIM4_Cmd
2798                     	xref	_TIM4_TimeBaseInit
2799                     	xref	_TIM2_ClearITPendingBit
2800                     	xref	_TIM2_ClearFlag
2801                     	xref	_TIM2_SetAutoreload
2802                     	xref	_TIM2_ITConfig
2803                     	xref	_TIM2_Cmd
2804                     	xref	_TIM2_TimeBaseInit
2805                     	xref	_ITC_SetSoftwarePriority
2806                     	xref	_ITC_DeInit
2807                     	xref	_GPIO_ReadOutputData
2808                     	xref	_GPIO_ReadInputData
2809                     	xref	_GPIO_WriteLow
2810                     	xref	_GPIO_WriteHigh
2811                     	xref	_GPIO_Init
2812                     	xref	_EXTI_SetExtIntSensitivity
2813                     	xref	_EXTI_DeInit
2814                     	xref	_CLK_PeripheralClockConfig
2815                     .const:	section	.text
2816  0000               L165:
2817  0000 3f800000      	dc.w	16256,0
2818  0004               L745:
2819  0004 40000000      	dc.w	16384,0
2820  0008               L735:
2821  0008 3f000000      	dc.w	16128,0
2822  000c               L734:
2823  000c 437a0000      	dc.w	17274,0
2824  0010               L142:
2825  0010 3e23d70a      	dc.w	15907,-10486
2826  0014               L361:
2827  0014 42c80000      	dc.w	17096,0
2828                     	xref.b	c_lreg
2829                     	xref.b	c_x
2830                     	xref.b	c_y
2850                     	xref	c_fgadd
2851                     	xref	c_fsub
2852                     	xref	c_fcmp
2853                     	xref	c_rtol
2854                     	xref	c_ctof
2855                     	xref	c_ftol
2856                     	xref	c_fmul
2857                     	xref	c_ltor
2858                     	end
