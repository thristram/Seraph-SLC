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
 525  0026 cc018a        	jp	L522
 526  0029               L02:
 527                     ; 86 				case 0xFE:
 527                     ; 87 					if(IIC_RxBuffer[5] == 0x01)	init_device_info();
 529  0029 b63b          	ld	a,_IIC_RxBuffer+5
 530  002b a101          	cp	a,#1
 531  002d 2703          	jreq	L22
 532  002f cc018a        	jp	L522
 533  0032               L22:
 536  0032 cd0000        	call	_init_device_info
 538  0035 ac8a018a      	jpf	L522
 539  0039               L571:
 540                     ; 89 				case 0x03:
 540                     ; 90 					if((IIC_RxBuffer[5] == 0x03)&&(IIC_RxBuffer[6] == slave_address)){
 542  0039 b63b          	ld	a,_IIC_RxBuffer+5
 543  003b a103          	cp	a,#3
 544  003d 2703          	jreq	L42
 545  003f cc018a        	jp	L522
 546  0042               L42:
 548  0042 b63c          	ld	a,_IIC_RxBuffer+6
 549  0044 b157          	cp	a,_slave_address
 550  0046 2703          	jreq	L62
 551  0048 cc018a        	jp	L522
 552  004b               L62:
 553                     ; 92 						if(Check_Sum(&IIC_RxBuffer[2],IIC_RxBuffer[3]) == IIC_RxBuffer[7]){
 555  004b 3b0039        	push	_IIC_RxBuffer+3
 556  004e ae0038        	ldw	x,#_IIC_RxBuffer+2
 557  0051 cd0000        	call	_Check_Sum
 559  0054 5b01          	addw	sp,#1
 560  0056 b13d          	cp	a,_IIC_RxBuffer+7
 561  0058 2703          	jreq	L03
 562  005a cc018a        	jp	L522
 563  005d               L03:
 564                     ; 93 							rev_heart_breat();
 566  005d cd0000        	call	_rev_heart_breat
 568  0060 ac8a018a      	jpf	L522
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
 584  007a cc018a        	jp	L522
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
 792  0185 2003          	jra	L522
 793  0187               L102:
 794                     ; 129 				case 0x59://调光时间结束后SC发送查询ch状态
 794                     ; 130 					//if(IIC_RxBuffer[5] == slave_address){//查询action dimmer执行后SLC状态
 794                     ; 131 						rev_action_dimmer_done();
 796  0187 cd0000        	call	_rev_action_dimmer_done
 798                     ; 133 				break;
 800  018a               L302:
 801                     ; 134 				default:
 801                     ; 135 				break;
 803  018a               L522:
 804                     ; 139 	}
 807  018a 5b05          	addw	sp,#5
 808  018c 81            	ret
 846                     ; 141 	void init_device_info(void)
 846                     ; 142 	{
 847                     .text:	section	.text,new
 848  0000               _init_device_info:
 850  0000 5221          	subw	sp,#33
 851       00000021      OFST:	set	33
 854                     ; 144 		di.frame_h1 = 0x7E;
 856  0002 a67e          	ld	a,#126
 857  0004 6b01          	ld	(OFST-32,sp),a
 858                     ; 145 		di.frame_h2 = 0x7E;
 860  0006 a67e          	ld	a,#126
 861  0008 6b02          	ld	(OFST-31,sp),a
 862                     ; 146 		di.message_id = IIC_RxBuffer[2];
 864  000a b638          	ld	a,_IIC_RxBuffer+2
 865  000c 6b03          	ld	(OFST-30,sp),a
 866                     ; 147 		di.payload[0] = 0xB2;
 868  000e a6b2          	ld	a,#178
 869  0010 6b04          	ld	(OFST-29,sp),a
 870                     ; 148 		di.payload[1] = 0x01;
 872  0012 a601          	ld	a,#1
 873  0014 6b05          	ld	(OFST-28,sp),a
 874                     ; 149 		di.payload[2] = 0x01;
 876  0016 a601          	ld	a,#1
 877  0018 6b06          	ld	(OFST-27,sp),a
 878                     ; 150 		di.payload[3] = 0x01;
 880  001a a601          	ld	a,#1
 881  001c 6b07          	ld	(OFST-26,sp),a
 882                     ; 151 		di.payload[4] = 0x01;
 884  001e a601          	ld	a,#1
 885  0020 6b08          	ld	(OFST-25,sp),a
 886                     ; 152 		di.payload[5] = 0x63;
 888  0022 a663          	ld	a,#99
 889  0024 6b09          	ld	(OFST-24,sp),a
 890                     ; 153 		di.payload[6] = 0x00;
 892  0026 0f0a          	clr	(OFST-23,sp)
 893                     ; 154 		di.payload[7] = 0xc0;
 895  0028 a6c0          	ld	a,#192
 896  002a 6b0b          	ld	(OFST-22,sp),a
 897                     ; 155 		di.payload[8] = slave_address;
 899  002c b657          	ld	a,_slave_address
 900  002e 6b0c          	ld	(OFST-21,sp),a
 901                     ; 156 		i2c_init_message(&di,9);
 903  0030 4b09          	push	#9
 904  0032 96            	ldw	x,sp
 905  0033 1c0002        	addw	x,#OFST-31
 906  0036 cd0000        	call	_i2c_init_message
 908  0039 84            	pop	a
 909                     ; 157 	}
 912  003a 5b21          	addw	sp,#33
 913  003c 81            	ret
 951                     ; 159 	void rev_heart_breat(void)
 951                     ; 160 	{
 952                     .text:	section	.text,new
 953  0000               _rev_heart_breat:
 955  0000 5221          	subw	sp,#33
 956       00000021      OFST:	set	33
 959                     ; 162 		hb.frame_h1 = 0x7E;
 961  0002 a67e          	ld	a,#126
 962  0004 6b01          	ld	(OFST-32,sp),a
 963                     ; 163 		hb.frame_h2 = 0x7E;
 965  0006 a67e          	ld	a,#126
 966  0008 6b02          	ld	(OFST-31,sp),a
 967                     ; 164 		hb.message_id = IIC_RxBuffer[2];
 969  000a b638          	ld	a,_IIC_RxBuffer+2
 970  000c 6b03          	ld	(OFST-30,sp),a
 971                     ; 165 		hb.payload[0] = 0x06;
 973  000e a606          	ld	a,#6
 974  0010 6b04          	ld	(OFST-29,sp),a
 975                     ; 166 		hb.payload[1] = slc.MDID;
 977  0012 b66c          	ld	a,_slc+20
 978  0014 6b05          	ld	(OFST-28,sp),a
 979                     ; 167 		hb.payload[2] = slc.ch1_status;
 981  0016 b66d          	ld	a,_slc+21
 982  0018 6b06          	ld	(OFST-27,sp),a
 983                     ; 168 		hb.payload[3] = slc.ch2_status;
 985  001a b66e          	ld	a,_slc+22
 986  001c 6b07          	ld	(OFST-26,sp),a
 987                     ; 169 		hb.payload[4] = slc.ch3_status;
 989  001e b66f          	ld	a,_slc+23
 990  0020 6b08          	ld	(OFST-25,sp),a
 991                     ; 170 		hb.payload[5] = slc.ch4_status;
 993  0022 b670          	ld	a,_slc+24
 994  0024 6b09          	ld	(OFST-24,sp),a
 995                     ; 171 		i2c_init_message(&hb,6);
 997  0026 4b06          	push	#6
 998  0028 96            	ldw	x,sp
 999  0029 1c0002        	addw	x,#OFST-31
1000  002c cd0000        	call	_i2c_init_message
1002  002f 84            	pop	a
1003                     ; 172 	}
1006  0030 5b21          	addw	sp,#33
1007  0032 81            	ret
1046                     ; 174 	void rev_action_dimmer_OK(void)
1046                     ; 175 	{
1047                     .text:	section	.text,new
1048  0000               _rev_action_dimmer_OK:
1050  0000 5221          	subw	sp,#33
1051       00000021      OFST:	set	33
1054                     ; 177 		ad.frame_h1 = 0x7E;
1056  0002 a67e          	ld	a,#126
1057  0004 6b01          	ld	(OFST-32,sp),a
1058                     ; 178 		ad.frame_h2 = 0x7E;
1060  0006 a67e          	ld	a,#126
1061  0008 6b02          	ld	(OFST-31,sp),a
1062                     ; 179 		ad.message_id = IIC_RxBuffer[2];
1064  000a b638          	ld	a,_IIC_RxBuffer+2
1065  000c 6b03          	ld	(OFST-30,sp),a
1066                     ; 180 		ad.payload[0] = 0xAA;
1068  000e a6aa          	ld	a,#170
1069  0010 6b04          	ld	(OFST-29,sp),a
1070                     ; 181 		ad.payload[1] = 0x02;
1072  0012 a602          	ld	a,#2
1073  0014 6b05          	ld	(OFST-28,sp),a
1074                     ; 182 		ad.payload[2] = slc.MDID;
1076  0016 b66c          	ld	a,_slc+20
1077  0018 6b06          	ld	(OFST-27,sp),a
1078                     ; 183 		i2c_init_message(&ad,3);
1080  001a 4b03          	push	#3
1081  001c 96            	ldw	x,sp
1082  001d 1c0002        	addw	x,#OFST-31
1083  0020 cd0000        	call	_i2c_init_message
1085  0023 84            	pop	a
1086                     ; 184 	}
1089  0024 5b21          	addw	sp,#33
1090  0026 81            	ret
1128                     ; 187 	void rev_action_dimmer_done(void)
1128                     ; 188 	{
1129                     .text:	section	.text,new
1130  0000               _rev_action_dimmer_done:
1132  0000 5221          	subw	sp,#33
1133       00000021      OFST:	set	33
1136                     ; 190 		ad.frame_h1 = 0x7E;
1138  0002 a67e          	ld	a,#126
1139  0004 6b01          	ld	(OFST-32,sp),a
1140                     ; 191 		ad.frame_h2 = 0x7E;
1142  0006 a67e          	ld	a,#126
1143  0008 6b02          	ld	(OFST-31,sp),a
1144                     ; 192 		ad.message_id = 66;
1146  000a a642          	ld	a,#66
1147  000c 6b03          	ld	(OFST-30,sp),a
1148                     ; 193 		ad.payload[0] = 0xAA;
1150  000e a6aa          	ld	a,#170
1151  0010 6b04          	ld	(OFST-29,sp),a
1152                     ; 194 		ad.payload[1] = 0x05;
1154  0012 a605          	ld	a,#5
1155  0014 6b05          	ld	(OFST-28,sp),a
1156                     ; 195 		ad.payload[2] = slc.MDID;
1158  0016 b66c          	ld	a,_slc+20
1159  0018 6b06          	ld	(OFST-27,sp),a
1160                     ; 196 		ad.payload[3] = slc.ch1_status;
1162  001a b66d          	ld	a,_slc+21
1163  001c 6b07          	ld	(OFST-26,sp),a
1164                     ; 197 		ad.payload[4] = slc.ch2_status;
1166  001e b66e          	ld	a,_slc+22
1167  0020 6b08          	ld	(OFST-25,sp),a
1168                     ; 198 		ad.payload[5] = slc.ch3_status;
1170  0022 b66f          	ld	a,_slc+23
1171  0024 6b09          	ld	(OFST-24,sp),a
1172                     ; 199 		ad.payload[6] = slc.ch4_status;
1174  0026 b670          	ld	a,_slc+24
1175  0028 6b0a          	ld	(OFST-23,sp),a
1176                     ; 200 		i2c_init_message(&ad,7);
1178  002a 4b07          	push	#7
1179  002c 96            	ldw	x,sp
1180  002d 1c0002        	addw	x,#OFST-31
1181  0030 cd0000        	call	_i2c_init_message
1183  0033 84            	pop	a
1184                     ; 201 	}
1187  0034 5b21          	addw	sp,#33
1188  0036 81            	ret
1214                     ; 205 	void I2C_transaction_end(void)
1214                     ; 206 	{
1215                     .text:	section	.text,new
1216  0000               _I2C_transaction_end:
1220                     ; 207 		ReceiveState = IIC_STATE_END;
1222  0000 35030001      	mov	_ReceiveState,#3
1223                     ; 208 		ReceiveState = IIC_STATE_UNKNOWN;
1225  0004 3f01          	clr	_ReceiveState
1226                     ; 209 			GetDataIndex = 0;
1228  0006 3f00          	clr	_GetDataIndex
1229                     ; 210 	}	
1232  0008 81            	ret
1257                     ; 212 	void I2C_transaction_receive(void)
1257                     ; 213 	{
1258                     .text:	section	.text,new
1259  0000               _I2C_transaction_receive:
1263                     ; 214 		ReceiveState = IIC_STATE_RECEIVEING;
1265  0000 35020001      	mov	_ReceiveState,#2
1266                     ; 215 	}
1269  0004 81            	ret
1306                     ; 217 	void I2C_byte_received(uint8_t RxData)
1306                     ; 218 	{
1307                     .text:	section	.text,new
1308  0000               _I2C_byte_received:
1310  0000 88            	push	a
1311       00000000      OFST:	set	0
1314                     ; 219 		if(GetDataIndex < MAX_BUFFER) {
1316  0001 b600          	ld	a,_GetDataIndex
1317  0003 a120          	cp	a,#32
1318  0005 2410          	jruge	L144
1319                     ; 220 			IIC_RxBuffer[GetDataIndex++] = RxData;
1321  0007 b600          	ld	a,_GetDataIndex
1322  0009 97            	ld	xl,a
1323  000a 3c00          	inc	_GetDataIndex
1324  000c 9f            	ld	a,xl
1325  000d 5f            	clrw	x
1326  000e 97            	ld	xl,a
1327  000f 7b01          	ld	a,(OFST+1,sp)
1328  0011 e736          	ld	(_IIC_RxBuffer,x),a
1329                     ; 221 			ReceiveState = IIC_STATE_RECEIVEING;
1331  0013 35020001      	mov	_ReceiveState,#2
1332  0017               L144:
1333                     ; 223 	}
1336  0017 84            	pop	a
1337  0018 81            	ret
1362                     ; 225 	uint8_t I2C_byte_write(void)
1362                     ; 226 	{
1363                     .text:	section	.text,new
1364  0000               _I2C_byte_write:
1368                     ; 227 			return IIC_TxBuffer[SendDataIndex++];
1370  0000 b602          	ld	a,_SendDataIndex
1371  0002 97            	ld	xl,a
1372  0003 3c02          	inc	_SendDataIndex
1373  0005 9f            	ld	a,xl
1374  0006 5f            	clrw	x
1375  0007 97            	ld	xl,a
1376  0008 e616          	ld	a,(_IIC_TxBuffer,x)
1379  000a 81            	ret
1382                     	switch	.ubsct
1383  0000               L354_sr1:
1384  0000 00            	ds.b	1
1385  0001               L554_sr2:
1386  0001 00            	ds.b	1
1387  0002               L754_sr3:
1388  0002 00            	ds.b	1
1444                     ; 237 @far @interrupt void I2C_Slave_check_event(void) {
1446                     .text:	section	.text,new
1447  0000               f_I2C_Slave_check_event:
1450  0000 3b0002        	push	c_x+2
1451  0003 be00          	ldw	x,c_x
1452  0005 89            	pushw	x
1453  0006 3b0002        	push	c_y+2
1454  0009 be00          	ldw	x,c_y
1455  000b 89            	pushw	x
1458                     ; 244 	sr1 = I2C->SR1;
1460  000c 5552170000    	mov	L354_sr1,21015
1461                     ; 245 	sr2 = I2C->SR2;
1463  0011 5552180001    	mov	L554_sr2,21016
1464                     ; 246 	sr3 = I2C->SR3;
1466  0016 5552190002    	mov	L754_sr3,21017
1467                     ; 249   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
1469  001b b601          	ld	a,L554_sr2
1470  001d a52b          	bcp	a,#43
1471  001f 2708          	jreq	L705
1472                     ; 251     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
1474  0021 72125211      	bset	21009,#1
1475                     ; 252     I2C->SR2= 0;					    // clear all error flags
1477  0025 725f5218      	clr	21016
1478  0029               L705:
1479                     ; 255   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
1481  0029 b600          	ld	a,L354_sr1
1482  002b a444          	and	a,#68
1483  002d a144          	cp	a,#68
1484  002f 2606          	jrne	L115
1485                     ; 257     I2C_byte_received(I2C->DR);
1487  0031 c65216        	ld	a,21014
1488  0034 cd0000        	call	_I2C_byte_received
1490  0037               L115:
1491                     ; 260   if (sr1 & I2C_SR1_RXNE)
1493  0037 b600          	ld	a,L354_sr1
1494  0039 a540          	bcp	a,#64
1495  003b 2706          	jreq	L315
1496                     ; 262     I2C_byte_received(I2C->DR);
1498  003d c65216        	ld	a,21014
1499  0040 cd0000        	call	_I2C_byte_received
1501  0043               L315:
1502                     ; 265   if (sr2 & I2C_SR2_AF)
1504  0043 b601          	ld	a,L554_sr2
1505  0045 a504          	bcp	a,#4
1506  0047 2707          	jreq	L515
1507                     ; 267     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
1509  0049 72155218      	bres	21016,#2
1510                     ; 268 		I2C_transaction_end();
1512  004d cd0000        	call	_I2C_transaction_end
1514  0050               L515:
1515                     ; 271   if (sr1 & I2C_SR1_STOPF) 
1517  0050 b600          	ld	a,L354_sr1
1518  0052 a510          	bcp	a,#16
1519  0054 2707          	jreq	L715
1520                     ; 273     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
1522  0056 72145211      	bset	21009,#2
1523                     ; 274 		I2C_transaction_end();
1525  005a cd0000        	call	_I2C_transaction_end
1527  005d               L715:
1528                     ; 277   if (sr1 & I2C_SR1_ADDR)
1530  005d b600          	ld	a,L354_sr1
1531  005f a502          	bcp	a,#2
1532  0061 270e          	jreq	L125
1533                     ; 279 		if(sr3 & I2C_SR3_TRA){//从机发送数据
1535  0063 b602          	ld	a,L754_sr3
1536  0065 a504          	bcp	a,#4
1537  0067 2705          	jreq	L325
1538                     ; 280 			I2C_transaction_begin();
1540  0069 cd0000        	call	_I2C_transaction_begin
1543  006c 2003          	jra	L125
1544  006e               L325:
1545                     ; 282 			I2C_receive_begin();//从机接收数据
1547  006e cd0000        	call	_I2C_receive_begin
1549  0071               L125:
1550                     ; 286   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
1552  0071 b600          	ld	a,L354_sr1
1553  0073 a484          	and	a,#132
1554  0075 a184          	cp	a,#132
1555  0077 2606          	jrne	L725
1556                     ; 288 		I2C->DR = I2C_byte_write();
1558  0079 cd0000        	call	_I2C_byte_write
1560  007c c75216        	ld	21014,a
1561  007f               L725:
1562                     ; 291   if (sr1 & I2C_SR1_TXE)
1564  007f b600          	ld	a,L354_sr1
1565  0081 a580          	bcp	a,#128
1566  0083 2706          	jreq	L135
1567                     ; 293 		I2C->DR = I2C_byte_write();
1569  0085 cd0000        	call	_I2C_byte_write
1571  0088 c75216        	ld	21014,a
1572  008b               L135:
1573                     ; 296 }
1576  008b 85            	popw	x
1577  008c bf00          	ldw	c_y,x
1578  008e 320002        	pop	c_y+2
1579  0091 85            	popw	x
1580  0092 bf00          	ldw	c_x,x
1581  0094 320002        	pop	c_x+2
1582  0097 80            	iret
1605                     ; 301 void IIC_SlaveConfig (void)
1605                     ; 302 {
1607                     .text:	section	.text,new
1608  0000               _IIC_SlaveConfig:
1612                     ; 313 		I2C->CR1 |= 0x01;				        	// Enable I2C peripheral
1614  0000 72105210      	bset	21008,#0
1615                     ; 314 		I2C->CR2 = 0x04;					      		// Enable I2C acknowledgement
1617  0004 35045211      	mov	21009,#4
1618                     ; 315 		I2C->FREQR = 16; 					      	// Set I2C Freq value (16MHz)
1620  0008 35105212      	mov	21010,#16
1621                     ; 317 		I2C->OARL = (SLAVE_ADDRESS << 1) ;	// set slave address to 0x51 (put 0xA2 for the register dues to7bit address) 
1623  000c b657          	ld	a,_slave_address
1624  000e 48            	sll	a
1625  000f c75213        	ld	21011,a
1626                     ; 318 		I2C->OARH = 0x40;					      	// Set 7bit address mode
1628  0012 35405214      	mov	21012,#64
1629                     ; 331 	I2C->ITR	= 0x07;					      // all I2C interrupt enable  
1631  0016 3507521a      	mov	21018,#7
1632                     ; 332 }
1635  001a 81            	ret
1990                     	xdef	_I2C_byte_write
1991                     	xdef	_I2C_byte_received
1992                     	xdef	_I2C_transaction_receive
1993                     	xdef	_I2C_transaction_end
1994                     	xdef	_I2C_transaction_begin
1995                     	xdef	_I2C_receive_begin
1996                     	xdef	_i2c_init_message
1997                     	xdef	_Check_Sum
1998                     	xdef	_mymemcpy
1999                     	switch	.ubsct
2000  0003               _action_flag:
2001  0003 00            	ds.b	1
2002                     	xdef	_action_flag
2003  0004               _change_step2:
2004  0004 00000000      	ds.b	4
2005                     	xdef	_change_step2
2006  0008               _change_step1:
2007  0008 00000000      	ds.b	4
2008                     	xdef	_change_step1
2009  000c               _change_time:
2010  000c 00            	ds.b	1
2011                     	xdef	_change_time
2012  000d               _aim_bright2:
2013  000d 00000000      	ds.b	4
2014                     	xdef	_aim_bright2
2015  0011               _aim_bright1:
2016  0011 00000000      	ds.b	4
2017                     	xdef	_aim_bright1
2018  0015               _channel:
2019  0015 00            	ds.b	1
2020                     	xdef	_channel
2021                     	xref.b	_last_bright2
2022                     	xref.b	_last_bright1
2023                     	xref.b	_realtime_bright2
2024                     	xref.b	_realtime_bright1
2025                     	xdef	_SendDataIndex
2026                     	xdef	_ReceiveState
2027                     	xdef	_GetDataIndex
2028  0016               _IIC_TxBuffer:
2029  0016 000000000000  	ds.b	32
2030                     	xdef	_IIC_TxBuffer
2031  0036               _IIC_RxBuffer:
2032  0036 000000000000  	ds.b	32
2033                     	xdef	_IIC_RxBuffer
2034  0056               _action_done:
2035  0056 00            	ds.b	1
2036                     	xdef	_action_done
2037  0057               _slave_address:
2038  0057 00            	ds.b	1
2039                     	xdef	_slave_address
2040  0058               _slc:
2041  0058 000000000000  	ds.b	25
2042                     	xdef	_slc
2043                     	xdef	_rev_action_dimmer_done
2044                     	xdef	_rev_action_dimmer_OK
2045                     	xdef	_rev_heart_breat
2046                     	xdef	_init_device_info
2047                     	xdef	f_I2C_Slave_check_event
2048                     	xdef	_IIC_SlaveConfig
2049                     .const:	section	.text
2050  0000               L562:
2051  0000 42c80000      	dc.w	17096,0
2052                     	xref.b	c_lreg
2053                     	xref.b	c_x
2054                     	xref.b	c_y
2074                     	xref	c_fsub
2075                     	xref	c_rtol
2076                     	xref	c_fdiv
2077                     	xref	c_itof
2078                     	xref	c_lrzmp
2079                     	xref	c_lgsbc
2080                     	xref	c_ltor
2081                     	end
