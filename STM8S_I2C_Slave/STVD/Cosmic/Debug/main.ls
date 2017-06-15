   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               _sys:
   6  0000 00            	dc.b	0
   7  0001 000000        	ds.b	3
   8  0004 000000000000  	ds.b	25
  66                     ; 58 void delay(u16 Count)
  66                     ; 59 {
  68                     .text:	section	.text,new
  69  0000               _delay:
  71  0000 89            	pushw	x
  72  0001 89            	pushw	x
  73       00000002      OFST:	set	2
  76  0002 2014          	jra	L35
  77  0004               L15:
  78                     ; 63     for(i=0;i<100;i++)
  80  0004 0f01          	clr	(OFST-1,sp)
  81  0006               L75:
  82                     ; 64     for(j=0;j<50;j++);
  84  0006 0f02          	clr	(OFST+0,sp)
  85  0008               L56:
  89  0008 0c02          	inc	(OFST+0,sp)
  92  000a 7b02          	ld	a,(OFST+0,sp)
  93  000c a132          	cp	a,#50
  94  000e 25f8          	jrult	L56
  95                     ; 63     for(i=0;i<100;i++)
  97  0010 0c01          	inc	(OFST-1,sp)
 100  0012 7b01          	ld	a,(OFST-1,sp)
 101  0014 a164          	cp	a,#100
 102  0016 25ee          	jrult	L75
 103  0018               L35:
 104                     ; 61   while (Count--)//Count形参控制延时次数
 106  0018 1e03          	ldw	x,(OFST+1,sp)
 107  001a 1d0001        	subw	x,#1
 108  001d 1f03          	ldw	(OFST+1,sp),x
 109  001f 1c0001        	addw	x,#1
 110  0022 a30000        	cpw	x,#0
 111  0025 26dd          	jrne	L15
 112                     ; 66 }
 115  0027 5b04          	addw	sp,#4
 116  0029 81            	ret
 176                     ; 74 void main(void)
 176                     ; 75 {
 177                     .text:	section	.text,new
 178  0000               _main:
 180  0000 88            	push	a
 181       00000001      OFST:	set	1
 184                     ; 79 	CLK->SWCR |= 0x02; //开启切换
 186  0001 721250c5      	bset	20677,#1
 187                     ; 80   CLK->SWR   = 0xb4;       //选择时钟为外部8M
 189  0005 35b450c4      	mov	20676,#180
 191  0009               L511:
 192                     ; 81   while((CLK->SWCR & 0x01)==0x01);
 194  0009 c650c5        	ld	a,20677
 195  000c a401          	and	a,#1
 196  000e a101          	cp	a,#1
 197  0010 27f7          	jreq	L511
 198                     ; 82   CLK->CKDIVR = 0x80;    //不分频
 200  0012 358050c6      	mov	20678,#128
 201                     ; 83   CLK->SWCR  &= ~0x02; //关闭切换
 203  0016 721350c5      	bres	20677,#1
 204                     ; 89 	GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);
 206  001a 4b40          	push	#64
 207  001c 4b04          	push	#4
 208  001e ae500f        	ldw	x,#20495
 209  0021 cd0000        	call	_GPIO_Init
 211  0024 85            	popw	x
 212                     ; 90 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT);
 214  0025 4b40          	push	#64
 215  0027 4b40          	push	#64
 216  0029 ae500a        	ldw	x,#20490
 217  002c cd0000        	call	_GPIO_Init
 219  002f 85            	popw	x
 220                     ; 91 	GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_5, GPIO_MODE_IN_PU_NO_IT);
 222  0030 4b40          	push	#64
 223  0032 4b20          	push	#32
 224  0034 ae500a        	ldw	x,#20490
 225  0037 cd0000        	call	_GPIO_Init
 227  003a 85            	popw	x
 228                     ; 92 	GPIO_Init(GPIOA, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);
 230  003b 4b40          	push	#64
 231  003d 4b08          	push	#8
 232  003f ae5000        	ldw	x,#20480
 233  0042 cd0000        	call	_GPIO_Init
 235  0045 85            	popw	x
 236                     ; 93 	delay(100);
 238  0046 ae0064        	ldw	x,#100
 239  0049 cd0000        	call	_delay
 241                     ; 94 	if(GPIO_ReadInputData(GPIOD) & 0x04)	slave_address |= 0x08;
 243  004c ae500f        	ldw	x,#20495
 244  004f cd0000        	call	_GPIO_ReadInputData
 246  0052 a504          	bcp	a,#4
 247  0054 2704          	jreq	L121
 250  0056 72160000      	bset	_slave_address,#3
 251  005a               L121:
 252                     ; 95 	if(GPIO_ReadInputData(GPIOC) & 0x40)	slave_address |= 0x04;
 254  005a ae500a        	ldw	x,#20490
 255  005d cd0000        	call	_GPIO_ReadInputData
 257  0060 a540          	bcp	a,#64
 258  0062 2704          	jreq	L321
 261  0064 72140000      	bset	_slave_address,#2
 262  0068               L321:
 263                     ; 96 	if(GPIO_ReadInputData(GPIOC) & 0x20)	slave_address |= 0x02;
 265  0068 ae500a        	ldw	x,#20490
 266  006b cd0000        	call	_GPIO_ReadInputData
 268  006e a520          	bcp	a,#32
 269  0070 2704          	jreq	L521
 272  0072 72120000      	bset	_slave_address,#1
 273  0076               L521:
 274                     ; 97 	if(GPIO_ReadInputData(GPIOA) & 0x08)	slave_address |= 0x01;
 276  0076 ae5000        	ldw	x,#20480
 277  0079 cd0000        	call	_GPIO_ReadInputData
 279  007c a508          	bcp	a,#8
 280  007e 2704          	jreq	L721
 283  0080 72100000      	bset	_slave_address,#0
 284  0084               L721:
 285                     ; 98 	slc.MDID = slave_address;
 287  0084 b600          	ld	a,_slave_address
 288  0086 5f            	clrw	x
 289  0087 97            	ld	xl,a
 290  0088 bf13          	ldw	_slc+19,x
 291                     ; 99 	GPIO_Config();
 293  008a cd0000        	call	L5_GPIO_Config
 295                     ; 100 	Sys_Init();
 297  008d cd0000        	call	L3_Sys_Init
 299                     ; 101 	ExtInterrupt_Config();
 301  0090 cd0000        	call	L7_ExtInterrupt_Config
 303                     ; 102 	TIMER4_Init();
 305  0093 cd0000        	call	L31_TIMER4_Init
 307                     ; 104 	UART_Init(115200);
 309  0096 aec200        	ldw	x,#49664
 310  0099 89            	pushw	x
 311  009a ae0001        	ldw	x,#1
 312  009d 89            	pushw	x
 313  009e cd0000        	call	_UART_Init
 315  00a1 5b04          	addw	sp,#4
 316                     ; 106 	printf("Hello World!\n");
 318  00a3 ae005d        	ldw	x,#L131
 319  00a6 cd0000        	call	_printf
 321                     ; 108 	IIC_SlaveConfig();
 323  00a9 cd0000        	call	_IIC_SlaveConfig
 326  00ac 2016          	jra	L531
 327  00ae               L331:
 328                     ; 115 		 if (sys.checkAcCnt == 0)
 330  00ae be0e          	ldw	x,_sys+14
 331  00b0 2612          	jrne	L531
 332                     ; 122 			sys.gotHzFlag = FALSE;    
 334  00b2 3f09          	clr	_sys+9
 335                     ; 123 			sys.reqCalHzFlag = FALSE;
 337  00b4 3f08          	clr	_sys+8
 338                     ; 124 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 340  00b6 350a000b      	mov	_sys+11,#10
 341                     ; 125 			sys.hzCnt = 0;
 343  00ba 5f            	clrw	x
 344  00bb bf0c          	ldw	_sys+12,x
 345                     ; 126 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 347  00bd ae07d0        	ldw	x,#2000
 348  00c0 bf0e          	ldw	_sys+14,x
 349                     ; 127 			break;
 351  00c2 201a          	jra	L541
 352  00c4               L531:
 353                     ; 113 	 while(!sys.gotHzFlag)
 355  00c4 3d09          	tnz	_sys+9
 356  00c6 27e6          	jreq	L331
 357  00c8 2014          	jra	L541
 358  00ca               L341:
 359                     ; 134 		 if (sys.checkAcCnt == 0)
 361  00ca be0e          	ldw	x,_sys+14
 362  00cc 2610          	jrne	L541
 363                     ; 137 			sys.gotHzFlag = FALSE;    
 365  00ce 3f09          	clr	_sys+9
 366                     ; 138 			sys.reqCalHzFlag = FALSE;
 368  00d0 3f08          	clr	_sys+8
 369                     ; 139 			sys.calHzIntCnt = GET_AC_FRE_CNT;
 371  00d2 350a000b      	mov	_sys+11,#10
 372                     ; 140 			sys.hzCnt = 0;
 374  00d6 5f            	clrw	x
 375  00d7 bf0c          	ldw	_sys+12,x
 376                     ; 141 			sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 378  00d9 ae07d0        	ldw	x,#2000
 379  00dc bf0e          	ldw	_sys+14,x
 380  00de               L541:
 381                     ; 132 	 while(!sys.gotHzFlag)
 383  00de 3d09          	tnz	_sys+9
 384  00e0 27e8          	jreq	L341
 385                     ; 144 	 sys.acOkFlag = TRUE;
 387  00e2 35010011      	mov	_sys+17,#1
 388                     ; 145 	 TIMER2_Init();
 390  00e6 cd0000        	call	L11_TIMER2_Init
 392                     ; 146 	 enableInterrupts();
 395  00e9 9a            rim
 397                     ; 148 	 last_bright = DEFAULT_BRIGHTNESS;
 400  00ea 35280004      	mov	_last_bright,#40
 401                     ; 149 	 aim_bright = 0;
 403  00ee 3f00          	clr	_aim_bright
 404  00f0               L351:
 405                     ; 153 		if(ReceiveState == IIC_STATE_END)
 407  00f0 b600          	ld	a,_ReceiveState
 408  00f2 a103          	cp	a,#3
 409  00f4 2626          	jrne	L751
 410                     ; 155 			for(i=0;i<GetDataIndex;i++){
 412  00f6 0f01          	clr	(OFST+0,sp)
 414  00f8 2012          	jra	L561
 415  00fa               L161:
 416                     ; 156 				printf("%02X ",IIC_RxBuffer[i]&0xFF);
 418  00fa 7b01          	ld	a,(OFST+0,sp)
 419  00fc 5f            	clrw	x
 420  00fd 97            	ld	xl,a
 421  00fe e600          	ld	a,(_IIC_RxBuffer,x)
 422  0100 5f            	clrw	x
 423  0101 97            	ld	xl,a
 424  0102 89            	pushw	x
 425  0103 ae0057        	ldw	x,#L171
 426  0106 cd0000        	call	_printf
 428  0109 85            	popw	x
 429                     ; 155 			for(i=0;i<GetDataIndex;i++){
 431  010a 0c01          	inc	(OFST+0,sp)
 432  010c               L561:
 435  010c 7b01          	ld	a,(OFST+0,sp)
 436  010e b100          	cp	a,_GetDataIndex
 437  0110 25e8          	jrult	L161
 438                     ; 158 			printf("\n");
 440  0112 ae0055        	ldw	x,#L371
 441  0115 cd0000        	call	_printf
 443                     ; 159 			ReceiveState = IIC_STATE_UNKNOWN;
 445  0118 3f00          	clr	_ReceiveState
 446                     ; 160 			GetDataIndex = 0;
 448  011a 3f00          	clr	_GetDataIndex
 449  011c               L751:
 450                     ; 163 		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE)
 452  011c be0e          	ldw	x,_sys+14
 453  011e 260a          	jrne	L571
 455  0120 3d10          	tnz	_sys+16
 456  0122 2606          	jrne	L571
 457                     ; 167 			 sys.acErrFlag = TRUE;
 459  0124 35010010      	mov	_sys+16,#1
 460                     ; 168 			 sys.acOkFlag = FALSE;
 462  0128 3f11          	clr	_sys+17
 463  012a               L571:
 464                     ; 171 		if (sys.acErrFlag == FALSE && sys.acOkFlag == FALSE)
 466  012a 3d10          	tnz	_sys+16
 467  012c 260d          	jrne	L771
 469  012e 3d11          	tnz	_sys+17
 470  0130 2609          	jrne	L771
 471                     ; 175 			sys.acOkFlag = TRUE;
 473  0132 35010011      	mov	_sys+17,#1
 474                     ; 176 			sys.cnt1s = CNT_1S;
 476  0136 ae4e20        	ldw	x,#20000
 477  0139 bf1b          	ldw	_sys+27,x
 478  013b               L771:
 479                     ; 179 		if(f_100ms){
 481  013b 3d01          	tnz	_f_100ms
 482  013d 2778          	jreq	L102
 483                     ; 180 			f_100ms = 0;
 485  013f 3f01          	clr	_f_100ms
 486                     ; 181 			if((up)&&(!down)){//调亮
 488  0141 3d00          	tnz	_up
 489  0143 2721          	jreq	L302
 491  0145 3d00          	tnz	_down
 492  0147 261d          	jrne	L302
 493                     ; 182 				if(last_bright < aim_bright){
 495  0149 b604          	ld	a,_last_bright
 496  014b b100          	cp	a,_aim_bright
 497  014d 243a          	jruge	L112
 498                     ; 183 					last_bright += change_step;
 500  014f b604          	ld	a,_last_bright
 501  0151 bb00          	add	a,_change_step
 502  0153 b704          	ld	_last_bright,a
 503                     ; 184 					if(last_bright >= aim_bright)	{last_bright = aim_bright;channel = 0x00;up = FALSE;down = FALSE;}
 505  0155 b604          	ld	a,_last_bright
 506  0157 b100          	cp	a,_aim_bright
 507  0159 252e          	jrult	L112
 510  015b 450004        	mov	_last_bright,_aim_bright
 513  015e 3f00          	clr	_channel
 516  0160 3f00          	clr	_up
 519  0162 3f00          	clr	_down
 520  0164 2023          	jra	L112
 521  0166               L302:
 522                     ; 188 			else if((!up)&&(down)){//调暗
 524  0166 3d00          	tnz	_up
 525  0168 261f          	jrne	L112
 527  016a 3d00          	tnz	_down
 528  016c 271b          	jreq	L112
 529                     ; 189 				if(last_bright > aim_bright){
 531  016e b604          	ld	a,_last_bright
 532  0170 b100          	cp	a,_aim_bright
 533  0172 2315          	jrule	L112
 534                     ; 190 					last_bright -= change_step;
 536  0174 b604          	ld	a,_last_bright
 537  0176 b000          	sub	a,_change_step
 538  0178 b704          	ld	_last_bright,a
 539                     ; 191 					if(last_bright <= aim_bright)	{last_bright = aim_bright;channel = 0x00;up = FALSE;down = FALSE;}
 541  017a b604          	ld	a,_last_bright
 542  017c b100          	cp	a,_aim_bright
 543  017e 2209          	jrugt	L112
 546  0180 450004        	mov	_last_bright,_aim_bright
 549  0183 3f00          	clr	_channel
 552  0185 3f00          	clr	_up
 555  0187 3f00          	clr	_down
 556  0189               L112:
 557                     ; 195 			tick1s++;
 559  0189 3c00          	inc	_tick1s
 560                     ; 196 			if(tick1s >= 10){
 562  018b b600          	ld	a,_tick1s
 563  018d a10a          	cp	a,#10
 564  018f 2526          	jrult	L102
 565                     ; 197 				tick1s = 0;
 567  0191 3f00          	clr	_tick1s
 568                     ; 198 				printf("last_bright = %02X, aim_bright = %02X\n",last_bright&0xFF,aim_bright&0xFF);
 570  0193 b600          	ld	a,_aim_bright
 571  0195 5f            	clrw	x
 572  0196 97            	ld	xl,a
 573  0197 89            	pushw	x
 574  0198 b604          	ld	a,_last_bright
 575  019a 5f            	clrw	x
 576  019b 97            	ld	xl,a
 577  019c 89            	pushw	x
 578  019d ae002e        	ldw	x,#L322
 579  01a0 cd0000        	call	_printf
 581  01a3 5b04          	addw	sp,#4
 582                     ; 199 				printf("slc.ch1_status = %02X, slc.ch2_status = %02X\n",slc.ch1_status&0xFF,slc.ch2_status&0xFF);
 584  01a5 b616          	ld	a,_slc+22
 585  01a7 5f            	clrw	x
 586  01a8 97            	ld	xl,a
 587  01a9 89            	pushw	x
 588  01aa b615          	ld	a,_slc+21
 589  01ac 5f            	clrw	x
 590  01ad 97            	ld	xl,a
 591  01ae 89            	pushw	x
 592  01af ae0000        	ldw	x,#L522
 593  01b2 cd0000        	call	_printf
 595  01b5 5b04          	addw	sp,#4
 596  01b7               L102:
 597                     ; 202 		if((channel & 0x01)==0x01)//调节Dimmer1
 599  01b7 b600          	ld	a,_channel
 600  01b9 a401          	and	a,#1
 601  01bb a101          	cp	a,#1
 602  01bd 2606          	jrne	L722
 603                     ; 204 			sys.light1.briVal = last_bright;
 605  01bf 450402        	mov	_sys+2,_last_bright
 606                     ; 205 			slc.ch1_status = last_bright;
 608  01c2 450415        	mov	_slc+21,_last_bright
 609  01c5               L722:
 610                     ; 207 		if((channel & 0x02)==0x02)//调节Dimmer2
 612  01c5 b600          	ld	a,_channel
 613  01c7 a402          	and	a,#2
 614  01c9 a102          	cp	a,#2
 615  01cb 2606          	jrne	L132
 616                     ; 209 			sys.light2.briVal = last_bright;
 618  01cd 450406        	mov	_sys+6,_last_bright
 619                     ; 210 			slc.ch2_status = last_bright;
 621  01d0 450416        	mov	_slc+22,_last_bright
 622  01d3               L132:
 623                     ; 213 		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE)
 625  01d3 be0e          	ldw	x,_sys+14
 626  01d5 260a          	jrne	L332
 628  01d7 3d10          	tnz	_sys+16
 629  01d9 2606          	jrne	L332
 630                     ; 217 			 sys.acErrFlag = TRUE;
 632  01db 35010010      	mov	_sys+16,#1
 633                     ; 218 			 sys.acOkFlag = FALSE;
 635  01df 3f11          	clr	_sys+17
 636  01e1               L332:
 637                     ; 221 		if (sys.acErrFlag == FALSE && sys.acOkFlag == FALSE)
 639  01e1 3d10          	tnz	_sys+16
 640  01e3 2703          	jreq	L01
 641  01e5 cc00f0        	jp	L351
 642  01e8               L01:
 644  01e8 3d11          	tnz	_sys+17
 645  01ea 2703          	jreq	L21
 646  01ec cc00f0        	jp	L351
 647  01ef               L21:
 648                     ; 225 			sys.acOkFlag = TRUE;
 650  01ef 35010011      	mov	_sys+17,#1
 651                     ; 226 			sys.cnt1s = CNT_1S;
 653  01f3 ae4e20        	ldw	x,#20000
 654  01f6 bf1b          	ldw	_sys+27,x
 655  01f8 acf000f0      	jpf	L351
 690                     ; 240 void assert_failed(uint8_t* file, uint32_t line)
 690                     ; 241 { 
 691                     .text:	section	.text,new
 692  0000               _assert_failed:
 696  0000               L552:
 697  0000 20fe          	jra	L552
 722                     ; 252 static void GPIO_Config(void)
 722                     ; 253 {
 723                     .text:	section	.text,new
 724  0000               L5_GPIO_Config:
 728                     ; 255     GPIO_Init(L1_EN_PIN_PORT, (GPIO_Pin_TypeDef)L1_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
 730  0000 4bd0          	push	#208
 731  0002 4b10          	push	#16
 732  0004 ae500a        	ldw	x,#20490
 733  0007 cd0000        	call	_GPIO_Init
 735  000a 85            	popw	x
 736                     ; 256     GPIO_Init(L2_EN_PIN_PORT, (GPIO_Pin_TypeDef)L2_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);   
 738  000b 4bd0          	push	#208
 739  000d 4b08          	push	#8
 740  000f ae500a        	ldw	x,#20490
 741  0012 cd0000        	call	_GPIO_Init
 743  0015 85            	popw	x
 744                     ; 257     L1_EN_OFF;
 746  0016 4b10          	push	#16
 747  0018 ae500a        	ldw	x,#20490
 748  001b cd0000        	call	_GPIO_WriteHigh
 750  001e 84            	pop	a
 751                     ; 258     L2_EN_OFF;
 753  001f 4b08          	push	#8
 754  0021 ae500a        	ldw	x,#20490
 755  0024 cd0000        	call	_GPIO_WriteHigh
 757  0027 84            	pop	a
 758                     ; 259     GPIO_Init(ZD_PIN_PORT, (GPIO_Pin_TypeDef)ZD_PIN, GPIO_MODE_IN_FL_IT);  
 760  0028 4b20          	push	#32
 761  002a 4b08          	push	#8
 762  002c ae500f        	ldw	x,#20495
 763  002f cd0000        	call	_GPIO_Init
 765  0032 85            	popw	x
 766                     ; 261 }
 769  0033 81            	ret
 794                     ; 263 static void Sys_Init(void)
 794                     ; 264 {
 795                     .text:	section	.text,new
 796  0000               L3_Sys_Init:
 800                     ; 265     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 802  0000 ae0001        	ldw	x,#1
 803  0003 a604          	ld	a,#4
 804  0005 95            	ld	xh,a
 805  0006 cd0000        	call	_CLK_PeripheralClockConfig
 807                     ; 266     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
 809  0009 ae0001        	ldw	x,#1
 810  000c a605          	ld	a,#5
 811  000e 95            	ld	xh,a
 812  000f cd0000        	call	_CLK_PeripheralClockConfig
 814                     ; 268     sys.gotHzFlag = FALSE;    
 816  0012 3f09          	clr	_sys+9
 817                     ; 269     sys.reqCalHzFlag = FALSE;
 819  0014 3f08          	clr	_sys+8
 820                     ; 270     sys.light1.briVal = DEFAULT_BRIGHTNESS;
 822  0016 35280002      	mov	_sys+2,#40
 823                     ; 271     sys.light2.briVal = DEFAULT_BRIGHTNESS;    
 825  001a 35280006      	mov	_sys+6,#40
 826                     ; 272     sys.calHzIntCnt = GET_AC_FRE_CNT;
 828  001e 350a000b      	mov	_sys+11,#10
 829                     ; 273     sys.hzCnt = 0;
 831  0022 5f            	clrw	x
 832  0023 bf0c          	ldw	_sys+12,x
 833                     ; 274     sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 835  0025 ae07d0        	ldw	x,#2000
 836  0028 bf0e          	ldw	_sys+14,x
 837                     ; 275 }
 840  002a 81            	ret
 866                     ; 277 static void ExtInterrupt_Config(void)
 866                     ; 278 {
 867                     .text:	section	.text,new
 868  0000               L7_ExtInterrupt_Config:
 872                     ; 279 	EXTI_DeInit();
 874  0000 cd0000        	call	_EXTI_DeInit
 876                     ; 280 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
 878  0003 ae0002        	ldw	x,#2
 879  0006 a603          	ld	a,#3
 880  0008 95            	ld	xh,a
 881  0009 cd0000        	call	_EXTI_SetExtIntSensitivity
 883                     ; 282 }
 886  000c 81            	ret
 916                     ; 288 @far @interrupt void Ext_PortD_ISR(void) {
 918                     .text:	section	.text,new
 919  0000               f_Ext_PortD_ISR:
 922  0000 3b0002        	push	c_x+2
 923  0003 be00          	ldw	x,c_x
 924  0005 89            	pushw	x
 925  0006 3b0002        	push	c_y+2
 926  0009 be00          	ldw	x,c_y
 927  000b 89            	pushw	x
 930                     ; 291 	if (ZD_STATUS == 0)
 932  000c ae500f        	ldw	x,#20495
 933  000f cd0000        	call	_GPIO_ReadOutputData
 935  0012 a508          	bcp	a,#8
 936  0014 2704          	jreq	L23
 937  0016 acc800c8      	jpf	L123
 938  001a               L23:
 939                     ; 293 		sys.checkAcCnt = CHECK_AC_INPUT_CNT;
 941  001a ae07d0        	ldw	x,#2000
 942  001d bf0e          	ldw	_sys+14,x
 943                     ; 294 		sys.acErrFlag = FALSE;
 945  001f 3f10          	clr	_sys+16
 946                     ; 297 		if (!sys.gotHzFlag)
 948  0021 3d09          	tnz	_sys+9
 949  0023 262f          	jrne	L323
 950                     ; 299 			if (!sys.reqCalHzFlag)
 952  0025 3d08          	tnz	_sys+8
 953  0027 2609          	jrne	L523
 954                     ; 301 				TIM4_SetAutoreload(TIMER4_INT_TIME);				
 956  0029 a632          	ld	a,#50
 957  002b cd0000        	call	_TIM4_SetAutoreload
 959                     ; 302 				sys.reqCalHzFlag = TRUE;
 961  002e 35010008      	mov	_sys+8,#1
 962  0032               L523:
 963                     ; 304 			if (sys.calHzIntCnt == 0)
 965  0032 3d0b          	tnz	_sys+11
 966  0034 261a          	jrne	L723
 967                     ; 306 				if ((sys.hzCnt/GET_AC_FRE_CNT) >= HZ_COUNT)
 969  0036 be0c          	ldw	x,_sys+12
 970  0038 a60a          	ld	a,#10
 971  003a 62            	div	x,a
 972  003b a300b4        	cpw	x,#180
 973  003e 2506          	jrult	L133
 974                     ; 308 					sys.hz50Flag = TRUE;
 976  0040 3501000a      	mov	_sys+10,#1
 978  0044 2002          	jra	L333
 979  0046               L133:
 980                     ; 312 					sys.hz50Flag = FALSE;
 982  0046 3f0a          	clr	_sys+10
 983  0048               L333:
 984                     ; 315 				sys.gotHzFlag = TRUE;
 986  0048 35010009      	mov	_sys+9,#1
 987                     ; 316 				sys.reqCalHzFlag = FALSE;
 989  004c 3f08          	clr	_sys+8
 991  004e 2078          	jra	L123
 992  0050               L723:
 993                     ; 320 				sys.calHzIntCnt--;
 995  0050 3a0b          	dec	_sys+11
 996  0052 2074          	jra	L123
 997  0054               L323:
 998                     ; 325 			if (sys.light1.briVal == MAX_BRIGHTNESS)
1000  0054 b602          	ld	a,_sys+2
1001  0056 a1fa          	cp	a,#250
1002  0058 2615          	jrne	L143
1003                     ; 329 				L1_EN_ON;
1005  005a 4b10          	push	#16
1006  005c ae500a        	ldw	x,#20490
1007  005f cd0000        	call	_GPIO_WriteLow
1009  0062 84            	pop	a
1012  0063 35280001      	mov	_sys+1,#40
1013                     ; 330 				sys.light1.briCnt = 0;
1015  0067 3f00          	clr	_sys
1016                     ; 331 				sys.light1.onFlag = TRUE;			
1018  0069 35010003      	mov	_sys+3,#1
1020  006d 2011          	jra	L343
1021  006f               L143:
1022                     ; 336 				sys.light1.briCnt = MAX_BRIGHTNESS - sys.light1.briVal;				
1024  006f a6fa          	ld	a,#250
1025  0071 b002          	sub	a,_sys+2
1026  0073 b700          	ld	_sys,a
1027                     ; 337 				sys.light1.onFlag = FALSE;
1029  0075 3f03          	clr	_sys+3
1030                     ; 338 				L1_EN_OFF;
1032  0077 4b10          	push	#16
1033  0079 ae500a        	ldw	x,#20490
1034  007c cd0000        	call	_GPIO_WriteHigh
1036  007f 84            	pop	a
1037  0080               L343:
1038                     ; 341 			if (sys.light2.briVal == MAX_BRIGHTNESS)
1040  0080 b606          	ld	a,_sys+6
1041  0082 a1fa          	cp	a,#250
1042  0084 2615          	jrne	L543
1043                     ; 343 				L2_EN_ON;
1045  0086 4b08          	push	#8
1046  0088 ae500a        	ldw	x,#20490
1047  008b cd0000        	call	_GPIO_WriteLow
1049  008e 84            	pop	a
1052  008f 35280005      	mov	_sys+5,#40
1053                     ; 344 				sys.light2.briCnt = 0;
1055  0093 3f04          	clr	_sys+4
1056                     ; 345 				sys.light2.onFlag = TRUE;			
1058  0095 35010007      	mov	_sys+7,#1
1060  0099 2011          	jra	L743
1061  009b               L543:
1062                     ; 349 				sys.light2.briCnt = MAX_BRIGHTNESS - sys.light2.briVal;
1064  009b a6fa          	ld	a,#250
1065  009d b006          	sub	a,_sys+6
1066  009f b704          	ld	_sys+4,a
1067                     ; 350 				sys.light2.onFlag = FALSE;				
1069  00a1 3f07          	clr	_sys+7
1070                     ; 351 				L2_EN_OFF;
1072  00a3 4b08          	push	#8
1073  00a5 ae500a        	ldw	x,#20490
1074  00a8 cd0000        	call	_GPIO_WriteHigh
1076  00ab 84            	pop	a
1077  00ac               L743:
1078                     ; 354 			if (sys.light1.briCnt || sys.light2.briCnt)
1080  00ac 3d00          	tnz	_sys
1081  00ae 2604          	jrne	L353
1083  00b0 3d04          	tnz	_sys+4
1084  00b2 2714          	jreq	L123
1085  00b4               L353:
1086                     ; 357 				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
1088  00b4 3d0a          	tnz	_sys+10
1089  00b6 2705          	jreq	L62
1090  00b8 ae0028        	ldw	x,#40
1091  00bb 2003          	jra	L03
1092  00bd               L62:
1093  00bd ae0021        	ldw	x,#33
1094  00c0               L03:
1095  00c0 cd0000        	call	_TIM2_SetAutoreload
1097                     ; 358 				TIM2_Cmd(ENABLE);
1099  00c3 a601          	ld	a,#1
1100  00c5 cd0000        	call	_TIM2_Cmd
1102  00c8               L123:
1103                     ; 362 }
1106  00c8 85            	popw	x
1107  00c9 bf00          	ldw	c_y,x
1108  00cb 320002        	pop	c_y+2
1109  00ce 85            	popw	x
1110  00cf bf00          	ldw	c_x,x
1111  00d1 320002        	pop	c_x+2
1112  00d4 80            	iret
1138                     ; 382 static void TIMER4_Init(void)
1138                     ; 383 {    
1140                     .text:	section	.text,new
1141  0000               L31_TIMER4_Init:
1145                     ; 384     TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIMER4_INT_TIME);
1147  0000 ae0032        	ldw	x,#50
1148  0003 a604          	ld	a,#4
1149  0005 95            	ld	xh,a
1150  0006 cd0000        	call	_TIM4_TimeBaseInit
1152                     ; 385     TIM4_ClearFlag(TIM4_FLAG_UPDATE);
1154  0009 a601          	ld	a,#1
1155  000b cd0000        	call	_TIM4_ClearFlag
1157                     ; 386     TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);	
1159  000e ae0001        	ldw	x,#1
1160  0011 a601          	ld	a,#1
1161  0013 95            	ld	xh,a
1162  0014 cd0000        	call	_TIM4_ITConfig
1164                     ; 387     TIM4_Cmd(ENABLE);
1166  0017 a601          	ld	a,#1
1167  0019 cd0000        	call	_TIM4_Cmd
1169                     ; 388 }
1172  001c 81            	ret
1200                     ; 394 @far @interrupt void Timer4_ISR(void) {
1202                     .text:	section	.text,new
1203  0000               f_Timer4_ISR:
1206  0000 3b0002        	push	c_x+2
1207  0003 be00          	ldw	x,c_x
1208  0005 89            	pushw	x
1209  0006 3b0002        	push	c_y+2
1210  0009 be00          	ldw	x,c_y
1211  000b 89            	pushw	x
1214                     ; 396 TIM4_ClearITPendingBit(TIM4_IT_UPDATE);  
1216  000c a601          	ld	a,#1
1217  000e cd0000        	call	_TIM4_ClearITPendingBit
1219                     ; 397   if (sys.reqCalHzFlag)
1221  0011 3d08          	tnz	_sys+8
1222  0013 2707          	jreq	L573
1223                     ; 399 	  sys.hzCnt++; 	  
1225  0015 be0c          	ldw	x,_sys+12
1226  0017 1c0001        	addw	x,#1
1227  001a bf0c          	ldw	_sys+12,x
1228  001c               L573:
1229                     ; 402   if (sys.light1.triacTriggeTime)
1231  001c 3d01          	tnz	_sys+1
1232  001e 270f          	jreq	L773
1233                     ; 404 	  sys.light1.triacTriggeTime--;
1235  0020 3a01          	dec	_sys+1
1236                     ; 405 	  if (sys.light1.triacTriggeTime == 0)
1238  0022 3d01          	tnz	_sys+1
1239  0024 2609          	jrne	L773
1240                     ; 407 		  L1_EN_OFF;
1242  0026 4b10          	push	#16
1243  0028 ae500a        	ldw	x,#20490
1244  002b cd0000        	call	_GPIO_WriteHigh
1246  002e 84            	pop	a
1247  002f               L773:
1248                     ; 412   if (sys.light2.triacTriggeTime)
1250  002f 3d05          	tnz	_sys+5
1251  0031 270f          	jreq	L304
1252                     ; 414 	  sys.light2.triacTriggeTime--;
1254  0033 3a05          	dec	_sys+5
1255                     ; 415 	  if (sys.light2.triacTriggeTime == 0)
1257  0035 3d05          	tnz	_sys+5
1258  0037 2609          	jrne	L304
1259                     ; 417 		  L2_EN_OFF;
1261  0039 4b08          	push	#8
1262  003b ae500a        	ldw	x,#20490
1263  003e cd0000        	call	_GPIO_WriteHigh
1265  0041 84            	pop	a
1266  0042               L304:
1267                     ; 421   if (sys.checkAcCnt)
1269  0042 be0e          	ldw	x,_sys+14
1270  0044 2707          	jreq	L704
1271                     ; 423 		sys.checkAcCnt--;
1273  0046 be0e          	ldw	x,_sys+14
1274  0048 1d0001        	subw	x,#1
1275  004b bf0e          	ldw	_sys+14,x
1276  004d               L704:
1277                     ; 426   if (sys.cnt1s)
1279  004d be1b          	ldw	x,_sys+27
1280  004f 2707          	jreq	L114
1281                     ; 428 		sys.cnt1s--;
1283  0051 be1b          	ldw	x,_sys+27
1284  0053 1d0001        	subw	x,#1
1285  0056 bf1b          	ldw	_sys+27,x
1286  0058               L114:
1287                     ; 430 	Tick100ms++;
1289  0058 be02          	ldw	x,_Tick100ms
1290  005a 1c0001        	addw	x,#1
1291  005d bf02          	ldw	_Tick100ms,x
1292                     ; 431 	if(Tick100ms >= 2000){
1294  005f be02          	ldw	x,_Tick100ms
1295  0061 a307d0        	cpw	x,#2000
1296  0064 2507          	jrult	L314
1297                     ; 432 		Tick100ms = 0;
1299  0066 5f            	clrw	x
1300  0067 bf02          	ldw	_Tick100ms,x
1301                     ; 433 		f_100ms = 1;
1303  0069 35010001      	mov	_f_100ms,#1
1304  006d               L314:
1305                     ; 435 }
1308  006d 85            	popw	x
1309  006e bf00          	ldw	c_y,x
1310  0070 320002        	pop	c_y+2
1311  0073 85            	popw	x
1312  0074 bf00          	ldw	c_x,x
1313  0076 320002        	pop	c_x+2
1314  0079 80            	iret
1340                     ; 437 static void TIMER2_Init(void)
1340                     ; 438 {    
1342                     .text:	section	.text,new
1343  0000               L11_TIMER2_Init:
1347                     ; 439 	TIM2_TimeBaseInit(TIM2_PRESCALER_16, sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
1349  0000 3d0a          	tnz	_sys+10
1350  0002 2705          	jreq	L24
1351  0004 ae0028        	ldw	x,#40
1352  0007 2003          	jra	L44
1353  0009               L24:
1354  0009 ae0021        	ldw	x,#33
1355  000c               L44:
1356  000c 89            	pushw	x
1357  000d a604          	ld	a,#4
1358  000f cd0000        	call	_TIM2_TimeBaseInit
1360  0012 85            	popw	x
1361                     ; 440    	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
1363  0013 ae0001        	ldw	x,#1
1364  0016 cd0000        	call	_TIM2_ClearFlag
1366                     ; 441    	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	   
1368  0019 ae0001        	ldw	x,#1
1369  001c a601          	ld	a,#1
1370  001e 95            	ld	xh,a
1371  001f cd0000        	call	_TIM2_ITConfig
1373                     ; 442 }
1376  0022 81            	ret
1403                     ; 448 @far @interrupt void Timer2_ISR(void) {
1405                     .text:	section	.text,new
1406  0000               f_Timer2_ISR:
1409  0000 3b0002        	push	c_x+2
1410  0003 be00          	ldw	x,c_x
1411  0005 89            	pushw	x
1412  0006 3b0002        	push	c_y+2
1413  0009 be00          	ldw	x,c_y
1414  000b 89            	pushw	x
1417                     ; 450 	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);  
1419  000c a601          	ld	a,#1
1420  000e cd0000        	call	_TIM2_ClearITPendingBit
1422                     ; 451 	if (sys.light1.briCnt) 
1424  0011 3d00          	tnz	_sys
1425  0013 2702          	jreq	L534
1426                     ; 453 		sys.light1.briCnt--;			
1428  0015 3a00          	dec	_sys
1429  0017               L534:
1430                     ; 455 	if (sys.light1.briCnt == 0 && !sys.light1.onFlag)
1432  0017 3d00          	tnz	_sys
1433  0019 2615          	jrne	L734
1435  001b 3d03          	tnz	_sys+3
1436  001d 2611          	jrne	L734
1437                     ; 457 		L1_EN_ON;
1439  001f 4b10          	push	#16
1440  0021 ae500a        	ldw	x,#20490
1441  0024 cd0000        	call	_GPIO_WriteLow
1443  0027 84            	pop	a
1446  0028 35280001      	mov	_sys+1,#40
1447                     ; 458 		sys.light1.onFlag = TRUE;
1449  002c 35010003      	mov	_sys+3,#1
1450  0030               L734:
1451                     ; 462 	if (sys.light2.briCnt) 
1453  0030 3d04          	tnz	_sys+4
1454  0032 2702          	jreq	L144
1455                     ; 464 		sys.light2.briCnt--;		
1457  0034 3a04          	dec	_sys+4
1458  0036               L144:
1459                     ; 466 	if (sys.light2.briCnt == 0 && !sys.light2.onFlag)
1461  0036 3d04          	tnz	_sys+4
1462  0038 2615          	jrne	L344
1464  003a 3d07          	tnz	_sys+7
1465  003c 2611          	jrne	L344
1466                     ; 468 		L2_EN_ON;
1468  003e 4b08          	push	#8
1469  0040 ae500a        	ldw	x,#20490
1470  0043 cd0000        	call	_GPIO_WriteLow
1472  0046 84            	pop	a
1475  0047 35280005      	mov	_sys+5,#40
1476                     ; 469 		sys.light2.onFlag = TRUE;
1478  004b 35010007      	mov	_sys+7,#1
1479  004f               L344:
1480                     ; 472 	if ((sys.light1.briCnt ||  sys.light2.briCnt) == 0)
1482  004f 3d00          	tnz	_sys
1483  0051 2604          	jrne	L25
1484  0053 3d04          	tnz	_sys+4
1485  0055 2705          	jreq	L05
1486  0057               L25:
1487  0057 ae0001        	ldw	x,#1
1488  005a 2001          	jra	L45
1489  005c               L05:
1490  005c 5f            	clrw	x
1491  005d               L45:
1492  005d a30000        	cpw	x,#0
1493  0060 2604          	jrne	L544
1494                     ; 474 		TIM2_Cmd(DISABLE);
1496  0062 4f            	clr	a
1497  0063 cd0000        	call	_TIM2_Cmd
1499  0066               L544:
1500                     ; 476 }
1503  0066 85            	popw	x
1504  0067 bf00          	ldw	c_y,x
1505  0069 320002        	pop	c_y+2
1506  006c 85            	popw	x
1507  006d bf00          	ldw	c_x,x
1508  006f 320002        	pop	c_x+2
1509  0072 80            	iret
1783                     	xdef	_main
1784                     	xdef	_delay
1785                     	switch	.ubsct
1786  0000               _tick1s:
1787  0000 00            	ds.b	1
1788                     	xdef	_tick1s
1789  0001               _f_100ms:
1790  0001 00            	ds.b	1
1791                     	xdef	_f_100ms
1792  0002               _Tick100ms:
1793  0002 0000          	ds.b	2
1794                     	xdef	_Tick100ms
1795                     	xref.b	_down
1796                     	xref.b	_up
1797                     	xref.b	_change_step
1798                     	xref.b	_aim_bright
1799                     	xref.b	_channel
1800  0004               _last_bright:
1801  0004 00            	ds.b	1
1802                     	xdef	_last_bright
1803                     	xref.b	_ReceiveState
1804                     	xref.b	_GetDataIndex
1805                     	xref.b	_IIC_RxBuffer
1806                     	xref.b	_slave_address
1807                     	xref.b	_slc
1808                     	xref	_UART_Init
1809                     	xref	_printf
1810                     	xref	_IIC_SlaveConfig
1811                     	xdef	f_Timer4_ISR
1812                     	xdef	f_Timer2_ISR
1813                     	xdef	f_Ext_PortD_ISR
1814                     	xdef	_sys
1815                     	xdef	_assert_failed
1816                     	xref	_TIM4_ClearITPendingBit
1817                     	xref	_TIM4_ClearFlag
1818                     	xref	_TIM4_SetAutoreload
1819                     	xref	_TIM4_ITConfig
1820                     	xref	_TIM4_Cmd
1821                     	xref	_TIM4_TimeBaseInit
1822                     	xref	_TIM2_ClearITPendingBit
1823                     	xref	_TIM2_ClearFlag
1824                     	xref	_TIM2_SetAutoreload
1825                     	xref	_TIM2_ITConfig
1826                     	xref	_TIM2_Cmd
1827                     	xref	_TIM2_TimeBaseInit
1828                     	xref	_GPIO_ReadOutputData
1829                     	xref	_GPIO_ReadInputData
1830                     	xref	_GPIO_WriteLow
1831                     	xref	_GPIO_WriteHigh
1832                     	xref	_GPIO_Init
1833                     	xref	_EXTI_SetExtIntSensitivity
1834                     	xref	_EXTI_DeInit
1835                     	xref	_CLK_PeripheralClockConfig
1836                     .const:	section	.text
1837  0000               L522:
1838  0000 736c632e6368  	dc.b	"slc.ch1_status = %"
1839  0012 3032582c2073  	dc.b	"02X, slc.ch2_statu"
1840  0024 73203d202530  	dc.b	"s = %02X",10,0
1841  002e               L322:
1842  002e 6c6173745f62  	dc.b	"last_bright = %02X"
1843  0040 2c2061696d5f  	dc.b	", aim_bright = %02"
1844  0052 580a00        	dc.b	"X",10,0
1845  0055               L371:
1846  0055 0a00          	dc.b	10,0
1847  0057               L171:
1848  0057 253032582000  	dc.b	"%02X ",0
1849  005d               L131:
1850  005d 48656c6c6f20  	dc.b	"Hello World!",10,0
1851                     	xref.b	c_x
1852                     	xref.b	c_y
1872                     	end
