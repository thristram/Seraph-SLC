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
 316                     ; 120 	ITC_SetSoftwarePriority(ITC_IRQ_PORTD,ITC_PRIORITYLEVEL_2);
 318  00a9 5f            	clrw	x
 319  00aa a606          	ld	a,#6
 320  00ac 95            	ld	xh,a
 321  00ad cd0000        	call	_ITC_SetSoftwarePriority
 323                     ; 121 	ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF,ITC_PRIORITYLEVEL_2);
 325  00b0 5f            	clrw	x
 326  00b1 a60d          	ld	a,#13
 327  00b3 95            	ld	xh,a
 328  00b4 cd0000        	call	_ITC_SetSoftwarePriority
 330                     ; 122 	ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF,ITC_PRIORITYLEVEL_2);
 332  00b7 5f            	clrw	x
 333  00b8 a617          	ld	a,#23
 334  00ba 95            	ld	xh,a
 335  00bb cd0000        	call	_ITC_SetSoftwarePriority
 337                     ; 123 	ITC_SetSoftwarePriority(ITC_IRQ_I2C,ITC_PRIORITYLEVEL_3);
 339  00be ae0003        	ldw	x,#3
 340  00c1 a613          	ld	a,#19
 341  00c3 95            	ld	xh,a
 342  00c4 cd0000        	call	_ITC_SetSoftwarePriority
 344                     ; 126 	enableInterrupts();
 347  00c7 9a            rim
 351  00c8 2016          	jra	L521
 352  00ca               L321:
 353                     ; 130 		 if (sys.checkAcCnt == 0)
 355  00ca be0e          	ldw	x,_sys+14
 356  00cc 2612          	jrne	L521
 357                     ; 137 			sys.gotHzFlag = FALSE;    
 359  00ce 3f09          	clr	_sys+9
 360                     ; 138 			sys.reqCalHzFlag = FALSE;
 362  00d0 3f08          	clr	_sys+8
 363                     ; 139 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 365  00d2 350a000b      	mov	_sys+11,#10
 366                     ; 140 			sys.hzCnt = 0;
 368  00d6 5f            	clrw	x
 369  00d7 bf0c          	ldw	_sys+12,x
 370                     ; 141 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 372  00d9 ae07d0        	ldw	x,#2000
 373  00dc bf0e          	ldw	_sys+14,x
 374                     ; 142 			break;
 376  00de 201a          	jra	L531
 377  00e0               L521:
 378                     ; 128 	 while(!sys.gotHzFlag)
 380  00e0 3d09          	tnz	_sys+9
 381  00e2 27e6          	jreq	L321
 382  00e4 2014          	jra	L531
 383  00e6               L331:
 384                     ; 149 		 if (sys.checkAcCnt == 0)
 386  00e6 be0e          	ldw	x,_sys+14
 387  00e8 2610          	jrne	L531
 388                     ; 152 			sys.gotHzFlag = FALSE;    
 390  00ea 3f09          	clr	_sys+9
 391                     ; 153 			sys.reqCalHzFlag = FALSE;
 393  00ec 3f08          	clr	_sys+8
 394                     ; 154 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 396  00ee 350a000b      	mov	_sys+11,#10
 397                     ; 155 			sys.hzCnt = 0;
 399  00f2 5f            	clrw	x
 400  00f3 bf0c          	ldw	_sys+12,x
 401                     ; 156 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 403  00f5 ae07d0        	ldw	x,#2000
 404  00f8 bf0e          	ldw	_sys+14,x
 405  00fa               L531:
 406                     ; 147 	 while(!sys.gotHzFlag)
 408  00fa 3d09          	tnz	_sys+9
 409  00fc 27e8          	jreq	L331
 410                     ; 159 	 sys.acOkFlag = TRUE;
 412  00fe 35010011      	mov	_sys+17,#1
 413                     ; 160 	 TIMER2_Init();
 415  0102 cd0000        	call	L11_TIMER2_Init
 417  0105               L341:
 418                     ; 167 		if(ReceiveState == IIC_STATE_END)
 420  0105 b600          	ld	a,_ReceiveState
 421  0107 a103          	cp	a,#3
 422  0109 2604          	jrne	L741
 423                     ; 173 			ReceiveState = IIC_STATE_UNKNOWN;
 425  010b 3f00          	clr	_ReceiveState
 426                     ; 174 			GetDataIndex = 0;
 428  010d 3f00          	clr	_GetDataIndex
 429  010f               L741:
 430                     ; 177 		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE)
 432  010f be0e          	ldw	x,_sys+14
 433  0111 260a          	jrne	L151
 435  0113 3d10          	tnz	_sys+16
 436  0115 2606          	jrne	L151
 437                     ; 181 			 sys.acErrFlag = TRUE;
 439  0117 35010010      	mov	_sys+16,#1
 440                     ; 182 			 sys.acOkFlag = FALSE;
 442  011b 3f11          	clr	_sys+17
 443  011d               L151:
 444                     ; 185 		if (sys.acErrFlag == FALSE && sys.acOkFlag == FALSE)
 446  011d 3d10          	tnz	_sys+16
 447  011f 260d          	jrne	L351
 449  0121 3d11          	tnz	_sys+17
 450  0123 2609          	jrne	L351
 451                     ; 189 			sys.acOkFlag = TRUE;
 453  0125 35010011      	mov	_sys+17,#1
 454                     ; 190 			sys.cnt1s = CNT_1S;
 456  0129 ae4e20        	ldw	x,#20000
 457  012c bf1b          	ldw	_sys+27,x
 458  012e               L351:
 459                     ; 193 		if(f_100ms){
 461  012e 3d01          	tnz	_f_100ms
 462  0130 2705          	jreq	L551
 463                     ; 194 			f_100ms = 0;
 465  0132 3f01          	clr	_f_100ms
 466                     ; 195 			lightCtrl100ms();
 468  0134 cd0000        	call	_lightCtrl100ms
 470  0137               L551:
 471                     ; 204 		if((channel & 0x01)==0x01)//调节Dimmer1
 473  0137 b600          	ld	a,_channel
 474  0139 a401          	and	a,#1
 475  013b a101          	cp	a,#1
 476  013d 2617          	jrne	L751
 477                     ; 206 			sys.light1.briVal = realtime_bright1;
 479  013f 450502        	mov	_sys+2,_realtime_bright1
 480                     ; 208 			slc.ch1_status = (u8)(realtime_bright1*0.4);
 482  0142 b605          	ld	a,_realtime_bright1
 483  0144 5f            	clrw	x
 484  0145 97            	ld	xl,a
 485  0146 cd0000        	call	c_itof
 487  0149 ae0014        	ldw	x,#L561
 488  014c cd0000        	call	c_fmul
 490  014f cd0000        	call	c_ftol
 492  0152 b603          	ld	a,c_lreg+3
 493  0154 b715          	ld	_slc+21,a
 494  0156               L751:
 495                     ; 210 		if((channel & 0x02)==0x02)//调节Dimmer2
 497  0156 b600          	ld	a,_channel
 498  0158 a402          	and	a,#2
 499  015a a102          	cp	a,#2
 500  015c 2617          	jrne	L171
 501                     ; 212 			sys.light2.briVal = realtime_bright2;
 503  015e 450406        	mov	_sys+6,_realtime_bright2
 504                     ; 214 			slc.ch2_status = (u8)(realtime_bright2*0.4);
 506  0161 b604          	ld	a,_realtime_bright2
 507  0163 5f            	clrw	x
 508  0164 97            	ld	xl,a
 509  0165 cd0000        	call	c_itof
 511  0168 ae0014        	ldw	x,#L561
 512  016b cd0000        	call	c_fmul
 514  016e cd0000        	call	c_ftol
 516  0171 b603          	ld	a,c_lreg+3
 517  0173 b716          	ld	_slc+22,a
 518  0175               L171:
 519                     ; 216 		if (sys.acOkFlag && sys.cnt1s == 0)
 521  0175 3d11          	tnz	_sys+17
 522  0177 278c          	jreq	L341
 524  0179 be1b          	ldw	x,_sys+27
 525  017b 2688          	jrne	L341
 526                     ; 221 			sys.cnt1s = CNT_1S;
 528  017d ae4e20        	ldw	x,#20000
 529  0180 bf1b          	ldw	_sys+27,x
 530  0182 2081          	jpf	L341
 565                     ; 235 void assert_failed(uint8_t* file, uint32_t line)
 565                     ; 236 { 
 566                     .text:	section	.text,new
 567  0000               _assert_failed:
 571  0000               L312:
 572  0000 20fe          	jra	L312
 597                     ; 247 static void GPIO_Config(void)
 597                     ; 248 {
 598                     .text:	section	.text,new
 599  0000               L5_GPIO_Config:
 603                     ; 250     GPIO_Init(L1_EN_PIN_PORT, (GPIO_Pin_TypeDef)L1_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
 605  0000 4bd0          	push	#208
 606  0002 4b10          	push	#16
 607  0004 ae500a        	ldw	x,#20490
 608  0007 cd0000        	call	_GPIO_Init
 610  000a 85            	popw	x
 611                     ; 251     GPIO_Init(L2_EN_PIN_PORT, (GPIO_Pin_TypeDef)L2_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);   
 613  000b 4bd0          	push	#208
 614  000d 4b08          	push	#8
 615  000f ae500a        	ldw	x,#20490
 616  0012 cd0000        	call	_GPIO_Init
 618  0015 85            	popw	x
 619                     ; 252     L1_EN_OFF;
 621  0016 4b10          	push	#16
 622  0018 ae500a        	ldw	x,#20490
 623  001b cd0000        	call	_GPIO_WriteHigh
 625  001e 84            	pop	a
 626                     ; 253     L2_EN_OFF;
 628  001f 4b08          	push	#8
 629  0021 ae500a        	ldw	x,#20490
 630  0024 cd0000        	call	_GPIO_WriteHigh
 632  0027 84            	pop	a
 633                     ; 254     GPIO_Init(ZD_PIN_PORT, (GPIO_Pin_TypeDef)ZD_PIN, GPIO_MODE_IN_FL_IT);  
 635  0028 4b20          	push	#32
 636  002a 4b08          	push	#8
 637  002c ae500f        	ldw	x,#20495
 638  002f cd0000        	call	_GPIO_Init
 640  0032 85            	popw	x
 641                     ; 256 }
 644  0033 81            	ret
 673                     ; 258 static void Sys_Init(void)
 673                     ; 259 {
 674                     .text:	section	.text,new
 675  0000               L3_Sys_Init:
 679                     ; 260     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 681  0000 ae0001        	ldw	x,#1
 682  0003 a604          	ld	a,#4
 683  0005 95            	ld	xh,a
 684  0006 cd0000        	call	_CLK_PeripheralClockConfig
 686                     ; 261     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 688  0009 ae0001        	ldw	x,#1
 689  000c a605          	ld	a,#5
 690  000e 95            	ld	xh,a
 691  000f cd0000        	call	_CLK_PeripheralClockConfig
 693                     ; 263     sys.gotHzFlag = FALSE;    
 695  0012 3f09          	clr	_sys+9
 696                     ; 264     sys.reqCalHzFlag = FALSE;
 698  0014 3f08          	clr	_sys+8
 699                     ; 265     sys.light1.briVal = DEFAULT_BRIGHTNESS;
 701  0016 35280002      	mov	_sys+2,#40
 702                     ; 266     sys.light2.briVal = DEFAULT_BRIGHTNESS;    
 704  001a 35280006      	mov	_sys+6,#40
 705                     ; 267     sys.calHzIntCnt = GET_AC_FRE_CNT;
 707  001e 350a000b      	mov	_sys+11,#10
 708                     ; 268     sys.hzCnt = 0;
 710  0022 5f            	clrw	x
 711  0023 bf0c          	ldw	_sys+12,x
 712                     ; 269     sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 714  0025 ae07d0        	ldw	x,#2000
 715  0028 bf0e          	ldw	_sys+14,x
 716                     ; 270 		last_bright1 = 0.16;
 718  002a ce0012        	ldw	x,L342+2
 719  002d bf0c          	ldw	_last_bright1+2,x
 720  002f ce0010        	ldw	x,L342
 721  0032 bf0a          	ldw	_last_bright1,x
 722                     ; 271 		aim_bright1 = 0;
 724  0034 ae0000        	ldw	x,#0
 725  0037 bf02          	ldw	_aim_bright1+2,x
 726  0039 ae0000        	ldw	x,#0
 727  003c bf00          	ldw	_aim_bright1,x
 728                     ; 272 		last_bright2 = 0.16;
 730  003e ce0012        	ldw	x,L342+2
 731  0041 bf08          	ldw	_last_bright2+2,x
 732  0043 ce0010        	ldw	x,L342
 733  0046 bf06          	ldw	_last_bright2,x
 734                     ; 273 		aim_bright2 = 0;
 736  0048 ae0000        	ldw	x,#0
 737  004b bf02          	ldw	_aim_bright2+2,x
 738  004d ae0000        	ldw	x,#0
 739  0050 bf00          	ldw	_aim_bright2,x
 740                     ; 274 }
 743  0052 81            	ret
 769                     ; 276 static void ExtInterrupt_Config(void)
 769                     ; 277 {
 770                     .text:	section	.text,new
 771  0000               L7_ExtInterrupt_Config:
 775                     ; 279 	EXTI_DeInit();
 777  0000 cd0000        	call	_EXTI_DeInit
 779                     ; 280 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 781  0003 ae0002        	ldw	x,#2
 782  0006 a603          	ld	a,#3
 783  0008 95            	ld	xh,a
 784  0009 cd0000        	call	_EXTI_SetExtIntSensitivity
 786                     ; 282 }
 789  000c 81            	ret
 819                     ; 288 @far @interrupt void Ext_PortD_ISR(void) {
 821                     .text:	section	.text,new
 822  0000               f_Ext_PortD_ISR:
 825  0000 3b0002        	push	c_x+2
 826  0003 be00          	ldw	x,c_x
 827  0005 89            	pushw	x
 828  0006 3b0002        	push	c_y+2
 829  0009 be00          	ldw	x,c_y
 830  000b 89            	pushw	x
 833                     ; 291 	if (ZD_STATUS == 0)
 835  000c ae500f        	ldw	x,#20495
 836  000f cd0000        	call	_GPIO_ReadOutputData
 838  0012 a508          	bcp	a,#8
 839  0014 2704          	jreq	L62
 840  0016 acc800c8      	jpf	L762
 841  001a               L62:
 842                     ; 293 		sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 844  001a ae07d0        	ldw	x,#2000
 845  001d bf0e          	ldw	_sys+14,x
 846                     ; 294 		sys.acErrFlag = FALSE;
 848  001f 3f10          	clr	_sys+16
 849                     ; 297 		if (!sys.gotHzFlag)
 851  0021 3d09          	tnz	_sys+9
 852  0023 262f          	jrne	L172
 853                     ; 299 			if (!sys.reqCalHzFlag)
 855  0025 3d08          	tnz	_sys+8
 856  0027 2609          	jrne	L372
 857                     ; 301 				TIM4_SetAutoreload(TIMER4_INT_TIME);				
 859  0029 a632          	ld	a,#50
 860  002b cd0000        	call	_TIM4_SetAutoreload
 862                     ; 302 				sys.reqCalHzFlag = TRUE;
 864  002e 35010008      	mov	_sys+8,#1
 865  0032               L372:
 866                     ; 304 			if (sys.calHzIntCnt == 0)
 868  0032 3d0b          	tnz	_sys+11
 869  0034 261a          	jrne	L572
 870                     ; 306 				if ((sys.hzCnt/GET_AC_FRE_CNT) >= HZ_COUNT)
 872  0036 be0c          	ldw	x,_sys+12
 873  0038 a60a          	ld	a,#10
 874  003a 62            	div	x,a
 875  003b a300b4        	cpw	x,#180
 876  003e 2506          	jrult	L772
 877                     ; 308 					sys.hz50Flag = TRUE;
 879  0040 3501000a      	mov	_sys+10,#1
 881  0044 2002          	jra	L103
 882  0046               L772:
 883                     ; 312 					sys.hz50Flag = FALSE;
 885  0046 3f0a          	clr	_sys+10
 886  0048               L103:
 887                     ; 315 				sys.gotHzFlag = TRUE;
 889  0048 35010009      	mov	_sys+9,#1
 890                     ; 316 				sys.reqCalHzFlag = FALSE;
 892  004c 3f08          	clr	_sys+8
 894  004e 2078          	jra	L762
 895  0050               L572:
 896                     ; 320 				sys.calHzIntCnt--;
 898  0050 3a0b          	dec	_sys+11
 899  0052 2074          	jra	L762
 900  0054               L172:
 901                     ; 325 			if (sys.light1.briVal == MAX_BRIGHTNESS)
 903  0054 b602          	ld	a,_sys+2
 904  0056 a1fa          	cp	a,#250
 905  0058 2615          	jrne	L703
 906                     ; 329 				L1_EN_ON;
 908  005a 4b10          	push	#16
 909  005c ae500a        	ldw	x,#20490
 910  005f cd0000        	call	_GPIO_WriteLow
 912  0062 84            	pop	a
 915  0063 35280001      	mov	_sys+1,#40
 916                     ; 330 				sys.light1.briCnt = 0;
 918  0067 3f00          	clr	_sys
 919                     ; 331 				sys.light1.onFlag = TRUE;			
 921  0069 35010003      	mov	_sys+3,#1
 923  006d 2011          	jra	L113
 924  006f               L703:
 925                     ; 336 				sys.light1.briCnt = MAX_BRIGHTNESS - sys.light1.briVal;				
 927  006f a6fa          	ld	a,#250
 928  0071 b002          	sub	a,_sys+2
 929  0073 b700          	ld	_sys,a
 930                     ; 337 				sys.light1.onFlag = FALSE;
 932  0075 3f03          	clr	_sys+3
 933                     ; 338 				L1_EN_OFF;
 935  0077 4b10          	push	#16
 936  0079 ae500a        	ldw	x,#20490
 937  007c cd0000        	call	_GPIO_WriteHigh
 939  007f 84            	pop	a
 940  0080               L113:
 941                     ; 341 			if (sys.light2.briVal == MAX_BRIGHTNESS)
 943  0080 b606          	ld	a,_sys+6
 944  0082 a1fa          	cp	a,#250
 945  0084 2615          	jrne	L313
 946                     ; 343 				L2_EN_ON;
 948  0086 4b08          	push	#8
 949  0088 ae500a        	ldw	x,#20490
 950  008b cd0000        	call	_GPIO_WriteLow
 952  008e 84            	pop	a
 955  008f 35280005      	mov	_sys+5,#40
 956                     ; 344 				sys.light2.briCnt = 0;
 958  0093 3f04          	clr	_sys+4
 959                     ; 345 				sys.light2.onFlag = TRUE;			
 961  0095 35010007      	mov	_sys+7,#1
 963  0099 2011          	jra	L513
 964  009b               L313:
 965                     ; 349 				sys.light2.briCnt = MAX_BRIGHTNESS - sys.light2.briVal;
 967  009b a6fa          	ld	a,#250
 968  009d b006          	sub	a,_sys+6
 969  009f b704          	ld	_sys+4,a
 970                     ; 350 				sys.light2.onFlag = FALSE;				
 972  00a1 3f07          	clr	_sys+7
 973                     ; 351 				L2_EN_OFF;
 975  00a3 4b08          	push	#8
 976  00a5 ae500a        	ldw	x,#20490
 977  00a8 cd0000        	call	_GPIO_WriteHigh
 979  00ab 84            	pop	a
 980  00ac               L513:
 981                     ; 354 			if (sys.light1.briCnt || sys.light2.briCnt)
 983  00ac 3d00          	tnz	_sys
 984  00ae 2604          	jrne	L123
 986  00b0 3d04          	tnz	_sys+4
 987  00b2 2714          	jreq	L762
 988  00b4               L123:
 989                     ; 357 				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
 991  00b4 3d0a          	tnz	_sys+10
 992  00b6 2705          	jreq	L22
 993  00b8 ae0028        	ldw	x,#40
 994  00bb 2003          	jra	L42
 995  00bd               L22:
 996  00bd ae0021        	ldw	x,#33
 997  00c0               L42:
 998  00c0 cd0000        	call	_TIM2_SetAutoreload
1000                     ; 358 				TIM2_Cmd(ENABLE);
1002  00c3 a601          	ld	a,#1
1003  00c5 cd0000        	call	_TIM2_Cmd
1005  00c8               L762:
1006                     ; 362 }
1009  00c8 85            	popw	x
1010  00c9 bf00          	ldw	c_y,x
1011  00cb 320002        	pop	c_y+2
1012  00ce 85            	popw	x
1013  00cf bf00          	ldw	c_x,x
1014  00d1 320002        	pop	c_x+2
1015  00d4 80            	iret
1041                     ; 382 static void TIMER4_Init(void)
1041                     ; 383 {    
1043                     .text:	section	.text,new
1044  0000               L31_TIMER4_Init:
1048                     ; 384     TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIMER4_INT_TIME);
1050  0000 ae0032        	ldw	x,#50
1051  0003 a604          	ld	a,#4
1052  0005 95            	ld	xh,a
1053  0006 cd0000        	call	_TIM4_TimeBaseInit
1055                     ; 385     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
1057  0009 a601          	ld	a,#1
1058  000b cd0000        	call	_TIM4_ClearFlag
1060                     ; 386     TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);	
1062  000e ae0001        	ldw	x,#1
1063  0011 a601          	ld	a,#1
1064  0013 95            	ld	xh,a
1065  0014 cd0000        	call	_TIM4_ITConfig
1067                     ; 387     TIM4_Cmd(ENABLE);
1069  0017 a601          	ld	a,#1
1070  0019 cd0000        	call	_TIM4_Cmd
1072                     ; 388 }
1075  001c 81            	ret
1103                     ; 394 @far @interrupt void Timer4_ISR(void) {
1105                     .text:	section	.text,new
1106  0000               f_Timer4_ISR:
1109  0000 3b0002        	push	c_x+2
1110  0003 be00          	ldw	x,c_x
1111  0005 89            	pushw	x
1112  0006 3b0002        	push	c_y+2
1113  0009 be00          	ldw	x,c_y
1114  000b 89            	pushw	x
1117                     ; 396 TIM4_ClearITPendingBit(TIM4_IT_UPDATE);  
1119  000c a601          	ld	a,#1
1120  000e cd0000        	call	_TIM4_ClearITPendingBit
1122                     ; 397   if (sys.reqCalHzFlag)
1124  0011 3d08          	tnz	_sys+8
1125  0013 2707          	jreq	L343
1126                     ; 399 	  sys.hzCnt++; 	  
1128  0015 be0c          	ldw	x,_sys+12
1129  0017 1c0001        	addw	x,#1
1130  001a bf0c          	ldw	_sys+12,x
1131  001c               L343:
1132                     ; 402   if (sys.light1.triacTriggeTime)
1134  001c 3d01          	tnz	_sys+1
1135  001e 270f          	jreq	L543
1136                     ; 404 	  sys.light1.triacTriggeTime--;
1138  0020 3a01          	dec	_sys+1
1139                     ; 405 	  if (sys.light1.triacTriggeTime == 0)
1141  0022 3d01          	tnz	_sys+1
1142  0024 2609          	jrne	L543
1143                     ; 407 		  L1_EN_OFF;
1145  0026 4b10          	push	#16
1146  0028 ae500a        	ldw	x,#20490
1147  002b cd0000        	call	_GPIO_WriteHigh
1149  002e 84            	pop	a
1150  002f               L543:
1151                     ; 412   if (sys.light2.triacTriggeTime)
1153  002f 3d05          	tnz	_sys+5
1154  0031 270f          	jreq	L153
1155                     ; 414 	  sys.light2.triacTriggeTime--;
1157  0033 3a05          	dec	_sys+5
1158                     ; 415 	  if (sys.light2.triacTriggeTime == 0)
1160  0035 3d05          	tnz	_sys+5
1161  0037 2609          	jrne	L153
1162                     ; 417 		  L2_EN_OFF;
1164  0039 4b08          	push	#8
1165  003b ae500a        	ldw	x,#20490
1166  003e cd0000        	call	_GPIO_WriteHigh
1168  0041 84            	pop	a
1169  0042               L153:
1170                     ; 421   if (sys.checkAcCnt)
1172  0042 be0e          	ldw	x,_sys+14
1173  0044 2707          	jreq	L553
1174                     ; 423 		sys.checkAcCnt--;
1176  0046 be0e          	ldw	x,_sys+14
1177  0048 1d0001        	subw	x,#1
1178  004b bf0e          	ldw	_sys+14,x
1179  004d               L553:
1180                     ; 426   if (sys.cnt1s)
1182  004d be1b          	ldw	x,_sys+27
1183  004f 2707          	jreq	L753
1184                     ; 428 		sys.cnt1s--;
1186  0051 be1b          	ldw	x,_sys+27
1187  0053 1d0001        	subw	x,#1
1188  0056 bf1b          	ldw	_sys+27,x
1189  0058               L753:
1190                     ; 430 	Tick100ms++;
1192  0058 be02          	ldw	x,_Tick100ms
1193  005a 1c0001        	addw	x,#1
1194  005d bf02          	ldw	_Tick100ms,x
1195                     ; 431 	if(Tick100ms >= 2000){
1197  005f be02          	ldw	x,_Tick100ms
1198  0061 a307d0        	cpw	x,#2000
1199  0064 2507          	jrult	L163
1200                     ; 432 		Tick100ms = 0;
1202  0066 5f            	clrw	x
1203  0067 bf02          	ldw	_Tick100ms,x
1204                     ; 433 		f_100ms = 1;
1206  0069 35010001      	mov	_f_100ms,#1
1207  006d               L163:
1208                     ; 435 }
1211  006d 85            	popw	x
1212  006e bf00          	ldw	c_y,x
1213  0070 320002        	pop	c_y+2
1214  0073 85            	popw	x
1215  0074 bf00          	ldw	c_x,x
1216  0076 320002        	pop	c_x+2
1217  0079 80            	iret
1243                     ; 437 static void TIMER2_Init(void)
1243                     ; 438 {    
1245                     .text:	section	.text,new
1246  0000               L11_TIMER2_Init:
1250                     ; 439 	TIM2_TimeBaseInit(TIM2_PRESCALER_16, sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
1252  0000 3d0a          	tnz	_sys+10
1253  0002 2705          	jreq	L63
1254  0004 ae0028        	ldw	x,#40
1255  0007 2003          	jra	L04
1256  0009               L63:
1257  0009 ae0021        	ldw	x,#33
1258  000c               L04:
1259  000c 89            	pushw	x
1260  000d a604          	ld	a,#4
1261  000f cd0000        	call	_TIM2_TimeBaseInit
1263  0012 85            	popw	x
1264                     ; 440    	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
1266  0013 ae0001        	ldw	x,#1
1267  0016 cd0000        	call	_TIM2_ClearFlag
1269                     ; 441    	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	   
1271  0019 ae0001        	ldw	x,#1
1272  001c a601          	ld	a,#1
1273  001e 95            	ld	xh,a
1274  001f cd0000        	call	_TIM2_ITConfig
1276                     ; 442 }
1279  0022 81            	ret
1306                     ; 448 @far @interrupt void Timer2_ISR(void) {
1308                     .text:	section	.text,new
1309  0000               f_Timer2_ISR:
1312  0000 3b0002        	push	c_x+2
1313  0003 be00          	ldw	x,c_x
1314  0005 89            	pushw	x
1315  0006 3b0002        	push	c_y+2
1316  0009 be00          	ldw	x,c_y
1317  000b 89            	pushw	x
1320                     ; 450 	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);  
1322  000c a601          	ld	a,#1
1323  000e cd0000        	call	_TIM2_ClearITPendingBit
1325                     ; 451 	if (sys.light1.briCnt) 
1327  0011 3d00          	tnz	_sys
1328  0013 2702          	jreq	L304
1329                     ; 453 		sys.light1.briCnt--;			
1331  0015 3a00          	dec	_sys
1332  0017               L304:
1333                     ; 455 	if (sys.light1.briCnt == 0 && !sys.light1.onFlag)
1335  0017 3d00          	tnz	_sys
1336  0019 2615          	jrne	L504
1338  001b 3d03          	tnz	_sys+3
1339  001d 2611          	jrne	L504
1340                     ; 457 		L1_EN_ON;
1342  001f 4b10          	push	#16
1343  0021 ae500a        	ldw	x,#20490
1344  0024 cd0000        	call	_GPIO_WriteLow
1346  0027 84            	pop	a
1349  0028 35280001      	mov	_sys+1,#40
1350                     ; 458 		sys.light1.onFlag = TRUE;
1352  002c 35010003      	mov	_sys+3,#1
1353  0030               L504:
1354                     ; 462 	if (sys.light2.briCnt) 
1356  0030 3d04          	tnz	_sys+4
1357  0032 2702          	jreq	L704
1358                     ; 464 		sys.light2.briCnt--;		
1360  0034 3a04          	dec	_sys+4
1361  0036               L704:
1362                     ; 466 	if (sys.light2.briCnt == 0 && !sys.light2.onFlag)
1364  0036 3d04          	tnz	_sys+4
1365  0038 2615          	jrne	L114
1367  003a 3d07          	tnz	_sys+7
1368  003c 2611          	jrne	L114
1369                     ; 468 		L2_EN_ON;
1371  003e 4b08          	push	#8
1372  0040 ae500a        	ldw	x,#20490
1373  0043 cd0000        	call	_GPIO_WriteLow
1375  0046 84            	pop	a
1378  0047 35280005      	mov	_sys+5,#40
1379                     ; 469 		sys.light2.onFlag = TRUE;
1381  004b 35010007      	mov	_sys+7,#1
1382  004f               L114:
1383                     ; 472 	if ((sys.light1.briCnt ||  sys.light2.briCnt) == 0)
1385  004f 3d00          	tnz	_sys
1386  0051 2604          	jrne	L64
1387  0053 3d04          	tnz	_sys+4
1388  0055 2705          	jreq	L44
1389  0057               L64:
1390  0057 ae0001        	ldw	x,#1
1391  005a 2001          	jra	L05
1392  005c               L44:
1393  005c 5f            	clrw	x
1394  005d               L05:
1395  005d a30000        	cpw	x,#0
1396  0060 2604          	jrne	L314
1397                     ; 474 		TIM2_Cmd(DISABLE);
1399  0062 4f            	clr	a
1400  0063 cd0000        	call	_TIM2_Cmd
1402  0066               L314:
1403                     ; 476 }
1406  0066 85            	popw	x
1407  0067 bf00          	ldw	c_y,x
1408  0069 320002        	pop	c_y+2
1409  006c 85            	popw	x
1410  006d bf00          	ldw	c_x,x
1411  006f 320002        	pop	c_x+2
1412  0072 80            	iret
1445                     ; 478 u8 Linear(float t)
1445                     ; 479 {
1447                     .text:	section	.text,new
1448  0000               _Linear:
1450  0000 5204          	subw	sp,#4
1451       00000004      OFST:	set	4
1454                     ; 480 	if((t >= 0)&&(t <=1))
1456  0002 9c            	rvf
1457  0003 0d07          	tnz	(OFST+3,sp)
1458  0005 2f31          	jrslt	L334
1460  0007 9c            	rvf
1461  0008 a601          	ld	a,#1
1462  000a cd0000        	call	c_ctof
1464  000d 96            	ldw	x,sp
1465  000e 1c0001        	addw	x,#OFST-3
1466  0011 cd0000        	call	c_rtol
1468  0014 96            	ldw	x,sp
1469  0015 1c0007        	addw	x,#OFST+3
1470  0018 cd0000        	call	c_ltor
1472  001b 96            	ldw	x,sp
1473  001c 1c0001        	addw	x,#OFST-3
1474  001f cd0000        	call	c_fcmp
1476  0022 2c14          	jrsgt	L334
1477                     ; 481 		return (u8)(t*250);
1479  0024 96            	ldw	x,sp
1480  0025 1c0007        	addw	x,#OFST+3
1481  0028 cd0000        	call	c_ltor
1483  002b ae000c        	ldw	x,#L144
1484  002e cd0000        	call	c_fmul
1486  0031 cd0000        	call	c_ftol
1488  0034 b603          	ld	a,c_lreg+3
1490  0036 2002          	jra	L45
1491  0038               L334:
1492                     ; 483 		return 40;
1494  0038 a628          	ld	a,#40
1496  003a               L45:
1498  003a 5b04          	addw	sp,#4
1499  003c 81            	ret
1533                     ; 485 u8 EraseIn(float t)
1533                     ; 486 {
1534                     .text:	section	.text,new
1535  0000               _EraseIn:
1537  0000 5204          	subw	sp,#4
1538       00000004      OFST:	set	4
1541                     ; 487 	if((t >= 0)&&(t <=1))
1543  0002 9c            	rvf
1544  0003 0d07          	tnz	(OFST+3,sp)
1545  0005 2f38          	jrslt	L564
1547  0007 9c            	rvf
1548  0008 a601          	ld	a,#1
1549  000a cd0000        	call	c_ctof
1551  000d 96            	ldw	x,sp
1552  000e 1c0001        	addw	x,#OFST-3
1553  0011 cd0000        	call	c_rtol
1555  0014 96            	ldw	x,sp
1556  0015 1c0007        	addw	x,#OFST+3
1557  0018 cd0000        	call	c_ltor
1559  001b 96            	ldw	x,sp
1560  001c 1c0001        	addw	x,#OFST-3
1561  001f cd0000        	call	c_fcmp
1563  0022 2c1b          	jrsgt	L564
1564                     ; 488 		return (u8)(t*t*250);
1566  0024 96            	ldw	x,sp
1567  0025 1c0007        	addw	x,#OFST+3
1568  0028 cd0000        	call	c_ltor
1570  002b 96            	ldw	x,sp
1571  002c 1c0007        	addw	x,#OFST+3
1572  002f cd0000        	call	c_fmul
1574  0032 ae000c        	ldw	x,#L144
1575  0035 cd0000        	call	c_fmul
1577  0038 cd0000        	call	c_ftol
1579  003b b603          	ld	a,c_lreg+3
1581  003d 2002          	jra	L06
1582  003f               L564:
1583                     ; 490 		return 40;
1585  003f a628          	ld	a,#40
1587  0041               L06:
1589  0041 5b04          	addw	sp,#4
1590  0043 81            	ret
1624                     ; 492 u8 EraseOut(float t)
1624                     ; 493 {
1625                     .text:	section	.text,new
1626  0000               _EraseOut:
1628  0000 5204          	subw	sp,#4
1629       00000004      OFST:	set	4
1632                     ; 494 	if((t >= 0)&&(t <=1))
1634  0002 9c            	rvf
1635  0003 0d07          	tnz	(OFST+3,sp)
1636  0005 2f3d          	jrslt	L705
1638  0007 9c            	rvf
1639  0008 a601          	ld	a,#1
1640  000a cd0000        	call	c_ctof
1642  000d 96            	ldw	x,sp
1643  000e 1c0001        	addw	x,#OFST-3
1644  0011 cd0000        	call	c_rtol
1646  0014 96            	ldw	x,sp
1647  0015 1c0007        	addw	x,#OFST+3
1648  0018 cd0000        	call	c_ltor
1650  001b 96            	ldw	x,sp
1651  001c 1c0001        	addw	x,#OFST-3
1652  001f cd0000        	call	c_fcmp
1654  0022 2c20          	jrsgt	L705
1655                     ; 495 		return (u8)((2-t)*t*250);
1657  0024 a602          	ld	a,#2
1658  0026 cd0000        	call	c_ctof
1660  0029 96            	ldw	x,sp
1661  002a 1c0007        	addw	x,#OFST+3
1662  002d cd0000        	call	c_fsub
1664  0030 96            	ldw	x,sp
1665  0031 1c0007        	addw	x,#OFST+3
1666  0034 cd0000        	call	c_fmul
1668  0037 ae000c        	ldw	x,#L144
1669  003a cd0000        	call	c_fmul
1671  003d cd0000        	call	c_ftol
1673  0040 b603          	ld	a,c_lreg+3
1675  0042 2002          	jra	L46
1676  0044               L705:
1677                     ; 497 		return 40;
1679  0044 a628          	ld	a,#40
1681  0046               L46:
1683  0046 5b04          	addw	sp,#4
1684  0048 81            	ret
1718                     ; 499 u8 Swing(float t)
1718                     ; 500 {
1719                     .text:	section	.text,new
1720  0000               _Swing:
1722  0000 5204          	subw	sp,#4
1723       00000004      OFST:	set	4
1726                     ; 501 	if((t >= 0)&&(t <=1)){
1728  0002 9c            	rvf
1729  0003 0d07          	tnz	(OFST+3,sp)
1730  0005 2e03          	jrsge	L27
1731  0007 cc0093        	jp	L135
1732  000a               L27:
1734  000a 9c            	rvf
1735  000b a601          	ld	a,#1
1736  000d cd0000        	call	c_ctof
1738  0010 96            	ldw	x,sp
1739  0011 1c0001        	addw	x,#OFST-3
1740  0014 cd0000        	call	c_rtol
1742  0017 96            	ldw	x,sp
1743  0018 1c0007        	addw	x,#OFST+3
1744  001b cd0000        	call	c_ltor
1746  001e 96            	ldw	x,sp
1747  001f 1c0001        	addw	x,#OFST-3
1748  0022 cd0000        	call	c_fcmp
1750  0025 2c6c          	jrsgt	L135
1751                     ; 502 		if(t < 0.5)
1753  0027 9c            	rvf
1754  0028 96            	ldw	x,sp
1755  0029 1c0007        	addw	x,#OFST+3
1756  002c cd0000        	call	c_ltor
1758  002f ae0008        	ldw	x,#L145
1759  0032 cd0000        	call	c_fcmp
1761  0035 2e21          	jrsge	L335
1762                     ; 503 			return (u8)(2*t*t*250);
1764  0037 96            	ldw	x,sp
1765  0038 1c0007        	addw	x,#OFST+3
1766  003b cd0000        	call	c_ltor
1768  003e ae0004        	ldw	x,#L155
1769  0041 cd0000        	call	c_fmul
1771  0044 96            	ldw	x,sp
1772  0045 1c0007        	addw	x,#OFST+3
1773  0048 cd0000        	call	c_fmul
1775  004b ae000c        	ldw	x,#L144
1776  004e cd0000        	call	c_fmul
1778  0051 cd0000        	call	c_ftol
1780  0054 b603          	ld	a,c_lreg+3
1782  0056 2038          	jra	L07
1783  0058               L335:
1784                     ; 505 			return (u8)(((4-2*t)*t - 1)*250);
1786  0058 96            	ldw	x,sp
1787  0059 1c0007        	addw	x,#OFST+3
1788  005c cd0000        	call	c_ltor
1790  005f ae0004        	ldw	x,#L155
1791  0062 cd0000        	call	c_fmul
1793  0065 96            	ldw	x,sp
1794  0066 1c0001        	addw	x,#OFST-3
1795  0069 cd0000        	call	c_rtol
1797  006c a604          	ld	a,#4
1798  006e cd0000        	call	c_ctof
1800  0071 96            	ldw	x,sp
1801  0072 1c0001        	addw	x,#OFST-3
1802  0075 cd0000        	call	c_fsub
1804  0078 96            	ldw	x,sp
1805  0079 1c0007        	addw	x,#OFST+3
1806  007c cd0000        	call	c_fmul
1808  007f ae0000        	ldw	x,#L365
1809  0082 cd0000        	call	c_fsub
1811  0085 ae000c        	ldw	x,#L144
1812  0088 cd0000        	call	c_fmul
1814  008b cd0000        	call	c_ftol
1816  008e b603          	ld	a,c_lreg+3
1818  0090               L07:
1820  0090 5b04          	addw	sp,#4
1821  0092 81            	ret
1822  0093               L135:
1823                     ; 508 		return 40;
1825  0093 a628          	ld	a,#40
1827  0095 20f9          	jra	L07
1864                     ; 511 void lightCtrl100ms(void)
1864                     ; 512 {
1865                     .text:	section	.text,new
1866  0000               _lightCtrl100ms:
1870                     ; 513 	if((channel & 0x01) == 0x01){
1872  0000 b600          	ld	a,_channel
1873  0002 a401          	and	a,#1
1874  0004 a101          	cp	a,#1
1875  0006 266e          	jrne	L106
1876                     ; 514 	if(linear1_begin){//channel1 Linear调光开始
1878  0008 b600          	ld	a,_action_flag
1879  000a a501          	bcp	a,#1
1880  000c 2768          	jreq	L106
1881                     ; 515 		last_bright1 += change_step1;
1883  000e ae0000        	ldw	x,#_change_step1
1884  0011 cd0000        	call	c_ltor
1886  0014 ae000a        	ldw	x,#_last_bright1
1887  0017 cd0000        	call	c_fgadd
1889                     ; 516 		realtime_bright1 = Linear(last_bright1);
1891  001a be0c          	ldw	x,_last_bright1+2
1892  001c 89            	pushw	x
1893  001d be0a          	ldw	x,_last_bright1
1894  001f 89            	pushw	x
1895  0020 cd0000        	call	_Linear
1897  0023 5b04          	addw	sp,#4
1898  0025 b705          	ld	_realtime_bright1,a
1899                     ; 517 		if(last_bright1 > aim_bright1){
1901  0027 9c            	rvf
1902  0028 ae000a        	ldw	x,#_last_bright1
1903  002b cd0000        	call	c_ltor
1905  002e ae0000        	ldw	x,#_aim_bright1
1906  0031 cd0000        	call	c_fcmp
1908  0034 2d21          	jrsle	L506
1909                     ; 518 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
1911  0036 ae000a        	ldw	x,#_last_bright1
1912  0039 cd0000        	call	c_ltor
1914  003c ae0000        	ldw	x,#_aim_bright1
1915  003f cd0000        	call	c_fsub
1917  0042 ae000c        	ldw	x,#L144
1918  0045 cd0000        	call	c_fmul
1920  0048 cd0000        	call	c_ftol
1922  004b b603          	ld	a,c_lreg+3
1923  004d a102          	cp	a,#2
1924  004f 2425          	jruge	L106
1925                     ; 519 				linear1_begin = 0;
1927  0051 72110000      	bres	_action_flag,#0
1928  0055 201f          	jra	L106
1929  0057               L506:
1930                     ; 522 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
1932  0057 ae0000        	ldw	x,#_aim_bright1
1933  005a cd0000        	call	c_ltor
1935  005d ae000a        	ldw	x,#_last_bright1
1936  0060 cd0000        	call	c_fsub
1938  0063 ae000c        	ldw	x,#L144
1939  0066 cd0000        	call	c_fmul
1941  0069 cd0000        	call	c_ftol
1943  006c b603          	ld	a,c_lreg+3
1944  006e a102          	cp	a,#2
1945  0070 2404          	jruge	L106
1946                     ; 523 				linear1_begin = 0;
1948  0072 72110000      	bres	_action_flag,#0
1949  0076               L106:
1950                     ; 527 	if((channel & 0x02) == 0x02){
1952  0076 b600          	ld	a,_channel
1953  0078 a402          	and	a,#2
1954  007a a102          	cp	a,#2
1955  007c 266e          	jrne	L516
1956                     ; 528 	if(linear2_begin){//channel2 Linear调光开始
1958  007e b600          	ld	a,_action_flag
1959  0080 a502          	bcp	a,#2
1960  0082 2768          	jreq	L516
1961                     ; 529 		last_bright2 += change_step2;
1963  0084 ae0000        	ldw	x,#_change_step2
1964  0087 cd0000        	call	c_ltor
1966  008a ae0006        	ldw	x,#_last_bright2
1967  008d cd0000        	call	c_fgadd
1969                     ; 530 		realtime_bright2 = Linear(last_bright2);
1971  0090 be08          	ldw	x,_last_bright2+2
1972  0092 89            	pushw	x
1973  0093 be06          	ldw	x,_last_bright2
1974  0095 89            	pushw	x
1975  0096 cd0000        	call	_Linear
1977  0099 5b04          	addw	sp,#4
1978  009b b704          	ld	_realtime_bright2,a
1979                     ; 531 		if(last_bright2 > aim_bright2){
1981  009d 9c            	rvf
1982  009e ae0006        	ldw	x,#_last_bright2
1983  00a1 cd0000        	call	c_ltor
1985  00a4 ae0000        	ldw	x,#_aim_bright2
1986  00a7 cd0000        	call	c_fcmp
1988  00aa 2d21          	jrsle	L126
1989                     ; 532 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
1991  00ac ae0006        	ldw	x,#_last_bright2
1992  00af cd0000        	call	c_ltor
1994  00b2 ae0000        	ldw	x,#_aim_bright2
1995  00b5 cd0000        	call	c_fsub
1997  00b8 ae000c        	ldw	x,#L144
1998  00bb cd0000        	call	c_fmul
2000  00be cd0000        	call	c_ftol
2002  00c1 b603          	ld	a,c_lreg+3
2003  00c3 a102          	cp	a,#2
2004  00c5 2425          	jruge	L516
2005                     ; 533 				linear2_begin = 0;
2007  00c7 72130000      	bres	_action_flag,#1
2008  00cb 201f          	jra	L516
2009  00cd               L126:
2010                     ; 536 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2012  00cd ae0000        	ldw	x,#_aim_bright2
2013  00d0 cd0000        	call	c_ltor
2015  00d3 ae0006        	ldw	x,#_last_bright2
2016  00d6 cd0000        	call	c_fsub
2018  00d9 ae000c        	ldw	x,#L144
2019  00dc cd0000        	call	c_fmul
2021  00df cd0000        	call	c_ftol
2023  00e2 b603          	ld	a,c_lreg+3
2024  00e4 a102          	cp	a,#2
2025  00e6 2404          	jruge	L516
2026                     ; 537 				linear2_begin = 0;
2028  00e8 72130000      	bres	_action_flag,#1
2029  00ec               L516:
2030                     ; 541 	if(eraseIn1_begin){//channel1 EraseIn调光开始
2032  00ec b600          	ld	a,_action_flag
2033  00ee a504          	bcp	a,#4
2034  00f0 2770          	jreq	L136
2035                     ; 542 		last_bright1 += change_step1;
2037  00f2 ae0000        	ldw	x,#_change_step1
2038  00f5 cd0000        	call	c_ltor
2040  00f8 ae000a        	ldw	x,#_last_bright1
2041  00fb cd0000        	call	c_fgadd
2043                     ; 543 		realtime_bright1 = EraseIn(last_bright1);	
2045  00fe be0c          	ldw	x,_last_bright1+2
2046  0100 89            	pushw	x
2047  0101 be0a          	ldw	x,_last_bright1
2048  0103 89            	pushw	x
2049  0104 cd0000        	call	_EraseIn
2051  0107 5b04          	addw	sp,#4
2052  0109 b705          	ld	_realtime_bright1,a
2053                     ; 544 		if(last_bright1 > aim_bright1){
2055  010b 9c            	rvf
2056  010c ae000a        	ldw	x,#_last_bright1
2057  010f cd0000        	call	c_ltor
2059  0112 ae0000        	ldw	x,#_aim_bright1
2060  0115 cd0000        	call	c_fcmp
2062  0118 2d25          	jrsle	L336
2063                     ; 545 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2065  011a ae000a        	ldw	x,#_last_bright1
2066  011d cd0000        	call	c_ltor
2068  0120 ae0000        	ldw	x,#_aim_bright1
2069  0123 cd0000        	call	c_fsub
2071  0126 ae000c        	ldw	x,#L144
2072  0129 cd0000        	call	c_fmul
2074  012c cd0000        	call	c_ftol
2076  012f b603          	ld	a,c_lreg+3
2077  0131 a102          	cp	a,#2
2078  0133 2404          	jruge	L536
2079                     ; 546 				eraseIn1_begin = 0;channel &= ~(0x01);
2081  0135 72150000      	bres	_action_flag,#2
2082  0139               L536:
2085  0139 72110000      	bres	_channel,#0
2087  013d 2023          	jra	L136
2088  013f               L336:
2089                     ; 549 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2091  013f ae0000        	ldw	x,#_aim_bright1
2092  0142 cd0000        	call	c_ltor
2094  0145 ae000a        	ldw	x,#_last_bright1
2095  0148 cd0000        	call	c_fsub
2097  014b ae000c        	ldw	x,#L144
2098  014e cd0000        	call	c_fmul
2100  0151 cd0000        	call	c_ftol
2102  0154 b603          	ld	a,c_lreg+3
2103  0156 a102          	cp	a,#2
2104  0158 2404          	jruge	L146
2105                     ; 550 				eraseIn1_begin = 0;channel &= ~(0x01);
2107  015a 72150000      	bres	_action_flag,#2
2108  015e               L146:
2111  015e 72110000      	bres	_channel,#0
2112  0162               L136:
2113                     ; 553 	if(eraseIn2_begin){//channel2 EraseIn调光开始
2115  0162 b600          	ld	a,_action_flag
2116  0164 a508          	bcp	a,#8
2117  0166 2770          	jreq	L346
2118                     ; 554 		last_bright2 += change_step2;
2120  0168 ae0000        	ldw	x,#_change_step2
2121  016b cd0000        	call	c_ltor
2123  016e ae0006        	ldw	x,#_last_bright2
2124  0171 cd0000        	call	c_fgadd
2126                     ; 555 		realtime_bright2 = EraseIn(last_bright2);
2128  0174 be08          	ldw	x,_last_bright2+2
2129  0176 89            	pushw	x
2130  0177 be06          	ldw	x,_last_bright2
2131  0179 89            	pushw	x
2132  017a cd0000        	call	_EraseIn
2134  017d 5b04          	addw	sp,#4
2135  017f b704          	ld	_realtime_bright2,a
2136                     ; 556 		if(last_bright2 > aim_bright2){
2138  0181 9c            	rvf
2139  0182 ae0006        	ldw	x,#_last_bright2
2140  0185 cd0000        	call	c_ltor
2142  0188 ae0000        	ldw	x,#_aim_bright2
2143  018b cd0000        	call	c_fcmp
2145  018e 2d25          	jrsle	L546
2146                     ; 557 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2148  0190 ae0006        	ldw	x,#_last_bright2
2149  0193 cd0000        	call	c_ltor
2151  0196 ae0000        	ldw	x,#_aim_bright2
2152  0199 cd0000        	call	c_fsub
2154  019c ae000c        	ldw	x,#L144
2155  019f cd0000        	call	c_fmul
2157  01a2 cd0000        	call	c_ftol
2159  01a5 b603          	ld	a,c_lreg+3
2160  01a7 a102          	cp	a,#2
2161  01a9 2404          	jruge	L746
2162                     ; 558 				eraseIn2_begin = 0;channel &= ~(0x02);
2164  01ab 72170000      	bres	_action_flag,#3
2165  01af               L746:
2168  01af 72130000      	bres	_channel,#1
2170  01b3 2023          	jra	L346
2171  01b5               L546:
2172                     ; 561 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2174  01b5 ae0000        	ldw	x,#_aim_bright2
2175  01b8 cd0000        	call	c_ltor
2177  01bb ae0006        	ldw	x,#_last_bright2
2178  01be cd0000        	call	c_fsub
2180  01c1 ae000c        	ldw	x,#L144
2181  01c4 cd0000        	call	c_fmul
2183  01c7 cd0000        	call	c_ftol
2185  01ca b603          	ld	a,c_lreg+3
2186  01cc a102          	cp	a,#2
2187  01ce 2404          	jruge	L356
2188                     ; 562 				eraseIn2_begin = 0;channel &= ~(0x02);
2190  01d0 72170000      	bres	_action_flag,#3
2191  01d4               L356:
2194  01d4 72130000      	bres	_channel,#1
2195  01d8               L346:
2196                     ; 565 	if(eraseOut1_begin){//channel1 EraseOut调光开始
2198  01d8 b600          	ld	a,_action_flag
2199  01da a510          	bcp	a,#16
2200  01dc 2770          	jreq	L556
2201                     ; 566 		last_bright1 += change_step1;
2203  01de ae0000        	ldw	x,#_change_step1
2204  01e1 cd0000        	call	c_ltor
2206  01e4 ae000a        	ldw	x,#_last_bright1
2207  01e7 cd0000        	call	c_fgadd
2209                     ; 567 		realtime_bright1 = EraseOut(last_bright1);	
2211  01ea be0c          	ldw	x,_last_bright1+2
2212  01ec 89            	pushw	x
2213  01ed be0a          	ldw	x,_last_bright1
2214  01ef 89            	pushw	x
2215  01f0 cd0000        	call	_EraseOut
2217  01f3 5b04          	addw	sp,#4
2218  01f5 b705          	ld	_realtime_bright1,a
2219                     ; 568 		if(last_bright1 > aim_bright1){
2221  01f7 9c            	rvf
2222  01f8 ae000a        	ldw	x,#_last_bright1
2223  01fb cd0000        	call	c_ltor
2225  01fe ae0000        	ldw	x,#_aim_bright1
2226  0201 cd0000        	call	c_fcmp
2228  0204 2d25          	jrsle	L756
2229                     ; 569 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2231  0206 ae000a        	ldw	x,#_last_bright1
2232  0209 cd0000        	call	c_ltor
2234  020c ae0000        	ldw	x,#_aim_bright1
2235  020f cd0000        	call	c_fsub
2237  0212 ae000c        	ldw	x,#L144
2238  0215 cd0000        	call	c_fmul
2240  0218 cd0000        	call	c_ftol
2242  021b b603          	ld	a,c_lreg+3
2243  021d a102          	cp	a,#2
2244  021f 2404          	jruge	L166
2245                     ; 570 				eraseOut1_begin = 0;channel &= ~(0x01);
2247  0221 72190000      	bres	_action_flag,#4
2248  0225               L166:
2251  0225 72110000      	bres	_channel,#0
2253  0229 2023          	jra	L556
2254  022b               L756:
2255                     ; 573 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2257  022b ae0000        	ldw	x,#_aim_bright1
2258  022e cd0000        	call	c_ltor
2260  0231 ae000a        	ldw	x,#_last_bright1
2261  0234 cd0000        	call	c_fsub
2263  0237 ae000c        	ldw	x,#L144
2264  023a cd0000        	call	c_fmul
2266  023d cd0000        	call	c_ftol
2268  0240 b603          	ld	a,c_lreg+3
2269  0242 a102          	cp	a,#2
2270  0244 2404          	jruge	L566
2271                     ; 574 				eraseOut1_begin = 0;channel &= ~(0x01);
2273  0246 72190000      	bres	_action_flag,#4
2274  024a               L566:
2277  024a 72110000      	bres	_channel,#0
2278  024e               L556:
2279                     ; 577 	if(eraseOut2_begin){//channel2 EraseOut调光开始
2281  024e b600          	ld	a,_action_flag
2282  0250 a520          	bcp	a,#32
2283  0252 2770          	jreq	L766
2284                     ; 578 		last_bright2 += change_step2;
2286  0254 ae0000        	ldw	x,#_change_step2
2287  0257 cd0000        	call	c_ltor
2289  025a ae0006        	ldw	x,#_last_bright2
2290  025d cd0000        	call	c_fgadd
2292                     ; 579 		realtime_bright2 = EraseOut(last_bright2);
2294  0260 be08          	ldw	x,_last_bright2+2
2295  0262 89            	pushw	x
2296  0263 be06          	ldw	x,_last_bright2
2297  0265 89            	pushw	x
2298  0266 cd0000        	call	_EraseOut
2300  0269 5b04          	addw	sp,#4
2301  026b b704          	ld	_realtime_bright2,a
2302                     ; 580 		if(last_bright2 > aim_bright2){
2304  026d 9c            	rvf
2305  026e ae0006        	ldw	x,#_last_bright2
2306  0271 cd0000        	call	c_ltor
2308  0274 ae0000        	ldw	x,#_aim_bright2
2309  0277 cd0000        	call	c_fcmp
2311  027a 2d25          	jrsle	L176
2312                     ; 581 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2314  027c ae0006        	ldw	x,#_last_bright2
2315  027f cd0000        	call	c_ltor
2317  0282 ae0000        	ldw	x,#_aim_bright2
2318  0285 cd0000        	call	c_fsub
2320  0288 ae000c        	ldw	x,#L144
2321  028b cd0000        	call	c_fmul
2323  028e cd0000        	call	c_ftol
2325  0291 b603          	ld	a,c_lreg+3
2326  0293 a102          	cp	a,#2
2327  0295 2404          	jruge	L376
2328                     ; 582 				eraseOut2_begin = 0;channel &= ~(0x02);
2330  0297 721b0000      	bres	_action_flag,#5
2331  029b               L376:
2334  029b 72130000      	bres	_channel,#1
2336  029f 2023          	jra	L766
2337  02a1               L176:
2338                     ; 585 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2340  02a1 ae0000        	ldw	x,#_aim_bright2
2341  02a4 cd0000        	call	c_ltor
2343  02a7 ae0006        	ldw	x,#_last_bright2
2344  02aa cd0000        	call	c_fsub
2346  02ad ae000c        	ldw	x,#L144
2347  02b0 cd0000        	call	c_fmul
2349  02b3 cd0000        	call	c_ftol
2351  02b6 b603          	ld	a,c_lreg+3
2352  02b8 a102          	cp	a,#2
2353  02ba 2404          	jruge	L776
2354                     ; 586 				eraseOut2_begin = 0;channel &= ~(0x02);
2356  02bc 721b0000      	bres	_action_flag,#5
2357  02c0               L776:
2360  02c0 72130000      	bres	_channel,#1
2361  02c4               L766:
2362                     ; 589 	if(swing1_begin){//channel1 Swing调光开始
2364  02c4 b600          	ld	a,_action_flag
2365  02c6 a540          	bcp	a,#64
2366  02c8 2770          	jreq	L107
2367                     ; 590 		last_bright1 += change_step1;
2369  02ca ae0000        	ldw	x,#_change_step1
2370  02cd cd0000        	call	c_ltor
2372  02d0 ae000a        	ldw	x,#_last_bright1
2373  02d3 cd0000        	call	c_fgadd
2375                     ; 591 		realtime_bright1 = Swing(last_bright1);	
2377  02d6 be0c          	ldw	x,_last_bright1+2
2378  02d8 89            	pushw	x
2379  02d9 be0a          	ldw	x,_last_bright1
2380  02db 89            	pushw	x
2381  02dc cd0000        	call	_Swing
2383  02df 5b04          	addw	sp,#4
2384  02e1 b705          	ld	_realtime_bright1,a
2385                     ; 592 		if(last_bright1 > aim_bright1){
2387  02e3 9c            	rvf
2388  02e4 ae000a        	ldw	x,#_last_bright1
2389  02e7 cd0000        	call	c_ltor
2391  02ea ae0000        	ldw	x,#_aim_bright1
2392  02ed cd0000        	call	c_fcmp
2394  02f0 2d25          	jrsle	L307
2395                     ; 593 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2397  02f2 ae000a        	ldw	x,#_last_bright1
2398  02f5 cd0000        	call	c_ltor
2400  02f8 ae0000        	ldw	x,#_aim_bright1
2401  02fb cd0000        	call	c_fsub
2403  02fe ae000c        	ldw	x,#L144
2404  0301 cd0000        	call	c_fmul
2406  0304 cd0000        	call	c_ftol
2408  0307 b603          	ld	a,c_lreg+3
2409  0309 a102          	cp	a,#2
2410  030b 2404          	jruge	L507
2411                     ; 594 				swing1_begin = 0;channel &= ~(0x01);
2413  030d 721d0000      	bres	_action_flag,#6
2414  0311               L507:
2417  0311 72110000      	bres	_channel,#0
2419  0315 2023          	jra	L107
2420  0317               L307:
2421                     ; 597 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2423  0317 ae0000        	ldw	x,#_aim_bright1
2424  031a cd0000        	call	c_ltor
2426  031d ae000a        	ldw	x,#_last_bright1
2427  0320 cd0000        	call	c_fsub
2429  0323 ae000c        	ldw	x,#L144
2430  0326 cd0000        	call	c_fmul
2432  0329 cd0000        	call	c_ftol
2434  032c b603          	ld	a,c_lreg+3
2435  032e a102          	cp	a,#2
2436  0330 2404          	jruge	L117
2437                     ; 598 				swing1_begin = 0;channel &= ~(0x01);
2439  0332 721d0000      	bres	_action_flag,#6
2440  0336               L117:
2443  0336 72110000      	bres	_channel,#0
2444  033a               L107:
2445                     ; 601 	if(swing2_begin){//channel2 Swing调光开始
2447  033a b600          	ld	a,_action_flag
2448  033c a580          	bcp	a,#128
2449  033e 2770          	jreq	L317
2450                     ; 602 		last_bright2 += change_step2;
2452  0340 ae0000        	ldw	x,#_change_step2
2453  0343 cd0000        	call	c_ltor
2455  0346 ae0006        	ldw	x,#_last_bright2
2456  0349 cd0000        	call	c_fgadd
2458                     ; 603 		realtime_bright2 = Swing(last_bright2);
2460  034c be08          	ldw	x,_last_bright2+2
2461  034e 89            	pushw	x
2462  034f be06          	ldw	x,_last_bright2
2463  0351 89            	pushw	x
2464  0352 cd0000        	call	_Swing
2466  0355 5b04          	addw	sp,#4
2467  0357 b704          	ld	_realtime_bright2,a
2468                     ; 604 		if(last_bright2 > aim_bright2){
2470  0359 9c            	rvf
2471  035a ae0006        	ldw	x,#_last_bright2
2472  035d cd0000        	call	c_ltor
2474  0360 ae0000        	ldw	x,#_aim_bright2
2475  0363 cd0000        	call	c_fcmp
2477  0366 2d25          	jrsle	L517
2478                     ; 605 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2480  0368 ae0006        	ldw	x,#_last_bright2
2481  036b cd0000        	call	c_ltor
2483  036e ae0000        	ldw	x,#_aim_bright2
2484  0371 cd0000        	call	c_fsub
2486  0374 ae000c        	ldw	x,#L144
2487  0377 cd0000        	call	c_fmul
2489  037a cd0000        	call	c_ftol
2491  037d b603          	ld	a,c_lreg+3
2492  037f a102          	cp	a,#2
2493  0381 2404          	jruge	L717
2494                     ; 606 				swing2_begin = 0;channel &= ~(0x02);
2496  0383 721f0000      	bres	_action_flag,#7
2497  0387               L717:
2500  0387 72130000      	bres	_channel,#1
2502  038b 2023          	jra	L317
2503  038d               L517:
2504                     ; 609 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2506  038d ae0000        	ldw	x,#_aim_bright2
2507  0390 cd0000        	call	c_ltor
2509  0393 ae0006        	ldw	x,#_last_bright2
2510  0396 cd0000        	call	c_fsub
2512  0399 ae000c        	ldw	x,#L144
2513  039c cd0000        	call	c_fmul
2515  039f cd0000        	call	c_ftol
2517  03a2 b603          	ld	a,c_lreg+3
2518  03a4 a102          	cp	a,#2
2519  03a6 2404          	jruge	L327
2520                     ; 610 				swing2_begin = 0;channel &= ~(0x02);
2522  03a8 721f0000      	bres	_action_flag,#7
2523  03ac               L327:
2526  03ac 72130000      	bres	_channel,#1
2527  03b0               L317:
2528                     ; 613 }
2531  03b0 81            	ret
2833                     	xdef	_Swing
2834                     	xdef	_EraseOut
2835                     	xdef	_EraseIn
2836                     	xdef	_Linear
2837                     	xdef	_main
2838                     	xdef	_delay
2839                     	switch	.ubsct
2840  0000               _tick1s:
2841  0000 00            	ds.b	1
2842                     	xdef	_tick1s
2843  0001               _f_100ms:
2844  0001 00            	ds.b	1
2845                     	xdef	_f_100ms
2846  0002               _Tick100ms:
2847  0002 0000          	ds.b	2
2848                     	xdef	_Tick100ms
2849                     	xref.b	_action_flag
2850                     	xref.b	_change_step2
2851                     	xref.b	_change_step1
2852                     	xref.b	_aim_bright2
2853                     	xref.b	_aim_bright1
2854                     	xref.b	_channel
2855  0004               _realtime_bright2:
2856  0004 00            	ds.b	1
2857                     	xdef	_realtime_bright2
2858  0005               _realtime_bright1:
2859  0005 00            	ds.b	1
2860                     	xdef	_realtime_bright1
2861  0006               _last_bright2:
2862  0006 00000000      	ds.b	4
2863                     	xdef	_last_bright2
2864  000a               _last_bright1:
2865  000a 00000000      	ds.b	4
2866                     	xdef	_last_bright1
2867                     	xref.b	_ReceiveState
2868                     	xref.b	_GetDataIndex
2869                     	xref.b	_slave_address
2870                     	xref.b	_slc
2871                     	xref	_IIC_SlaveConfig
2872                     	xdef	f_Timer4_ISR
2873                     	xdef	f_Timer2_ISR
2874                     	xdef	f_Ext_PortD_ISR
2875                     	xdef	_lightCtrl100ms
2876                     	xdef	_sys
2877                     	xdef	_assert_failed
2878                     	xref	_TIM4_ClearITPendingBit
2879                     	xref	_TIM4_ClearFlag
2880                     	xref	_TIM4_SetAutoreload
2881                     	xref	_TIM4_ITConfig
2882                     	xref	_TIM4_Cmd
2883                     	xref	_TIM4_TimeBaseInit
2884                     	xref	_TIM2_ClearITPendingBit
2885                     	xref	_TIM2_ClearFlag
2886                     	xref	_TIM2_SetAutoreload
2887                     	xref	_TIM2_ITConfig
2888                     	xref	_TIM2_Cmd
2889                     	xref	_TIM2_TimeBaseInit
2890                     	xref	_ITC_SetSoftwarePriority
2891                     	xref	_ITC_DeInit
2892                     	xref	_GPIO_ReadOutputData
2893                     	xref	_GPIO_ReadInputData
2894                     	xref	_GPIO_WriteLow
2895                     	xref	_GPIO_WriteHigh
2896                     	xref	_GPIO_Init
2897                     	xref	_EXTI_SetExtIntSensitivity
2898                     	xref	_EXTI_DeInit
2899                     	xref	_CLK_PeripheralClockConfig
2900                     .const:	section	.text
2901  0000               L365:
2902  0000 3f800000      	dc.w	16256,0
2903  0004               L155:
2904  0004 40000000      	dc.w	16384,0
2905  0008               L145:
2906  0008 3f000000      	dc.w	16128,0
2907  000c               L144:
2908  000c 437a0000      	dc.w	17274,0
2909  0010               L342:
2910  0010 3e23d70a      	dc.w	15907,-10486
2911  0014               L561:
2912  0014 3ecccccc      	dc.w	16076,-13108
2913                     	xref.b	c_lreg
2914                     	xref.b	c_x
2915                     	xref.b	c_y
2935                     	xref	c_fgadd
2936                     	xref	c_fsub
2937                     	xref	c_fcmp
2938                     	xref	c_rtol
2939                     	xref	c_ctof
2940                     	xref	c_ltor
2941                     	xref	c_ftol
2942                     	xref	c_fmul
2943                     	xref	c_itof
2944                     	end
