   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               _GetDataIndex:
   6  0000 00            	dc.b	0
   7  0001               _ReceiveState:
   8  0001 00            	dc.b	0
   9  0002               _SendDataIndex:
  10  0002 00            	dc.b	0
  91                     ; 37 void mymemcpy(void *des,void *src,u32 n)  
  91                     ; 38 {  
  93                     .text:	section	.text,new
  94  0000               _mymemcpy:
  96  0000 89            	pushw	x
  97  0001 5204          	subw	sp,#4
  98       00000004      OFST:	set	4
 101                     ; 39   u8 *xdes=des;
 103  0003 1f01          	ldw	(OFST-3,sp),x
 104                     ; 40 	u8 *xsrc=src; 
 106  0005 1e09          	ldw	x,(OFST+5,sp)
 107  0007 1f03          	ldw	(OFST-1,sp),x
 109  0009 2016          	jra	L35
 110  000b               L74:
 111                     ; 41   while(n--)*xdes++=*xsrc++;  
 113  000b 1e03          	ldw	x,(OFST-1,sp)
 114  000d 1c0001        	addw	x,#1
 115  0010 1f03          	ldw	(OFST-1,sp),x
 116  0012 1d0001        	subw	x,#1
 117  0015 f6            	ld	a,(x)
 118  0016 1e01          	ldw	x,(OFST-3,sp)
 119  0018 1c0001        	addw	x,#1
 120  001b 1f01          	ldw	(OFST-3,sp),x
 121  001d 1d0001        	subw	x,#1
 122  0020 f7            	ld	(x),a
 123  0021               L35:
 126  0021 96            	ldw	x,sp
 127  0022 1c000b        	addw	x,#OFST+7
 128  0025 cd0000        	call	c_ltor
 130  0028 96            	ldw	x,sp
 131  0029 1c000b        	addw	x,#OFST+7
 132  002c a601          	ld	a,#1
 133  002e cd0000        	call	c_lgsbc
 135  0031 cd0000        	call	c_lrzmp
 137  0034 26d5          	jrne	L74
 138                     ; 42 }  
 141  0036 5b06          	addw	sp,#6
 142  0038 81            	ret
 204                     ; 48 u8 Check_Sum(u8 *buf,u8 length)
 204                     ; 49 {
 205                     .text:	section	.text,new
 206  0000               _Check_Sum:
 208  0000 89            	pushw	x
 209  0001 89            	pushw	x
 210       00000002      OFST:	set	2
 213                     ; 51 	u8 result = *buf++;
 215  0002 1e03          	ldw	x,(OFST+1,sp)
 216  0004 1c0001        	addw	x,#1
 217  0007 1f03          	ldw	(OFST+1,sp),x
 218  0009 1d0001        	subw	x,#1
 219  000c f6            	ld	a,(x)
 220  000d 6b01          	ld	(OFST-1,sp),a
 221                     ; 52 	for(i = 1;i < length;i++)
 223  000f a601          	ld	a,#1
 224  0011 6b02          	ld	(OFST+0,sp),a
 226  0013 2011          	jra	L511
 227  0015               L111:
 228                     ; 54 		result ^= *buf++;
 230  0015 1e03          	ldw	x,(OFST+1,sp)
 231  0017 1c0001        	addw	x,#1
 232  001a 1f03          	ldw	(OFST+1,sp),x
 233  001c 1d0001        	subw	x,#1
 234  001f 7b01          	ld	a,(OFST-1,sp)
 235  0021 f8            	xor	a,	(x)
 236  0022 6b01          	ld	(OFST-1,sp),a
 237                     ; 52 	for(i = 1;i < length;i++)
 239  0024 0c02          	inc	(OFST+0,sp)
 240  0026               L511:
 243  0026 7b02          	ld	a,(OFST+0,sp)
 244  0028 1107          	cp	a,(OFST+5,sp)
 245  002a 25e9          	jrult	L111
 246                     ; 56 	return result;
 248  002c 7b01          	ld	a,(OFST-1,sp)
 251  002e 5b04          	addw	sp,#4
 252  0030 81            	ret
 339                     ; 60 u8 i2c_init_message(I2C_Message *tx,u8 payload_len)
 339                     ; 61 {
 340                     .text:	section	.text,new
 341  0000               _i2c_init_message:
 343  0000 89            	pushw	x
 344       00000000      OFST:	set	0
 347                     ; 62 	IIC_TxBuffer[0] = tx->frame_h1;
 349  0001 f6            	ld	a,(x)
 350  0002 b716          	ld	_IIC_TxBuffer,a
 351                     ; 63 	IIC_TxBuffer[1] = tx->frame_h2;
 353  0004 e601          	ld	a,(1,x)
 354  0006 b717          	ld	_IIC_TxBuffer+1,a
 355                     ; 64 	IIC_TxBuffer[2] = tx->message_id;
 357  0008 e602          	ld	a,(2,x)
 358  000a b718          	ld	_IIC_TxBuffer+2,a
 359                     ; 65 	IIC_TxBuffer[3] = 2+payload_len;
 361  000c 7b05          	ld	a,(OFST+5,sp)
 362  000e ab02          	add	a,#2
 363  0010 b719          	ld	_IIC_TxBuffer+3,a
 364                     ; 66 	mymemcpy(&IIC_TxBuffer[4],tx->payload,payload_len);
 366  0012 7b05          	ld	a,(OFST+5,sp)
 367  0014 b703          	ld	c_lreg+3,a
 368  0016 3f02          	clr	c_lreg+2
 369  0018 3f01          	clr	c_lreg+1
 370  001a 3f00          	clr	c_lreg
 371  001c be02          	ldw	x,c_lreg+2
 372  001e 89            	pushw	x
 373  001f be00          	ldw	x,c_lreg
 374  0021 89            	pushw	x
 375  0022 1e05          	ldw	x,(OFST+5,sp)
 376  0024 1c0003        	addw	x,#3
 377  0027 89            	pushw	x
 378  0028 ae001a        	ldw	x,#_IIC_TxBuffer+4
 379  002b cd0000        	call	_mymemcpy
 381  002e 5b06          	addw	sp,#6
 382                     ; 67 	IIC_TxBuffer[4+payload_len] = Check_Sum(&IIC_TxBuffer[2],IIC_TxBuffer[3]);
 384  0030 7b05          	ld	a,(OFST+5,sp)
 385  0032 5f            	clrw	x
 386  0033 97            	ld	xl,a
 387  0034 89            	pushw	x
 388  0035 3b0019        	push	_IIC_TxBuffer+3
 389  0038 ae0018        	ldw	x,#_IIC_TxBuffer+2
 390  003b cd0000        	call	_Check_Sum
 392  003e 5b01          	addw	sp,#1
 393  0040 85            	popw	x
 394  0041 e71a          	ld	(_IIC_TxBuffer+4,x),a
 395                     ; 69 }
 398  0043 85            	popw	x
 399  0044 81            	ret
 423                     ; 71 	void I2C_receive_begin(void)
 423                     ; 72 	{
 424                     .text:	section	.text,new
 425  0000               _I2C_receive_begin:
 429                     ; 73 		ReceiveState = IIC_STATE_BEGIN;
 431  0000 35010001      	mov	_ReceiveState,#1
 432                     ; 74 	}
 435  0004 81            	ret
 489                     ; 76 	void I2C_transaction_begin(void)
 489                     ; 77 	{
 490                     .text:	section	.text,new
 491  0000               _I2C_transaction_begin:
 493  0000 5205          	subw	sp,#5
 494       00000005      OFST:	set	5
 497                     ; 80 		SendDataIndex = 0;
 499  0002 3f02          	clr	_SendDataIndex
 500                     ; 81 		cmd = IIC_RxBuffer[4];
 502  0004 b63a          	ld	a,_IIC_RxBuffer+4
 503  0006 6b05          	ld	(OFST+0,sp),a
 504                     ; 85 			switch(cmd){
 506  0008 7b05          	ld	a,(OFST+0,sp)
 508                     ; 134 				default:
 508                     ; 135 				break;
 509  000a a003          	sub	a,#3
 510  000c 272b          	jreq	L571
 511  000e a04e          	sub	a,#78
 512  0010 2752          	jreq	L771
 513  0012 4a            	dec	a
 514  0013 274f          	jreq	L771
 515  0015 4a            	dec	a
 516  0016 274c          	jreq	L771
 517  0018 4a            	dec	a
 518  0019 2749          	jreq	L771
 519  001b a005          	sub	a,#5
 520  001d 2603          	jrne	L61
 521  001f cc0187        	jp	L102
 522  0022               L61:
 523  0022 a0a5          	sub	a,#165
 524  0024 2703          	jreq	L02
 525  0026 cc0190        	jp	L522
 526  0029               L02:
 527                     ; 86 				case 0xFE:
 527                     ; 87 					if(IIC_RxBuffer[5] == 0x01)	init_device_info();
 529  0029 b63b          	ld	a,_IIC_RxBuffer+5
 530  002b a101          	cp	a,#1
 531  002d 2703          	jreq	L22
 532  002f cc0190        	jp	L522
 533  0032               L22:
 536  0032 cd0000        	call	_init_device_info
 538  0035 ac900190      	jpf	L522
 539  0039               L571:
 540                     ; 89 				case 0x03:
 540                     ; 90 					if((IIC_RxBuffer[5] == 0x03)&&(IIC_RxBuffer[6] == slave_address)){
 542  0039 b63b          	ld	a,_IIC_RxBuffer+5
 543  003b a103          	cp	a,#3
 544  003d 2703          	jreq	L42
 545  003f cc0190        	jp	L522
 546  0042               L42:
 548  0042 b63c          	ld	a,_IIC_RxBuffer+6
 549  0044 b157          	cp	a,_slave_address
 550  0046 2703          	jreq	L62
 551  0048 cc0190        	jp	L522
 552  004b               L62:
 553                     ; 92 						if(Check_Sum(&IIC_RxBuffer[2],IIC_RxBuffer[3]) == IIC_RxBuffer[7]){
 555  004b 3b0039        	push	_IIC_RxBuffer+3
 556  004e ae0038        	ldw	x,#_IIC_RxBuffer+2
 557  0051 cd0000        	call	_Check_Sum
 559  0054 5b01          	addw	sp,#1
 560  0056 b13d          	cp	a,_IIC_RxBuffer+7
 561  0058 2703          	jreq	L03
 562  005a cc0190        	jp	L522
 563  005d               L03:
 564                     ; 93 							rev_heart_breat();
 566  005d cd0000        	call	_rev_heart_breat
 568  0060 ac900190      	jpf	L522
 569  0064               L771:
 570                     ; 97 				case 0x51://Linear
 570                     ; 98 				case 0x52://Erase in
 570                     ; 99 				case 0x53://Erase out
 570                     ; 100 				case 0x54://Swing
 570                     ; 101 					if(((IIC_RxBuffer[5]&0xf0)>>4) == slave_address){
 572  0064 b63b          	ld	a,_IIC_RxBuffer+5
 573  0066 a4f0          	and	a,#240
 574  0068 4e            	swap	a
 575  0069 a40f          	and	a,#15
 576  006b 5f            	clrw	x
 577  006c 97            	ld	xl,a
 578  006d b657          	ld	a,_slave_address
 579  006f 905f          	clrw	y
 580  0071 9097          	ld	yl,a
 581  0073 90bf01        	ldw	c_y+1,y
 582  0076 b301          	cpw	x,c_y+1
 583  0078 2703          	jreq	L23
 584  007a cc0190        	jp	L522
 585  007d               L23:
 586                     ; 103 						channel = (IIC_RxBuffer[5]&0x0f);
 588  007d b63b          	ld	a,_IIC_RxBuffer+5
 589  007f a40f          	and	a,#15
 590  0081 b715          	ld	_channel,a
 591                     ; 104 						change_time = IIC_RxBuffer[7];
 593  0083 453d0c        	mov	_change_time,_IIC_RxBuffer+7
 594                     ; 105 						if((channel & 0x01) == 0x01)
 596  0086 b615          	ld	a,_channel
 597  0088 a401          	and	a,#1
 598  008a a101          	cp	a,#1
 599  008c 2676          	jrne	L732
 600                     ; 107 							if(IIC_RxBuffer[4] == 0x51)	{linear1_begin = 1;}
 602  008e b63a          	ld	a,_IIC_RxBuffer+4
 603  0090 a151          	cp	a,#81
 604  0092 2606          	jrne	L142
 607  0094 72100003      	bset	_action_flag,#0
 609  0098 2030          	jra	L342
 610  009a               L142:
 611                     ; 109 							else if((IIC_RxBuffer[4] == 0x52)&& ((realtime_bright1 == 0) || (realtime_bright1 == 1)))	{action_flag._flag_byte |= 0x04;}
 613  009a b63a          	ld	a,_IIC_RxBuffer+4
 614  009c a152          	cp	a,#82
 615  009e 2610          	jrne	L542
 617  00a0 3d00          	tnz	_realtime_bright1
 618  00a2 2706          	jreq	L742
 620  00a4 b600          	ld	a,_realtime_bright1
 621  00a6 a101          	cp	a,#1
 622  00a8 2606          	jrne	L542
 623  00aa               L742:
 626  00aa 72140003      	bset	_action_flag,#2
 628  00ae 201a          	jra	L342
 629  00b0               L542:
 630                     ; 111 							else if((IIC_RxBuffer[4] == 0x53)&& (IIC_RxBuffer[6]== 0)){action_flag._flag_byte |= 0x10;}
 632  00b0 b63a          	ld	a,_IIC_RxBuffer+4
 633  00b2 a153          	cp	a,#83
 634  00b4 260a          	jrne	L352
 636  00b6 3d3c          	tnz	_IIC_RxBuffer+6
 637  00b8 2606          	jrne	L352
 640  00ba 72180003      	bset	_action_flag,#4
 642  00be 200a          	jra	L342
 643  00c0               L352:
 644                     ; 112 							else if(IIC_RxBuffer[4] == 0x54)	{action_flag._flag_byte |= 0x40;}
 646  00c0 b63a          	ld	a,_IIC_RxBuffer+4
 647  00c2 a154          	cp	a,#84
 648  00c4 2604          	jrne	L342
 651  00c6 721c0003      	bset	_action_flag,#6
 652  00ca               L342:
 653                     ; 113 							aim_bright1 = ((float)IIC_RxBuffer[6]) / 100;
 655  00ca b63c          	ld	a,_IIC_RxBuffer+6
 656  00cc 5f            	clrw	x
 657  00cd 97            	ld	xl,a
 658  00ce cd0000        	call	c_itof
 660  00d1 ae0000        	ldw	x,#L562
 661  00d4 cd0000        	call	c_fdiv
 663  00d7 ae0011        	ldw	x,#_aim_bright1
 664  00da cd0000        	call	c_rtol
 666                     ; 114 							change_step1 = (aim_bright1 - last_bright1)/change_time;//change_step1可正可负
 668  00dd b60c          	ld	a,_change_time
 669  00df 5f            	clrw	x
 670  00e0 97            	ld	xl,a
 671  00e1 cd0000        	call	c_itof
 673  00e4 96            	ldw	x,sp
 674  00e5 1c0001        	addw	x,#OFST-4
 675  00e8 cd0000        	call	c_rtol
 677  00eb ae0011        	ldw	x,#_aim_bright1
 678  00ee cd0000        	call	c_ltor
 680  00f1 ae0000        	ldw	x,#_last_bright1
 681  00f4 cd0000        	call	c_fsub
 683  00f7 96            	ldw	x,sp
 684  00f8 1c0001        	addw	x,#OFST-4
 685  00fb cd0000        	call	c_fdiv
 687  00fe ae0008        	ldw	x,#_change_step1
 688  0101 cd0000        	call	c_rtol
 690  0104               L732:
 691                     ; 117 						if((channel & 0x02) == 0x02)
 693  0104 b615          	ld	a,_channel
 694  0106 a402          	and	a,#2
 695  0108 a102          	cp	a,#2
 696  010a 2676          	jrne	L172
 697                     ; 119 							if(IIC_RxBuffer[4] == 0x51)	{linear2_begin = 1;}
 699  010c b63a          	ld	a,_IIC_RxBuffer+4
 700  010e a151          	cp	a,#81
 701  0110 2606          	jrne	L372
 704  0112 72120003      	bset	_action_flag,#1
 706  0116 2030          	jra	L572
 707  0118               L372:
 708                     ; 120 							else if((IIC_RxBuffer[4] == 0x52)&& ((realtime_bright2 == 0) || (realtime_bright2 == 1)))	{action_flag._flag_byte |= 0x08;}
 710  0118 b63a          	ld	a,_IIC_RxBuffer+4
 711  011a a152          	cp	a,#82
 712  011c 2610          	jrne	L772
 714  011e 3d00          	tnz	_realtime_bright2
 715  0120 2706          	jreq	L103
 717  0122 b600          	ld	a,_realtime_bright2
 718  0124 a101          	cp	a,#1
 719  0126 2606          	jrne	L772
 720  0128               L103:
 723  0128 72160003      	bset	_action_flag,#3
 725  012c 201a          	jra	L572
 726  012e               L772:
 727                     ; 121 							else if((IIC_RxBuffer[4] == 0x53)&& (IIC_RxBuffer[6]==0)){action_flag._flag_byte |= 0x20;}
 729  012e b63a          	ld	a,_IIC_RxBuffer+4
 730  0130 a153          	cp	a,#83
 731  0132 260a          	jrne	L503
 733  0134 3d3c          	tnz	_IIC_RxBuffer+6
 734  0136 2606          	jrne	L503
 737  0138 721a0003      	bset	_action_flag,#5
 739  013c 200a          	jra	L572
 740  013e               L503:
 741                     ; 122 							else if(IIC_RxBuffer[4] == 0x54)	{action_flag._flag_byte |= 0x80;}
 743  013e b63a          	ld	a,_IIC_RxBuffer+4
 744  0140 a154          	cp	a,#84
 745  0142 2604          	jrne	L572
 748  0144 721e0003      	bset	_action_flag,#7
 749  0148               L572:
 750                     ; 123 							aim_bright2 = ((float)IIC_RxBuffer[6]) / 100;
 752  0148 b63c          	ld	a,_IIC_RxBuffer+6
 753  014a 5f            	clrw	x
 754  014b 97            	ld	xl,a
 755  014c cd0000        	call	c_itof
 757  014f ae0000        	ldw	x,#L562
 758  0152 cd0000        	call	c_fdiv
 760  0155 ae000d        	ldw	x,#_aim_bright2
 761  0158 cd0000        	call	c_rtol
 763                     ; 124 							change_step2 = (aim_bright2 - last_bright2)/change_time;
 765  015b b60c          	ld	a,_change_time
 766  015d 5f            	clrw	x
 767  015e 97            	ld	xl,a
 768  015f cd0000        	call	c_itof
 770  0162 96            	ldw	x,sp
 771  0163 1c0001        	addw	x,#OFST-4
 772  0166 cd0000        	call	c_rtol
 774  0169 ae000d        	ldw	x,#_aim_bright2
 775  016c cd0000        	call	c_ltor
 777  016f ae0000        	ldw	x,#_last_bright2
 778  0172 cd0000        	call	c_fsub
 780  0175 96            	ldw	x,sp
 781  0176 1c0001        	addw	x,#OFST-4
 782  0179 cd0000        	call	c_fdiv
 784  017c ae0004        	ldw	x,#_change_step2
 785  017f cd0000        	call	c_rtol
 787  0182               L172:
 788                     ; 126 						rev_action_dimmer_OK();
 790  0182 cd0000        	call	_rev_action_dimmer_OK
 792  0185 2009          	jra	L522
 793  0187               L102:
 794                     ; 129 				case 0x59://调光时间结束后SC发送查询ch状态
 794                     ; 130 					if(IIC_RxBuffer[5] == slave_address){//查询action dimmer执行后SLC状态
 796  0187 b63b          	ld	a,_IIC_RxBuffer+5
 797  0189 b157          	cp	a,_slave_address
 798  018b 2603          	jrne	L522
 799                     ; 131 						rev_action_dimmer_done();
 801  018d cd0000        	call	_rev_action_dimmer_done
 803  0190               L302:
 804                     ; 134 				default:
 804                     ; 135 				break;
 806  0190               L522:
 807                     ; 139 	}
 810  0190 5b05          	addw	sp,#5
 811  0192 81            	ret
 849                     ; 141 	void init_device_info(void)
 849                     ; 142 	{
 850                     .text:	section	.text,new
 851  0000               _init_device_info:
 853  0000 5221          	subw	sp,#33
 854       00000021      OFST:	set	33
 857                     ; 144 		di.frame_h1 = 0x7E;
 859  0002 a67e          	ld	a,#126
 860  0004 6b01          	ld	(OFST-32,sp),a
 861                     ; 145 		di.frame_h2 = 0x7E;
 863  0006 a67e          	ld	a,#126
 864  0008 6b02          	ld	(OFST-31,sp),a
 865                     ; 146 		di.message_id = IIC_RxBuffer[2];
 867  000a b638          	ld	a,_IIC_RxBuffer+2
 868  000c 6b03          	ld	(OFST-30,sp),a
 869                     ; 147 		di.payload[0] = 0xB2;
 871  000e a6b2          	ld	a,#178
 872  0010 6b04          	ld	(OFST-29,sp),a
 873                     ; 148 		di.payload[1] = 0xAA;
 875  0012 a6aa          	ld	a,#170
 876  0014 6b05          	ld	(OFST-28,sp),a
 877                     ; 149 		di.payload[2] = 0x55;
 879  0016 a655          	ld	a,#85
 880  0018 6b06          	ld	(OFST-27,sp),a
 881                     ; 150 		di.payload[3] = 0xAB;
 883  001a a6ab          	ld	a,#171
 884  001c 6b07          	ld	(OFST-26,sp),a
 885                     ; 151 		di.payload[4] = 0x57;
 887  001e a657          	ld	a,#87
 888  0020 6b08          	ld	(OFST-25,sp),a
 889                     ; 152 		di.payload[5] = 0x63;
 891  0022 a663          	ld	a,#99
 892  0024 6b09          	ld	(OFST-24,sp),a
 893                     ; 153 		di.payload[6] = 0x00;
 895  0026 0f0a          	clr	(OFST-23,sp)
 896                     ; 154 		di.payload[7] = 0xc0;
 898  0028 a6c0          	ld	a,#192
 899  002a 6b0b          	ld	(OFST-22,sp),a
 900                     ; 155 		di.payload[8] = slave_address;
 902  002c b657          	ld	a,_slave_address
 903  002e 6b0c          	ld	(OFST-21,sp),a
 904                     ; 156 		i2c_init_message(&di,9);
 906  0030 4b09          	push	#9
 907  0032 96            	ldw	x,sp
 908  0033 1c0002        	addw	x,#OFST-31
 909  0036 cd0000        	call	_i2c_init_message
 911  0039 84            	pop	a
 912                     ; 157 	}
 915  003a 5b21          	addw	sp,#33
 916  003c 81            	ret
 954                     ; 159 	void rev_heart_breat(void)
 954                     ; 160 	{
 955                     .text:	section	.text,new
 956  0000               _rev_heart_breat:
 958  0000 5221          	subw	sp,#33
 959       00000021      OFST:	set	33
 962                     ; 162 		hb.frame_h1 = 0x7E;
 964  0002 a67e          	ld	a,#126
 965  0004 6b01          	ld	(OFST-32,sp),a
 966                     ; 163 		hb.frame_h2 = 0x7E;
 968  0006 a67e          	ld	a,#126
 969  0008 6b02          	ld	(OFST-31,sp),a
 970                     ; 164 		hb.message_id = IIC_RxBuffer[2];
 972  000a b638          	ld	a,_IIC_RxBuffer+2
 973  000c 6b03          	ld	(OFST-30,sp),a
 974                     ; 165 		hb.payload[0] = 0x06;
 976  000e a606          	ld	a,#6
 977  0010 6b04          	ld	(OFST-29,sp),a
 978                     ; 166 		hb.payload[1] = slc.MDID;
 980  0012 b66c          	ld	a,_slc+20
 981  0014 6b05          	ld	(OFST-28,sp),a
 982                     ; 167 		hb.payload[2] = slc.ch1_status;
 984  0016 b66d          	ld	a,_slc+21
 985  0018 6b06          	ld	(OFST-27,sp),a
 986                     ; 168 		hb.payload[3] = slc.ch2_status;
 988  001a b66e          	ld	a,_slc+22
 989  001c 6b07          	ld	(OFST-26,sp),a
 990                     ; 169 		hb.payload[4] = slc.ch3_status;
 992  001e b66f          	ld	a,_slc+23
 993  0020 6b08          	ld	(OFST-25,sp),a
 994                     ; 170 		hb.payload[5] = slc.ch4_status;
 996  0022 b670          	ld	a,_slc+24
 997  0024 6b09          	ld	(OFST-24,sp),a
 998                     ; 171 		i2c_init_message(&hb,6);
1000  0026 4b06          	push	#6
1001  0028 96            	ldw	x,sp
1002  0029 1c0002        	addw	x,#OFST-31
1003  002c cd0000        	call	_i2c_init_message
1005  002f 84            	pop	a
1006                     ; 172 	}
1009  0030 5b21          	addw	sp,#33
1010  0032 81            	ret
1049                     ; 174 	void rev_action_dimmer_OK(void)
1049                     ; 175 	{
1050                     .text:	section	.text,new
1051  0000               _rev_action_dimmer_OK:
1053  0000 5221          	subw	sp,#33
1054       00000021      OFST:	set	33
1057                     ; 177 		ad.frame_h1 = 0x7E;
1059  0002 a67e          	ld	a,#126
1060  0004 6b01          	ld	(OFST-32,sp),a
1061                     ; 178 		ad.frame_h2 = 0x7E;
1063  0006 a67e          	ld	a,#126
1064  0008 6b02          	ld	(OFST-31,sp),a
1065                     ; 179 		ad.message_id = IIC_RxBuffer[2];
1067  000a b638          	ld	a,_IIC_RxBuffer+2
1068  000c 6b03          	ld	(OFST-30,sp),a
1069                     ; 180 		ad.payload[0] = 0xAA;
1071  000e a6aa          	ld	a,#170
1072  0010 6b04          	ld	(OFST-29,sp),a
1073                     ; 181 		ad.payload[1] = 0x02;
1075  0012 a602          	ld	a,#2
1076  0014 6b05          	ld	(OFST-28,sp),a
1077                     ; 182 		ad.payload[2] = slc.MDID;
1079  0016 b66c          	ld	a,_slc+20
1080  0018 6b06          	ld	(OFST-27,sp),a
1081                     ; 183 		i2c_init_message(&ad,3);
1083  001a 4b03          	push	#3
1084  001c 96            	ldw	x,sp
1085  001d 1c0002        	addw	x,#OFST-31
1086  0020 cd0000        	call	_i2c_init_message
1088  0023 84            	pop	a
1089                     ; 184 	}
1092  0024 5b21          	addw	sp,#33
1093  0026 81            	ret
1131                     ; 187 	void rev_action_dimmer_done(void)
1131                     ; 188 	{
1132                     .text:	section	.text,new
1133  0000               _rev_action_dimmer_done:
1135  0000 5221          	subw	sp,#33
1136       00000021      OFST:	set	33
1139                     ; 190 		ad.frame_h1 = 0x7E;
1141  0002 a67e          	ld	a,#126
1142  0004 6b01          	ld	(OFST-32,sp),a
1143                     ; 191 		ad.frame_h2 = 0x7E;
1145  0006 a67e          	ld	a,#126
1146  0008 6b02          	ld	(OFST-31,sp),a
1147                     ; 192 		ad.message_id = 66;
1149  000a a642          	ld	a,#66
1150  000c 6b03          	ld	(OFST-30,sp),a
1151                     ; 193 		ad.payload[0] = 0xAA;
1153  000e a6aa          	ld	a,#170
1154  0010 6b04          	ld	(OFST-29,sp),a
1155                     ; 194 		ad.payload[1] = 0x05;
1157  0012 a605          	ld	a,#5
1158  0014 6b05          	ld	(OFST-28,sp),a
1159                     ; 195 		ad.payload[2] = slc.MDID;
1161  0016 b66c          	ld	a,_slc+20
1162  0018 6b06          	ld	(OFST-27,sp),a
1163                     ; 196 		ad.payload[3] = slc.ch1_status;
1165  001a b66d          	ld	a,_slc+21
1166  001c 6b07          	ld	(OFST-26,sp),a
1167                     ; 197 		ad.payload[4] = slc.ch2_status;
1169  001e b66e          	ld	a,_slc+22
1170  0020 6b08          	ld	(OFST-25,sp),a
1171                     ; 198 		ad.payload[5] = slc.ch3_status;
1173  0022 b66f          	ld	a,_slc+23
1174  0024 6b09          	ld	(OFST-24,sp),a
1175                     ; 199 		ad.payload[6] = slc.ch4_status;
1177  0026 b670          	ld	a,_slc+24
1178  0028 6b0a          	ld	(OFST-23,sp),a
1179                     ; 200 		i2c_init_message(&ad,7);
1181  002a 4b07          	push	#7
1182  002c 96            	ldw	x,sp
1183  002d 1c0002        	addw	x,#OFST-31
1184  0030 cd0000        	call	_i2c_init_message
1186  0033 84            	pop	a
1187                     ; 201 	}
1190  0034 5b21          	addw	sp,#33
1191  0036 81            	ret
1216                     ; 205 	void I2C_transaction_end(void)
1216                     ; 206 	{
1217                     .text:	section	.text,new
1218  0000               _I2C_transaction_end:
1222                     ; 207 		ReceiveState = IIC_STATE_END;
1224  0000 35030001      	mov	_ReceiveState,#3
1225                     ; 210 	}	
1228  0004 81            	ret
1253                     ; 212 	void I2C_transaction_receive(void)
1253                     ; 213 	{
1254                     .text:	section	.text,new
1255  0000               _I2C_transaction_receive:
1259                     ; 214 		ReceiveState = IIC_STATE_RECEIVEING;
1261  0000 35020001      	mov	_ReceiveState,#2
1262                     ; 215 	}
1265  0004 81            	ret
1302                     ; 217 	void I2C_byte_received(uint8_t RxData)
1302                     ; 218 	{
1303                     .text:	section	.text,new
1304  0000               _I2C_byte_received:
1306  0000 88            	push	a
1307       00000000      OFST:	set	0
1310                     ; 219 		if(GetDataIndex < MAX_BUFFER) {
1312  0001 b600          	ld	a,_GetDataIndex
1313  0003 a120          	cp	a,#32
1314  0005 2410          	jruge	L344
1315                     ; 220 			IIC_RxBuffer[GetDataIndex++] = RxData;
1317  0007 b600          	ld	a,_GetDataIndex
1318  0009 97            	ld	xl,a
1319  000a 3c00          	inc	_GetDataIndex
1320  000c 9f            	ld	a,xl
1321  000d 5f            	clrw	x
1322  000e 97            	ld	xl,a
1323  000f 7b01          	ld	a,(OFST+1,sp)
1324  0011 e736          	ld	(_IIC_RxBuffer,x),a
1325                     ; 221 			ReceiveState = IIC_STATE_RECEIVEING;
1327  0013 35020001      	mov	_ReceiveState,#2
1328  0017               L344:
1329                     ; 223 	}
1332  0017 84            	pop	a
1333  0018 81            	ret
1358                     ; 225 	uint8_t I2C_byte_write(void)
1358                     ; 226 	{
1359                     .text:	section	.text,new
1360  0000               _I2C_byte_write:
1364                     ; 227 			return IIC_TxBuffer[SendDataIndex++];
1366  0000 b602          	ld	a,_SendDataIndex
1367  0002 97            	ld	xl,a
1368  0003 3c02          	inc	_SendDataIndex
1369  0005 9f            	ld	a,xl
1370  0006 5f            	clrw	x
1371  0007 97            	ld	xl,a
1372  0008 e616          	ld	a,(_IIC_TxBuffer,x)
1375  000a 81            	ret
1378                     	switch	.ubsct
1379  0000               L554_sr1:
1380  0000 00            	ds.b	1
1381  0001               L754_sr2:
1382  0001 00            	ds.b	1
1383  0002               L164_sr3:
1384  0002 00            	ds.b	1
1440                     ; 237 @far @interrupt void I2C_Slave_check_event(void) {
1442                     .text:	section	.text,new
1443  0000               f_I2C_Slave_check_event:
1446  0000 3b0002        	push	c_x+2
1447  0003 be00          	ldw	x,c_x
1448  0005 89            	pushw	x
1449  0006 3b0002        	push	c_y+2
1450  0009 be00          	ldw	x,c_y
1451  000b 89            	pushw	x
1454                     ; 244 	sr1 = I2C->SR1;
1456  000c 5552170000    	mov	L554_sr1,21015
1457                     ; 245 	sr2 = I2C->SR2;
1459  0011 5552180001    	mov	L754_sr2,21016
1460                     ; 246 	sr3 = I2C->SR3;
1462  0016 5552190002    	mov	L164_sr3,21017
1463                     ; 249   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
1465  001b b601          	ld	a,L754_sr2
1466  001d a52b          	bcp	a,#43
1467  001f 2708          	jreq	L115
1468                     ; 251     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
1470  0021 72125211      	bset	21009,#1
1471                     ; 252     I2C->SR2= 0;					    // clear all error flags
1473  0025 725f5218      	clr	21016
1474  0029               L115:
1475                     ; 255   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
1477  0029 b600          	ld	a,L554_sr1
1478  002b a444          	and	a,#68
1479  002d a144          	cp	a,#68
1480  002f 2606          	jrne	L315
1481                     ; 257     I2C_byte_received(I2C->DR);
1483  0031 c65216        	ld	a,21014
1484  0034 cd0000        	call	_I2C_byte_received
1486  0037               L315:
1487                     ; 260   if (sr1 & I2C_SR1_RXNE)
1489  0037 b600          	ld	a,L554_sr1
1490  0039 a540          	bcp	a,#64
1491  003b 2706          	jreq	L515
1492                     ; 262     I2C_byte_received(I2C->DR);
1494  003d c65216        	ld	a,21014
1495  0040 cd0000        	call	_I2C_byte_received
1497  0043               L515:
1498                     ; 265   if (sr2 & I2C_SR2_AF)
1500  0043 b601          	ld	a,L754_sr2
1501  0045 a504          	bcp	a,#4
1502  0047 2707          	jreq	L715
1503                     ; 267     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
1505  0049 72155218      	bres	21016,#2
1506                     ; 268 		I2C_transaction_end();
1508  004d cd0000        	call	_I2C_transaction_end
1510  0050               L715:
1511                     ; 271   if (sr1 & I2C_SR1_STOPF) 
1513  0050 b600          	ld	a,L554_sr1
1514  0052 a510          	bcp	a,#16
1515  0054 2707          	jreq	L125
1516                     ; 273     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
1518  0056 72145211      	bset	21009,#2
1519                     ; 274 		I2C_transaction_end();
1521  005a cd0000        	call	_I2C_transaction_end
1523  005d               L125:
1524                     ; 277   if (sr1 & I2C_SR1_ADDR)
1526  005d b600          	ld	a,L554_sr1
1527  005f a502          	bcp	a,#2
1528  0061 270e          	jreq	L325
1529                     ; 279 		if(sr3 & I2C_SR3_TRA){//从机发送数据
1531  0063 b602          	ld	a,L164_sr3
1532  0065 a504          	bcp	a,#4
1533  0067 2705          	jreq	L525
1534                     ; 280 			I2C_transaction_begin();
1536  0069 cd0000        	call	_I2C_transaction_begin
1539  006c 2003          	jra	L325
1540  006e               L525:
1541                     ; 282 			I2C_receive_begin();//从机接收数据
1543  006e cd0000        	call	_I2C_receive_begin
1545  0071               L325:
1546                     ; 286   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
1548  0071 b600          	ld	a,L554_sr1
1549  0073 a484          	and	a,#132
1550  0075 a184          	cp	a,#132
1551  0077 2606          	jrne	L135
1552                     ; 288 		I2C->DR = I2C_byte_write();
1554  0079 cd0000        	call	_I2C_byte_write
1556  007c c75216        	ld	21014,a
1557  007f               L135:
1558                     ; 291   if (sr1 & I2C_SR1_TXE)
1560  007f b600          	ld	a,L554_sr1
1561  0081 a580          	bcp	a,#128
1562  0083 2706          	jreq	L335
1563                     ; 293 		I2C->DR = I2C_byte_write();
1565  0085 cd0000        	call	_I2C_byte_write
1567  0088 c75216        	ld	21014,a
1568  008b               L335:
1569                     ; 296 }
1572  008b 85            	popw	x
1573  008c bf00          	ldw	c_y,x
1574  008e 320002        	pop	c_y+2
1575  0091 85            	popw	x
1576  0092 bf00          	ldw	c_x,x
1577  0094 320002        	pop	c_x+2
1578  0097 80            	iret
1601                     ; 301 void IIC_SlaveConfig (void)
1601                     ; 302 {
1603                     .text:	section	.text,new
1604  0000               _IIC_SlaveConfig:
1608                     ; 313 		I2C->CR1 |= 0x01;				        	// Enable I2C peripheral
1610  0000 72105210      	bset	21008,#0
1611                     ; 314 		I2C->CR2 = 0x04;					      		// Enable I2C acknowledgement
1613  0004 35045211      	mov	21009,#4
1614                     ; 315 		I2C->FREQR = 16; 					      	// Set I2C Freq value (16MHz)
1616  0008 35105212      	mov	21010,#16
1617                     ; 317 		I2C->OARL = (SLAVE_ADDRESS << 1) ;	// set slave address to 0x51 (put 0xA2 for the register dues to7bit address) 
1619  000c b657          	ld	a,_slave_address
1620  000e 48            	sll	a
1621  000f c75213        	ld	21011,a
1622                     ; 318 		I2C->OARH = 0x40;					      	// Set 7bit address mode
1624  0012 35405214      	mov	21012,#64
1625                     ; 331 	I2C->ITR	= 0x07;					      // all I2C interrupt enable  
1627  0016 3507521a      	mov	21018,#7
1628                     ; 332 }
1631  001a 81            	ret
1986                     	xdef	_I2C_byte_write
1987                     	xdef	_I2C_byte_received
1988                     	xdef	_I2C_transaction_receive
1989                     	xdef	_I2C_transaction_end
1990                     	xdef	_I2C_transaction_begin
1991                     	xdef	_I2C_receive_begin
1992                     	xdef	_i2c_init_message
1993                     	xdef	_Check_Sum
1994                     	xdef	_mymemcpy
1995                     	switch	.ubsct
1996  0003               _action_flag:
1997  0003 00            	ds.b	1
1998                     	xdef	_action_flag
1999  0004               _change_step2:
2000  0004 00000000      	ds.b	4
2001                     	xdef	_change_step2
2002  0008               _change_step1:
2003  0008 00000000      	ds.b	4
2004                     	xdef	_change_step1
2005  000c               _change_time:
2006  000c 00            	ds.b	1
2007                     	xdef	_change_time
2008  000d               _aim_bright2:
2009  000d 00000000      	ds.b	4
2010                     	xdef	_aim_bright2
2011  0011               _aim_bright1:
2012  0011 00000000      	ds.b	4
2013                     	xdef	_aim_bright1
2014  0015               _channel:
2015  0015 00            	ds.b	1
2016                     	xdef	_channel
2017                     	xref.b	_last_bright2
2018                     	xref.b	_last_bright1
2019                     	xref.b	_realtime_bright2
2020                     	xref.b	_realtime_bright1
2021                     	xdef	_SendDataIndex
2022                     	xdef	_ReceiveState
2023                     	xdef	_GetDataIndex
2024  0016               _IIC_TxBuffer:
2025  0016 000000000000  	ds.b	32
2026                     	xdef	_IIC_TxBuffer
2027  0036               _IIC_RxBuffer:
2028  0036 000000000000  	ds.b	32
2029                     	xdef	_IIC_RxBuffer
2030  0056               _action_done:
2031  0056 00            	ds.b	1
2032                     	xdef	_action_done
2033  0057               _slave_address:
2034  0057 00            	ds.b	1
2035                     	xdef	_slave_address
2036  0058               _slc:
2037  0058 000000000000  	ds.b	25
2038                     	xdef	_slc
2039                     	xdef	_rev_action_dimmer_done
2040                     	xdef	_rev_action_dimmer_OK
2041                     	xdef	_rev_heart_breat
2042                     	xdef	_init_device_info
2043                     	xdef	f_I2C_Slave_check_event
2044                     	xdef	_IIC_SlaveConfig
2045                     .const:	section	.text
2046  0000               L562:
2047  0000 42c80000      	dc.w	17096,0
2048                     	xref.b	c_lreg
2049                     	xref.b	c_x
2050                     	xref.b	c_y
2070                     	xref	c_fsub
2071                     	xref	c_rtol
2072                     	xref	c_fdiv
2073                     	xref	c_itof
2074                     	xref	c_lrzmp
2075                     	xref	c_lgsbc
2076                     	xref	c_ltor
2077                     	end
