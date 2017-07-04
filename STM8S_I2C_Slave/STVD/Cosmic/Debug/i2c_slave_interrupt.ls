   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               _GetDataIndex:
   6  0000 00            	dc.b	0
   7  0001               _ReceiveState:
   8  0001 00            	dc.b	0
   9  0002               _SendDataIndex:
  10  0002 00            	dc.b	0
  91                     ; 36 void mymemcpy(void *des,void *src,u32 n)  
  91                     ; 37 {  
  93                     .text:	section	.text,new
  94  0000               _mymemcpy:
  96  0000 89            	pushw	x
  97  0001 5204          	subw	sp,#4
  98       00000004      OFST:	set	4
 101                     ; 38   u8 *xdes=des;
 103  0003 1f01          	ldw	(OFST-3,sp),x
 104                     ; 39 	u8 *xsrc=src; 
 106  0005 1e09          	ldw	x,(OFST+5,sp)
 107  0007 1f03          	ldw	(OFST-1,sp),x
 109  0009 2016          	jra	L35
 110  000b               L74:
 111                     ; 40   while(n--)*xdes++=*xsrc++;  
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
 138                     ; 41 }  
 141  0036 5b06          	addw	sp,#6
 142  0038 81            	ret
 204                     ; 47 u8 Check_Sum(u8 *buf,u8 length)
 204                     ; 48 {
 205                     .text:	section	.text,new
 206  0000               _Check_Sum:
 208  0000 89            	pushw	x
 209  0001 89            	pushw	x
 210       00000002      OFST:	set	2
 213                     ; 50 	u8 result = *buf++;
 215  0002 1e03          	ldw	x,(OFST+1,sp)
 216  0004 1c0001        	addw	x,#1
 217  0007 1f03          	ldw	(OFST+1,sp),x
 218  0009 1d0001        	subw	x,#1
 219  000c f6            	ld	a,(x)
 220  000d 6b01          	ld	(OFST-1,sp),a
 221                     ; 51 	for(i = 1;i < length;i++)
 223  000f a601          	ld	a,#1
 224  0011 6b02          	ld	(OFST+0,sp),a
 226  0013 2011          	jra	L511
 227  0015               L111:
 228                     ; 53 		result ^= *buf++;
 230  0015 1e03          	ldw	x,(OFST+1,sp)
 231  0017 1c0001        	addw	x,#1
 232  001a 1f03          	ldw	(OFST+1,sp),x
 233  001c 1d0001        	subw	x,#1
 234  001f 7b01          	ld	a,(OFST-1,sp)
 235  0021 f8            	xor	a,	(x)
 236  0022 6b01          	ld	(OFST-1,sp),a
 237                     ; 51 	for(i = 1;i < length;i++)
 239  0024 0c02          	inc	(OFST+0,sp)
 240  0026               L511:
 243  0026 7b02          	ld	a,(OFST+0,sp)
 244  0028 1107          	cp	a,(OFST+5,sp)
 245  002a 25e9          	jrult	L111
 246                     ; 55 	return result;
 248  002c 7b01          	ld	a,(OFST-1,sp)
 251  002e 5b04          	addw	sp,#4
 252  0030 81            	ret
 339                     ; 59 u8 i2c_init_message(I2C_Message *tx,u8 payload_len)
 339                     ; 60 {
 340                     .text:	section	.text,new
 341  0000               _i2c_init_message:
 343  0000 89            	pushw	x
 344       00000000      OFST:	set	0
 347                     ; 61 	IIC_TxBuffer[0] = tx->frame_h1;
 349  0001 f6            	ld	a,(x)
 350  0002 b716          	ld	_IIC_TxBuffer,a
 351                     ; 62 	IIC_TxBuffer[1] = tx->frame_h2;
 353  0004 e601          	ld	a,(1,x)
 354  0006 b717          	ld	_IIC_TxBuffer+1,a
 355                     ; 63 	IIC_TxBuffer[2] = tx->message_id;
 357  0008 e602          	ld	a,(2,x)
 358  000a b718          	ld	_IIC_TxBuffer+2,a
 359                     ; 64 	IIC_TxBuffer[3] = 2+payload_len;
 361  000c 7b05          	ld	a,(OFST+5,sp)
 362  000e ab02          	add	a,#2
 363  0010 b719          	ld	_IIC_TxBuffer+3,a
 364                     ; 65 	mymemcpy(&IIC_TxBuffer[4],tx->payload,payload_len);
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
 382                     ; 66 	IIC_TxBuffer[4+payload_len] = Check_Sum(&IIC_TxBuffer[2],IIC_TxBuffer[3]);
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
 395                     ; 68 }
 398  0043 85            	popw	x
 399  0044 81            	ret
 423                     ; 70 	void I2C_receive_begin(void)
 423                     ; 71 	{
 424                     .text:	section	.text,new
 425  0000               _I2C_receive_begin:
 429                     ; 72 		ReceiveState = IIC_STATE_BEGIN;
 431  0000 35010001      	mov	_ReceiveState,#1
 432                     ; 73 	}
 435  0004 81            	ret
 487                     ; 75 	void I2C_transaction_begin(void)
 487                     ; 76 	{
 488                     .text:	section	.text,new
 489  0000               _I2C_transaction_begin:
 491  0000 5205          	subw	sp,#5
 492       00000005      OFST:	set	5
 495                     ; 79 		SendDataIndex = 0;
 497  0002 3f02          	clr	_SendDataIndex
 498                     ; 80 		cmd = IIC_RxBuffer[4];
 500  0004 b63a          	ld	a,_IIC_RxBuffer+4
 501  0006 6b05          	ld	(OFST+0,sp),a
 502                     ; 84 			switch(cmd){
 504  0008 7b05          	ld	a,(OFST+0,sp)
 506                     ; 131 				default:
 506                     ; 132 				break;
 507  000a a003          	sub	a,#3
 508  000c 272b          	jreq	L571
 509  000e a04e          	sub	a,#78
 510  0010 2752          	jreq	L771
 511  0012 4a            	dec	a
 512  0013 274f          	jreq	L771
 513  0015 4a            	dec	a
 514  0016 274c          	jreq	L771
 515  0018 4a            	dec	a
 516  0019 2749          	jreq	L771
 517  001b a005          	sub	a,#5
 518  001d 2603          	jrne	L61
 519  001f cc017f        	jp	L102
 520  0022               L61:
 521  0022 a0a5          	sub	a,#165
 522  0024 2703          	jreq	L02
 523  0026 cc0182        	jp	L522
 524  0029               L02:
 525                     ; 85 				case 0xFE:
 525                     ; 86 					if(IIC_RxBuffer[5] == 0x01)	init_device_info();
 527  0029 b63b          	ld	a,_IIC_RxBuffer+5
 528  002b a101          	cp	a,#1
 529  002d 2703          	jreq	L22
 530  002f cc0182        	jp	L522
 531  0032               L22:
 534  0032 cd0000        	call	_init_device_info
 536  0035 ac820182      	jpf	L522
 537  0039               L571:
 538                     ; 88 				case 0x03:
 538                     ; 89 					if((IIC_RxBuffer[5] == 0x03)&&(IIC_RxBuffer[6] == slave_address)){
 540  0039 b63b          	ld	a,_IIC_RxBuffer+5
 541  003b a103          	cp	a,#3
 542  003d 2703          	jreq	L42
 543  003f cc0182        	jp	L522
 544  0042               L42:
 546  0042 b63c          	ld	a,_IIC_RxBuffer+6
 547  0044 b157          	cp	a,_slave_address
 548  0046 2703          	jreq	L62
 549  0048 cc0182        	jp	L522
 550  004b               L62:
 551                     ; 91 						if(Check_Sum(&IIC_RxBuffer[2],IIC_RxBuffer[3]) == IIC_RxBuffer[7]){
 553  004b 3b0039        	push	_IIC_RxBuffer+3
 554  004e ae0038        	ldw	x,#_IIC_RxBuffer+2
 555  0051 cd0000        	call	_Check_Sum
 557  0054 5b01          	addw	sp,#1
 558  0056 b13d          	cp	a,_IIC_RxBuffer+7
 559  0058 2703          	jreq	L03
 560  005a cc0182        	jp	L522
 561  005d               L03:
 562                     ; 92 							rev_heart_breat();
 564  005d cd0000        	call	_rev_heart_breat
 566  0060 ac820182      	jpf	L522
 567  0064               L771:
 568                     ; 96 				case 0x51://Linear
 568                     ; 97 				case 0x52://Erase in
 568                     ; 98 				case 0x53://Erase out
 568                     ; 99 				case 0x54://Swing
 568                     ; 100 					if(((IIC_RxBuffer[5]&0xf0)>>4) == slave_address){
 570  0064 b63b          	ld	a,_IIC_RxBuffer+5
 571  0066 a4f0          	and	a,#240
 572  0068 4e            	swap	a
 573  0069 a40f          	and	a,#15
 574  006b 5f            	clrw	x
 575  006c 97            	ld	xl,a
 576  006d b657          	ld	a,_slave_address
 577  006f 905f          	clrw	y
 578  0071 9097          	ld	yl,a
 579  0073 90bf01        	ldw	c_y+1,y
 580  0076 b301          	cpw	x,c_y+1
 581  0078 2703          	jreq	L23
 582  007a cc0182        	jp	L522
 583  007d               L23:
 584                     ; 102 						channel = (IIC_RxBuffer[5]&0x0f);
 586  007d b63b          	ld	a,_IIC_RxBuffer+5
 587  007f a40f          	and	a,#15
 588  0081 b715          	ld	_channel,a
 589                     ; 103 						change_time = IIC_RxBuffer[7];
 591  0083 453d0c        	mov	_change_time,_IIC_RxBuffer+7
 592                     ; 104 						if((channel & 0x01) == 0x01)
 594  0086 b615          	ld	a,_channel
 595  0088 a401          	and	a,#1
 596  008a a101          	cp	a,#1
 597  008c 2672          	jrne	L732
 598                     ; 106 							if(IIC_RxBuffer[4] == 0x51)	{linear1_begin = 1;}
 600  008e b63a          	ld	a,_IIC_RxBuffer+4
 601  0090 a151          	cp	a,#81
 602  0092 2606          	jrne	L142
 605  0094 72100003      	bset	_action_flag,#0
 607  0098 202c          	jra	L342
 608  009a               L142:
 609                     ; 107 							else if((IIC_RxBuffer[4] == 0x52)&& (IIC_RxBuffer[6]==0))	{action_flag._flag_byte |= 0x04;}
 611  009a b63a          	ld	a,_IIC_RxBuffer+4
 612  009c a152          	cp	a,#82
 613  009e 260a          	jrne	L542
 615  00a0 3d3c          	tnz	_IIC_RxBuffer+6
 616  00a2 2606          	jrne	L542
 619  00a4 72140003      	bset	_action_flag,#2
 621  00a8 201c          	jra	L342
 622  00aa               L542:
 623                     ; 108 							else if((IIC_RxBuffer[4] == 0x53)&& (IIC_RxBuffer[6]==100)){action_flag._flag_byte |= 0x10;}
 625  00aa b63a          	ld	a,_IIC_RxBuffer+4
 626  00ac a153          	cp	a,#83
 627  00ae 260c          	jrne	L152
 629  00b0 b63c          	ld	a,_IIC_RxBuffer+6
 630  00b2 a164          	cp	a,#100
 631  00b4 2606          	jrne	L152
 634  00b6 72180003      	bset	_action_flag,#4
 636  00ba 200a          	jra	L342
 637  00bc               L152:
 638                     ; 109 							else if(IIC_RxBuffer[4] == 0x54)	{action_flag._flag_byte |= 0x40;}
 640  00bc b63a          	ld	a,_IIC_RxBuffer+4
 641  00be a154          	cp	a,#84
 642  00c0 2604          	jrne	L342
 645  00c2 721c0003      	bset	_action_flag,#6
 646  00c6               L342:
 647                     ; 110 							aim_bright1 = ((float)IIC_RxBuffer[6]) / 100;
 649  00c6 b63c          	ld	a,_IIC_RxBuffer+6
 650  00c8 5f            	clrw	x
 651  00c9 97            	ld	xl,a
 652  00ca cd0000        	call	c_itof
 654  00cd ae0000        	ldw	x,#L362
 655  00d0 cd0000        	call	c_fdiv
 657  00d3 ae0011        	ldw	x,#_aim_bright1
 658  00d6 cd0000        	call	c_rtol
 660                     ; 111 							change_step1 = (aim_bright1 - last_bright1)/change_time;//change_step1可正可负
 662  00d9 b60c          	ld	a,_change_time
 663  00db 5f            	clrw	x
 664  00dc 97            	ld	xl,a
 665  00dd cd0000        	call	c_itof
 667  00e0 96            	ldw	x,sp
 668  00e1 1c0001        	addw	x,#OFST-4
 669  00e4 cd0000        	call	c_rtol
 671  00e7 ae0011        	ldw	x,#_aim_bright1
 672  00ea cd0000        	call	c_ltor
 674  00ed ae0000        	ldw	x,#_last_bright1
 675  00f0 cd0000        	call	c_fsub
 677  00f3 96            	ldw	x,sp
 678  00f4 1c0001        	addw	x,#OFST-4
 679  00f7 cd0000        	call	c_fdiv
 681  00fa ae0008        	ldw	x,#_change_step1
 682  00fd cd0000        	call	c_rtol
 684  0100               L732:
 685                     ; 114 						if((channel & 0x02) == 0x02)
 687  0100 b615          	ld	a,_channel
 688  0102 a402          	and	a,#2
 689  0104 a102          	cp	a,#2
 690  0106 2672          	jrne	L762
 691                     ; 116 							if(IIC_RxBuffer[4] == 0x51)	{linear2_begin = 1;}
 693  0108 b63a          	ld	a,_IIC_RxBuffer+4
 694  010a a151          	cp	a,#81
 695  010c 2606          	jrne	L172
 698  010e 72120003      	bset	_action_flag,#1
 700  0112 202c          	jra	L372
 701  0114               L172:
 702                     ; 117 							else if((IIC_RxBuffer[4] == 0x52)&& (IIC_RxBuffer[6]==0))	{action_flag._flag_byte |= 0x08;}
 704  0114 b63a          	ld	a,_IIC_RxBuffer+4
 705  0116 a152          	cp	a,#82
 706  0118 260a          	jrne	L572
 708  011a 3d3c          	tnz	_IIC_RxBuffer+6
 709  011c 2606          	jrne	L572
 712  011e 72160003      	bset	_action_flag,#3
 714  0122 201c          	jra	L372
 715  0124               L572:
 716                     ; 118 							else if((IIC_RxBuffer[4] == 0x53)&& (IIC_RxBuffer[6]==100)){action_flag._flag_byte |= 0x20;}
 718  0124 b63a          	ld	a,_IIC_RxBuffer+4
 719  0126 a153          	cp	a,#83
 720  0128 260c          	jrne	L103
 722  012a b63c          	ld	a,_IIC_RxBuffer+6
 723  012c a164          	cp	a,#100
 724  012e 2606          	jrne	L103
 727  0130 721a0003      	bset	_action_flag,#5
 729  0134 200a          	jra	L372
 730  0136               L103:
 731                     ; 119 							else if(IIC_RxBuffer[4] == 0x54)	{action_flag._flag_byte |= 0x80;}
 733  0136 b63a          	ld	a,_IIC_RxBuffer+4
 734  0138 a154          	cp	a,#84
 735  013a 2604          	jrne	L372
 738  013c 721e0003      	bset	_action_flag,#7
 739  0140               L372:
 740                     ; 120 							aim_bright2 = ((float)IIC_RxBuffer[6]) / 100;
 742  0140 b63c          	ld	a,_IIC_RxBuffer+6
 743  0142 5f            	clrw	x
 744  0143 97            	ld	xl,a
 745  0144 cd0000        	call	c_itof
 747  0147 ae0000        	ldw	x,#L362
 748  014a cd0000        	call	c_fdiv
 750  014d ae000d        	ldw	x,#_aim_bright2
 751  0150 cd0000        	call	c_rtol
 753                     ; 121 							change_step2 = (aim_bright2 - last_bright2)/change_time;
 755  0153 b60c          	ld	a,_change_time
 756  0155 5f            	clrw	x
 757  0156 97            	ld	xl,a
 758  0157 cd0000        	call	c_itof
 760  015a 96            	ldw	x,sp
 761  015b 1c0001        	addw	x,#OFST-4
 762  015e cd0000        	call	c_rtol
 764  0161 ae000d        	ldw	x,#_aim_bright2
 765  0164 cd0000        	call	c_ltor
 767  0167 ae0000        	ldw	x,#_last_bright2
 768  016a cd0000        	call	c_fsub
 770  016d 96            	ldw	x,sp
 771  016e 1c0001        	addw	x,#OFST-4
 772  0171 cd0000        	call	c_fdiv
 774  0174 ae0004        	ldw	x,#_change_step2
 775  0177 cd0000        	call	c_rtol
 777  017a               L762:
 778                     ; 123 						rev_action_dimmer_OK();
 780  017a cd0000        	call	_rev_action_dimmer_OK
 782  017d 2003          	jra	L522
 783  017f               L102:
 784                     ; 126 				case 0x59://调光时间结束后SC发送查询ch状态
 784                     ; 127 					//if(IIC_RxBuffer[5] == slave_address){//查询action dimmer执行后SLC状态
 784                     ; 128 						rev_action_dimmer_done();
 786  017f cd0000        	call	_rev_action_dimmer_done
 788                     ; 130 				break;
 790  0182               L302:
 791                     ; 131 				default:
 791                     ; 132 				break;
 793  0182               L522:
 794                     ; 136 	}
 797  0182 5b05          	addw	sp,#5
 798  0184 81            	ret
 836                     ; 138 	void init_device_info(void)
 836                     ; 139 	{
 837                     .text:	section	.text,new
 838  0000               _init_device_info:
 840  0000 5221          	subw	sp,#33
 841       00000021      OFST:	set	33
 844                     ; 141 		di.frame_h1 = 0x7E;
 846  0002 a67e          	ld	a,#126
 847  0004 6b01          	ld	(OFST-32,sp),a
 848                     ; 142 		di.frame_h2 = 0x7E;
 850  0006 a67e          	ld	a,#126
 851  0008 6b02          	ld	(OFST-31,sp),a
 852                     ; 143 		di.message_id = IIC_RxBuffer[2];
 854  000a b638          	ld	a,_IIC_RxBuffer+2
 855  000c 6b03          	ld	(OFST-30,sp),a
 856                     ; 144 		di.payload[0] = 0xB2;
 858  000e a6b2          	ld	a,#178
 859  0010 6b04          	ld	(OFST-29,sp),a
 860                     ; 145 		di.payload[1] = 0x01;
 862  0012 a601          	ld	a,#1
 863  0014 6b05          	ld	(OFST-28,sp),a
 864                     ; 146 		di.payload[2] = 0x01;
 866  0016 a601          	ld	a,#1
 867  0018 6b06          	ld	(OFST-27,sp),a
 868                     ; 147 		di.payload[3] = 0x01;
 870  001a a601          	ld	a,#1
 871  001c 6b07          	ld	(OFST-26,sp),a
 872                     ; 148 		di.payload[4] = 0x01;
 874  001e a601          	ld	a,#1
 875  0020 6b08          	ld	(OFST-25,sp),a
 876                     ; 149 		di.payload[5] = 0x63;
 878  0022 a663          	ld	a,#99
 879  0024 6b09          	ld	(OFST-24,sp),a
 880                     ; 150 		di.payload[6] = 0x00;
 882  0026 0f0a          	clr	(OFST-23,sp)
 883                     ; 151 		di.payload[7] = 0xc0;
 885  0028 a6c0          	ld	a,#192
 886  002a 6b0b          	ld	(OFST-22,sp),a
 887                     ; 152 		di.payload[8] = slave_address;
 889  002c b657          	ld	a,_slave_address
 890  002e 6b0c          	ld	(OFST-21,sp),a
 891                     ; 153 		i2c_init_message(&di,9);
 893  0030 4b09          	push	#9
 894  0032 96            	ldw	x,sp
 895  0033 1c0002        	addw	x,#OFST-31
 896  0036 cd0000        	call	_i2c_init_message
 898  0039 84            	pop	a
 899                     ; 154 	}
 902  003a 5b21          	addw	sp,#33
 903  003c 81            	ret
 941                     ; 156 	void rev_heart_breat(void)
 941                     ; 157 	{
 942                     .text:	section	.text,new
 943  0000               _rev_heart_breat:
 945  0000 5221          	subw	sp,#33
 946       00000021      OFST:	set	33
 949                     ; 159 		hb.frame_h1 = 0x7E;
 951  0002 a67e          	ld	a,#126
 952  0004 6b01          	ld	(OFST-32,sp),a
 953                     ; 160 		hb.frame_h2 = 0x7E;
 955  0006 a67e          	ld	a,#126
 956  0008 6b02          	ld	(OFST-31,sp),a
 957                     ; 161 		hb.message_id = IIC_RxBuffer[2];
 959  000a b638          	ld	a,_IIC_RxBuffer+2
 960  000c 6b03          	ld	(OFST-30,sp),a
 961                     ; 162 		hb.payload[0] = 0x06;
 963  000e a606          	ld	a,#6
 964  0010 6b04          	ld	(OFST-29,sp),a
 965                     ; 163 		hb.payload[1] = slc.MDID;
 967  0012 b66c          	ld	a,_slc+20
 968  0014 6b05          	ld	(OFST-28,sp),a
 969                     ; 164 		hb.payload[2] = slc.ch1_status;
 971  0016 b66d          	ld	a,_slc+21
 972  0018 6b06          	ld	(OFST-27,sp),a
 973                     ; 165 		hb.payload[3] = slc.ch2_status;
 975  001a b66e          	ld	a,_slc+22
 976  001c 6b07          	ld	(OFST-26,sp),a
 977                     ; 166 		hb.payload[4] = slc.ch3_status;
 979  001e b66f          	ld	a,_slc+23
 980  0020 6b08          	ld	(OFST-25,sp),a
 981                     ; 167 		hb.payload[5] = slc.ch4_status;
 983  0022 b670          	ld	a,_slc+24
 984  0024 6b09          	ld	(OFST-24,sp),a
 985                     ; 168 		i2c_init_message(&hb,6);
 987  0026 4b06          	push	#6
 988  0028 96            	ldw	x,sp
 989  0029 1c0002        	addw	x,#OFST-31
 990  002c cd0000        	call	_i2c_init_message
 992  002f 84            	pop	a
 993                     ; 169 	}
 996  0030 5b21          	addw	sp,#33
 997  0032 81            	ret
1036                     ; 171 	void rev_action_dimmer_OK(void)
1036                     ; 172 	{
1037                     .text:	section	.text,new
1038  0000               _rev_action_dimmer_OK:
1040  0000 5221          	subw	sp,#33
1041       00000021      OFST:	set	33
1044                     ; 174 		ad.frame_h1 = 0x7E;
1046  0002 a67e          	ld	a,#126
1047  0004 6b01          	ld	(OFST-32,sp),a
1048                     ; 175 		ad.frame_h2 = 0x7E;
1050  0006 a67e          	ld	a,#126
1051  0008 6b02          	ld	(OFST-31,sp),a
1052                     ; 176 		ad.message_id = IIC_RxBuffer[2];
1054  000a b638          	ld	a,_IIC_RxBuffer+2
1055  000c 6b03          	ld	(OFST-30,sp),a
1056                     ; 177 		ad.payload[0] = 0xAA;
1058  000e a6aa          	ld	a,#170
1059  0010 6b04          	ld	(OFST-29,sp),a
1060                     ; 178 		ad.payload[1] = 0x02;
1062  0012 a602          	ld	a,#2
1063  0014 6b05          	ld	(OFST-28,sp),a
1064                     ; 179 		ad.payload[2] = slc.MDID;
1066  0016 b66c          	ld	a,_slc+20
1067  0018 6b06          	ld	(OFST-27,sp),a
1068                     ; 180 		i2c_init_message(&ad,3);
1070  001a 4b03          	push	#3
1071  001c 96            	ldw	x,sp
1072  001d 1c0002        	addw	x,#OFST-31
1073  0020 cd0000        	call	_i2c_init_message
1075  0023 84            	pop	a
1076                     ; 181 	}
1079  0024 5b21          	addw	sp,#33
1080  0026 81            	ret
1118                     ; 184 	void rev_action_dimmer_done(void)
1118                     ; 185 	{
1119                     .text:	section	.text,new
1120  0000               _rev_action_dimmer_done:
1122  0000 5221          	subw	sp,#33
1123       00000021      OFST:	set	33
1126                     ; 187 		ad.frame_h1 = 0x7E;
1128  0002 a67e          	ld	a,#126
1129  0004 6b01          	ld	(OFST-32,sp),a
1130                     ; 188 		ad.frame_h2 = 0x7E;
1132  0006 a67e          	ld	a,#126
1133  0008 6b02          	ld	(OFST-31,sp),a
1134                     ; 189 		ad.message_id = 66;
1136  000a a642          	ld	a,#66
1137  000c 6b03          	ld	(OFST-30,sp),a
1138                     ; 190 		ad.payload[0] = 0xAA;
1140  000e a6aa          	ld	a,#170
1141  0010 6b04          	ld	(OFST-29,sp),a
1142                     ; 191 		ad.payload[1] = 0x05;
1144  0012 a605          	ld	a,#5
1145  0014 6b05          	ld	(OFST-28,sp),a
1146                     ; 192 		ad.payload[2] = slc.MDID;
1148  0016 b66c          	ld	a,_slc+20
1149  0018 6b06          	ld	(OFST-27,sp),a
1150                     ; 193 		ad.payload[3] = slc.ch1_status;
1152  001a b66d          	ld	a,_slc+21
1153  001c 6b07          	ld	(OFST-26,sp),a
1154                     ; 194 		ad.payload[4] = slc.ch2_status;
1156  001e b66e          	ld	a,_slc+22
1157  0020 6b08          	ld	(OFST-25,sp),a
1158                     ; 195 		ad.payload[5] = slc.ch3_status;
1160  0022 b66f          	ld	a,_slc+23
1161  0024 6b09          	ld	(OFST-24,sp),a
1162                     ; 196 		ad.payload[6] = slc.ch4_status;
1164  0026 b670          	ld	a,_slc+24
1165  0028 6b0a          	ld	(OFST-23,sp),a
1166                     ; 197 		i2c_init_message(&ad,7);
1168  002a 4b07          	push	#7
1169  002c 96            	ldw	x,sp
1170  002d 1c0002        	addw	x,#OFST-31
1171  0030 cd0000        	call	_i2c_init_message
1173  0033 84            	pop	a
1174                     ; 198 	}
1177  0034 5b21          	addw	sp,#33
1178  0036 81            	ret
1204                     ; 202 	void I2C_transaction_end(void)
1204                     ; 203 	{
1205                     .text:	section	.text,new
1206  0000               _I2C_transaction_end:
1210                     ; 204 		ReceiveState = IIC_STATE_END;
1212  0000 35030001      	mov	_ReceiveState,#3
1213                     ; 205 		ReceiveState = IIC_STATE_UNKNOWN;
1215  0004 3f01          	clr	_ReceiveState
1216                     ; 206 			GetDataIndex = 0;
1218  0006 3f00          	clr	_GetDataIndex
1219                     ; 207 	}	
1222  0008 81            	ret
1247                     ; 209 	void I2C_transaction_receive(void)
1247                     ; 210 	{
1248                     .text:	section	.text,new
1249  0000               _I2C_transaction_receive:
1253                     ; 211 		ReceiveState = IIC_STATE_RECEIVEING;
1255  0000 35020001      	mov	_ReceiveState,#2
1256                     ; 212 	}
1259  0004 81            	ret
1296                     ; 214 	void I2C_byte_received(uint8_t RxData)
1296                     ; 215 	{
1297                     .text:	section	.text,new
1298  0000               _I2C_byte_received:
1300  0000 88            	push	a
1301       00000000      OFST:	set	0
1304                     ; 216 		if(GetDataIndex < MAX_BUFFER) {
1306  0001 b600          	ld	a,_GetDataIndex
1307  0003 a120          	cp	a,#32
1308  0005 2410          	jruge	L534
1309                     ; 217 			IIC_RxBuffer[GetDataIndex++] = RxData;
1311  0007 b600          	ld	a,_GetDataIndex
1312  0009 97            	ld	xl,a
1313  000a 3c00          	inc	_GetDataIndex
1314  000c 9f            	ld	a,xl
1315  000d 5f            	clrw	x
1316  000e 97            	ld	xl,a
1317  000f 7b01          	ld	a,(OFST+1,sp)
1318  0011 e736          	ld	(_IIC_RxBuffer,x),a
1319                     ; 218 			ReceiveState = IIC_STATE_RECEIVEING;
1321  0013 35020001      	mov	_ReceiveState,#2
1322  0017               L534:
1323                     ; 220 	}
1326  0017 84            	pop	a
1327  0018 81            	ret
1352                     ; 222 	uint8_t I2C_byte_write(void)
1352                     ; 223 	{
1353                     .text:	section	.text,new
1354  0000               _I2C_byte_write:
1358                     ; 224 			return IIC_TxBuffer[SendDataIndex++];
1360  0000 b602          	ld	a,_SendDataIndex
1361  0002 97            	ld	xl,a
1362  0003 3c02          	inc	_SendDataIndex
1363  0005 9f            	ld	a,xl
1364  0006 5f            	clrw	x
1365  0007 97            	ld	xl,a
1366  0008 e616          	ld	a,(_IIC_TxBuffer,x)
1369  000a 81            	ret
1372                     	switch	.ubsct
1373  0000               L744_sr1:
1374  0000 00            	ds.b	1
1375  0001               L154_sr2:
1376  0001 00            	ds.b	1
1377  0002               L354_sr3:
1378  0002 00            	ds.b	1
1434                     ; 234 @far @interrupt void I2C_Slave_check_event(void) {
1436                     .text:	section	.text,new
1437  0000               f_I2C_Slave_check_event:
1440  0000 3b0002        	push	c_x+2
1441  0003 be00          	ldw	x,c_x
1442  0005 89            	pushw	x
1443  0006 3b0002        	push	c_y+2
1444  0009 be00          	ldw	x,c_y
1445  000b 89            	pushw	x
1448                     ; 241 	sr1 = I2C->SR1;
1450  000c 5552170000    	mov	L744_sr1,21015
1451                     ; 242 	sr2 = I2C->SR2;
1453  0011 5552180001    	mov	L154_sr2,21016
1454                     ; 243 	sr3 = I2C->SR3;
1456  0016 5552190002    	mov	L354_sr3,21017
1457                     ; 246   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
1459  001b b601          	ld	a,L154_sr2
1460  001d a52b          	bcp	a,#43
1461  001f 2708          	jreq	L305
1462                     ; 248     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
1464  0021 72125211      	bset	21009,#1
1465                     ; 249     I2C->SR2= 0;					    // clear all error flags
1467  0025 725f5218      	clr	21016
1468  0029               L305:
1469                     ; 252   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
1471  0029 b600          	ld	a,L744_sr1
1472  002b a444          	and	a,#68
1473  002d a144          	cp	a,#68
1474  002f 2606          	jrne	L505
1475                     ; 254     I2C_byte_received(I2C->DR);
1477  0031 c65216        	ld	a,21014
1478  0034 cd0000        	call	_I2C_byte_received
1480  0037               L505:
1481                     ; 257   if (sr1 & I2C_SR1_RXNE)
1483  0037 b600          	ld	a,L744_sr1
1484  0039 a540          	bcp	a,#64
1485  003b 2706          	jreq	L705
1486                     ; 259     I2C_byte_received(I2C->DR);
1488  003d c65216        	ld	a,21014
1489  0040 cd0000        	call	_I2C_byte_received
1491  0043               L705:
1492                     ; 262   if (sr2 & I2C_SR2_AF)
1494  0043 b601          	ld	a,L154_sr2
1495  0045 a504          	bcp	a,#4
1496  0047 2707          	jreq	L115
1497                     ; 264     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
1499  0049 72155218      	bres	21016,#2
1500                     ; 265 		I2C_transaction_end();
1502  004d cd0000        	call	_I2C_transaction_end
1504  0050               L115:
1505                     ; 268   if (sr1 & I2C_SR1_STOPF) 
1507  0050 b600          	ld	a,L744_sr1
1508  0052 a510          	bcp	a,#16
1509  0054 2707          	jreq	L315
1510                     ; 270     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
1512  0056 72145211      	bset	21009,#2
1513                     ; 271 		I2C_transaction_end();
1515  005a cd0000        	call	_I2C_transaction_end
1517  005d               L315:
1518                     ; 274   if (sr1 & I2C_SR1_ADDR)
1520  005d b600          	ld	a,L744_sr1
1521  005f a502          	bcp	a,#2
1522  0061 270e          	jreq	L515
1523                     ; 276 		if(sr3 & I2C_SR3_TRA){//从机发送数据
1525  0063 b602          	ld	a,L354_sr3
1526  0065 a504          	bcp	a,#4
1527  0067 2705          	jreq	L715
1528                     ; 277 			I2C_transaction_begin();
1530  0069 cd0000        	call	_I2C_transaction_begin
1533  006c 2003          	jra	L515
1534  006e               L715:
1535                     ; 279 			I2C_receive_begin();//从机接收数据
1537  006e cd0000        	call	_I2C_receive_begin
1539  0071               L515:
1540                     ; 283   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
1542  0071 b600          	ld	a,L744_sr1
1543  0073 a484          	and	a,#132
1544  0075 a184          	cp	a,#132
1545  0077 2606          	jrne	L325
1546                     ; 285 		I2C->DR = I2C_byte_write();
1548  0079 cd0000        	call	_I2C_byte_write
1550  007c c75216        	ld	21014,a
1551  007f               L325:
1552                     ; 288   if (sr1 & I2C_SR1_TXE)
1554  007f b600          	ld	a,L744_sr1
1555  0081 a580          	bcp	a,#128
1556  0083 2706          	jreq	L525
1557                     ; 290 		I2C->DR = I2C_byte_write();
1559  0085 cd0000        	call	_I2C_byte_write
1561  0088 c75216        	ld	21014,a
1562  008b               L525:
1563                     ; 293 }
1566  008b 85            	popw	x
1567  008c bf00          	ldw	c_y,x
1568  008e 320002        	pop	c_y+2
1569  0091 85            	popw	x
1570  0092 bf00          	ldw	c_x,x
1571  0094 320002        	pop	c_x+2
1572  0097 80            	iret
1595                     ; 298 void IIC_SlaveConfig (void)
1595                     ; 299 {
1597                     .text:	section	.text,new
1598  0000               _IIC_SlaveConfig:
1602                     ; 305   GPIOB->ODR |= (1<<4)|(1<<5);                //define SDA, SCL outputs, HiZ, Open drain, Fast
1604  0000 c65005        	ld	a,20485
1605  0003 aa30          	or	a,#48
1606  0005 c75005        	ld	20485,a
1607                     ; 306   GPIOB->DDR |= (1<<4)|(1<<5);
1609  0008 c65007        	ld	a,20487
1610  000b aa30          	or	a,#48
1611  000d c75007        	ld	20487,a
1612                     ; 307   GPIOB->CR2 |= (1<<4)|(1<<5);
1614  0010 c65009        	ld	a,20489
1615  0013 aa30          	or	a,#48
1616  0015 c75009        	ld	20489,a
1617                     ; 310 		I2C->CR1 |= 0x01;				        	// Enable I2C peripheral
1619  0018 72105210      	bset	21008,#0
1620                     ; 311 		I2C->CR2 = 0x04;					      		// Enable I2C acknowledgement
1622  001c 35045211      	mov	21009,#4
1623                     ; 312 		I2C->FREQR = 16; 					      	// Set I2C Freq value (16MHz)
1625  0020 35105212      	mov	21010,#16
1626                     ; 314 		I2C->OARL = (SLAVE_ADDRESS << 1) ;	// set slave address to 0x51 (put 0xA2 for the register dues to7bit address) 
1628  0024 b657          	ld	a,_slave_address
1629  0026 48            	sll	a
1630  0027 c75213        	ld	21011,a
1631                     ; 315 		I2C->OARH = 0x40;					      	// Set 7bit address mode
1633  002a 35405214      	mov	21012,#64
1634                     ; 328 	I2C->ITR	= 0x07;					      // all I2C interrupt enable  
1636  002e 3507521a      	mov	21018,#7
1637                     ; 329 }
1640  0032 81            	ret
1995                     	xdef	_I2C_byte_write
1996                     	xdef	_I2C_byte_received
1997                     	xdef	_I2C_transaction_receive
1998                     	xdef	_I2C_transaction_end
1999                     	xdef	_I2C_transaction_begin
2000                     	xdef	_I2C_receive_begin
2001                     	xdef	_i2c_init_message
2002                     	xdef	_Check_Sum
2003                     	xdef	_mymemcpy
2004                     	switch	.ubsct
2005  0003               _action_flag:
2006  0003 00            	ds.b	1
2007                     	xdef	_action_flag
2008  0004               _change_step2:
2009  0004 00000000      	ds.b	4
2010                     	xdef	_change_step2
2011  0008               _change_step1:
2012  0008 00000000      	ds.b	4
2013                     	xdef	_change_step1
2014  000c               _change_time:
2015  000c 00            	ds.b	1
2016                     	xdef	_change_time
2017  000d               _aim_bright2:
2018  000d 00000000      	ds.b	4
2019                     	xdef	_aim_bright2
2020  0011               _aim_bright1:
2021  0011 00000000      	ds.b	4
2022                     	xdef	_aim_bright1
2023  0015               _channel:
2024  0015 00            	ds.b	1
2025                     	xdef	_channel
2026                     	xref.b	_last_bright2
2027                     	xref.b	_last_bright1
2028                     	xdef	_SendDataIndex
2029                     	xdef	_ReceiveState
2030                     	xdef	_GetDataIndex
2031  0016               _IIC_TxBuffer:
2032  0016 000000000000  	ds.b	32
2033                     	xdef	_IIC_TxBuffer
2034  0036               _IIC_RxBuffer:
2035  0036 000000000000  	ds.b	32
2036                     	xdef	_IIC_RxBuffer
2037  0056               _action_done:
2038  0056 00            	ds.b	1
2039                     	xdef	_action_done
2040  0057               _slave_address:
2041  0057 00            	ds.b	1
2042                     	xdef	_slave_address
2043  0058               _slc:
2044  0058 000000000000  	ds.b	25
2045                     	xdef	_slc
2046                     	xdef	_rev_action_dimmer_done
2047                     	xdef	_rev_action_dimmer_OK
2048                     	xdef	_rev_heart_breat
2049                     	xdef	_init_device_info
2050                     	xdef	f_I2C_Slave_check_event
2051                     	xdef	_IIC_SlaveConfig
2052                     .const:	section	.text
2053  0000               L362:
2054  0000 42c80000      	dc.w	17096,0
2055                     	xref.b	c_lreg
2056                     	xref.b	c_x
2057                     	xref.b	c_y
2077                     	xref	c_fsub
2078                     	xref	c_rtol
2079                     	xref	c_fdiv
2080                     	xref	c_itof
2081                     	xref	c_lrzmp
2082                     	xref	c_lgsbc
2083                     	xref	c_ltor
2084                     	end
