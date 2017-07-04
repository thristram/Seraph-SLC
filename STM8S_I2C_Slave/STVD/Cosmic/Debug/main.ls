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
 196                     ; 95 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 198  0026 4b00          	push	#0
 199  0028 4b40          	push	#64
 200  002a ae500a        	ldw	x,#20490
 201  002d cd0000        	call	_GPIO_Init
 203  0030 85            	popw	x
 204                     ; 96 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
 206  0031 4b00          	push	#0
 207  0033 4b20          	push	#32
 208  0035 ae500a        	ldw	x,#20490
 209  0038 cd0000        	call	_GPIO_Init
 211  003b 85            	popw	x
 212                     ; 97 	GPIO_Init(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
 214  003c 4b00          	push	#0
 215  003e 4b08          	push	#8
 216  0040 ae5000        	ldw	x,#20480
 217  0043 cd0000        	call	_GPIO_Init
 219  0046 85            	popw	x
 220                     ; 98 	delay(100);
 222  0047 ae0064        	ldw	x,#100
 223  004a cd0000        	call	_delay
 225                     ; 99 	if(GPIO_ReadInputData(GPIOD) & 0x04)	slave_address |= 0x08;
 227  004d ae500f        	ldw	x,#20495
 228  0050 cd0000        	call	_GPIO_ReadInputData
 230  0053 a504          	bcp	a,#4
 231  0055 2704          	jreq	L311
 234  0057 72160000      	bset	_slave_address,#3
 235  005b               L311:
 236                     ; 100 	if(GPIO_ReadInputData(GPIOC) & 0x40)	slave_address |= 0x04;
 238  005b ae500a        	ldw	x,#20490
 239  005e cd0000        	call	_GPIO_ReadInputData
 241  0061 a540          	bcp	a,#64
 242  0063 2704          	jreq	L511
 245  0065 72140000      	bset	_slave_address,#2
 246  0069               L511:
 247                     ; 101 	if(GPIO_ReadInputData(GPIOC) & 0x20)	slave_address |= 0x02;
 249  0069 ae500a        	ldw	x,#20490
 250  006c cd0000        	call	_GPIO_ReadInputData
 252  006f a520          	bcp	a,#32
 253  0071 2704          	jreq	L711
 256  0073 72120000      	bset	_slave_address,#1
 257  0077               L711:
 258                     ; 102 	if(GPIO_ReadInputData(GPIOA) & 0x08)	slave_address |= 0x01;
 260  0077 ae5000        	ldw	x,#20480
 261  007a cd0000        	call	_GPIO_ReadInputData
 263  007d a508          	bcp	a,#8
 264  007f 2704          	jreq	L121
 267  0081 72100000      	bset	_slave_address,#0
 268  0085               L121:
 269                     ; 103 	slc.MDID = slave_address;
 271  0085 b600          	ld	a,_slave_address
 272  0087 5f            	clrw	x
 273  0088 97            	ld	xl,a
 274  0089 bf13          	ldw	_slc+19,x
 275                     ; 104 	GPIO_Config();
 277  008b cd0000        	call	L5_GPIO_Config
 279                     ; 105 	Sys_Init();
 281  008e cd0000        	call	L3_Sys_Init
 283                     ; 106 	ExtInterrupt_Config();
 285  0091 cd0000        	call	L7_ExtInterrupt_Config
 287                     ; 107 	TIMER4_Init();
 289  0094 cd0000        	call	L31_TIMER4_Init
 291                     ; 114 	IIC_SlaveConfig();
 293  0097 cd0000        	call	_IIC_SlaveConfig
 295                     ; 117 	enableInterrupts();
 298  009a 9a            rim
 302  009b 2016          	jra	L521
 303  009d               L321:
 304                     ; 121 		 if (sys.checkAcCnt == 0)
 306  009d be0e          	ldw	x,_sys+14
 307  009f 2612          	jrne	L521
 308                     ; 128 			sys.gotHzFlag = FALSE;    
 310  00a1 3f09          	clr	_sys+9
 311                     ; 129 			sys.reqCalHzFlag = FALSE;
 313  00a3 3f08          	clr	_sys+8
 314                     ; 130 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 316  00a5 350a000b      	mov	_sys+11,#10
 317                     ; 131 			sys.hzCnt = 0;
 319  00a9 5f            	clrw	x
 320  00aa bf0c          	ldw	_sys+12,x
 321                     ; 132 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 323  00ac ae07d0        	ldw	x,#2000
 324  00af bf0e          	ldw	_sys+14,x
 325                     ; 133 			break;
 327  00b1 201a          	jra	L531
 328  00b3               L521:
 329                     ; 119 	 while(!sys.gotHzFlag)
 331  00b3 3d09          	tnz	_sys+9
 332  00b5 27e6          	jreq	L321
 333  00b7 2014          	jra	L531
 334  00b9               L331:
 335                     ; 140 		 if (sys.checkAcCnt == 0)
 337  00b9 be0e          	ldw	x,_sys+14
 338  00bb 2610          	jrne	L531
 339                     ; 143 			sys.gotHzFlag = FALSE;    
 341  00bd 3f09          	clr	_sys+9
 342                     ; 144 			sys.reqCalHzFlag = FALSE;
 344  00bf 3f08          	clr	_sys+8
 345                     ; 145 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 347  00c1 350a000b      	mov	_sys+11,#10
 348                     ; 146 			sys.hzCnt = 0;
 350  00c5 5f            	clrw	x
 351  00c6 bf0c          	ldw	_sys+12,x
 352                     ; 147 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 354  00c8 ae07d0        	ldw	x,#2000
 355  00cb bf0e          	ldw	_sys+14,x
 356  00cd               L531:
 357                     ; 138 	 while(!sys.gotHzFlag)
 359  00cd 3d09          	tnz	_sys+9
 360  00cf 27e8          	jreq	L331
 361                     ; 150 	 sys.acOkFlag = TRUE;
 363  00d1 35010011      	mov	_sys+17,#1
 364                     ; 151 	 TIMER2_Init();
 366  00d5 cd0000        	call	L11_TIMER2_Init
 368  00d8               L341:
 369                     ; 168 		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE)
 371  00d8 be0e          	ldw	x,_sys+14
 372  00da 260a          	jrne	L741
 374  00dc 3d10          	tnz	_sys+16
 375  00de 2606          	jrne	L741
 376                     ; 172 			 sys.acErrFlag = TRUE;
 378  00e0 35010010      	mov	_sys+16,#1
 379                     ; 173 			 sys.acOkFlag = FALSE;
 381  00e4 3f11          	clr	_sys+17
 382  00e6               L741:
 383                     ; 176 		if (sys.acErrFlag == FALSE && sys.acOkFlag == FALSE)
 385  00e6 3d10          	tnz	_sys+16
 386  00e8 260d          	jrne	L151
 388  00ea 3d11          	tnz	_sys+17
 389  00ec 2609          	jrne	L151
 390                     ; 180 			sys.acOkFlag = TRUE;
 392  00ee 35010011      	mov	_sys+17,#1
 393                     ; 181 			sys.cnt1s = CNT_1S;
 395  00f2 ae4e20        	ldw	x,#20000
 396  00f5 bf1b          	ldw	_sys+27,x
 397  00f7               L151:
 398                     ; 184 		if(f_100ms){
 400  00f7 3d01          	tnz	_f_100ms
 401  00f9 2705          	jreq	L351
 402                     ; 185 			f_100ms = 0;
 404  00fb 3f01          	clr	_f_100ms
 405                     ; 186 			lightCtrl100ms();
 407  00fd cd0000        	call	_lightCtrl100ms
 409  0100               L351:
 410                     ; 198 		if((channel & 0x01)==0x01)//调节Dimmer1
 412  0100 b600          	ld	a,_channel
 413  0102 a401          	and	a,#1
 414  0104 a101          	cp	a,#1
 415  0106 2616          	jrne	L551
 416                     ; 200 			sys.light1.briVal = realtime_bright1;
 418  0108 450502        	mov	_sys+2,_realtime_bright1
 419                     ; 201 			slc.ch1_status = (u8)(last_bright1*100);
 421  010b ae000a        	ldw	x,#_last_bright1
 422  010e cd0000        	call	c_ltor
 424  0111 ae0014        	ldw	x,#L361
 425  0114 cd0000        	call	c_fmul
 427  0117 cd0000        	call	c_ftol
 429  011a b603          	ld	a,c_lreg+3
 430  011c b715          	ld	_slc+21,a
 431  011e               L551:
 432                     ; 203 		if((channel & 0x02)==0x02)//调节Dimmer2
 434  011e b600          	ld	a,_channel
 435  0120 a402          	and	a,#2
 436  0122 a102          	cp	a,#2
 437  0124 2616          	jrne	L761
 438                     ; 205 			sys.light2.briVal = realtime_bright2;
 440  0126 450406        	mov	_sys+6,_realtime_bright2
 441                     ; 206 			slc.ch2_status = (u8)(last_bright2*100);
 443  0129 ae0006        	ldw	x,#_last_bright2
 444  012c cd0000        	call	c_ltor
 446  012f ae0014        	ldw	x,#L361
 447  0132 cd0000        	call	c_fmul
 449  0135 cd0000        	call	c_ftol
 451  0138 b603          	ld	a,c_lreg+3
 452  013a b716          	ld	_slc+22,a
 453  013c               L761:
 454                     ; 208 		if (sys.acOkFlag && sys.cnt1s == 0)
 456  013c 3d11          	tnz	_sys+17
 457  013e 2798          	jreq	L341
 459  0140 be1b          	ldw	x,_sys+27
 460  0142 2694          	jrne	L341
 461                     ; 213 			sys.cnt1s = CNT_1S;
 463  0144 ae4e20        	ldw	x,#20000
 464  0147 bf1b          	ldw	_sys+27,x
 465  0149 208d          	jra	L341
 500                     ; 227 void assert_failed(uint8_t* file, uint32_t line)
 500                     ; 228 { 
 501                     .text:	section	.text,new
 502  0000               _assert_failed:
 506  0000               L112:
 507  0000 20fe          	jra	L112
 532                     ; 239 static void GPIO_Config(void)
 532                     ; 240 {
 533                     .text:	section	.text,new
 534  0000               L5_GPIO_Config:
 538                     ; 242     GPIO_Init(L1_EN_PIN_PORT, (GPIO_Pin_TypeDef)L1_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
 540  0000 4bd0          	push	#208
 541  0002 4b10          	push	#16
 542  0004 ae500a        	ldw	x,#20490
 543  0007 cd0000        	call	_GPIO_Init
 545  000a 85            	popw	x
 546                     ; 243     GPIO_Init(L2_EN_PIN_PORT, (GPIO_Pin_TypeDef)L2_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);   
 548  000b 4bd0          	push	#208
 549  000d 4b08          	push	#8
 550  000f ae500a        	ldw	x,#20490
 551  0012 cd0000        	call	_GPIO_Init
 553  0015 85            	popw	x
 554                     ; 244     L1_EN_OFF;
 556  0016 4b10          	push	#16
 557  0018 ae500a        	ldw	x,#20490
 558  001b cd0000        	call	_GPIO_WriteHigh
 560  001e 84            	pop	a
 561                     ; 245     L2_EN_OFF;
 563  001f 4b08          	push	#8
 564  0021 ae500a        	ldw	x,#20490
 565  0024 cd0000        	call	_GPIO_WriteHigh
 567  0027 84            	pop	a
 568                     ; 246     GPIO_Init(ZD_PIN_PORT, (GPIO_Pin_TypeDef)ZD_PIN, GPIO_MODE_IN_FL_IT);  
 570  0028 4b20          	push	#32
 571  002a 4b08          	push	#8
 572  002c ae500f        	ldw	x,#20495
 573  002f cd0000        	call	_GPIO_Init
 575  0032 85            	popw	x
 576                     ; 248 }
 579  0033 81            	ret
 608                     ; 250 static void Sys_Init(void)
 608                     ; 251 {
 609                     .text:	section	.text,new
 610  0000               L3_Sys_Init:
 614                     ; 252     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 616  0000 ae0001        	ldw	x,#1
 617  0003 a604          	ld	a,#4
 618  0005 95            	ld	xh,a
 619  0006 cd0000        	call	_CLK_PeripheralClockConfig
 621                     ; 253     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 623  0009 ae0001        	ldw	x,#1
 624  000c a605          	ld	a,#5
 625  000e 95            	ld	xh,a
 626  000f cd0000        	call	_CLK_PeripheralClockConfig
 628                     ; 255     sys.gotHzFlag = FALSE;    
 630  0012 3f09          	clr	_sys+9
 631                     ; 256     sys.reqCalHzFlag = FALSE;
 633  0014 3f08          	clr	_sys+8
 634                     ; 257     sys.light1.briVal = DEFAULT_BRIGHTNESS;
 636  0016 35280002      	mov	_sys+2,#40
 637                     ; 258     sys.light2.briVal = DEFAULT_BRIGHTNESS;    
 639  001a 35280006      	mov	_sys+6,#40
 640                     ; 259     sys.calHzIntCnt = GET_AC_FRE_CNT;
 642  001e 350a000b      	mov	_sys+11,#10
 643                     ; 260     sys.hzCnt = 0;
 645  0022 5f            	clrw	x
 646  0023 bf0c          	ldw	_sys+12,x
 647                     ; 261     sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 649  0025 ae07d0        	ldw	x,#2000
 650  0028 bf0e          	ldw	_sys+14,x
 651                     ; 262 		last_bright1 = 0.16;
 653  002a ce0012        	ldw	x,L142+2
 654  002d bf0c          	ldw	_last_bright1+2,x
 655  002f ce0010        	ldw	x,L142
 656  0032 bf0a          	ldw	_last_bright1,x
 657                     ; 263 		aim_bright1 = 0;
 659  0034 ae0000        	ldw	x,#0
 660  0037 bf02          	ldw	_aim_bright1+2,x
 661  0039 ae0000        	ldw	x,#0
 662  003c bf00          	ldw	_aim_bright1,x
 663                     ; 264 		last_bright2 = 0.16;
 665  003e ce0012        	ldw	x,L142+2
 666  0041 bf08          	ldw	_last_bright2+2,x
 667  0043 ce0010        	ldw	x,L142
 668  0046 bf06          	ldw	_last_bright2,x
 669                     ; 265 		aim_bright2 = 0;
 671  0048 ae0000        	ldw	x,#0
 672  004b bf02          	ldw	_aim_bright2+2,x
 673  004d ae0000        	ldw	x,#0
 674  0050 bf00          	ldw	_aim_bright2,x
 675                     ; 266 }
 678  0052 81            	ret
 704                     ; 268 static void ExtInterrupt_Config(void)
 704                     ; 269 {
 705                     .text:	section	.text,new
 706  0000               L7_ExtInterrupt_Config:
 710                     ; 271 	EXTI_DeInit();
 712  0000 cd0000        	call	_EXTI_DeInit
 714                     ; 272 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 716  0003 ae0002        	ldw	x,#2
 717  0006 a603          	ld	a,#3
 718  0008 95            	ld	xh,a
 719  0009 cd0000        	call	_EXTI_SetExtIntSensitivity
 721                     ; 274 }
 724  000c 81            	ret
 754                     ; 280 @far @interrupt void Ext_PortD_ISR(void) {
 756                     .text:	section	.text,new
 757  0000               f_Ext_PortD_ISR:
 760  0000 3b0002        	push	c_x+2
 761  0003 be00          	ldw	x,c_x
 762  0005 89            	pushw	x
 763  0006 3b0002        	push	c_y+2
 764  0009 be00          	ldw	x,c_y
 765  000b 89            	pushw	x
 768                     ; 283 	if (ZD_STATUS == 0)
 770  000c ae500f        	ldw	x,#20495
 771  000f cd0000        	call	_GPIO_ReadOutputData
 773  0012 a508          	bcp	a,#8
 774  0014 2704          	jreq	L62
 775  0016 acc800c8      	jpf	L562
 776  001a               L62:
 777                     ; 285 		sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 779  001a ae07d0        	ldw	x,#2000
 780  001d bf0e          	ldw	_sys+14,x
 781                     ; 286 		sys.acErrFlag = FALSE;
 783  001f 3f10          	clr	_sys+16
 784                     ; 289 		if (!sys.gotHzFlag)
 786  0021 3d09          	tnz	_sys+9
 787  0023 262f          	jrne	L762
 788                     ; 291 			if (!sys.reqCalHzFlag)
 790  0025 3d08          	tnz	_sys+8
 791  0027 2609          	jrne	L172
 792                     ; 293 				TIM4_SetAutoreload(TIMER4_INT_TIME);				
 794  0029 a632          	ld	a,#50
 795  002b cd0000        	call	_TIM4_SetAutoreload
 797                     ; 294 				sys.reqCalHzFlag = TRUE;
 799  002e 35010008      	mov	_sys+8,#1
 800  0032               L172:
 801                     ; 296 			if (sys.calHzIntCnt == 0)
 803  0032 3d0b          	tnz	_sys+11
 804  0034 261a          	jrne	L372
 805                     ; 298 				if ((sys.hzCnt/GET_AC_FRE_CNT) >= HZ_COUNT)
 807  0036 be0c          	ldw	x,_sys+12
 808  0038 a60a          	ld	a,#10
 809  003a 62            	div	x,a
 810  003b a300b4        	cpw	x,#180
 811  003e 2506          	jrult	L572
 812                     ; 300 					sys.hz50Flag = TRUE;
 814  0040 3501000a      	mov	_sys+10,#1
 816  0044 2002          	jra	L772
 817  0046               L572:
 818                     ; 304 					sys.hz50Flag = FALSE;
 820  0046 3f0a          	clr	_sys+10
 821  0048               L772:
 822                     ; 307 				sys.gotHzFlag = TRUE;
 824  0048 35010009      	mov	_sys+9,#1
 825                     ; 308 				sys.reqCalHzFlag = FALSE;
 827  004c 3f08          	clr	_sys+8
 829  004e 2078          	jra	L562
 830  0050               L372:
 831                     ; 312 				sys.calHzIntCnt--;
 833  0050 3a0b          	dec	_sys+11
 834  0052 2074          	jra	L562
 835  0054               L762:
 836                     ; 317 			if (sys.light1.briVal == MAX_BRIGHTNESS)
 838  0054 b602          	ld	a,_sys+2
 839  0056 a1fa          	cp	a,#250
 840  0058 2615          	jrne	L503
 841                     ; 321 				L1_EN_ON;
 843  005a 4b10          	push	#16
 844  005c ae500a        	ldw	x,#20490
 845  005f cd0000        	call	_GPIO_WriteLow
 847  0062 84            	pop	a
 850  0063 35280001      	mov	_sys+1,#40
 851                     ; 322 				sys.light1.briCnt = 0;
 853  0067 3f00          	clr	_sys
 854                     ; 323 				sys.light1.onFlag = TRUE;			
 856  0069 35010003      	mov	_sys+3,#1
 858  006d 2011          	jra	L703
 859  006f               L503:
 860                     ; 328 				sys.light1.briCnt = MAX_BRIGHTNESS - sys.light1.briVal;				
 862  006f a6fa          	ld	a,#250
 863  0071 b002          	sub	a,_sys+2
 864  0073 b700          	ld	_sys,a
 865                     ; 329 				sys.light1.onFlag = FALSE;
 867  0075 3f03          	clr	_sys+3
 868                     ; 330 				L1_EN_OFF;
 870  0077 4b10          	push	#16
 871  0079 ae500a        	ldw	x,#20490
 872  007c cd0000        	call	_GPIO_WriteHigh
 874  007f 84            	pop	a
 875  0080               L703:
 876                     ; 333 			if (sys.light2.briVal == MAX_BRIGHTNESS)
 878  0080 b606          	ld	a,_sys+6
 879  0082 a1fa          	cp	a,#250
 880  0084 2615          	jrne	L113
 881                     ; 335 				L2_EN_ON;
 883  0086 4b08          	push	#8
 884  0088 ae500a        	ldw	x,#20490
 885  008b cd0000        	call	_GPIO_WriteLow
 887  008e 84            	pop	a
 890  008f 35280005      	mov	_sys+5,#40
 891                     ; 336 				sys.light2.briCnt = 0;
 893  0093 3f04          	clr	_sys+4
 894                     ; 337 				sys.light2.onFlag = TRUE;			
 896  0095 35010007      	mov	_sys+7,#1
 898  0099 2011          	jra	L313
 899  009b               L113:
 900                     ; 341 				sys.light2.briCnt = MAX_BRIGHTNESS - sys.light2.briVal;
 902  009b a6fa          	ld	a,#250
 903  009d b006          	sub	a,_sys+6
 904  009f b704          	ld	_sys+4,a
 905                     ; 342 				sys.light2.onFlag = FALSE;				
 907  00a1 3f07          	clr	_sys+7
 908                     ; 343 				L2_EN_OFF;
 910  00a3 4b08          	push	#8
 911  00a5 ae500a        	ldw	x,#20490
 912  00a8 cd0000        	call	_GPIO_WriteHigh
 914  00ab 84            	pop	a
 915  00ac               L313:
 916                     ; 346 			if (sys.light1.briCnt || sys.light2.briCnt)
 918  00ac 3d00          	tnz	_sys
 919  00ae 2604          	jrne	L713
 921  00b0 3d04          	tnz	_sys+4
 922  00b2 2714          	jreq	L562
 923  00b4               L713:
 924                     ; 349 				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
 926  00b4 3d0a          	tnz	_sys+10
 927  00b6 2705          	jreq	L22
 928  00b8 ae0028        	ldw	x,#40
 929  00bb 2003          	jra	L42
 930  00bd               L22:
 931  00bd ae0021        	ldw	x,#33
 932  00c0               L42:
 933  00c0 cd0000        	call	_TIM2_SetAutoreload
 935                     ; 350 				TIM2_Cmd(ENABLE);
 937  00c3 a601          	ld	a,#1
 938  00c5 cd0000        	call	_TIM2_Cmd
 940  00c8               L562:
 941                     ; 354 }
 944  00c8 85            	popw	x
 945  00c9 bf00          	ldw	c_y,x
 946  00cb 320002        	pop	c_y+2
 947  00ce 85            	popw	x
 948  00cf bf00          	ldw	c_x,x
 949  00d1 320002        	pop	c_x+2
 950  00d4 80            	iret
 976                     ; 374 static void TIMER4_Init(void)
 976                     ; 375 {    
 978                     .text:	section	.text,new
 979  0000               L31_TIMER4_Init:
 983                     ; 376     TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIMER4_INT_TIME);
 985  0000 ae0032        	ldw	x,#50
 986  0003 a604          	ld	a,#4
 987  0005 95            	ld	xh,a
 988  0006 cd0000        	call	_TIM4_TimeBaseInit
 990                     ; 377     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 992  0009 a601          	ld	a,#1
 993  000b cd0000        	call	_TIM4_ClearFlag
 995                     ; 378     TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);	
 997  000e ae0001        	ldw	x,#1
 998  0011 a601          	ld	a,#1
 999  0013 95            	ld	xh,a
1000  0014 cd0000        	call	_TIM4_ITConfig
1002                     ; 379     TIM4_Cmd(ENABLE);
1004  0017 a601          	ld	a,#1
1005  0019 cd0000        	call	_TIM4_Cmd
1007                     ; 380 }
1010  001c 81            	ret
1038                     ; 386 @far @interrupt void Timer4_ISR(void) {
1040                     .text:	section	.text,new
1041  0000               f_Timer4_ISR:
1044  0000 3b0002        	push	c_x+2
1045  0003 be00          	ldw	x,c_x
1046  0005 89            	pushw	x
1047  0006 3b0002        	push	c_y+2
1048  0009 be00          	ldw	x,c_y
1049  000b 89            	pushw	x
1052                     ; 388 TIM4_ClearITPendingBit(TIM4_IT_UPDATE);  
1054  000c a601          	ld	a,#1
1055  000e cd0000        	call	_TIM4_ClearITPendingBit
1057                     ; 389   if (sys.reqCalHzFlag)
1059  0011 3d08          	tnz	_sys+8
1060  0013 2707          	jreq	L143
1061                     ; 391 	  sys.hzCnt++; 	  
1063  0015 be0c          	ldw	x,_sys+12
1064  0017 1c0001        	addw	x,#1
1065  001a bf0c          	ldw	_sys+12,x
1066  001c               L143:
1067                     ; 394   if (sys.light1.triacTriggeTime)
1069  001c 3d01          	tnz	_sys+1
1070  001e 270f          	jreq	L343
1071                     ; 396 	  sys.light1.triacTriggeTime--;
1073  0020 3a01          	dec	_sys+1
1074                     ; 397 	  if (sys.light1.triacTriggeTime == 0)
1076  0022 3d01          	tnz	_sys+1
1077  0024 2609          	jrne	L343
1078                     ; 399 		  L1_EN_OFF;
1080  0026 4b10          	push	#16
1081  0028 ae500a        	ldw	x,#20490
1082  002b cd0000        	call	_GPIO_WriteHigh
1084  002e 84            	pop	a
1085  002f               L343:
1086                     ; 404   if (sys.light2.triacTriggeTime)
1088  002f 3d05          	tnz	_sys+5
1089  0031 270f          	jreq	L743
1090                     ; 406 	  sys.light2.triacTriggeTime--;
1092  0033 3a05          	dec	_sys+5
1093                     ; 407 	  if (sys.light2.triacTriggeTime == 0)
1095  0035 3d05          	tnz	_sys+5
1096  0037 2609          	jrne	L743
1097                     ; 409 		  L2_EN_OFF;
1099  0039 4b08          	push	#8
1100  003b ae500a        	ldw	x,#20490
1101  003e cd0000        	call	_GPIO_WriteHigh
1103  0041 84            	pop	a
1104  0042               L743:
1105                     ; 413   if (sys.checkAcCnt)
1107  0042 be0e          	ldw	x,_sys+14
1108  0044 2707          	jreq	L353
1109                     ; 415 		sys.checkAcCnt--;
1111  0046 be0e          	ldw	x,_sys+14
1112  0048 1d0001        	subw	x,#1
1113  004b bf0e          	ldw	_sys+14,x
1114  004d               L353:
1115                     ; 418   if (sys.cnt1s)
1117  004d be1b          	ldw	x,_sys+27
1118  004f 2707          	jreq	L553
1119                     ; 420 		sys.cnt1s--;
1121  0051 be1b          	ldw	x,_sys+27
1122  0053 1d0001        	subw	x,#1
1123  0056 bf1b          	ldw	_sys+27,x
1124  0058               L553:
1125                     ; 422 	Tick100ms++;
1127  0058 be02          	ldw	x,_Tick100ms
1128  005a 1c0001        	addw	x,#1
1129  005d bf02          	ldw	_Tick100ms,x
1130                     ; 423 	if(Tick100ms >= 2000){
1132  005f be02          	ldw	x,_Tick100ms
1133  0061 a307d0        	cpw	x,#2000
1134  0064 2507          	jrult	L753
1135                     ; 424 		Tick100ms = 0;
1137  0066 5f            	clrw	x
1138  0067 bf02          	ldw	_Tick100ms,x
1139                     ; 425 		f_100ms = 1;
1141  0069 35010001      	mov	_f_100ms,#1
1142  006d               L753:
1143                     ; 427 }
1146  006d 85            	popw	x
1147  006e bf00          	ldw	c_y,x
1148  0070 320002        	pop	c_y+2
1149  0073 85            	popw	x
1150  0074 bf00          	ldw	c_x,x
1151  0076 320002        	pop	c_x+2
1152  0079 80            	iret
1178                     ; 429 static void TIMER2_Init(void)
1178                     ; 430 {    
1180                     .text:	section	.text,new
1181  0000               L11_TIMER2_Init:
1185                     ; 431 	TIM2_TimeBaseInit(TIM2_PRESCALER_16, sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
1187  0000 3d0a          	tnz	_sys+10
1188  0002 2705          	jreq	L63
1189  0004 ae0028        	ldw	x,#40
1190  0007 2003          	jra	L04
1191  0009               L63:
1192  0009 ae0021        	ldw	x,#33
1193  000c               L04:
1194  000c 89            	pushw	x
1195  000d a604          	ld	a,#4
1196  000f cd0000        	call	_TIM2_TimeBaseInit
1198  0012 85            	popw	x
1199                     ; 432    	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
1201  0013 ae0001        	ldw	x,#1
1202  0016 cd0000        	call	_TIM2_ClearFlag
1204                     ; 433    	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	   
1206  0019 ae0001        	ldw	x,#1
1207  001c a601          	ld	a,#1
1208  001e 95            	ld	xh,a
1209  001f cd0000        	call	_TIM2_ITConfig
1211                     ; 434 }
1214  0022 81            	ret
1241                     ; 440 @far @interrupt void Timer2_ISR(void) {
1243                     .text:	section	.text,new
1244  0000               f_Timer2_ISR:
1247  0000 3b0002        	push	c_x+2
1248  0003 be00          	ldw	x,c_x
1249  0005 89            	pushw	x
1250  0006 3b0002        	push	c_y+2
1251  0009 be00          	ldw	x,c_y
1252  000b 89            	pushw	x
1255                     ; 442 	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);  
1257  000c a601          	ld	a,#1
1258  000e cd0000        	call	_TIM2_ClearITPendingBit
1260                     ; 443 	if (sys.light1.briCnt) 
1262  0011 3d00          	tnz	_sys
1263  0013 2702          	jreq	L104
1264                     ; 445 		sys.light1.briCnt--;			
1266  0015 3a00          	dec	_sys
1267  0017               L104:
1268                     ; 447 	if (sys.light1.briCnt == 0 && !sys.light1.onFlag)
1270  0017 3d00          	tnz	_sys
1271  0019 2615          	jrne	L304
1273  001b 3d03          	tnz	_sys+3
1274  001d 2611          	jrne	L304
1275                     ; 449 		L1_EN_ON;
1277  001f 4b10          	push	#16
1278  0021 ae500a        	ldw	x,#20490
1279  0024 cd0000        	call	_GPIO_WriteLow
1281  0027 84            	pop	a
1284  0028 35280001      	mov	_sys+1,#40
1285                     ; 450 		sys.light1.onFlag = TRUE;
1287  002c 35010003      	mov	_sys+3,#1
1288  0030               L304:
1289                     ; 454 	if (sys.light2.briCnt) 
1291  0030 3d04          	tnz	_sys+4
1292  0032 2702          	jreq	L504
1293                     ; 456 		sys.light2.briCnt--;		
1295  0034 3a04          	dec	_sys+4
1296  0036               L504:
1297                     ; 458 	if (sys.light2.briCnt == 0 && !sys.light2.onFlag)
1299  0036 3d04          	tnz	_sys+4
1300  0038 2615          	jrne	L704
1302  003a 3d07          	tnz	_sys+7
1303  003c 2611          	jrne	L704
1304                     ; 460 		L2_EN_ON;
1306  003e 4b08          	push	#8
1307  0040 ae500a        	ldw	x,#20490
1308  0043 cd0000        	call	_GPIO_WriteLow
1310  0046 84            	pop	a
1313  0047 35280005      	mov	_sys+5,#40
1314                     ; 461 		sys.light2.onFlag = TRUE;
1316  004b 35010007      	mov	_sys+7,#1
1317  004f               L704:
1318                     ; 464 	if ((sys.light1.briCnt ||  sys.light2.briCnt) == 0)
1320  004f 3d00          	tnz	_sys
1321  0051 2604          	jrne	L64
1322  0053 3d04          	tnz	_sys+4
1323  0055 2705          	jreq	L44
1324  0057               L64:
1325  0057 ae0001        	ldw	x,#1
1326  005a 2001          	jra	L05
1327  005c               L44:
1328  005c 5f            	clrw	x
1329  005d               L05:
1330  005d a30000        	cpw	x,#0
1331  0060 2604          	jrne	L114
1332                     ; 466 		TIM2_Cmd(DISABLE);
1334  0062 4f            	clr	a
1335  0063 cd0000        	call	_TIM2_Cmd
1337  0066               L114:
1338                     ; 468 }
1341  0066 85            	popw	x
1342  0067 bf00          	ldw	c_y,x
1343  0069 320002        	pop	c_y+2
1344  006c 85            	popw	x
1345  006d bf00          	ldw	c_x,x
1346  006f 320002        	pop	c_x+2
1347  0072 80            	iret
1380                     ; 470 u8 Linear(float t)
1380                     ; 471 {
1382                     .text:	section	.text,new
1383  0000               _Linear:
1385  0000 5204          	subw	sp,#4
1386       00000004      OFST:	set	4
1389                     ; 472 	if((t >= 0)&&(t <=1))
1391  0002 9c            	rvf
1392  0003 0d07          	tnz	(OFST+3,sp)
1393  0005 2f31          	jrslt	L134
1395  0007 9c            	rvf
1396  0008 a601          	ld	a,#1
1397  000a cd0000        	call	c_ctof
1399  000d 96            	ldw	x,sp
1400  000e 1c0001        	addw	x,#OFST-3
1401  0011 cd0000        	call	c_rtol
1403  0014 96            	ldw	x,sp
1404  0015 1c0007        	addw	x,#OFST+3
1405  0018 cd0000        	call	c_ltor
1407  001b 96            	ldw	x,sp
1408  001c 1c0001        	addw	x,#OFST-3
1409  001f cd0000        	call	c_fcmp
1411  0022 2c14          	jrsgt	L134
1412                     ; 473 		return (u8)(t*250);
1414  0024 96            	ldw	x,sp
1415  0025 1c0007        	addw	x,#OFST+3
1416  0028 cd0000        	call	c_ltor
1418  002b ae000c        	ldw	x,#L734
1419  002e cd0000        	call	c_fmul
1421  0031 cd0000        	call	c_ftol
1423  0034 b603          	ld	a,c_lreg+3
1425  0036 2002          	jra	L45
1426  0038               L134:
1427                     ; 475 		return 40;
1429  0038 a628          	ld	a,#40
1431  003a               L45:
1433  003a 5b04          	addw	sp,#4
1434  003c 81            	ret
1468                     ; 477 u8 EraseIn(float t)
1468                     ; 478 {
1469                     .text:	section	.text,new
1470  0000               _EraseIn:
1472  0000 5204          	subw	sp,#4
1473       00000004      OFST:	set	4
1476                     ; 479 	if((t >= 0)&&(t <=1))
1478  0002 9c            	rvf
1479  0003 0d07          	tnz	(OFST+3,sp)
1480  0005 2f38          	jrslt	L364
1482  0007 9c            	rvf
1483  0008 a601          	ld	a,#1
1484  000a cd0000        	call	c_ctof
1486  000d 96            	ldw	x,sp
1487  000e 1c0001        	addw	x,#OFST-3
1488  0011 cd0000        	call	c_rtol
1490  0014 96            	ldw	x,sp
1491  0015 1c0007        	addw	x,#OFST+3
1492  0018 cd0000        	call	c_ltor
1494  001b 96            	ldw	x,sp
1495  001c 1c0001        	addw	x,#OFST-3
1496  001f cd0000        	call	c_fcmp
1498  0022 2c1b          	jrsgt	L364
1499                     ; 480 		return (u8)(t*t*250);
1501  0024 96            	ldw	x,sp
1502  0025 1c0007        	addw	x,#OFST+3
1503  0028 cd0000        	call	c_ltor
1505  002b 96            	ldw	x,sp
1506  002c 1c0007        	addw	x,#OFST+3
1507  002f cd0000        	call	c_fmul
1509  0032 ae000c        	ldw	x,#L734
1510  0035 cd0000        	call	c_fmul
1512  0038 cd0000        	call	c_ftol
1514  003b b603          	ld	a,c_lreg+3
1516  003d 2002          	jra	L06
1517  003f               L364:
1518                     ; 482 		return 40;
1520  003f a628          	ld	a,#40
1522  0041               L06:
1524  0041 5b04          	addw	sp,#4
1525  0043 81            	ret
1559                     ; 484 u8 EraseOut(float t)
1559                     ; 485 {
1560                     .text:	section	.text,new
1561  0000               _EraseOut:
1563  0000 5204          	subw	sp,#4
1564       00000004      OFST:	set	4
1567                     ; 486 	if((t >= 0)&&(t <=1))
1569  0002 9c            	rvf
1570  0003 0d07          	tnz	(OFST+3,sp)
1571  0005 2f3d          	jrslt	L505
1573  0007 9c            	rvf
1574  0008 a601          	ld	a,#1
1575  000a cd0000        	call	c_ctof
1577  000d 96            	ldw	x,sp
1578  000e 1c0001        	addw	x,#OFST-3
1579  0011 cd0000        	call	c_rtol
1581  0014 96            	ldw	x,sp
1582  0015 1c0007        	addw	x,#OFST+3
1583  0018 cd0000        	call	c_ltor
1585  001b 96            	ldw	x,sp
1586  001c 1c0001        	addw	x,#OFST-3
1587  001f cd0000        	call	c_fcmp
1589  0022 2c20          	jrsgt	L505
1590                     ; 487 		return (u8)((2-t)*t*250);
1592  0024 a602          	ld	a,#2
1593  0026 cd0000        	call	c_ctof
1595  0029 96            	ldw	x,sp
1596  002a 1c0007        	addw	x,#OFST+3
1597  002d cd0000        	call	c_fsub
1599  0030 96            	ldw	x,sp
1600  0031 1c0007        	addw	x,#OFST+3
1601  0034 cd0000        	call	c_fmul
1603  0037 ae000c        	ldw	x,#L734
1604  003a cd0000        	call	c_fmul
1606  003d cd0000        	call	c_ftol
1608  0040 b603          	ld	a,c_lreg+3
1610  0042 2002          	jra	L46
1611  0044               L505:
1612                     ; 489 		return 40;
1614  0044 a628          	ld	a,#40
1616  0046               L46:
1618  0046 5b04          	addw	sp,#4
1619  0048 81            	ret
1653                     ; 491 u8 Swing(float t)
1653                     ; 492 {
1654                     .text:	section	.text,new
1655  0000               _Swing:
1657  0000 5204          	subw	sp,#4
1658       00000004      OFST:	set	4
1661                     ; 493 	if((t >= 0)&&(t <=1)){
1663  0002 9c            	rvf
1664  0003 0d07          	tnz	(OFST+3,sp)
1665  0005 2e03          	jrsge	L27
1666  0007 cc0093        	jp	L725
1667  000a               L27:
1669  000a 9c            	rvf
1670  000b a601          	ld	a,#1
1671  000d cd0000        	call	c_ctof
1673  0010 96            	ldw	x,sp
1674  0011 1c0001        	addw	x,#OFST-3
1675  0014 cd0000        	call	c_rtol
1677  0017 96            	ldw	x,sp
1678  0018 1c0007        	addw	x,#OFST+3
1679  001b cd0000        	call	c_ltor
1681  001e 96            	ldw	x,sp
1682  001f 1c0001        	addw	x,#OFST-3
1683  0022 cd0000        	call	c_fcmp
1685  0025 2c6c          	jrsgt	L725
1686                     ; 494 		if(t < 0.5)
1688  0027 9c            	rvf
1689  0028 96            	ldw	x,sp
1690  0029 1c0007        	addw	x,#OFST+3
1691  002c cd0000        	call	c_ltor
1693  002f ae0008        	ldw	x,#L735
1694  0032 cd0000        	call	c_fcmp
1696  0035 2e21          	jrsge	L135
1697                     ; 495 			return (u8)(2*t*t*250);
1699  0037 96            	ldw	x,sp
1700  0038 1c0007        	addw	x,#OFST+3
1701  003b cd0000        	call	c_ltor
1703  003e ae0004        	ldw	x,#L745
1704  0041 cd0000        	call	c_fmul
1706  0044 96            	ldw	x,sp
1707  0045 1c0007        	addw	x,#OFST+3
1708  0048 cd0000        	call	c_fmul
1710  004b ae000c        	ldw	x,#L734
1711  004e cd0000        	call	c_fmul
1713  0051 cd0000        	call	c_ftol
1715  0054 b603          	ld	a,c_lreg+3
1717  0056 2038          	jra	L07
1718  0058               L135:
1719                     ; 497 			return (u8)(((4-2*t)*t - 1)*250);
1721  0058 96            	ldw	x,sp
1722  0059 1c0007        	addw	x,#OFST+3
1723  005c cd0000        	call	c_ltor
1725  005f ae0004        	ldw	x,#L745
1726  0062 cd0000        	call	c_fmul
1728  0065 96            	ldw	x,sp
1729  0066 1c0001        	addw	x,#OFST-3
1730  0069 cd0000        	call	c_rtol
1732  006c a604          	ld	a,#4
1733  006e cd0000        	call	c_ctof
1735  0071 96            	ldw	x,sp
1736  0072 1c0001        	addw	x,#OFST-3
1737  0075 cd0000        	call	c_fsub
1739  0078 96            	ldw	x,sp
1740  0079 1c0007        	addw	x,#OFST+3
1741  007c cd0000        	call	c_fmul
1743  007f ae0000        	ldw	x,#L165
1744  0082 cd0000        	call	c_fsub
1746  0085 ae000c        	ldw	x,#L734
1747  0088 cd0000        	call	c_fmul
1749  008b cd0000        	call	c_ftol
1751  008e b603          	ld	a,c_lreg+3
1753  0090               L07:
1755  0090 5b04          	addw	sp,#4
1756  0092 81            	ret
1757  0093               L725:
1758                     ; 500 		return 40;
1760  0093 a628          	ld	a,#40
1762  0095 20f9          	jra	L07
1798                     ; 503 void lightCtrl100ms(void)
1798                     ; 504 {
1799                     .text:	section	.text,new
1800  0000               _lightCtrl100ms:
1804                     ; 505 	if(linear1_begin){//channel1 Linear调光开始
1806  0000 b600          	ld	a,_action_flag
1807  0002 a501          	bcp	a,#1
1808  0004 2768          	jreq	L775
1809                     ; 506 		last_bright1 += change_step1;
1811  0006 ae0000        	ldw	x,#_change_step1
1812  0009 cd0000        	call	c_ltor
1814  000c ae000a        	ldw	x,#_last_bright1
1815  000f cd0000        	call	c_fgadd
1817                     ; 507 		realtime_bright1 = Linear(last_bright1);
1819  0012 be0c          	ldw	x,_last_bright1+2
1820  0014 89            	pushw	x
1821  0015 be0a          	ldw	x,_last_bright1
1822  0017 89            	pushw	x
1823  0018 cd0000        	call	_Linear
1825  001b 5b04          	addw	sp,#4
1826  001d b705          	ld	_realtime_bright1,a
1827                     ; 508 		if(last_bright1 > aim_bright1){
1829  001f 9c            	rvf
1830  0020 ae000a        	ldw	x,#_last_bright1
1831  0023 cd0000        	call	c_ltor
1833  0026 ae0000        	ldw	x,#_aim_bright1
1834  0029 cd0000        	call	c_fcmp
1836  002c 2d21          	jrsle	L106
1837                     ; 509 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
1839  002e ae000a        	ldw	x,#_last_bright1
1840  0031 cd0000        	call	c_ltor
1842  0034 ae0000        	ldw	x,#_aim_bright1
1843  0037 cd0000        	call	c_fsub
1845  003a ae000c        	ldw	x,#L734
1846  003d cd0000        	call	c_fmul
1848  0040 cd0000        	call	c_ftol
1850  0043 b603          	ld	a,c_lreg+3
1851  0045 a102          	cp	a,#2
1852  0047 2425          	jruge	L775
1853                     ; 510 				linear1_begin = 0;
1855  0049 72110000      	bres	_action_flag,#0
1856  004d 201f          	jra	L775
1857  004f               L106:
1858                     ; 513 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
1860  004f ae0000        	ldw	x,#_aim_bright1
1861  0052 cd0000        	call	c_ltor
1863  0055 ae000a        	ldw	x,#_last_bright1
1864  0058 cd0000        	call	c_fsub
1866  005b ae000c        	ldw	x,#L734
1867  005e cd0000        	call	c_fmul
1869  0061 cd0000        	call	c_ftol
1871  0064 b603          	ld	a,c_lreg+3
1872  0066 a102          	cp	a,#2
1873  0068 2404          	jruge	L775
1874                     ; 514 				linear1_begin = 0;
1876  006a 72110000      	bres	_action_flag,#0
1877  006e               L775:
1878                     ; 517 	if(linear2_begin){//channel2 Linear调光开始
1880  006e b600          	ld	a,_action_flag
1881  0070 a502          	bcp	a,#2
1882  0072 2768          	jreq	L116
1883                     ; 518 		last_bright2 += change_step2;
1885  0074 ae0000        	ldw	x,#_change_step2
1886  0077 cd0000        	call	c_ltor
1888  007a ae0006        	ldw	x,#_last_bright2
1889  007d cd0000        	call	c_fgadd
1891                     ; 519 		realtime_bright2 = Linear(last_bright2);
1893  0080 be08          	ldw	x,_last_bright2+2
1894  0082 89            	pushw	x
1895  0083 be06          	ldw	x,_last_bright2
1896  0085 89            	pushw	x
1897  0086 cd0000        	call	_Linear
1899  0089 5b04          	addw	sp,#4
1900  008b b704          	ld	_realtime_bright2,a
1901                     ; 520 		if(last_bright2 > aim_bright2){
1903  008d 9c            	rvf
1904  008e ae0006        	ldw	x,#_last_bright2
1905  0091 cd0000        	call	c_ltor
1907  0094 ae0000        	ldw	x,#_aim_bright2
1908  0097 cd0000        	call	c_fcmp
1910  009a 2d21          	jrsle	L316
1911                     ; 521 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
1913  009c ae0006        	ldw	x,#_last_bright2
1914  009f cd0000        	call	c_ltor
1916  00a2 ae0000        	ldw	x,#_aim_bright2
1917  00a5 cd0000        	call	c_fsub
1919  00a8 ae000c        	ldw	x,#L734
1920  00ab cd0000        	call	c_fmul
1922  00ae cd0000        	call	c_ftol
1924  00b1 b603          	ld	a,c_lreg+3
1925  00b3 a102          	cp	a,#2
1926  00b5 2425          	jruge	L116
1927                     ; 522 				linear2_begin = 0;
1929  00b7 72130000      	bres	_action_flag,#1
1930  00bb 201f          	jra	L116
1931  00bd               L316:
1932                     ; 525 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
1934  00bd ae0000        	ldw	x,#_aim_bright2
1935  00c0 cd0000        	call	c_ltor
1937  00c3 ae0006        	ldw	x,#_last_bright2
1938  00c6 cd0000        	call	c_fsub
1940  00c9 ae000c        	ldw	x,#L734
1941  00cc cd0000        	call	c_fmul
1943  00cf cd0000        	call	c_ftol
1945  00d2 b603          	ld	a,c_lreg+3
1946  00d4 a102          	cp	a,#2
1947  00d6 2404          	jruge	L116
1948                     ; 526 				linear2_begin = 0;
1950  00d8 72130000      	bres	_action_flag,#1
1951  00dc               L116:
1952                     ; 529 	if(eraseIn1_begin){//channel1 EraseIn调光开始
1954  00dc b600          	ld	a,_action_flag
1955  00de a504          	bcp	a,#4
1956  00e0 2768          	jreq	L326
1957                     ; 530 		last_bright1 += change_step1;
1959  00e2 ae0000        	ldw	x,#_change_step1
1960  00e5 cd0000        	call	c_ltor
1962  00e8 ae000a        	ldw	x,#_last_bright1
1963  00eb cd0000        	call	c_fgadd
1965                     ; 531 		realtime_bright1 = EraseIn(last_bright1);	
1967  00ee be0c          	ldw	x,_last_bright1+2
1968  00f0 89            	pushw	x
1969  00f1 be0a          	ldw	x,_last_bright1
1970  00f3 89            	pushw	x
1971  00f4 cd0000        	call	_EraseIn
1973  00f7 5b04          	addw	sp,#4
1974  00f9 b705          	ld	_realtime_bright1,a
1975                     ; 532 		if(last_bright1 > aim_bright1){
1977  00fb 9c            	rvf
1978  00fc ae000a        	ldw	x,#_last_bright1
1979  00ff cd0000        	call	c_ltor
1981  0102 ae0000        	ldw	x,#_aim_bright1
1982  0105 cd0000        	call	c_fcmp
1984  0108 2d21          	jrsle	L526
1985                     ; 533 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
1987  010a ae000a        	ldw	x,#_last_bright1
1988  010d cd0000        	call	c_ltor
1990  0110 ae0000        	ldw	x,#_aim_bright1
1991  0113 cd0000        	call	c_fsub
1993  0116 ae000c        	ldw	x,#L734
1994  0119 cd0000        	call	c_fmul
1996  011c cd0000        	call	c_ftol
1998  011f b603          	ld	a,c_lreg+3
1999  0121 a102          	cp	a,#2
2000  0123 2425          	jruge	L326
2001                     ; 534 				eraseIn1_begin = 0;
2003  0125 72150000      	bres	_action_flag,#2
2004  0129 201f          	jra	L326
2005  012b               L526:
2006                     ; 537 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2008  012b ae0000        	ldw	x,#_aim_bright1
2009  012e cd0000        	call	c_ltor
2011  0131 ae000a        	ldw	x,#_last_bright1
2012  0134 cd0000        	call	c_fsub
2014  0137 ae000c        	ldw	x,#L734
2015  013a cd0000        	call	c_fmul
2017  013d cd0000        	call	c_ftol
2019  0140 b603          	ld	a,c_lreg+3
2020  0142 a102          	cp	a,#2
2021  0144 2404          	jruge	L326
2022                     ; 538 				eraseIn1_begin = 0;
2024  0146 72150000      	bres	_action_flag,#2
2025  014a               L326:
2026                     ; 541 	if(eraseIn2_begin){//channel2 EraseIn调光开始
2028  014a b600          	ld	a,_action_flag
2029  014c a508          	bcp	a,#8
2030  014e 2768          	jreq	L536
2031                     ; 542 		last_bright2 += change_step2;
2033  0150 ae0000        	ldw	x,#_change_step2
2034  0153 cd0000        	call	c_ltor
2036  0156 ae0006        	ldw	x,#_last_bright2
2037  0159 cd0000        	call	c_fgadd
2039                     ; 543 		realtime_bright2 = EraseIn(last_bright2);
2041  015c be08          	ldw	x,_last_bright2+2
2042  015e 89            	pushw	x
2043  015f be06          	ldw	x,_last_bright2
2044  0161 89            	pushw	x
2045  0162 cd0000        	call	_EraseIn
2047  0165 5b04          	addw	sp,#4
2048  0167 b704          	ld	_realtime_bright2,a
2049                     ; 544 		if(last_bright2 > aim_bright2){
2051  0169 9c            	rvf
2052  016a ae0006        	ldw	x,#_last_bright2
2053  016d cd0000        	call	c_ltor
2055  0170 ae0000        	ldw	x,#_aim_bright2
2056  0173 cd0000        	call	c_fcmp
2058  0176 2d21          	jrsle	L736
2059                     ; 545 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2061  0178 ae0006        	ldw	x,#_last_bright2
2062  017b cd0000        	call	c_ltor
2064  017e ae0000        	ldw	x,#_aim_bright2
2065  0181 cd0000        	call	c_fsub
2067  0184 ae000c        	ldw	x,#L734
2068  0187 cd0000        	call	c_fmul
2070  018a cd0000        	call	c_ftol
2072  018d b603          	ld	a,c_lreg+3
2073  018f a102          	cp	a,#2
2074  0191 2425          	jruge	L536
2075                     ; 546 				eraseIn2_begin = 0;
2077  0193 72170000      	bres	_action_flag,#3
2078  0197 201f          	jra	L536
2079  0199               L736:
2080                     ; 549 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2082  0199 ae0000        	ldw	x,#_aim_bright2
2083  019c cd0000        	call	c_ltor
2085  019f ae0006        	ldw	x,#_last_bright2
2086  01a2 cd0000        	call	c_fsub
2088  01a5 ae000c        	ldw	x,#L734
2089  01a8 cd0000        	call	c_fmul
2091  01ab cd0000        	call	c_ftol
2093  01ae b603          	ld	a,c_lreg+3
2094  01b0 a102          	cp	a,#2
2095  01b2 2404          	jruge	L536
2096                     ; 550 				eraseIn2_begin = 0;
2098  01b4 72170000      	bres	_action_flag,#3
2099  01b8               L536:
2100                     ; 553 	if(eraseOut1_begin){//channel1 EraseOut调光开始
2102  01b8 b600          	ld	a,_action_flag
2103  01ba a510          	bcp	a,#16
2104  01bc 2768          	jreq	L746
2105                     ; 554 		last_bright1 += change_step1;
2107  01be ae0000        	ldw	x,#_change_step1
2108  01c1 cd0000        	call	c_ltor
2110  01c4 ae000a        	ldw	x,#_last_bright1
2111  01c7 cd0000        	call	c_fgadd
2113                     ; 555 		realtime_bright1 = EraseOut(last_bright1);	
2115  01ca be0c          	ldw	x,_last_bright1+2
2116  01cc 89            	pushw	x
2117  01cd be0a          	ldw	x,_last_bright1
2118  01cf 89            	pushw	x
2119  01d0 cd0000        	call	_EraseOut
2121  01d3 5b04          	addw	sp,#4
2122  01d5 b705          	ld	_realtime_bright1,a
2123                     ; 556 		if(last_bright1 > aim_bright1){
2125  01d7 9c            	rvf
2126  01d8 ae000a        	ldw	x,#_last_bright1
2127  01db cd0000        	call	c_ltor
2129  01de ae0000        	ldw	x,#_aim_bright1
2130  01e1 cd0000        	call	c_fcmp
2132  01e4 2d21          	jrsle	L156
2133                     ; 557 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2135  01e6 ae000a        	ldw	x,#_last_bright1
2136  01e9 cd0000        	call	c_ltor
2138  01ec ae0000        	ldw	x,#_aim_bright1
2139  01ef cd0000        	call	c_fsub
2141  01f2 ae000c        	ldw	x,#L734
2142  01f5 cd0000        	call	c_fmul
2144  01f8 cd0000        	call	c_ftol
2146  01fb b603          	ld	a,c_lreg+3
2147  01fd a102          	cp	a,#2
2148  01ff 2425          	jruge	L746
2149                     ; 558 				eraseOut1_begin = 0;
2151  0201 72190000      	bres	_action_flag,#4
2152  0205 201f          	jra	L746
2153  0207               L156:
2154                     ; 561 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2156  0207 ae0000        	ldw	x,#_aim_bright1
2157  020a cd0000        	call	c_ltor
2159  020d ae000a        	ldw	x,#_last_bright1
2160  0210 cd0000        	call	c_fsub
2162  0213 ae000c        	ldw	x,#L734
2163  0216 cd0000        	call	c_fmul
2165  0219 cd0000        	call	c_ftol
2167  021c b603          	ld	a,c_lreg+3
2168  021e a102          	cp	a,#2
2169  0220 2404          	jruge	L746
2170                     ; 562 				eraseOut1_begin = 0;
2172  0222 72190000      	bres	_action_flag,#4
2173  0226               L746:
2174                     ; 565 	if(eraseOut2_begin){//channel2 EraseOut调光开始
2176  0226 b600          	ld	a,_action_flag
2177  0228 a520          	bcp	a,#32
2178  022a 2768          	jreq	L166
2179                     ; 566 		last_bright2 += change_step2;
2181  022c ae0000        	ldw	x,#_change_step2
2182  022f cd0000        	call	c_ltor
2184  0232 ae0006        	ldw	x,#_last_bright2
2185  0235 cd0000        	call	c_fgadd
2187                     ; 567 		realtime_bright2 = EraseOut(last_bright2);
2189  0238 be08          	ldw	x,_last_bright2+2
2190  023a 89            	pushw	x
2191  023b be06          	ldw	x,_last_bright2
2192  023d 89            	pushw	x
2193  023e cd0000        	call	_EraseOut
2195  0241 5b04          	addw	sp,#4
2196  0243 b704          	ld	_realtime_bright2,a
2197                     ; 568 		if(last_bright2 > aim_bright2){
2199  0245 9c            	rvf
2200  0246 ae0006        	ldw	x,#_last_bright2
2201  0249 cd0000        	call	c_ltor
2203  024c ae0000        	ldw	x,#_aim_bright2
2204  024f cd0000        	call	c_fcmp
2206  0252 2d21          	jrsle	L366
2207                     ; 569 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2209  0254 ae0006        	ldw	x,#_last_bright2
2210  0257 cd0000        	call	c_ltor
2212  025a ae0000        	ldw	x,#_aim_bright2
2213  025d cd0000        	call	c_fsub
2215  0260 ae000c        	ldw	x,#L734
2216  0263 cd0000        	call	c_fmul
2218  0266 cd0000        	call	c_ftol
2220  0269 b603          	ld	a,c_lreg+3
2221  026b a102          	cp	a,#2
2222  026d 2425          	jruge	L166
2223                     ; 570 				eraseOut2_begin = 0;
2225  026f 721b0000      	bres	_action_flag,#5
2226  0273 201f          	jra	L166
2227  0275               L366:
2228                     ; 573 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2230  0275 ae0000        	ldw	x,#_aim_bright2
2231  0278 cd0000        	call	c_ltor
2233  027b ae0006        	ldw	x,#_last_bright2
2234  027e cd0000        	call	c_fsub
2236  0281 ae000c        	ldw	x,#L734
2237  0284 cd0000        	call	c_fmul
2239  0287 cd0000        	call	c_ftol
2241  028a b603          	ld	a,c_lreg+3
2242  028c a102          	cp	a,#2
2243  028e 2404          	jruge	L166
2244                     ; 574 				eraseOut2_begin = 0;
2246  0290 721b0000      	bres	_action_flag,#5
2247  0294               L166:
2248                     ; 577 	if(swing1_begin){//channel1 Swing调光开始
2250  0294 b600          	ld	a,_action_flag
2251  0296 a540          	bcp	a,#64
2252  0298 2768          	jreq	L376
2253                     ; 578 		last_bright1 += change_step1;
2255  029a ae0000        	ldw	x,#_change_step1
2256  029d cd0000        	call	c_ltor
2258  02a0 ae000a        	ldw	x,#_last_bright1
2259  02a3 cd0000        	call	c_fgadd
2261                     ; 579 		realtime_bright1 = Swing(last_bright1);	
2263  02a6 be0c          	ldw	x,_last_bright1+2
2264  02a8 89            	pushw	x
2265  02a9 be0a          	ldw	x,_last_bright1
2266  02ab 89            	pushw	x
2267  02ac cd0000        	call	_Swing
2269  02af 5b04          	addw	sp,#4
2270  02b1 b705          	ld	_realtime_bright1,a
2271                     ; 580 		if(last_bright1 > aim_bright1){
2273  02b3 9c            	rvf
2274  02b4 ae000a        	ldw	x,#_last_bright1
2275  02b7 cd0000        	call	c_ltor
2277  02ba ae0000        	ldw	x,#_aim_bright1
2278  02bd cd0000        	call	c_fcmp
2280  02c0 2d21          	jrsle	L576
2281                     ; 581 			if(((u8)((last_bright1 - aim_bright1)*250) <= 1))
2283  02c2 ae000a        	ldw	x,#_last_bright1
2284  02c5 cd0000        	call	c_ltor
2286  02c8 ae0000        	ldw	x,#_aim_bright1
2287  02cb cd0000        	call	c_fsub
2289  02ce ae000c        	ldw	x,#L734
2290  02d1 cd0000        	call	c_fmul
2292  02d4 cd0000        	call	c_ftol
2294  02d7 b603          	ld	a,c_lreg+3
2295  02d9 a102          	cp	a,#2
2296  02db 2425          	jruge	L376
2297                     ; 582 				swing1_begin = 0;
2299  02dd 721d0000      	bres	_action_flag,#6
2300  02e1 201f          	jra	L376
2301  02e3               L576:
2302                     ; 585 			if(((u8)((aim_bright1- last_bright1)*250) <= 1))
2304  02e3 ae0000        	ldw	x,#_aim_bright1
2305  02e6 cd0000        	call	c_ltor
2307  02e9 ae000a        	ldw	x,#_last_bright1
2308  02ec cd0000        	call	c_fsub
2310  02ef ae000c        	ldw	x,#L734
2311  02f2 cd0000        	call	c_fmul
2313  02f5 cd0000        	call	c_ftol
2315  02f8 b603          	ld	a,c_lreg+3
2316  02fa a102          	cp	a,#2
2317  02fc 2404          	jruge	L376
2318                     ; 586 				swing1_begin = 0;
2320  02fe 721d0000      	bres	_action_flag,#6
2321  0302               L376:
2322                     ; 589 	if(swing2_begin){//channel2 Swing调光开始
2324  0302 b600          	ld	a,_action_flag
2325  0304 a580          	bcp	a,#128
2326  0306 2768          	jreq	L507
2327                     ; 590 		last_bright2 += change_step2;
2329  0308 ae0000        	ldw	x,#_change_step2
2330  030b cd0000        	call	c_ltor
2332  030e ae0006        	ldw	x,#_last_bright2
2333  0311 cd0000        	call	c_fgadd
2335                     ; 591 		realtime_bright2 = Swing(last_bright2);
2337  0314 be08          	ldw	x,_last_bright2+2
2338  0316 89            	pushw	x
2339  0317 be06          	ldw	x,_last_bright2
2340  0319 89            	pushw	x
2341  031a cd0000        	call	_Swing
2343  031d 5b04          	addw	sp,#4
2344  031f b704          	ld	_realtime_bright2,a
2345                     ; 592 		if(last_bright2 > aim_bright2){
2347  0321 9c            	rvf
2348  0322 ae0006        	ldw	x,#_last_bright2
2349  0325 cd0000        	call	c_ltor
2351  0328 ae0000        	ldw	x,#_aim_bright2
2352  032b cd0000        	call	c_fcmp
2354  032e 2d21          	jrsle	L707
2355                     ; 593 			if(((u8)((last_bright2 - aim_bright2)*250)	<= 1))
2357  0330 ae0006        	ldw	x,#_last_bright2
2358  0333 cd0000        	call	c_ltor
2360  0336 ae0000        	ldw	x,#_aim_bright2
2361  0339 cd0000        	call	c_fsub
2363  033c ae000c        	ldw	x,#L734
2364  033f cd0000        	call	c_fmul
2366  0342 cd0000        	call	c_ftol
2368  0345 b603          	ld	a,c_lreg+3
2369  0347 a102          	cp	a,#2
2370  0349 2425          	jruge	L507
2371                     ; 594 				swing2_begin = 0;
2373  034b 721f0000      	bres	_action_flag,#7
2374  034f 201f          	jra	L507
2375  0351               L707:
2376                     ; 597 			if(((u8)((aim_bright2- last_bright2)*250) <= 1))
2378  0351 ae0000        	ldw	x,#_aim_bright2
2379  0354 cd0000        	call	c_ltor
2381  0357 ae0006        	ldw	x,#_last_bright2
2382  035a cd0000        	call	c_fsub
2384  035d ae000c        	ldw	x,#L734
2385  0360 cd0000        	call	c_fmul
2387  0363 cd0000        	call	c_ftol
2389  0366 b603          	ld	a,c_lreg+3
2390  0368 a102          	cp	a,#2
2391  036a 2404          	jruge	L507
2392                     ; 598 				swing2_begin = 0;
2394  036c 721f0000      	bres	_action_flag,#7
2395  0370               L507:
2396                     ; 601 }
2399  0370 81            	ret
2701                     	xdef	_Swing
2702                     	xdef	_EraseOut
2703                     	xdef	_EraseIn
2704                     	xdef	_Linear
2705                     	xdef	_main
2706                     	xdef	_delay
2707                     	switch	.ubsct
2708  0000               _tick1s:
2709  0000 00            	ds.b	1
2710                     	xdef	_tick1s
2711  0001               _f_100ms:
2712  0001 00            	ds.b	1
2713                     	xdef	_f_100ms
2714  0002               _Tick100ms:
2715  0002 0000          	ds.b	2
2716                     	xdef	_Tick100ms
2717                     	xref.b	_action_flag
2718                     	xref.b	_change_step2
2719                     	xref.b	_change_step1
2720                     	xref.b	_aim_bright2
2721                     	xref.b	_aim_bright1
2722                     	xref.b	_channel
2723  0004               _realtime_bright2:
2724  0004 00            	ds.b	1
2725                     	xdef	_realtime_bright2
2726  0005               _realtime_bright1:
2727  0005 00            	ds.b	1
2728                     	xdef	_realtime_bright1
2729  0006               _last_bright2:
2730  0006 00000000      	ds.b	4
2731                     	xdef	_last_bright2
2732  000a               _last_bright1:
2733  000a 00000000      	ds.b	4
2734                     	xdef	_last_bright1
2735                     	xref.b	_slave_address
2736                     	xref.b	_slc
2737                     	xref	_IIC_SlaveConfig
2738                     	xdef	f_Timer4_ISR
2739                     	xdef	f_Timer2_ISR
2740                     	xdef	f_Ext_PortD_ISR
2741                     	xdef	_lightCtrl100ms
2742                     	xdef	_sys
2743                     	xdef	_assert_failed
2744                     	xref	_TIM4_ClearITPendingBit
2745                     	xref	_TIM4_ClearFlag
2746                     	xref	_TIM4_SetAutoreload
2747                     	xref	_TIM4_ITConfig
2748                     	xref	_TIM4_Cmd
2749                     	xref	_TIM4_TimeBaseInit
2750                     	xref	_TIM2_ClearITPendingBit
2751                     	xref	_TIM2_ClearFlag
2752                     	xref	_TIM2_SetAutoreload
2753                     	xref	_TIM2_ITConfig
2754                     	xref	_TIM2_Cmd
2755                     	xref	_TIM2_TimeBaseInit
2756                     	xref	_GPIO_ReadOutputData
2757                     	xref	_GPIO_ReadInputData
2758                     	xref	_GPIO_WriteLow
2759                     	xref	_GPIO_WriteHigh
2760                     	xref	_GPIO_Init
2761                     	xref	_EXTI_SetExtIntSensitivity
2762                     	xref	_EXTI_DeInit
2763                     	xref	_CLK_PeripheralClockConfig
2764                     .const:	section	.text
2765  0000               L165:
2766  0000 3f800000      	dc.w	16256,0
2767  0004               L745:
2768  0004 40000000      	dc.w	16384,0
2769  0008               L735:
2770  0008 3f000000      	dc.w	16128,0
2771  000c               L734:
2772  000c 437a0000      	dc.w	17274,0
2773  0010               L142:
2774  0010 3e23d70a      	dc.w	15907,-10486
2775  0014               L361:
2776  0014 42c80000      	dc.w	17096,0
2777                     	xref.b	c_lreg
2778                     	xref.b	c_x
2779                     	xref.b	c_y
2799                     	xref	c_fgadd
2800                     	xref	c_fsub
2801                     	xref	c_fcmp
2802                     	xref	c_rtol
2803                     	xref	c_ctof
2804                     	xref	c_ftol
2805                     	xref	c_fmul
2806                     	xref	c_ltor
2807                     	end
