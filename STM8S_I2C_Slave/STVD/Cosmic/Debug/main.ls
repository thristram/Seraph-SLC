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
 164                     ; 80 void main(void)
 164                     ; 81 {
 165                     .text:	section	.text,new
 166  0000               _main:
 170                     ; 86 	CLK->SWCR |= 0x02; //开启切换
 172  0000 721250c5      	bset	20677,#1
 173                     ; 87   CLK->SWR   = 0xb4;       //选择时钟为外部8M
 175  0004 35b450c4      	mov	20676,#180
 177  0008               L701:
 178                     ; 88   while((CLK->SWCR & 0x01)==0x01);
 180  0008 c650c5        	ld	a,20677
 181  000b a401          	and	a,#1
 182  000d a101          	cp	a,#1
 183  000f 27f7          	jreq	L701
 184                     ; 89   CLK->CKDIVR = 0x80;    //不分频
 186  0011 358050c6      	mov	20678,#128
 187                     ; 90   CLK->SWCR  &= ~0x02; //关闭切换
 189  0015 721350c5      	bres	20677,#1
 190                     ; 93 	slave_address = 0x00;
 192  0019 3f00          	clr	_slave_address
 193                     ; 94 	GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
 195  001b 4b00          	push	#0
 196  001d 4b04          	push	#4
 197  001f ae500f        	ldw	x,#20495
 198  0022 cd0000        	call	_GPIO_Init
 200  0025 85            	popw	x
 201                     ; 95 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);
 203  0026 4b00          	push	#0
 204  0028 4b80          	push	#128
 205  002a ae500a        	ldw	x,#20490
 206  002d cd0000        	call	_GPIO_Init
 208  0030 85            	popw	x
 209                     ; 96 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 211  0031 4b00          	push	#0
 212  0033 4b40          	push	#64
 213  0035 ae500a        	ldw	x,#20490
 214  0038 cd0000        	call	_GPIO_Init
 216  003b 85            	popw	x
 217                     ; 97 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 219  003c 4b00          	push	#0
 220  003e 4b40          	push	#64
 221  0040 ae500a        	ldw	x,#20490
 222  0043 cd0000        	call	_GPIO_Init
 224  0046 85            	popw	x
 225                     ; 98 	GPIO_Init(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
 227  0047 4b00          	push	#0
 228  0049 4b08          	push	#8
 229  004b ae5000        	ldw	x,#20480
 230  004e cd0000        	call	_GPIO_Init
 232  0051 85            	popw	x
 233                     ; 99 	delay(100);
 235  0052 ae0064        	ldw	x,#100
 236  0055 cd0000        	call	_delay
 238                     ; 101 	if(GPIO_ReadInputData(GPIOD) & 0x04)	slave_address |= 0x08;
 240  0058 ae500f        	ldw	x,#20495
 241  005b cd0000        	call	_GPIO_ReadInputData
 243  005e a504          	bcp	a,#4
 244  0060 2704          	jreq	L311
 247  0062 72160000      	bset	_slave_address,#3
 248  0066               L311:
 249                     ; 102 	if(GPIO_ReadInputData(GPIOC) & 0x20)	slave_address |= 0x04;
 251  0066 ae500a        	ldw	x,#20490
 252  0069 cd0000        	call	_GPIO_ReadInputData
 254  006c a520          	bcp	a,#32
 255  006e 2704          	jreq	L511
 258  0070 72140000      	bset	_slave_address,#2
 259  0074               L511:
 260                     ; 103 	if(GPIO_ReadInputData(GPIOC) & 0x40)	slave_address |= 0x02;
 262  0074 ae500a        	ldw	x,#20490
 263  0077 cd0000        	call	_GPIO_ReadInputData
 265  007a a540          	bcp	a,#64
 266  007c 2704          	jreq	L711
 269  007e 72120000      	bset	_slave_address,#1
 270  0082               L711:
 271                     ; 104 	if(GPIO_ReadInputData(GPIOC) & 0x80)	slave_address |= 0x01;
 273  0082 ae500a        	ldw	x,#20490
 274  0085 cd0000        	call	_GPIO_ReadInputData
 276  0088 a580          	bcp	a,#128
 277  008a 2704          	jreq	L121
 280  008c 72100000      	bset	_slave_address,#0
 281  0090               L121:
 282                     ; 105 	slc.MDID = slave_address;
 284  0090 b600          	ld	a,_slave_address
 285  0092 5f            	clrw	x
 286  0093 97            	ld	xl,a
 287  0094 bf13          	ldw	_slc+19,x
 288                     ; 106 	GPIO_Config();
 290  0096 cd0000        	call	L5_GPIO_Config
 292                     ; 107 	Sys_Init();
 294  0099 cd0000        	call	L3_Sys_Init
 296                     ; 108 	ExtInterrupt_Config();
 298  009c cd0000        	call	L7_ExtInterrupt_Config
 300                     ; 109 	TIMER4_Init();
 302  009f cd0000        	call	L31_TIMER4_Init
 304                     ; 116 	IIC_SlaveConfig();
 306  00a2 cd0000        	call	_IIC_SlaveConfig
 308                     ; 117 	disableInterrupts();
 311  00a5 9b            sim
 313                     ; 119 	ITC_DeInit();
 316  00a6 cd0000        	call	_ITC_DeInit
 318                     ; 120 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD,ITC_PRIORITYLEVEL_2);
 320  00a9 5f            	clrw	x
 321  00aa a606          	ld	a,#6
 322  00ac 95            	ld	xh,a
 323  00ad cd0000        	call	_ITC_SetSoftwarePriority
 325                     ; 121 	ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF,ITC_PRIORITYLEVEL_2);
 327  00b0 5f            	clrw	x
 328  00b1 a60d          	ld	a,#13
 329  00b3 95            	ld	xh,a
 330  00b4 cd0000        	call	_ITC_SetSoftwarePriority
 332                     ; 122 	ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF,ITC_PRIORITYLEVEL_2);
 334  00b7 5f            	clrw	x
 335  00b8 a617          	ld	a,#23
 336  00ba 95            	ld	xh,a
 337  00bb cd0000        	call	_ITC_SetSoftwarePriority
 339                     ; 123 	ITC_SetSoftwarePriority(ITC_IRQ_I2C,ITC_PRIORITYLEVEL_3);
 341  00be ae0003        	ldw	x,#3
 342  00c1 a613          	ld	a,#19
 343  00c3 95            	ld	xh,a
 344  00c4 cd0000        	call	_ITC_SetSoftwarePriority
 346                     ; 126 	enableInterrupts();
 349  00c7 9a            rim
 353  00c8 2016          	jra	L521
 354  00ca               L321:
 355                     ; 130 		 if (sys.checkAcCnt == 0)
 357  00ca be0e          	ldw	x,_sys+14
 358  00cc 2612          	jrne	L521
 359                     ; 137 			sys.gotHzFlag = FALSE;    
 361  00ce 3f09          	clr	_sys+9
 362                     ; 138 			sys.reqCalHzFlag = FALSE;
 364  00d0 3f08          	clr	_sys+8
 365                     ; 139 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 367  00d2 350a000b      	mov	_sys+11,#10
 368                     ; 140 			sys.hzCnt = 0;
 370  00d6 5f            	clrw	x
 371  00d7 bf0c          	ldw	_sys+12,x
 372                     ; 141 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 374  00d9 ae07d0        	ldw	x,#2000
 375  00dc bf0e          	ldw	_sys+14,x
 376                     ; 142 			break;
 378  00de 201a          	jra	L531
 379  00e0               L521:
 380                     ; 128 	 while(!sys.gotHzFlag)
 382  00e0 3d09          	tnz	_sys+9
 383  00e2 27e6          	jreq	L321
 384  00e4 2014          	jra	L531
 385  00e6               L331:
 386                     ; 149 		 if (sys.checkAcCnt == 0)
 388  00e6 be0e          	ldw	x,_sys+14
 389  00e8 2610          	jrne	L531
 390                     ; 152 			sys.gotHzFlag = FALSE;    
 392  00ea 3f09          	clr	_sys+9
 393                     ; 153 			sys.reqCalHzFlag = FALSE;
 395  00ec 3f08          	clr	_sys+8
 396                     ; 154 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 398  00ee 350a000b      	mov	_sys+11,#10
 399                     ; 155 			sys.hzCnt = 0;
 401  00f2 5f            	clrw	x
 402  00f3 bf0c          	ldw	_sys+12,x
 403                     ; 156 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 405  00f5 ae07d0        	ldw	x,#2000
 406  00f8 bf0e          	ldw	_sys+14,x
 407  00fa               L531:
 408                     ; 147 	 while(!sys.gotHzFlag)
 410  00fa 3d09          	tnz	_sys+9
 411  00fc 27e8          	jreq	L331
 412                     ; 159 	 sys.acOkFlag = TRUE;
 414  00fe 35010011      	mov	_sys+17,#1
 415                     ; 160 	 TIMER2_Init();
 417  0102 cd0000        	call	L11_TIMER2_Init
 419  0105               L341:
 420                     ; 167 		if(ReceiveState == IIC_STATE_END)
 422  0105 b600          	ld	a,_ReceiveState
 423  0107 a103          	cp	a,#3
 424  0109 2604          	jrne	L741
 425                     ; 173 			ReceiveState = IIC_STATE_UNKNOWN;
 427  010b 3f00          	clr	_ReceiveState
 428                     ; 174 			GetDataIndex = 0;
 430  010d 3f00          	clr	_GetDataIndex
 431  010f               L741:
 432                     ; 177 		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE)
 434  010f be0e          	ldw	x,_sys+14
 435  0111 260a          	jrne	L151
 437  0113 3d10          	tnz	_sys+16
 438  0115 2606          	jrne	L151
 439                     ; 181 			 sys.acErrFlag = TRUE;
 441  0117 35010010      	mov	_sys+16,#1
 442                     ; 182 			 sys.acOkFlag = FALSE;
 444  011b 3f11          	clr	_sys+17
 445  011d               L151:
 446                     ; 185 		if (sys.acErrFlag == FALSE && sys.acOkFlag == FALSE)
 448  011d 3d10          	tnz	_sys+16
 449  011f 260d          	jrne	L351
 451  0121 3d11          	tnz	_sys+17
 452  0123 2609          	jrne	L351
 453                     ; 189 			sys.acOkFlag = TRUE;
 455  0125 35010011      	mov	_sys+17,#1
 456                     ; 190 			sys.cnt1s = CNT_1S;
 458  0129 ae4e20        	ldw	x,#20000
 459  012c bf1b          	ldw	_sys+27,x
 460  012e               L351:
 461                     ; 193 		if(f_100ms){
 463  012e 3d01          	tnz	_f_100ms
 464  0130 2705          	jreq	L551
 465                     ; 194 			f_100ms = 0;
 467  0132 3f01          	clr	_f_100ms
 468                     ; 195 			lightCtrl100ms();
 470  0134 cd0000        	call	_lightCtrl100ms
 472  0137               L551:
 473                     ; 207 		if((channel & 0x01)==0x01)//调节Dimmer1
 475  0137 b600          	ld	a,_channel
 476  0139 a401          	and	a,#1
 477  013b a101          	cp	a,#1
 478  013d 2616          	jrne	L751
 479                     ; 209 			sys.light1.briVal = realtime_bright1;
 481  013f 450502        	mov	_sys+2,_realtime_bright1
 482                     ; 210 			slc.ch1_status = (u8)(last_bright1*100);
 484  0142 ae000a        	ldw	x,#_last_bright1
 485  0145 cd0000        	call	c_ltor
 487  0148 ae0014        	ldw	x,#L561
 488  014b cd0000        	call	c_fmul
 490  014e cd0000        	call	c_ftol
 492  0151 b603          	ld	a,c_lreg+3
 493  0153 b715          	ld	_slc+21,a
 494  0155               L751:
 495                     ; 212 		if((channel & 0x02)==0x02)//调节Dimmer2
 497  0155 b600          	ld	a,_channel
 498  0157 a402          	and	a,#2
 499  0159 a102          	cp	a,#2
 500  015b 2616          	jrne	L171
 501                     ; 214 			sys.light2.briVal = realtime_bright2;
 503  015d 450406        	mov	_sys+6,_realtime_bright2
 504                     ; 215 			slc.ch2_status = (u8)(last_bright2*100);
 506  0160 ae0006        	ldw	x,#_last_bright2
 507  0163 cd0000        	call	c_ltor
 509  0166 ae0014        	ldw	x,#L561
 510  0169 cd0000        	call	c_fmul
 512  016c cd0000        	call	c_ftol
 514  016f b603          	ld	a,c_lreg+3
 515  0171 b716          	ld	_slc+22,a
 516  0173               L171:
 517                     ; 217 		if (sys.acOkFlag && sys.cnt1s == 0)
 519  0173 3d11          	tnz	_sys+17
 520  0175 278e          	jreq	L341
 522  0177 be1b          	ldw	x,_sys+27
 523  0179 268a          	jrne	L341
 524                     ; 222 			sys.cnt1s = CNT_1S;
 526  017b ae4e20        	ldw	x,#20000
 527  017e bf1b          	ldw	_sys+27,x
 528  0180 2083          	jpf	L341
 563                     ; 236 void assert_failed(uint8_t* file, uint32_t line)
 563                     ; 237 { 
 564                     .text:	section	.text,new
 565  0000               _assert_failed:
 569  0000               L312:
 570  0000 20fe          	jra	L312
 595                     ; 248 static void GPIO_Config(void)
 595                     ; 249 {
 596                     .text:	section	.text,new
 597  0000               L5_GPIO_Config:
 601                     ; 251     GPIO_Init(L1_EN_PIN_PORT, (GPIO_Pin_TypeDef)L1_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
 603  0000 4bd0          	push	#208
 604  0002 4b10          	push	#16
 605  0004 ae500a        	ldw	x,#20490
 606  0007 cd0000        	call	_GPIO_Init
 608  000a 85            	popw	x
 609                     ; 252     GPIO_Init(L2_EN_PIN_PORT, (GPIO_Pin_TypeDef)L2_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);   
 611  000b 4bd0          	push	#208
 612  000d 4b08          	push	#8
 613  000f ae500a        	ldw	x,#20490
 614  0012 cd0000        	call	_GPIO_Init
 616  0015 85            	popw	x
 617                     ; 253     L1_EN_OFF;
 619  0016 4b10          	push	#16
 620  0018 ae500a        	ldw	x,#20490
 621  001b cd0000        	call	_GPIO_WriteHigh
 623  001e 84            	pop	a
 624                     ; 254     L2_EN_OFF;
 626  001f 4b08          	push	#8
 627  0021 ae500a        	ldw	x,#20490
 628  0024 cd0000        	call	_GPIO_WriteHigh
 630  0027 84            	pop	a
 631                     ; 255     GPIO_Init(ZD_PIN_PORT, (GPIO_Pin_TypeDef)ZD_PIN, GPIO_MODE_IN_FL_IT);  
 633  0028 4b20          	push	#32
 634  002a 4b08          	push	#8
 635  002c ae500f        	ldw	x,#20495
 636  002f cd0000        	call	_GPIO_Init
 638  0032 85            	popw	x
 639                     ; 257 }
 642  0033 81            	ret
 671                     ; 259 static void Sys_Init(void)
 671                     ; 260 {
 672                     .text:	section	.text,new
 673  0000               L3_Sys_Init:
 677                     ; 261     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 679  0000 ae0001        	ldw	x,#1
 680  0003 a604          	ld	a,#4
 681  0005 95            	ld	xh,a
 682  0006 cd0000        	call	_CLK_PeripheralClockConfig
 684                     ; 262     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 686  0009 ae0001        	ldw	x,#1
 687  000c a605          	ld	a,#5
 688  000e 95            	ld	xh,a
 689  000f cd0000        	call	_CLK_PeripheralClockConfig
 691                     ; 264     sys.gotHzFlag = FALSE;    
 693  0012 3f09          	clr	_sys+9
 694                     ; 265     sys.reqCalHzFlag = FALSE;
 696  0014 3f08          	clr	_sys+8
 697                     ; 266     sys.light1.briVal = DEFAULT_BRIGHTNESS;
 699  0016 35280002      	mov	_sys+2,#40
 700                     ; 267     sys.light2.briVal = DEFAULT_BRIGHTNESS;    
 702  001a 35280006      	mov	_sys+6,#40
 703                     ; 268     sys.calHzIntCnt = GET_AC_FRE_CNT;
 705  001e 350a000b      	mov	_sys+11,#10
 706                     ; 269     sys.hzCnt = 0;
 708  0022 5f            	clrw	x
 709  0023 bf0c          	ldw	_sys+12,x
 710                     ; 270     sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 712  0025 ae07d0        	ldw	x,#2000
 713  0028 bf0e          	ldw	_sys+14,x
 714                     ; 271 		last_bright1 = 0.16;
 716  002a ce0012        	ldw	x,L342+2
 717  002d bf0c          	ldw	_last_bright1+2,x
 718  002f ce0010        	ldw	x,L342
 719  0032 bf0a          	ldw	_last_bright1,x
 720                     ; 272 		aim_bright1 = 0;
 722  0034 ae0000        	ldw	x,#0
 723  0037 bf02          	ldw	_aim_bright1+2,x
 724  0039 ae0000        	ldw	x,#0
 725  003c bf00          	ldw	_aim_bright1,x
 726                     ; 273 		last_bright2 = 0.16;
 728  003e ce0012        	ldw	x,L342+2
 729  0041 bf08          	ldw	_last_bright2+2,x
 730  0043 ce0010        	ldw	x,L342
 731  0046 bf06          	ldw	_last_bright2,x
 732                     ; 274 		aim_bright2 = 0;
 734  0048 ae0000        	ldw	x,#0
 735  004b bf02          	ldw	_aim_bright2+2,x
 736  004d ae0000        	ldw	x,#0
 737  0050 bf00          	ldw	_aim_bright2,x
 738                     ; 275 }
 741  0052 81            	ret
 767                     ; 277 static void ExtInterrupt_Config(void)
 767                     ; 278 {
 768                     .text:	section	.text,new
 769  0000               L7_ExtInterrupt_Config:
 773                     ; 280 	EXTI_DeInit();
 775  0000 cd0000        	call	_EXTI_DeInit
 777                     ; 281 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 779  0003 ae0002        	ldw	x,#2
 780  0006 a603          	ld	a,#3
 781  0008 95            	ld	xh,a
 782  0009 cd0000        	call	_EXTI_SetExtIntSensitivity
 784                     ; 283 }
 787  000c 81            	ret
 817                     ; 289 @far @interrupt void Ext_PortD_ISR(void) {
 819                     .text:	section	.text,new
 820  0000               f_Ext_PortD_ISR:
 823  0000 3b0002        	push	c_x+2
 824  0003 be00          	ldw	x,c_x
 825  0005 89            	pushw	x
 826  0006 3b0002        	push	c_y+2
 827  0009 be00          	ldw	x,c_y
 828  000b 89            	pushw	x
 831                     ; 292 	if (ZD_STATUS == 0)
 833  000c ae500f        	ldw	x,#20495
 834  000f cd0000        	call	_GPIO_ReadOutputData
 836  0012 a508          	bcp	a,#8
 837  0014 2704          	jreq	L62
 838  0016 acc800c8      	jpf	L762
 839  001a               L62:
 840                     ; 294 		sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 842  001a ae07d0        	ldw	x,#2000
 843  001d bf0e          	ldw	_sys+14,x
 844                     ; 295 		sys.acErrFlag = FALSE;
 846  001f 3f10          	clr	_sys+16
 847                     ; 298 		if (!sys.gotHzFlag)
 849  0021 3d09          	tnz	_sys+9
 850  0023 262f          	jrne	L172
 851                     ; 300 			if (!sys.reqCalHzFlag)
 853  0025 3d08          	tnz	_sys+8
 854  0027 2609          	jrne	L372
 855                     ; 302 				TIM4_SetAutoreload(TIMER4_INT_TIME);				
 857  0029 a632          	ld	a,#50
 858  002b cd0000        	call	_TIM4_SetAutoreload
 860                     ; 303 				sys.reqCalHzFlag = TRUE;
 862  002e 35010008      	mov	_sys+8,#1
 863  0032               L372:
 864                     ; 305 			if (sys.calHzIntCnt == 0)
 866  0032 3d0b          	tnz	_sys+11
 867  0034 261a          	jrne	L572
 868                     ; 307 				if ((sys.hzCnt/GET_AC_FRE_CNT) >= HZ_COUNT)
 870  0036 be0c          	ldw	x,_sys+12
 871  0038 a60a          	ld	a,#10
 872  003a 62            	div	x,a
 873  003b a300b4        	cpw	x,#180
 874  003e 2506          	jrult	L772
 875                     ; 309 					sys.hz50Flag = TRUE;
 877  0040 3501000a      	mov	_sys+10,#1
 879  0044 2002          	jra	L103
 880  0046               L772:
 881                     ; 313 					sys.hz50Flag = FALSE;
 883  0046 3f0a          	clr	_sys+10
 884  0048               L103:
 885                     ; 316 				sys.gotHzFlag = TRUE;
 887  0048 35010009      	mov	_sys+9,#1
 888                     ; 317 				sys.reqCalHzFlag = FALSE;
 890  004c 3f08          	clr	_sys+8
 892  004e 2078          	jra	L762
 893  0050               L572:
 894                     ; 321 				sys.calHzIntCnt--;
 896  0050 3a0b          	dec	_sys+11
 897  0052 2074          	jra	L762
 898  0054               L172:
 899                     ; 326 			if (sys.light1.briVal == MAX_BRIGHTNESS)
 901  0054 b602          	ld	a,_sys+2
 902  0056 a1fa          	cp	a,#250
 903  0058 2615          	jrne	L703
 904                     ; 330 				L1_EN_ON;
 906  005a 4b10          	push	#16
 907  005c ae500a        	ldw	x,#20490
 908  005f cd0000        	call	_GPIO_WriteLow
 910  0062 84            	pop	a
 913  0063 35280001      	mov	_sys+1,#40
 914                     ; 331 				sys.light1.briCnt = 0;
 916  0067 3f00          	clr	_sys
 917                     ; 332 				sys.light1.onFlag = TRUE;			
 919  0069 35010003      	mov	_sys+3,#1
 921  006d 2011          	jra	L113
 922  006f               L703:
 923                     ; 337 				sys.light1.briCnt = MAX_BRIGHTNESS - sys.light1.briVal;				
 925  006f a6fa          	ld	a,#250
 926  0071 b002          	sub	a,_sys+2
 927  0073 b700          	ld	_sys,a
 928                     ; 338 				sys.light1.onFlag = FALSE;
 930  0075 3f03          	clr	_sys+3
 931                     ; 339 				L1_EN_OFF;
 933  0077 4b10          	push	#16
 934  0079 ae500a        	ldw	x,#20490
 935  007c cd0000        	call	_GPIO_WriteHigh
 937  007f 84            	pop	a
 938  0080               L113:
 939                     ; 342 			if (sys.light2.briVal == MAX_BRIGHTNESS)
 941  0080 b606          	ld	a,_sys+6
 942  0082 a1fa          	cp	a,#250
 943  0084 2615          	jrne	L313
 944                     ; 344 				L2_EN_ON;
 946  0086 4b08          	push	#8
 947  0088 ae500a        	ldw	x,#20490
 948  008b cd0000        	call	_GPIO_WriteLow
 950  008e 84            	pop	a
 953  008f 35280005      	mov	_sys+5,#40
 954                     ; 345 				sys.light2.briCnt = 0;
 956  0093 3f04          	clr	_sys+4
 957                     ; 346 				sys.light2.onFlag = TRUE;			
 959  0095 35010007      	mov	_sys+7,#1
 961  0099 2011          	jra	L513
 962  009b               L313:
 963                     ; 350 				sys.light2.briCnt = MAX_BRIGHTNESS - sys.light2.briVal;
 965  009b a6fa          	ld	a,#250
 966  009d b006          	sub	a,_sys+6
 967  009f b704          	ld	_sys+4,a
 968                     ; 351 				sys.light2.onFlag = FALSE;				
 970  00a1 3f07          	clr	_sys+7
 971                     ; 352 				L2_EN_OFF;
 973  00a3 4b08          	push	#8
 974  00a5 ae500a        	ldw	x,#20490
 975  00a8 cd0000        	call	_GPIO_WriteHigh
 977  00ab 84            	pop	a
 978  00ac               L513:
 979                     ; 355 			if (sys.light1.briCnt || sys.light2.briCnt)
 981  00ac 3d00          	tnz	_sys
 982  00ae 2604          	jrne	L123
 984  00b0 3d04          	tnz	_sys+4
 985  00b2 2714          	jreq	L762
 986  00b4               L123:
 987                     ; 358 				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
 989  00b4 3d0a          	tnz	_sys+10
 990  00b6 2705          	jreq	L22
 991  00b8 ae0028        	ldw	x,#40
 992  00bb 2003          	jra	L42
 993  00bd               L22:
 994  00bd ae0021        	ldw	x,#33
 995  00c0               L42:
 996  00c0 cd0000        	call	_TIM2_SetAutoreload
 998                     ; 359 				TIM2_Cmd(ENABLE);
1000  00c3 a601          	ld	a,#1
1001  00c5 cd0000        	call	_TIM2_Cmd
1003  00c8               L762:
1004                     ; 363 }
1007  00c8 85            	popw	x
1008  00c9 bf00          	ldw	c_y,x
1009  00cb 320002        	pop	c_y+2
1010  00ce 85            	popw	x
1011  00cf bf00          	ldw	c_x,x
1012  00d1 320002        	pop	c_x+2
1013  00d4 80            	iret
1039                     ; 383 static void TIMER4_Init(void)
1039                     ; 384 {    
1041                     .text:	section	.text,new
1042  0000               L31_TIMER4_Init:
1046                     ; 385     TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIMER4_INT_TIME);
1048  0000 ae0032        	ldw	x,#50
1049  0003 a604          	ld	a,#4
1050  0005 95            	ld	xh,a
1051  0006 cd0000        	call	_TIM4_TimeBaseInit
1053                     ; 386     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
1055  0009 a601          	ld	a,#1
1056  000b cd0000        	call	_TIM4_ClearFlag
1058                     ; 387     TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);	
1060  000e ae0001        	ldw	x,#1
1061  0011 a601          	ld	a,#1
1062  0013 95            	ld	xh,a
1063  0014 cd0000        	call	_TIM4_ITConfig
1065                     ; 388     TIM4_Cmd(ENABLE);
1067  0017 a601          	ld	a,#1
1068  0019 cd0000        	call	_TIM4_Cmd
1070                     ; 389 }
1073  001c 81            	ret
1101                     ; 395 @far @interrupt void Timer4_ISR(void) {
1103                     .text:	section	.text,new
1104  0000               f_Timer4_ISR:
1107  0000 3b0002        	push	c_x+2
1108  0003 be00          	ldw	x,c_x
1109  0005 89            	pushw	x
1110  0006 3b0002        	push	c_y+2
1111  0009 be00          	ldw	x,c_y
1112  000b 89            	pushw	x
1115                     ; 397 TIM4_ClearITPendingBit(TIM4_IT_UPDATE);  
1117  000c a601          	ld	a,#1
1118  000e cd0000        	call	_TIM4_ClearITPendingBit
1120                     ; 398   if (sys.reqCalHzFlag)
1122  0011 3d08          	tnz	_sys+8
1123  0013 2707          	jreq	L343
1124                     ; 400 	  sys.hzCnt++; 	  
1126  0015 be0c          	ldw	x,_sys+12
1127  0017 1c0001        	addw	x,#1
1128  001a bf0c          	ldw	_sys+12,x
1129  001c               L343:
1130                     ; 403   if (sys.light1.triacTriggeTime)
1132  001c 3d01          	tnz	_sys+1
1133  001e 270f          	jreq	L543
1134                     ; 405 	  sys.light1.triacTriggeTime--;
1136  0020 3a01          	dec	_sys+1
1137                     ; 406 	  if (sys.light1.triacTriggeTime == 0)
1139  0022 3d01          	tnz	_sys+1
1140  0024 2609          	jrne	L543
1141                     ; 408 		  L1_EN_OFF;
1143  0026 4b10          	push	#16
1144  0028 ae500a        	ldw	x,#20490
1145  002b cd0000        	call	_GPIO_WriteHigh
1147  002e 84            	pop	a
1148  002f               L543:
1149                     ; 413   if (sys.light2.triacTriggeTime)
1151  002f 3d05          	tnz	_sys+5
1152  0031 270f          	jreq	L153
1153                     ; 415 	  sys.light2.triacTriggeTime--;
1155  0033 3a05          	dec	_sys+5
1156                     ; 416 	  if (sys.light2.triacTriggeTime == 0)
1158  0035 3d05          	tnz	_sys+5
1159  0037 2609          	jrne	L153
1160                     ; 418 		  L2_EN_OFF;
1162  0039 4b08          	push	#8
1163  003b ae500a        	ldw	x,#20490
1164  003e cd0000        	call	_GPIO_WriteHigh
1166  0041 84            	pop	a
1167  0042               L153:
1168                     ; 422   if (sys.checkAcCnt)
1170  0042 be0e          	ldw	x,_sys+14
1171  0044 2707          	jreq	L553
1172                     ; 424 		sys.checkAcCnt--;
1174  0046 be0e          	ldw	x,_sys+14
1175  0048 1d0001        	subw	x,#1
1176  004b bf0e          	ldw	_sys+14,x
1177  004d               L553:
1178                     ; 427   if (sys.cnt1s)
1180  004d be1b          	ldw	x,_sys+27
1181  004f 2707          	jreq	L753
1182                     ; 429 		sys.cnt1s--;
1184  0051 be1b          	ldw	x,_sys+27
1185  0053 1d0001        	subw	x,#1
1186  0056 bf1b          	ldw	_sys+27,x
1187  0058               L753:
1188                     ; 431 	Tick100ms++;
1190  0058 be02          	ldw	x,_Tick100ms
1191  005a 1c0001        	addw	x,#1
1192  005d bf02          	ldw	_Tick100ms,x
1193                     ; 432 	if(Tick100ms >= 2000){
1195  005f be02          	ldw	x,_Tick100ms
1196  0061 a307d0        	cpw	x,#2000
1197  0064 2507          	jrult	L163
1198                     ; 433 		Tick100ms = 0;
1200  0066 5f            	clrw	x
1201  0067 bf02          	ldw	_Tick100ms,x
1202                     ; 434 		f_100ms = 1;
1204  0069 35010001      	mov	_f_100ms,#1
1205  006d               L163:
1206                     ; 436 }
1209  006d 85            	popw	x
1210  006e bf00          	ldw	c_y,x
1211  0070 320002        	pop	c_y+2
1212  0073 85            	popw	x
1213  0074 bf00          	ldw	c_x,x
1214  0076 320002        	pop	c_x+2
1215  0079 80            	iret
1241                     ; 438 static void TIMER2_Init(void)
1241                     ; 439 {    
1243                     .text:	section	.text,new
1244  0000               L11_TIMER2_Init:
1248                     ; 440 	TIM2_TimeBaseInit(TIM2_PRESCALER_16, sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
1250  0000 3d0a          	tnz	_sys+10
1251  0002 2705          	jreq	L63
1252  0004 ae0028        	ldw	x,#40
1253  0007 2003          	jra	L04
1254  0009               L63:
1255  0009 ae0021        	ldw	x,#33
1256  000c               L04:
1257  000c 89            	pushw	x
1258  000d a604          	ld	a,#4
1259  000f cd0000        	call	_TIM2_TimeBaseInit
1261  0012 85            	popw	x
1262                     ; 441    	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
1264  0013 ae0001        	ldw	x,#1
1265  0016 cd0000        	call	_TIM2_ClearFlag
1267                     ; 442    	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	   
1269  0019 ae0001        	ldw	x,#1
1270  001c a601          	ld	a,#1
1271  001e 95            	ld	xh,a
1272  001f cd0000        	call	_TIM2_ITConfig
1274                     ; 443 }
1277  0022 81            	ret
1304                     ; 449 @far @interrupt void Timer2_ISR(void) {
1306                     .text:	section	.text,new
1307  0000               f_Timer2_ISR:
1310  0000 3b0002        	push	c_x+2
1311  0003 be00          	ldw	x,c_x
1312  0005 89            	pushw	x
1313  0006 3b0002        	push	c_y+2
1314  0009 be00          	ldw	x,c_y
1315  000b 89            	pushw	x
1318                     ; 451 	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);  
1320  000c a601          	ld	a,#1
1321  000e cd0000        	call	_TIM2_ClearITPendingBit
1323                     ; 452 	if (sys.light1.briCnt) 
1325  0011 3d00          	tnz	_sys
1326  0013 2702          	jreq	L304
1327                     ; 454 		sys.light1.briCnt--;			
1329  0015 3a00          	dec	_sys
1330  0017               L304:
1331                     ; 456 	if (sys.light1.briCnt == 0 && !sys.light1.onFlag)
1333  0017 3d00          	tnz	_sys
1334  0019 2615          	jrne	L504
1336  001b 3d03          	tnz	_sys+3
1337  001d 2611          	jrne	L504
1338                     ; 458 		L1_EN_ON;
1340  001f 4b10          	push	#16
1341  0021 ae500a        	ldw	x,#20490
1342  0024 cd0000        	call	_GPIO_WriteLow
1344  0027 84            	pop	a
1347  0028 35280001      	mov	_sys+1,#40
1348                     ; 459 		sys.light1.onFlag = TRUE;
1350  002c 35010003      	mov	_sys+3,#1
1351  0030               L504:
1352                     ; 463 	if (sys.light2.briCnt) 
1354  0030 3d04          	tnz	_sys+4
1355  0032 2702          	jreq	L704
1356                     ; 465 		sys.light2.briCnt--;		
1358  0034 3a04          	dec	_sys+4
1359  0036               L704:
1360                     ; 467 	if (sys.light2.briCnt == 0 && !sys.light2.onFlag)
1362  0036 3d04          	tnz	_sys+4
1363  0038 2615          	jrne	L114
1365  003a 3d07          	tnz	_sys+7
1366  003c 2611          	jrne	L114
1367                     ; 469 		L2_EN_ON;
1369  003e 4b08          	push	#8
1370  0040 ae500a        	ldw	x,#20490
1371  0043 cd0000        	call	_GPIO_WriteLow
1373  0046 84            	pop	a
1376  0047 35280005      	mov	_sys+5,#40
1377                     ; 470 		sys.light2.onFlag = TRUE;
1379  004b 35010007      	mov	_sys+7,#1
1380  004f               L114:
1381                     ; 473 	if ((sys.light1.briCnt ||  sys.light2.briCnt) == 0)
1383  004f 3d00          	tnz	_sys
1384  0051 2604          	jrne	L64
1385  0053 3d04          	tnz	_sys+4
1386  0055 2705          	jreq	L44
1387  0057               L64:
1388  0057 ae0001        	ldw	x,#1
1389  005a 2001          	jra	L05
1390  005c               L44:
1391  005c 5f            	clrw	x
1392  005d               L05:
1393  005d a30000        	cpw	x,#0
1394  0060 2604          	jrne	L314
1395                     ; 475 		TIM2_Cmd(DISABLE);
1397  0062 4f            	clr	a
1398  0063 cd0000        	call	_TIM2_Cmd
1400  0066               L314:
1401                     ; 477 }
1404  0066 85            	popw	x
1405  0067 bf00          	ldw	c_y,x
1406  0069 320002        	pop	c_y+2
1407  006c 85            	popw	x
1408  006d bf00          	ldw	c_x,x
1409  006f 320002        	pop	c_x+2
1410  0072 80            	iret
1443                     ; 479 u8 Linear(float t)
1443                     ; 480 {
1445                     .text:	section	.text,new
1446  0000               _Linear:
1448  0000 5204          	subw	sp,#4
1449       00000004      OFST:	set	4
1452                     ; 481 	if((t >= 0)&&(t <=1))
1454  0002 9c            	rvf
1455  0003 0d07          	tnz	(OFST+3,sp)
1456  0005 2f31          	jrslt	L334
1458  0007 9c            	rvf
1459  0008 a601          	ld	a,#1
1460  000a cd0000        	call	c_ctof
1462  000d 96            	ldw	x,sp
1463  000e 1c0001        	addw	x,#OFST-3
1464  0011 cd0000        	call	c_rtol
1466  0014 96            	ldw	x,sp
1467  0015 1c0007        	addw	x,#OFST+3
1468  0018 cd0000        	call	c_ltor
1470  001b 96            	ldw	x,sp
1471  001c 1c0001        	addw	x,#OFST-3
1472  001f cd0000        	call	c_fcmp
1474  0022 2c14          	jrsgt	L334
1475                     ; 482 		return (u8)(t*250);
1477  0024 96            	ldw	x,sp
1478  0025 1c0007        	addw	x,#OFST+3
1479  0028 cd0000        	call	c_ltor
1481  002b ae000c        	ldw	x,#L144
1482  002e cd0000        	call	c_fmul
1484  0031 cd0000        	call	c_ftol
1486  0034 b603          	ld	a,c_lreg+3
1488  0036 2002          	jra	L45
1489  0038               L334:
1490                     ; 484 		return 40;
1492  0038 a628          	ld	a,#40
1494  003a               L45:
1496  003a 5b04          	addw	sp,#4
1497  003c 81            	ret
1531                     ; 486 u8 EraseIn(float t)
1531                     ; 487 {
1532                     .text:	section	.text,new
1533  0000               _EraseIn:
1535  0000 5204          	subw	sp,#4
1536       00000004      OFST:	set	4
1539                     ; 488 	if((t >= 0)&&(t <=1))
1541  0002 9c            	rvf
1542  0003 0d07          	tnz	(OFST+3,sp)
1543  0005 2f38          	jrslt	L564
1545  0007 9c            	rvf
1546  0008 a601          	ld	a,#1
1547  000a cd0000        	call	c_ctof
1549  000d 96            	ldw	x,sp
1550  000e 1c0001        	addw	x,#OFST-3
1551  0011 cd0000        	call	c_rtol
1553  0014 96            	ldw	x,sp
1554  0015 1c0007        	addw	x,#OFST+3
1555  0018 cd0000        	call	c_ltor
1557  001b 96            	ldw	x,sp
1558  001c 1c0001        	addw	x,#OFST-3
1559  001f cd0000        	call	c_fcmp
1561  0022 2c1b          	jrsgt	L564
1562                     ; 489 		return (u8)(t*t*250);
1564  0024 96            	ldw	x,sp
1565  0025 1c0007        	addw	x,#OFST+3
1566  0028 cd0000        	call	c_ltor
1568  002b 96            	ldw	x,sp
1569  002c 1c0007        	addw	x,#OFST+3
1570  002f cd0000        	call	c_fmul
1572  0032 ae000c        	ldw	x,#L144
1573  0035 cd0000        	call	c_fmul
1575  0038 cd0000        	call	c_ftol
1577  003b b603          	ld	a,c_lreg+3
1579  003d 2002          	jra	L06
1580  003f               L564:
1581                     ; 491 		return 40;
1583  003f a628          	ld	a,#40
1585  0041               L06:
1587  0041 5b04          	addw	sp,#4
1588  0043 81            	ret
1622                     ; 493 u8 EraseOut(float t)
1622                     ; 494 {
1623                     .text:	section	.text,new
1624  0000               _EraseOut:
1626  0000 5204          	subw	sp,#4
1627       00000004      OFST:	set	4
1630                     ; 495 	if((t >= 0)&&(t <=1))
1632  0002 9c            	rvf
1633  0003 0d07          	tnz	(OFST+3,sp)
1634  0005 2f3d          	jrslt	L705
1636  0007 9c            	rvf
1637  0008 a601          	ld	a,#1
1638  000a cd0000        	call	c_ctof
1640  000d 96            	ldw	x,sp
1641  000e 1c0001        	addw	x,#OFST-3
1642  0011 cd0000        	call	c_rtol
1644  0014 96            	ldw	x,sp
1645  0015 1c0007        	addw	x,#OFST+3
1646  0018 cd0000        	call	c_ltor
1648  001b 96            	ldw	x,sp
1649  001c 1c0001        	addw	x,#OFST-3
1650  001f cd0000        	call	c_fcmp
1652  0022 2c20          	jrsgt	L705
1653                     ; 496 		return (u8)((2-t)*t*250);
1655  0024 a602          	ld	a,#2
1656  0026 cd0000        	call	c_ctof
1658  0029 96            	ldw	x,sp
1659  002a 1c0007        	addw	x,#OFST+3
1660  002d cd0000        	call	c_fsub
1662  0030 96            	ldw	x,sp
1663  0031 1c0007        	addw	x,#OFST+3
1664  0034 cd0000        	call	c_fmul
1666  0037 ae000c        	ldw	x,#L144
1667  003a cd0000        	call	c_fmul
1669  003d cd0000        	call	c_ftol
1671  0040 b603          	ld	a,c_lreg+3
1673  0042 2002          	jra	L46
1674  0044               L705:
1675                     ; 498 		return 40;
1677  0044 a628          	ld	a,#40
1679  0046               L46:
1681  0046 5b04          	addw	sp,#4
1682  0048 81            	ret
1716                     ; 500 u8 Swing(float t)
1716                     ; 501 {
1717                     .text:	section	.text,new
1718  0000               _Swing:
1720  0000 5204          	subw	sp,#4
1721       00000004      OFST:	set	4
1724                     ; 502 	if((t >= 0)&&(t <=1)){
1726  0002 9c            	rvf
1727  0003 0d07          	tnz	(OFST+3,sp)
1728  0005 2e03          	jrsge	L27
1729  0007 cc0093        	jp	L135
1730  000a               L27:
1732  000a 9c            	rvf
1733  000b a601          	ld	a,#1
1734  000d cd0000        	call	c_ctof
1736  0010 96            	ldw	x,sp
1737  0011 1c0001        	addw	x,#OFST-3
1738  0014 cd0000        	call	c_rtol
1740  0017 96            	ldw	x,sp
1741  0018 1c0007        	addw	x,#OFST+3
1742  001b cd0000        	call	c_ltor
1744  001e 96            	ldw	x,sp
1745  001f 1c0001        	addw	x,#OFST-3
1746  0022 cd0000        	call	c_fcmp
1748  0025 2c6c          	jrsgt	L135
1749                     ; 503 		if(t < 0.5)
1751  0027 9c            	rvf
1752  0028 96            	ldw	x,sp
1753  0029 1c0007        	addw	x,#OFST+3
1754  002c cd0000        	call	c_ltor
1756  002f ae0008        	ldw	x,#L145
1757  0032 cd0000        	call	c_fcmp
1759  0035 2e21          	jrsge	L335
1760                     ; 504 			return (u8)(2*t*t*250);
1762  0037 96            	ldw	x,sp
1763  0038 1c0007        	addw	x,#OFST+3
1764  003b cd0000        	call	c_ltor
1766  003e ae0004        	ldw	x,#L155
1767  0041 cd0000        	call	c_fmul
1769  0044 96            	ldw	x,sp
1770  0045 1c0007        	addw	x,#OFST+3
1771  0048 cd0000        	call	c_fmul
1773  004b ae000c        	ldw	x,#L144
1774  004e cd0000        	call	c_fmul
1776  0051 cd0000        	call	c_ftol
1778  0054 b603          	ld	a,c_lreg+3
1780  0056 2038          	jra	L07
1781  0058               L335:
1782                     ; 506 			return (u8)(((4-2*t)*t - 1)*250);
1784  0058 96            	ldw	x,sp
1785  0059 1c0007        	addw	x,#OFST+3
1786  005c cd0000        	call	c_ltor
1788  005f ae0004        	ldw	x,#L155
1789  0062 cd0000        	call	c_fmul
1791  0065 96            	ldw	x,sp
1792  0066 1c0001        	addw	x,#OFST-3
1793  0069 cd0000        	call	c_rtol
1795  006c a604          	ld	a,#4
1796  006e cd0000        	call	c_ctof
1798  0071 96            	ldw	x,sp
1799  0072 1c0001        	addw	x,#OFST-3
1800  0075 cd0000        	call	c_fsub
1802  0078 96            	ldw	x,sp
1803  0079 1c0007        	addw	x,#OFST+3
1804  007c cd0000        	call	c_fmul
1806  007f ae0000        	ldw	x,#L365
1807  0082 cd0000        	call	c_fsub
1809  0085 ae000c        	ldw	x,#L144
1810  0088 cd0000        	call	c_fmul
1812  008b cd0000        	call	c_ftol
1814  008e b603          	ld	a,c_lreg+3
1816  0090               L07:
1818  0090 5b04          	addw	sp,#4
1819  0092 81            	ret
1820  0093               L135:
1821                     ; 509 		return 40;
1823  0093 a628          	ld	a,#40
1825  0095 20f9          	jra	L07
1861                     ; 512 void lightCtrl100ms(void)
1861                     ; 513 {
1862                     .text:	section	.text,new
1863  0000               _lightCtrl100ms:
1867                     ; 514 	if(linear1_begin){//channel1 Linear调光开始
1869  0000 b600          	ld	a,_action_flag
1870  0002 a501          	bcp	a,#1
1871  0004 2768          	jreq	L106
1872                     ; 515 		last_bright1 += change_step1;
1874  0006 ae0000        	ldw	x,#_change_step1
1875  0009 cd0000        	call	c_ltor
1877  000c ae000a        	ldw	x,#_last_bright1
1878  000f cd0000        	call	c_fgadd
1880                     ; 516 		realtime_bright1 = Linear(last_bright1);
1882  0012 be0c          	ldw	x,_last_bright1+2
1883  0014 89            	pushw	x
1884  0015 be0a          	ldw	x,_last_bright1
1885  0017 89            	pushw	x
1886  0018 cd0000        	call	_Linear
1888  001b 5b04          	addw	sp,#4
1889  001d b705          	ld	_realtime_bright1,a
1890                     ; 517 		if(last_bright1 > aim_bright1){
1892  001f 9c            	rvf
1893  0020 ae000a        	ldw	x,#_last_bright1
1894  0023 cd0000        	call	c_ltor
1896  0026 ae0000        	ldw	x,#_aim_bright1
1897  0029 cd0000        	call	c_fcmp
1899  002c 2d21          	jrsle	L306
1900                     ; 518 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
1902  002e ae000a        	ldw	x,#_last_bright1
1903  0031 cd0000        	call	c_ltor
1905  0034 ae0000        	ldw	x,#_aim_bright1
1906  0037 cd0000        	call	c_fsub
1908  003a ae000c        	ldw	x,#L144
1909  003d cd0000        	call	c_fmul
1911  0040 cd0000        	call	c_ftol
1913  0043 b603          	ld	a,c_lreg+3
1914  0045 a102          	cp	a,#2
1915  0047 2425          	jruge	L106
1916                     ; 519 				linear1_begin = 0;
1918  0049 72110000      	bres	_action_flag,#0
1919  004d 201f          	jra	L106
1920  004f               L306:
1921                     ; 522 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
1923  004f ae0000        	ldw	x,#_aim_bright1
1924  0052 cd0000        	call	c_ltor
1926  0055 ae000a        	ldw	x,#_last_bright1
1927  0058 cd0000        	call	c_fsub
1929  005b ae000c        	ldw	x,#L144
1930  005e cd0000        	call	c_fmul
1932  0061 cd0000        	call	c_ftol
1934  0064 b603          	ld	a,c_lreg+3
1935  0066 a102          	cp	a,#2
1936  0068 2404          	jruge	L106
1937                     ; 523 				linear1_begin = 0;
1939  006a 72110000      	bres	_action_flag,#0
1940  006e               L106:
1941                     ; 526 	if(linear2_begin){//channel2 Linear调光开始
1943  006e b600          	ld	a,_action_flag
1944  0070 a502          	bcp	a,#2
1945  0072 2768          	jreq	L316
1946                     ; 527 		last_bright2 += change_step2;
1948  0074 ae0000        	ldw	x,#_change_step2
1949  0077 cd0000        	call	c_ltor
1951  007a ae0006        	ldw	x,#_last_bright2
1952  007d cd0000        	call	c_fgadd
1954                     ; 528 		realtime_bright2 = Linear(last_bright2);
1956  0080 be08          	ldw	x,_last_bright2+2
1957  0082 89            	pushw	x
1958  0083 be06          	ldw	x,_last_bright2
1959  0085 89            	pushw	x
1960  0086 cd0000        	call	_Linear
1962  0089 5b04          	addw	sp,#4
1963  008b b704          	ld	_realtime_bright2,a
1964                     ; 529 		if(last_bright2 > aim_bright2){
1966  008d 9c            	rvf
1967  008e ae0006        	ldw	x,#_last_bright2
1968  0091 cd0000        	call	c_ltor
1970  0094 ae0000        	ldw	x,#_aim_bright2
1971  0097 cd0000        	call	c_fcmp
1973  009a 2d21          	jrsle	L516
1974                     ; 530 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
1976  009c ae0006        	ldw	x,#_last_bright2
1977  009f cd0000        	call	c_ltor
1979  00a2 ae0000        	ldw	x,#_aim_bright2
1980  00a5 cd0000        	call	c_fsub
1982  00a8 ae000c        	ldw	x,#L144
1983  00ab cd0000        	call	c_fmul
1985  00ae cd0000        	call	c_ftol
1987  00b1 b603          	ld	a,c_lreg+3
1988  00b3 a102          	cp	a,#2
1989  00b5 2425          	jruge	L316
1990                     ; 531 				linear2_begin = 0;
1992  00b7 72130000      	bres	_action_flag,#1
1993  00bb 201f          	jra	L316
1994  00bd               L516:
1995                     ; 534 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
1997  00bd ae0000        	ldw	x,#_aim_bright2
1998  00c0 cd0000        	call	c_ltor
2000  00c3 ae0006        	ldw	x,#_last_bright2
2001  00c6 cd0000        	call	c_fsub
2003  00c9 ae000c        	ldw	x,#L144
2004  00cc cd0000        	call	c_fmul
2006  00cf cd0000        	call	c_ftol
2008  00d2 b603          	ld	a,c_lreg+3
2009  00d4 a102          	cp	a,#2
2010  00d6 2404          	jruge	L316
2011                     ; 535 				linear2_begin = 0;
2013  00d8 72130000      	bres	_action_flag,#1
2014  00dc               L316:
2015                     ; 538 	if(eraseIn1_begin){//channel1 EraseIn调光开始
2017  00dc b600          	ld	a,_action_flag
2018  00de a504          	bcp	a,#4
2019  00e0 2768          	jreq	L526
2020                     ; 539 		last_bright1 += change_step1;
2022  00e2 ae0000        	ldw	x,#_change_step1
2023  00e5 cd0000        	call	c_ltor
2025  00e8 ae000a        	ldw	x,#_last_bright1
2026  00eb cd0000        	call	c_fgadd
2028                     ; 540 		realtime_bright1 = EraseIn(last_bright1);	
2030  00ee be0c          	ldw	x,_last_bright1+2
2031  00f0 89            	pushw	x
2032  00f1 be0a          	ldw	x,_last_bright1
2033  00f3 89            	pushw	x
2034  00f4 cd0000        	call	_EraseIn
2036  00f7 5b04          	addw	sp,#4
2037  00f9 b705          	ld	_realtime_bright1,a
2038                     ; 541 		if(last_bright1 > aim_bright1){
2040  00fb 9c            	rvf
2041  00fc ae000a        	ldw	x,#_last_bright1
2042  00ff cd0000        	call	c_ltor
2044  0102 ae0000        	ldw	x,#_aim_bright1
2045  0105 cd0000        	call	c_fcmp
2047  0108 2d21          	jrsle	L726
2048                     ; 542 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2050  010a ae000a        	ldw	x,#_last_bright1
2051  010d cd0000        	call	c_ltor
2053  0110 ae0000        	ldw	x,#_aim_bright1
2054  0113 cd0000        	call	c_fsub
2056  0116 ae000c        	ldw	x,#L144
2057  0119 cd0000        	call	c_fmul
2059  011c cd0000        	call	c_ftol
2061  011f b603          	ld	a,c_lreg+3
2062  0121 a102          	cp	a,#2
2063  0123 2425          	jruge	L526
2064                     ; 543 				eraseIn1_begin = 0;
2066  0125 72150000      	bres	_action_flag,#2
2067  0129 201f          	jra	L526
2068  012b               L726:
2069                     ; 546 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2071  012b ae0000        	ldw	x,#_aim_bright1
2072  012e cd0000        	call	c_ltor
2074  0131 ae000a        	ldw	x,#_last_bright1
2075  0134 cd0000        	call	c_fsub
2077  0137 ae000c        	ldw	x,#L144
2078  013a cd0000        	call	c_fmul
2080  013d cd0000        	call	c_ftol
2082  0140 b603          	ld	a,c_lreg+3
2083  0142 a102          	cp	a,#2
2084  0144 2404          	jruge	L526
2085                     ; 547 				eraseIn1_begin = 0;
2087  0146 72150000      	bres	_action_flag,#2
2088  014a               L526:
2089                     ; 550 	if(eraseIn2_begin){//channel2 EraseIn调光开始
2091  014a b600          	ld	a,_action_flag
2092  014c a508          	bcp	a,#8
2093  014e 2768          	jreq	L736
2094                     ; 551 		last_bright2 += change_step2;
2096  0150 ae0000        	ldw	x,#_change_step2
2097  0153 cd0000        	call	c_ltor
2099  0156 ae0006        	ldw	x,#_last_bright2
2100  0159 cd0000        	call	c_fgadd
2102                     ; 552 		realtime_bright2 = EraseIn(last_bright2);
2104  015c be08          	ldw	x,_last_bright2+2
2105  015e 89            	pushw	x
2106  015f be06          	ldw	x,_last_bright2
2107  0161 89            	pushw	x
2108  0162 cd0000        	call	_EraseIn
2110  0165 5b04          	addw	sp,#4
2111  0167 b704          	ld	_realtime_bright2,a
2112                     ; 553 		if(last_bright2 > aim_bright2){
2114  0169 9c            	rvf
2115  016a ae0006        	ldw	x,#_last_bright2
2116  016d cd0000        	call	c_ltor
2118  0170 ae0000        	ldw	x,#_aim_bright2
2119  0173 cd0000        	call	c_fcmp
2121  0176 2d21          	jrsle	L146
2122                     ; 554 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2124  0178 ae0006        	ldw	x,#_last_bright2
2125  017b cd0000        	call	c_ltor
2127  017e ae0000        	ldw	x,#_aim_bright2
2128  0181 cd0000        	call	c_fsub
2130  0184 ae000c        	ldw	x,#L144
2131  0187 cd0000        	call	c_fmul
2133  018a cd0000        	call	c_ftol
2135  018d b603          	ld	a,c_lreg+3
2136  018f a102          	cp	a,#2
2137  0191 2425          	jruge	L736
2138                     ; 555 				eraseIn2_begin = 0;
2140  0193 72170000      	bres	_action_flag,#3
2141  0197 201f          	jra	L736
2142  0199               L146:
2143                     ; 558 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2145  0199 ae0000        	ldw	x,#_aim_bright2
2146  019c cd0000        	call	c_ltor
2148  019f ae0006        	ldw	x,#_last_bright2
2149  01a2 cd0000        	call	c_fsub
2151  01a5 ae000c        	ldw	x,#L144
2152  01a8 cd0000        	call	c_fmul
2154  01ab cd0000        	call	c_ftol
2156  01ae b603          	ld	a,c_lreg+3
2157  01b0 a102          	cp	a,#2
2158  01b2 2404          	jruge	L736
2159                     ; 559 				eraseIn2_begin = 0;
2161  01b4 72170000      	bres	_action_flag,#3
2162  01b8               L736:
2163                     ; 562 	if(eraseOut1_begin){//channel1 EraseOut调光开始
2165  01b8 b600          	ld	a,_action_flag
2166  01ba a510          	bcp	a,#16
2167  01bc 2768          	jreq	L156
2168                     ; 563 		last_bright1 += change_step1;
2170  01be ae0000        	ldw	x,#_change_step1
2171  01c1 cd0000        	call	c_ltor
2173  01c4 ae000a        	ldw	x,#_last_bright1
2174  01c7 cd0000        	call	c_fgadd
2176                     ; 564 		realtime_bright1 = EraseOut(last_bright1);	
2178  01ca be0c          	ldw	x,_last_bright1+2
2179  01cc 89            	pushw	x
2180  01cd be0a          	ldw	x,_last_bright1
2181  01cf 89            	pushw	x
2182  01d0 cd0000        	call	_EraseOut
2184  01d3 5b04          	addw	sp,#4
2185  01d5 b705          	ld	_realtime_bright1,a
2186                     ; 565 		if(last_bright1 > aim_bright1){
2188  01d7 9c            	rvf
2189  01d8 ae000a        	ldw	x,#_last_bright1
2190  01db cd0000        	call	c_ltor
2192  01de ae0000        	ldw	x,#_aim_bright1
2193  01e1 cd0000        	call	c_fcmp
2195  01e4 2d21          	jrsle	L356
2196                     ; 566 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2198  01e6 ae000a        	ldw	x,#_last_bright1
2199  01e9 cd0000        	call	c_ltor
2201  01ec ae0000        	ldw	x,#_aim_bright1
2202  01ef cd0000        	call	c_fsub
2204  01f2 ae000c        	ldw	x,#L144
2205  01f5 cd0000        	call	c_fmul
2207  01f8 cd0000        	call	c_ftol
2209  01fb b603          	ld	a,c_lreg+3
2210  01fd a102          	cp	a,#2
2211  01ff 2425          	jruge	L156
2212                     ; 567 				eraseOut1_begin = 0;
2214  0201 72190000      	bres	_action_flag,#4
2215  0205 201f          	jra	L156
2216  0207               L356:
2217                     ; 570 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2219  0207 ae0000        	ldw	x,#_aim_bright1
2220  020a cd0000        	call	c_ltor
2222  020d ae000a        	ldw	x,#_last_bright1
2223  0210 cd0000        	call	c_fsub
2225  0213 ae000c        	ldw	x,#L144
2226  0216 cd0000        	call	c_fmul
2228  0219 cd0000        	call	c_ftol
2230  021c b603          	ld	a,c_lreg+3
2231  021e a102          	cp	a,#2
2232  0220 2404          	jruge	L156
2233                     ; 571 				eraseOut1_begin = 0;
2235  0222 72190000      	bres	_action_flag,#4
2236  0226               L156:
2237                     ; 574 	if(eraseOut2_begin){//channel2 EraseOut调光开始
2239  0226 b600          	ld	a,_action_flag
2240  0228 a520          	bcp	a,#32
2241  022a 2768          	jreq	L366
2242                     ; 575 		last_bright2 += change_step2;
2244  022c ae0000        	ldw	x,#_change_step2
2245  022f cd0000        	call	c_ltor
2247  0232 ae0006        	ldw	x,#_last_bright2
2248  0235 cd0000        	call	c_fgadd
2250                     ; 576 		realtime_bright2 = EraseOut(last_bright2);
2252  0238 be08          	ldw	x,_last_bright2+2
2253  023a 89            	pushw	x
2254  023b be06          	ldw	x,_last_bright2
2255  023d 89            	pushw	x
2256  023e cd0000        	call	_EraseOut
2258  0241 5b04          	addw	sp,#4
2259  0243 b704          	ld	_realtime_bright2,a
2260                     ; 577 		if(last_bright2 > aim_bright2){
2262  0245 9c            	rvf
2263  0246 ae0006        	ldw	x,#_last_bright2
2264  0249 cd0000        	call	c_ltor
2266  024c ae0000        	ldw	x,#_aim_bright2
2267  024f cd0000        	call	c_fcmp
2269  0252 2d21          	jrsle	L566
2270                     ; 578 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2272  0254 ae0006        	ldw	x,#_last_bright2
2273  0257 cd0000        	call	c_ltor
2275  025a ae0000        	ldw	x,#_aim_bright2
2276  025d cd0000        	call	c_fsub
2278  0260 ae000c        	ldw	x,#L144
2279  0263 cd0000        	call	c_fmul
2281  0266 cd0000        	call	c_ftol
2283  0269 b603          	ld	a,c_lreg+3
2284  026b a102          	cp	a,#2
2285  026d 2425          	jruge	L366
2286                     ; 579 				eraseOut2_begin = 0;
2288  026f 721b0000      	bres	_action_flag,#5
2289  0273 201f          	jra	L366
2290  0275               L566:
2291                     ; 582 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2293  0275 ae0000        	ldw	x,#_aim_bright2
2294  0278 cd0000        	call	c_ltor
2296  027b ae0006        	ldw	x,#_last_bright2
2297  027e cd0000        	call	c_fsub
2299  0281 ae000c        	ldw	x,#L144
2300  0284 cd0000        	call	c_fmul
2302  0287 cd0000        	call	c_ftol
2304  028a b603          	ld	a,c_lreg+3
2305  028c a102          	cp	a,#2
2306  028e 2404          	jruge	L366
2307                     ; 583 				eraseOut2_begin = 0;
2309  0290 721b0000      	bres	_action_flag,#5
2310  0294               L366:
2311                     ; 586 	if(swing1_begin){//channel1 Swing调光开始
2313  0294 b600          	ld	a,_action_flag
2314  0296 a540          	bcp	a,#64
2315  0298 2768          	jreq	L576
2316                     ; 587 		last_bright1 += change_step1;
2318  029a ae0000        	ldw	x,#_change_step1
2319  029d cd0000        	call	c_ltor
2321  02a0 ae000a        	ldw	x,#_last_bright1
2322  02a3 cd0000        	call	c_fgadd
2324                     ; 588 		realtime_bright1 = Swing(last_bright1);	
2326  02a6 be0c          	ldw	x,_last_bright1+2
2327  02a8 89            	pushw	x
2328  02a9 be0a          	ldw	x,_last_bright1
2329  02ab 89            	pushw	x
2330  02ac cd0000        	call	_Swing
2332  02af 5b04          	addw	sp,#4
2333  02b1 b705          	ld	_realtime_bright1,a
2334                     ; 589 		if(last_bright1 > aim_bright1){
2336  02b3 9c            	rvf
2337  02b4 ae000a        	ldw	x,#_last_bright1
2338  02b7 cd0000        	call	c_ltor
2340  02ba ae0000        	ldw	x,#_aim_bright1
2341  02bd cd0000        	call	c_fcmp
2343  02c0 2d21          	jrsle	L776
2344                     ; 590 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2346  02c2 ae000a        	ldw	x,#_last_bright1
2347  02c5 cd0000        	call	c_ltor
2349  02c8 ae0000        	ldw	x,#_aim_bright1
2350  02cb cd0000        	call	c_fsub
2352  02ce ae000c        	ldw	x,#L144
2353  02d1 cd0000        	call	c_fmul
2355  02d4 cd0000        	call	c_ftol
2357  02d7 b603          	ld	a,c_lreg+3
2358  02d9 a102          	cp	a,#2
2359  02db 2425          	jruge	L576
2360                     ; 591 				swing1_begin = 0;
2362  02dd 721d0000      	bres	_action_flag,#6
2363  02e1 201f          	jra	L576
2364  02e3               L776:
2365                     ; 594 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2367  02e3 ae0000        	ldw	x,#_aim_bright1
2368  02e6 cd0000        	call	c_ltor
2370  02e9 ae000a        	ldw	x,#_last_bright1
2371  02ec cd0000        	call	c_fsub
2373  02ef ae000c        	ldw	x,#L144
2374  02f2 cd0000        	call	c_fmul
2376  02f5 cd0000        	call	c_ftol
2378  02f8 b603          	ld	a,c_lreg+3
2379  02fa a102          	cp	a,#2
2380  02fc 2404          	jruge	L576
2381                     ; 595 				swing1_begin = 0;
2383  02fe 721d0000      	bres	_action_flag,#6
2384  0302               L576:
2385                     ; 598 	if(swing2_begin){//channel2 Swing调光开始
2387  0302 b600          	ld	a,_action_flag
2388  0304 a580          	bcp	a,#128
2389  0306 2768          	jreq	L707
2390                     ; 599 		last_bright2 += change_step2;
2392  0308 ae0000        	ldw	x,#_change_step2
2393  030b cd0000        	call	c_ltor
2395  030e ae0006        	ldw	x,#_last_bright2
2396  0311 cd0000        	call	c_fgadd
2398                     ; 600 		realtime_bright2 = Swing(last_bright2);
2400  0314 be08          	ldw	x,_last_bright2+2
2401  0316 89            	pushw	x
2402  0317 be06          	ldw	x,_last_bright2
2403  0319 89            	pushw	x
2404  031a cd0000        	call	_Swing
2406  031d 5b04          	addw	sp,#4
2407  031f b704          	ld	_realtime_bright2,a
2408                     ; 601 		if(last_bright2 > aim_bright2){
2410  0321 9c            	rvf
2411  0322 ae0006        	ldw	x,#_last_bright2
2412  0325 cd0000        	call	c_ltor
2414  0328 ae0000        	ldw	x,#_aim_bright2
2415  032b cd0000        	call	c_fcmp
2417  032e 2d21          	jrsle	L117
2418                     ; 602 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2420  0330 ae0006        	ldw	x,#_last_bright2
2421  0333 cd0000        	call	c_ltor
2423  0336 ae0000        	ldw	x,#_aim_bright2
2424  0339 cd0000        	call	c_fsub
2426  033c ae000c        	ldw	x,#L144
2427  033f cd0000        	call	c_fmul
2429  0342 cd0000        	call	c_ftol
2431  0345 b603          	ld	a,c_lreg+3
2432  0347 a102          	cp	a,#2
2433  0349 2425          	jruge	L707
2434                     ; 603 				swing2_begin = 0;
2436  034b 721f0000      	bres	_action_flag,#7
2437  034f 201f          	jra	L707
2438  0351               L117:
2439                     ; 606 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2441  0351 ae0000        	ldw	x,#_aim_bright2
2442  0354 cd0000        	call	c_ltor
2444  0357 ae0006        	ldw	x,#_last_bright2
2445  035a cd0000        	call	c_fsub
2447  035d ae000c        	ldw	x,#L144
2448  0360 cd0000        	call	c_fmul
2450  0363 cd0000        	call	c_ftol
2452  0366 b603          	ld	a,c_lreg+3
2453  0368 a102          	cp	a,#2
2454  036a 2404          	jruge	L707
2455                     ; 607 				swing2_begin = 0;
2457  036c 721f0000      	bres	_action_flag,#7
2458  0370               L707:
2459                     ; 610 }
2462  0370 81            	ret
2764                     	xdef	_Swing
2765                     	xdef	_EraseOut
2766                     	xdef	_EraseIn
2767                     	xdef	_Linear
2768                     	xdef	_main
2769                     	xdef	_delay
2770                     	switch	.ubsct
2771  0000               _tick1s:
2772  0000 00            	ds.b	1
2773                     	xdef	_tick1s
2774  0001               _f_100ms:
2775  0001 00            	ds.b	1
2776                     	xdef	_f_100ms
2777  0002               _Tick100ms:
2778  0002 0000          	ds.b	2
2779                     	xdef	_Tick100ms
2780                     	xref.b	_action_flag
2781                     	xref.b	_change_step2
2782                     	xref.b	_change_step1
2783                     	xref.b	_aim_bright2
2784                     	xref.b	_aim_bright1
2785                     	xref.b	_channel
2786  0004               _realtime_bright2:
2787  0004 00            	ds.b	1
2788                     	xdef	_realtime_bright2
2789  0005               _realtime_bright1:
2790  0005 00            	ds.b	1
2791                     	xdef	_realtime_bright1
2792  0006               _last_bright2:
2793  0006 00000000      	ds.b	4
2794                     	xdef	_last_bright2
2795  000a               _last_bright1:
2796  000a 00000000      	ds.b	4
2797                     	xdef	_last_bright1
2798                     	xref.b	_ReceiveState
2799                     	xref.b	_GetDataIndex
2800                     	xref.b	_slave_address
2801                     	xref.b	_slc
2802                     	xref	_IIC_SlaveConfig
2803                     	xdef	f_Timer4_ISR
2804                     	xdef	f_Timer2_ISR
2805                     	xdef	f_Ext_PortD_ISR
2806                     	xdef	_lightCtrl100ms
2807                     	xdef	_sys
2808                     	xdef	_assert_failed
2809                     	xref	_TIM4_ClearITPendingBit
2810                     	xref	_TIM4_ClearFlag
2811                     	xref	_TIM4_SetAutoreload
2812                     	xref	_TIM4_ITConfig
2813                     	xref	_TIM4_Cmd
2814                     	xref	_TIM4_TimeBaseInit
2815                     	xref	_TIM2_ClearITPendingBit
2816                     	xref	_TIM2_ClearFlag
2817                     	xref	_TIM2_SetAutoreload
2818                     	xref	_TIM2_ITConfig
2819                     	xref	_TIM2_Cmd
2820                     	xref	_TIM2_TimeBaseInit
2821                     	xref	_ITC_SetSoftwarePriority
2822                     	xref	_ITC_DeInit
2823                     	xref	_GPIO_ReadOutputData
2824                     	xref	_GPIO_ReadInputData
2825                     	xref	_GPIO_WriteLow
2826                     	xref	_GPIO_WriteHigh
2827                     	xref	_GPIO_Init
2828                     	xref	_EXTI_SetExtIntSensitivity
2829                     	xref	_EXTI_DeInit
2830                     	xref	_CLK_PeripheralClockConfig
2831                     .const:	section	.text
2832  0000               L365:
2833  0000 3f800000      	dc.w	16256,0
2834  0004               L155:
2835  0004 40000000      	dc.w	16384,0
2836  0008               L145:
2837  0008 3f000000      	dc.w	16128,0
2838  000c               L144:
2839  000c 437a0000      	dc.w	17274,0
2840  0010               L342:
2841  0010 3e23d70a      	dc.w	15907,-10486
2842  0014               L561:
2843  0014 42c80000      	dc.w	17096,0
2844                     	xref.b	c_lreg
2845                     	xref.b	c_x
2846                     	xref.b	c_y
2866                     	xref	c_fgadd
2867                     	xref	c_fsub
2868                     	xref	c_fcmp
2869                     	xref	c_rtol
2870                     	xref	c_ctof
2871                     	xref	c_ftol
2872                     	xref	c_fmul
2873                     	xref	c_ltor
2874                     	end
