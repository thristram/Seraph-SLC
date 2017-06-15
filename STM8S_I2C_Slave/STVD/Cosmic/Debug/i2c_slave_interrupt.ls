   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               _GetDataIndex:
   6  0000 00            	dc.b	0
   7  0001               _ReceiveState:
   8  0001 00            	dc.b	0
   9  0002               _SendDataIndex:
  10  0002 00            	dc.b	0
  11  0003               _up:
  12  0003 00            	dc.b	0
  13  0004               _down:
  14  0004 00            	dc.b	0
  95                     ; 34 void mymemcpy(void *des,void *src,u32 n)  
  95                     ; 35 {  
  97                     .text:	section	.text,new
  98  0000               _mymemcpy:
 100  0000 89            	pushw	x
 101  0001 5204          	subw	sp,#4
 102       00000004      OFST:	set	4
 105                     ; 36   u8 *xdes=des;
 107  0003 1f01          	ldw	(OFST-3,sp),x
 108                     ; 37 	u8 *xsrc=src; 
 110  0005 1e09          	ldw	x,(OFST+5,sp)
 111  0007 1f03          	ldw	(OFST-1,sp),x
 113  0009 2016          	jra	L35
 114  000b               L74:
 115                     ; 38   while(n--)*xdes++=*xsrc++;  
 117  000b 1e03          	ldw	x,(OFST-1,sp)
 118  000d 1c0001        	addw	x,#1
 119  0010 1f03          	ldw	(OFST-1,sp),x
 120  0012 1d0001        	subw	x,#1
 121  0015 f6            	ld	a,(x)
 122  0016 1e01          	ldw	x,(OFST-3,sp)
 123  0018 1c0001        	addw	x,#1
 124  001b 1f01          	ldw	(OFST-3,sp),x
 125  001d 1d0001        	subw	x,#1
 126  0020 f7            	ld	(x),a
 127  0021               L35:
 130  0021 96            	ldw	x,sp
 131  0022 1c000b        	addw	x,#OFST+7
 132  0025 cd0000        	call	c_ltor
 134  0028 96            	ldw	x,sp
 135  0029 1c000b        	addw	x,#OFST+7
 136  002c a601          	ld	a,#1
 137  002e cd0000        	call	c_lgsbc
 139  0031 cd0000        	call	c_lrzmp
 141  0034 26d5          	jrne	L74
 142                     ; 39 }  
 145  0036 5b06          	addw	sp,#6
 146  0038 81            	ret
 208                     ; 45 u8 Check_Sum(u8 *buf,u8 length)
 208                     ; 46 {
 209                     .text:	section	.text,new
 210  0000               _Check_Sum:
 212  0000 89            	pushw	x
 213  0001 89            	pushw	x
 214       00000002      OFST:	set	2
 217                     ; 48 	u8 result = *buf++;
 219  0002 1e03          	ldw	x,(OFST+1,sp)
 220  0004 1c0001        	addw	x,#1
 221  0007 1f03          	ldw	(OFST+1,sp),x
 222  0009 1d0001        	subw	x,#1
 223  000c f6            	ld	a,(x)
 224  000d 6b01          	ld	(OFST-1,sp),a
 225                     ; 49 	for(i = 1;i < length;i++)
 227  000f a601          	ld	a,#1
 228  0011 6b02          	ld	(OFST+0,sp),a
 230  0013 2011          	jra	L511
 231  0015               L111:
 232                     ; 51 		result ^= *buf++;
 234  0015 1e03          	ldw	x,(OFST+1,sp)
 235  0017 1c0001        	addw	x,#1
 236  001a 1f03          	ldw	(OFST+1,sp),x
 237  001c 1d0001        	subw	x,#1
 238  001f 7b01          	ld	a,(OFST-1,sp)
 239  0021 f8            	xor	a,	(x)
 240  0022 6b01          	ld	(OFST-1,sp),a
 241                     ; 49 	for(i = 1;i < length;i++)
 243  0024 0c02          	inc	(OFST+0,sp)
 244  0026               L511:
 247  0026 7b02          	ld	a,(OFST+0,sp)
 248  0028 1107          	cp	a,(OFST+5,sp)
 249  002a 25e9          	jrult	L111
 250                     ; 53 	return result;
 252  002c 7b01          	ld	a,(OFST-1,sp)
 255  002e 5b04          	addw	sp,#4
 256  0030 81            	ret
 343                     ; 57 u8 i2c_init_message(I2C_Message *tx,u8 payload_len)
 343                     ; 58 {
 344                     .text:	section	.text,new
 345  0000               _i2c_init_message:
 347  0000 89            	pushw	x
 348       00000000      OFST:	set	0
 351                     ; 59 	IIC_TxBuffer[0] = tx->frame_h1;
 353  0001 f6            	ld	a,(x)
 354  0002 b70c          	ld	_IIC_TxBuffer,a
 355                     ; 60 	IIC_TxBuffer[1] = tx->frame_h2;
 357  0004 e601          	ld	a,(1,x)
 358  0006 b70d          	ld	_IIC_TxBuffer+1,a
 359                     ; 61 	IIC_TxBuffer[2] = tx->message_id;
 361  0008 e602          	ld	a,(2,x)
 362  000a b70e          	ld	_IIC_TxBuffer+2,a
 363                     ; 62 	IIC_TxBuffer[3] = 2+payload_len;
 365  000c 7b05          	ld	a,(OFST+5,sp)
 366  000e ab02          	add	a,#2
 367  0010 b70f          	ld	_IIC_TxBuffer+3,a
 368                     ; 63 	mymemcpy(&IIC_TxBuffer[4],tx->payload,payload_len);
 370  0012 7b05          	ld	a,(OFST+5,sp)
 371  0014 b703          	ld	c_lreg+3,a
 372  0016 3f02          	clr	c_lreg+2
 373  0018 3f01          	clr	c_lreg+1
 374  001a 3f00          	clr	c_lreg
 375  001c be02          	ldw	x,c_lreg+2
 376  001e 89            	pushw	x
 377  001f be00          	ldw	x,c_lreg
 378  0021 89            	pushw	x
 379  0022 1e05          	ldw	x,(OFST+5,sp)
 380  0024 1c0003        	addw	x,#3
 381  0027 89            	pushw	x
 382  0028 ae0010        	ldw	x,#_IIC_TxBuffer+4
 383  002b cd0000        	call	_mymemcpy
 385  002e 5b06          	addw	sp,#6
 386                     ; 64 	IIC_TxBuffer[4+payload_len] = Check_Sum(&IIC_TxBuffer[2],IIC_TxBuffer[3]);
 388  0030 7b05          	ld	a,(OFST+5,sp)
 389  0032 5f            	clrw	x
 390  0033 97            	ld	xl,a
 391  0034 89            	pushw	x
 392  0035 3b000f        	push	_IIC_TxBuffer+3
 393  0038 ae000e        	ldw	x,#_IIC_TxBuffer+2
 394  003b cd0000        	call	_Check_Sum
 396  003e 5b01          	addw	sp,#1
 397  0040 85            	popw	x
 398  0041 e710          	ld	(_IIC_TxBuffer+4,x),a
 399                     ; 66 }
 402  0043 85            	popw	x
 403  0044 81            	ret
 427                     ; 68 	void I2C_receive_begin(void)
 427                     ; 69 	{
 428                     .text:	section	.text,new
 429  0000               _I2C_receive_begin:
 433                     ; 70 		ReceiveState = IIC_STATE_BEGIN;
 435  0000 35010001      	mov	_ReceiveState,#1
 436                     ; 71 	}
 439  0004 81            	ret
 490                     ; 73 	void I2C_transaction_begin(void)
 490                     ; 74 	{
 491                     .text:	section	.text,new
 492  0000               _I2C_transaction_begin:
 494  0000 88            	push	a
 495       00000001      OFST:	set	1
 498                     ; 77 		SendDataIndex = 0;
 500  0001 3f02          	clr	_SendDataIndex
 501                     ; 78 		cmd = IIC_RxBuffer[4];
 503  0003 b630          	ld	a,_IIC_RxBuffer+4
 504  0005 6b01          	ld	(OFST+0,sp),a
 505                     ; 106 		if((IIC_RxBuffer[0] == 0x7E) && (IIC_RxBuffer[1] == 0x7E)){
 507  0007 b62c          	ld	a,_IIC_RxBuffer
 508  0009 a17e          	cp	a,#126
 509  000b 2703          	jreq	L22
 510  000d cc01e1        	jp	L132
 511  0010               L22:
 513  0010 b62d          	ld	a,_IIC_RxBuffer+1
 514  0012 a17e          	cp	a,#126
 515  0014 2703          	jreq	L42
 516  0016 cc01e1        	jp	L132
 517  0019               L42:
 518                     ; 107 			switch(cmd){
 520  0019 7b01          	ld	a,(OFST+0,sp)
 522                     ; 172 				default:
 522                     ; 173 				break;
 523  001b a003          	sub	a,#3
 524  001d 2734          	jreq	L571
 525  001f a04e          	sub	a,#78
 526  0021 275b          	jreq	L771
 527  0023 4a            	dec	a
 528  0024 2603          	jrne	L62
 529  0026 cc0110        	jp	L102
 530  0029               L62:
 531  0029 4a            	dec	a
 532  002a 2603          	jrne	L03
 533  002c cc0152        	jp	L302
 534  002f               L03:
 535  002f 4a            	dec	a
 536  0030 2603          	jrne	L23
 537  0032 cc0194        	jp	L502
 538  0035               L23:
 539  0035 a005          	sub	a,#5
 540  0037 2603          	jrne	L43
 541  0039 cc01d8        	jp	L702
 542  003c               L43:
 543  003c a0a5          	sub	a,#165
 544  003e 2703          	jreq	L63
 545  0040 cc01e1        	jp	L132
 546  0043               L63:
 547                     ; 108 				case 0xFE:
 547                     ; 109 					if(IIC_RxBuffer[5] == 0x01)	init_device_info();
 549  0043 b631          	ld	a,_IIC_RxBuffer+5
 550  0045 a101          	cp	a,#1
 551  0047 2703          	jreq	L04
 552  0049 cc01e1        	jp	L132
 553  004c               L04:
 556  004c cd0000        	call	_init_device_info
 558  004f ace101e1      	jpf	L132
 559  0053               L571:
 560                     ; 111 				case 0x03:
 560                     ; 112 					if((IIC_RxBuffer[5] == 0x03)&&(IIC_RxBuffer[6] == slave_address)){
 562  0053 b631          	ld	a,_IIC_RxBuffer+5
 563  0055 a103          	cp	a,#3
 564  0057 2703          	jreq	L24
 565  0059 cc01e1        	jp	L132
 566  005c               L24:
 568  005c b632          	ld	a,_IIC_RxBuffer+6
 569  005e b14d          	cp	a,_slave_address
 570  0060 2703          	jreq	L44
 571  0062 cc01e1        	jp	L132
 572  0065               L44:
 573                     ; 114 						if(Check_Sum(&IIC_RxBuffer[2],IIC_RxBuffer[3]) == IIC_RxBuffer[7]){
 575  0065 3b002f        	push	_IIC_RxBuffer+3
 576  0068 ae002e        	ldw	x,#_IIC_RxBuffer+2
 577  006b cd0000        	call	_Check_Sum
 579  006e 5b01          	addw	sp,#1
 580  0070 b133          	cp	a,_IIC_RxBuffer+7
 581  0072 2703          	jreq	L64
 582  0074 cc01e1        	jp	L132
 583  0077               L64:
 584                     ; 115 							rev_heart_breat();
 586  0077 cd0000        	call	_rev_heart_breat
 588  007a ace101e1      	jpf	L132
 589  007e               L771:
 590                     ; 119 				case 0x51://Linear
 590                     ; 120 					if(((IIC_RxBuffer[5]&0xf0)>>4) == slave_address){
 592  007e b631          	ld	a,_IIC_RxBuffer+5
 593  0080 a4f0          	and	a,#240
 594  0082 4e            	swap	a
 595  0083 a40f          	and	a,#15
 596  0085 5f            	clrw	x
 597  0086 97            	ld	xl,a
 598  0087 b64d          	ld	a,_slave_address
 599  0089 905f          	clrw	y
 600  008b 9097          	ld	yl,a
 601  008d 90bf01        	ldw	c_y+1,y
 602  0090 b301          	cpw	x,c_y+1
 603  0092 267c          	jrne	L102
 604                     ; 122 						channel = (IIC_RxBuffer[5]&0x0f);
 606  0094 b631          	ld	a,_IIC_RxBuffer+5
 607  0096 a40f          	and	a,#15
 608  0098 b70b          	ld	_channel,a
 609                     ; 123 						aim_bright_float = (float)IIC_RxBuffer[6] * 2.5;
 611  009a b632          	ld	a,_IIC_RxBuffer+6
 612  009c 5f            	clrw	x
 613  009d 97            	ld	xl,a
 614  009e cd0000        	call	c_itof
 616  00a1 ae0000        	ldw	x,#L352
 617  00a4 cd0000        	call	c_fmul
 619  00a7 ae0007        	ldw	x,#_aim_bright_float
 620  00aa cd0000        	call	c_rtol
 622                     ; 124 						aim_bright = (uint8_t)aim_bright_float;
 624  00ad ae0007        	ldw	x,#_aim_bright_float
 625  00b0 cd0000        	call	c_ltor
 627  00b3 cd0000        	call	c_ftol
 629  00b6 b603          	ld	a,c_lreg+3
 630  00b8 b706          	ld	_aim_bright,a
 631                     ; 125 						change_time = IIC_RxBuffer[7];
 633  00ba 453305        	mov	_change_time,_IIC_RxBuffer+7
 634                     ; 126 						if(aim_bright > last_bright){
 636  00bd b606          	ld	a,_aim_bright
 637  00bf b100          	cp	a,_last_bright
 638  00c1 2326          	jrule	L752
 639                     ; 127 							up = TRUE;down = FALSE;
 641  00c3 35010003      	mov	_up,#1
 644  00c7 3f04          	clr	_down
 645                     ; 128 							change_step = (aim_bright - last_bright)/change_time;
 647  00c9 b606          	ld	a,_aim_bright
 648  00cb 5f            	clrw	x
 649  00cc b000          	sub	a,_last_bright
 650  00ce 2401          	jrnc	L61
 651  00d0 5a            	decw	x
 652  00d1               L61:
 653  00d1 02            	rlwa	x,a
 654  00d2 b605          	ld	a,_change_time
 655  00d4 905f          	clrw	y
 656  00d6 9097          	ld	yl,a
 657  00d8 cd0000        	call	c_idiv
 659  00db 01            	rrwa	x,a
 660  00dc b704          	ld	_change_step,a
 661  00de 02            	rlwa	x,a
 662                     ; 129 							if(change_step < 1)	change_step = 1;
 664  00df 3d04          	tnz	_change_step
 665  00e1 262a          	jrne	L362
 668  00e3 35010004      	mov	_change_step,#1
 669  00e7 2024          	jra	L362
 670  00e9               L752:
 671                     ; 132 							up = FALSE;down = TRUE;
 673  00e9 3f03          	clr	_up
 676  00eb 35010004      	mov	_down,#1
 677                     ; 133 							change_step = (last_bright - aim_bright)/change_time;
 679  00ef b600          	ld	a,_last_bright
 680  00f1 5f            	clrw	x
 681  00f2 b006          	sub	a,_aim_bright
 682  00f4 2401          	jrnc	L02
 683  00f6 5a            	decw	x
 684  00f7               L02:
 685  00f7 02            	rlwa	x,a
 686  00f8 b605          	ld	a,_change_time
 687  00fa 905f          	clrw	y
 688  00fc 9097          	ld	yl,a
 689  00fe cd0000        	call	c_idiv
 691  0101 01            	rrwa	x,a
 692  0102 b704          	ld	_change_step,a
 693  0104 02            	rlwa	x,a
 694                     ; 134 							if(change_step < 1)	change_step = 1;
 696  0105 3d04          	tnz	_change_step
 697  0107 2604          	jrne	L362
 700  0109 35010004      	mov	_change_step,#1
 701  010d               L362:
 702                     ; 136 						rev_action_dimmer_OK();
 704  010d cd0000        	call	_rev_action_dimmer_OK
 706  0110               L102:
 707                     ; 138 				case 0x52://Erase in
 707                     ; 139 					if(((IIC_RxBuffer[5]&0xf0)>>4) == slave_address){
 709  0110 b631          	ld	a,_IIC_RxBuffer+5
 710  0112 a4f0          	and	a,#240
 711  0114 4e            	swap	a
 712  0115 a40f          	and	a,#15
 713  0117 5f            	clrw	x
 714  0118 97            	ld	xl,a
 715  0119 b64d          	ld	a,_slave_address
 716  011b 905f          	clrw	y
 717  011d 9097          	ld	yl,a
 718  011f 90bf01        	ldw	c_y+1,y
 719  0122 b301          	cpw	x,c_y+1
 720  0124 262c          	jrne	L302
 721                     ; 141 						channel = (IIC_RxBuffer[5]&0x0f);
 723  0126 b631          	ld	a,_IIC_RxBuffer+5
 724  0128 a40f          	and	a,#15
 725  012a b70b          	ld	_channel,a
 726                     ; 142 						aim_bright_float = (float)IIC_RxBuffer[6] * 2.5;
 728  012c b632          	ld	a,_IIC_RxBuffer+6
 729  012e 5f            	clrw	x
 730  012f 97            	ld	xl,a
 731  0130 cd0000        	call	c_itof
 733  0133 ae0000        	ldw	x,#L352
 734  0136 cd0000        	call	c_fmul
 736  0139 ae0007        	ldw	x,#_aim_bright_float
 737  013c cd0000        	call	c_rtol
 739                     ; 143 						aim_bright = (uint8_t)aim_bright_float;
 741  013f ae0007        	ldw	x,#_aim_bright_float
 742  0142 cd0000        	call	c_ltor
 744  0145 cd0000        	call	c_ftol
 746  0148 b603          	ld	a,c_lreg+3
 747  014a b706          	ld	_aim_bright,a
 748                     ; 144 						change_time = IIC_RxBuffer[7];
 750  014c 453305        	mov	_change_time,_IIC_RxBuffer+7
 751                     ; 145 						rev_action_dimmer_OK();
 753  014f cd0000        	call	_rev_action_dimmer_OK
 755  0152               L302:
 756                     ; 147 				case 0x53://Erase out
 756                     ; 148 					if(((IIC_RxBuffer[5]&0xf0)>>4) == slave_address){
 758  0152 b631          	ld	a,_IIC_RxBuffer+5
 759  0154 a4f0          	and	a,#240
 760  0156 4e            	swap	a
 761  0157 a40f          	and	a,#15
 762  0159 5f            	clrw	x
 763  015a 97            	ld	xl,a
 764  015b b64d          	ld	a,_slave_address
 765  015d 905f          	clrw	y
 766  015f 9097          	ld	yl,a
 767  0161 90bf01        	ldw	c_y+1,y
 768  0164 b301          	cpw	x,c_y+1
 769  0166 262c          	jrne	L502
 770                     ; 150 						channel = (IIC_RxBuffer[5]&0x0f);
 772  0168 b631          	ld	a,_IIC_RxBuffer+5
 773  016a a40f          	and	a,#15
 774  016c b70b          	ld	_channel,a
 775                     ; 151 						aim_bright_float = (float)IIC_RxBuffer[6] * 2.5;
 777  016e b632          	ld	a,_IIC_RxBuffer+6
 778  0170 5f            	clrw	x
 779  0171 97            	ld	xl,a
 780  0172 cd0000        	call	c_itof
 782  0175 ae0000        	ldw	x,#L352
 783  0178 cd0000        	call	c_fmul
 785  017b ae0007        	ldw	x,#_aim_bright_float
 786  017e cd0000        	call	c_rtol
 788                     ; 152 						aim_bright = (uint8_t)aim_bright_float;
 790  0181 ae0007        	ldw	x,#_aim_bright_float
 791  0184 cd0000        	call	c_ltor
 793  0187 cd0000        	call	c_ftol
 795  018a b603          	ld	a,c_lreg+3
 796  018c b706          	ld	_aim_bright,a
 797                     ; 153 						change_time = IIC_RxBuffer[7];
 799  018e 453305        	mov	_change_time,_IIC_RxBuffer+7
 800                     ; 154 						rev_action_dimmer_OK();
 802  0191 cd0000        	call	_rev_action_dimmer_OK
 804  0194               L502:
 805                     ; 156 				case 0x54://Swing
 805                     ; 157 					if(((IIC_RxBuffer[5]&0xf0)>>4) == slave_address){
 807  0194 b631          	ld	a,_IIC_RxBuffer+5
 808  0196 a4f0          	and	a,#240
 809  0198 4e            	swap	a
 810  0199 a40f          	and	a,#15
 811  019b 5f            	clrw	x
 812  019c 97            	ld	xl,a
 813  019d b64d          	ld	a,_slave_address
 814  019f 905f          	clrw	y
 815  01a1 9097          	ld	yl,a
 816  01a3 90bf01        	ldw	c_y+1,y
 817  01a6 b301          	cpw	x,c_y+1
 818  01a8 2637          	jrne	L132
 819                     ; 159 						channel = (IIC_RxBuffer[5]&0x0f);
 821  01aa b631          	ld	a,_IIC_RxBuffer+5
 822  01ac a40f          	and	a,#15
 823  01ae b70b          	ld	_channel,a
 824                     ; 160 						aim_bright_float = (float)IIC_RxBuffer[6] * 2.5;
 826  01b0 b632          	ld	a,_IIC_RxBuffer+6
 827  01b2 5f            	clrw	x
 828  01b3 97            	ld	xl,a
 829  01b4 cd0000        	call	c_itof
 831  01b7 ae0000        	ldw	x,#L352
 832  01ba cd0000        	call	c_fmul
 834  01bd ae0007        	ldw	x,#_aim_bright_float
 835  01c0 cd0000        	call	c_rtol
 837                     ; 161 						aim_bright = (uint8_t)aim_bright_float;
 839  01c3 ae0007        	ldw	x,#_aim_bright_float
 840  01c6 cd0000        	call	c_ltor
 842  01c9 cd0000        	call	c_ftol
 844  01cc b603          	ld	a,c_lreg+3
 845  01ce b706          	ld	_aim_bright,a
 846                     ; 162 						change_time = IIC_RxBuffer[7];
 848  01d0 453305        	mov	_change_time,_IIC_RxBuffer+7
 849                     ; 163 						rev_action_dimmer_OK();
 851  01d3 cd0000        	call	_rev_action_dimmer_OK
 853  01d6 2009          	jra	L132
 854  01d8               L702:
 855                     ; 167 				case 0x59://调光时间结束后SC发送查询ch状态
 855                     ; 168 					if(IIC_RxBuffer[5] == slave_address){//查询action dimmer执行后SLC状态
 857  01d8 b631          	ld	a,_IIC_RxBuffer+5
 858  01da b14d          	cp	a,_slave_address
 859  01dc 2603          	jrne	L132
 860                     ; 169 						rev_action_dimmer_done();
 862  01de cd0000        	call	_rev_action_dimmer_done
 864  01e1               L112:
 865                     ; 172 				default:
 865                     ; 173 				break;
 867  01e1               L532:
 868  01e1               L132:
 869                     ; 177 	}
 872  01e1 84            	pop	a
 873  01e2 81            	ret
 911                     ; 179 	void init_device_info(void)
 911                     ; 180 	{
 912                     .text:	section	.text,new
 913  0000               _init_device_info:
 915  0000 5221          	subw	sp,#33
 916       00000021      OFST:	set	33
 919                     ; 182 		di.frame_h1 = 0x7E;
 921  0002 a67e          	ld	a,#126
 922  0004 6b01          	ld	(OFST-32,sp),a
 923                     ; 183 		di.frame_h2 = 0x7E;
 925  0006 a67e          	ld	a,#126
 926  0008 6b02          	ld	(OFST-31,sp),a
 927                     ; 184 		di.message_id = IIC_RxBuffer[2];
 929  000a b62e          	ld	a,_IIC_RxBuffer+2
 930  000c 6b03          	ld	(OFST-30,sp),a
 931                     ; 185 		di.payload[0] = 0xB2;
 933  000e a6b2          	ld	a,#178
 934  0010 6b04          	ld	(OFST-29,sp),a
 935                     ; 186 		di.payload[1] = 0x01;
 937  0012 a601          	ld	a,#1
 938  0014 6b05          	ld	(OFST-28,sp),a
 939                     ; 187 		di.payload[2] = 0x01;
 941  0016 a601          	ld	a,#1
 942  0018 6b06          	ld	(OFST-27,sp),a
 943                     ; 188 		di.payload[3] = 0x01;
 945  001a a601          	ld	a,#1
 946  001c 6b07          	ld	(OFST-26,sp),a
 947                     ; 189 		di.payload[4] = 0x01;
 949  001e a601          	ld	a,#1
 950  0020 6b08          	ld	(OFST-25,sp),a
 951                     ; 190 		di.payload[5] = 0x63;
 953  0022 a663          	ld	a,#99
 954  0024 6b09          	ld	(OFST-24,sp),a
 955                     ; 191 		di.payload[6] = 0x00;
 957  0026 0f0a          	clr	(OFST-23,sp)
 958                     ; 192 		di.payload[7] = 0xc0;
 960  0028 a6c0          	ld	a,#192
 961  002a 6b0b          	ld	(OFST-22,sp),a
 962                     ; 193 		di.payload[8] = slave_address;
 964  002c b64d          	ld	a,_slave_address
 965  002e 6b0c          	ld	(OFST-21,sp),a
 966                     ; 194 		i2c_init_message(&di,9);
 968  0030 4b09          	push	#9
 969  0032 96            	ldw	x,sp
 970  0033 1c0002        	addw	x,#OFST-31
 971  0036 cd0000        	call	_i2c_init_message
 973  0039 84            	pop	a
 974                     ; 195 	}
 977  003a 5b21          	addw	sp,#33
 978  003c 81            	ret
1016                     ; 197 	void rev_heart_breat(void)
1016                     ; 198 	{
1017                     .text:	section	.text,new
1018  0000               _rev_heart_breat:
1020  0000 5221          	subw	sp,#33
1021       00000021      OFST:	set	33
1024                     ; 200 		hb.frame_h1 = 0x7E;
1026  0002 a67e          	ld	a,#126
1027  0004 6b01          	ld	(OFST-32,sp),a
1028                     ; 201 		hb.frame_h2 = 0x7E;
1030  0006 a67e          	ld	a,#126
1031  0008 6b02          	ld	(OFST-31,sp),a
1032                     ; 202 		hb.message_id = IIC_RxBuffer[2];
1034  000a b62e          	ld	a,_IIC_RxBuffer+2
1035  000c 6b03          	ld	(OFST-30,sp),a
1036                     ; 203 		hb.payload[0] = 0x06;
1038  000e a606          	ld	a,#6
1039  0010 6b04          	ld	(OFST-29,sp),a
1040                     ; 204 		hb.payload[1] = slc.MDID;
1042  0012 b662          	ld	a,_slc+20
1043  0014 6b05          	ld	(OFST-28,sp),a
1044                     ; 205 		hb.payload[2] = slc.ch1_status;
1046  0016 b663          	ld	a,_slc+21
1047  0018 6b06          	ld	(OFST-27,sp),a
1048                     ; 206 		hb.payload[3] = slc.ch2_status;
1050  001a b664          	ld	a,_slc+22
1051  001c 6b07          	ld	(OFST-26,sp),a
1052                     ; 207 		hb.payload[4] = slc.ch3_status;
1054  001e b665          	ld	a,_slc+23
1055  0020 6b08          	ld	(OFST-25,sp),a
1056                     ; 208 		hb.payload[5] = slc.ch4_status;
1058  0022 b666          	ld	a,_slc+24
1059  0024 6b09          	ld	(OFST-24,sp),a
1060                     ; 209 		i2c_init_message(&hb,6);
1062  0026 4b06          	push	#6
1063  0028 96            	ldw	x,sp
1064  0029 1c0002        	addw	x,#OFST-31
1065  002c cd0000        	call	_i2c_init_message
1067  002f 84            	pop	a
1068                     ; 210 	}
1071  0030 5b21          	addw	sp,#33
1072  0032 81            	ret
1111                     ; 212 	void rev_action_dimmer_OK(void)
1111                     ; 213 	{
1112                     .text:	section	.text,new
1113  0000               _rev_action_dimmer_OK:
1115  0000 5221          	subw	sp,#33
1116       00000021      OFST:	set	33
1119                     ; 215 		ad.frame_h1 = 0x7E;
1121  0002 a67e          	ld	a,#126
1122  0004 6b01          	ld	(OFST-32,sp),a
1123                     ; 216 		ad.frame_h2 = 0x7E;
1125  0006 a67e          	ld	a,#126
1126  0008 6b02          	ld	(OFST-31,sp),a
1127                     ; 217 		ad.message_id = IIC_RxBuffer[2];
1129  000a b62e          	ld	a,_IIC_RxBuffer+2
1130  000c 6b03          	ld	(OFST-30,sp),a
1131                     ; 218 		ad.payload[0] = 0xAA;
1133  000e a6aa          	ld	a,#170
1134  0010 6b04          	ld	(OFST-29,sp),a
1135                     ; 219 		ad.payload[1] = 0x02;
1137  0012 a602          	ld	a,#2
1138  0014 6b05          	ld	(OFST-28,sp),a
1139                     ; 220 		ad.payload[2] = slc.MDID;
1141  0016 b662          	ld	a,_slc+20
1142  0018 6b06          	ld	(OFST-27,sp),a
1143                     ; 221 		i2c_init_message(&ad,3);
1145  001a 4b03          	push	#3
1146  001c 96            	ldw	x,sp
1147  001d 1c0002        	addw	x,#OFST-31
1148  0020 cd0000        	call	_i2c_init_message
1150  0023 84            	pop	a
1151                     ; 222 	}
1154  0024 5b21          	addw	sp,#33
1155  0026 81            	ret
1193                     ; 225 	void rev_action_dimmer_done(void)
1193                     ; 226 	{
1194                     .text:	section	.text,new
1195  0000               _rev_action_dimmer_done:
1197  0000 5221          	subw	sp,#33
1198       00000021      OFST:	set	33
1201                     ; 228 		ad.frame_h1 = 0x7E;
1203  0002 a67e          	ld	a,#126
1204  0004 6b01          	ld	(OFST-32,sp),a
1205                     ; 229 		ad.frame_h2 = 0x7E;
1207  0006 a67e          	ld	a,#126
1208  0008 6b02          	ld	(OFST-31,sp),a
1209                     ; 230 		ad.message_id = 66;
1211  000a a642          	ld	a,#66
1212  000c 6b03          	ld	(OFST-30,sp),a
1213                     ; 231 		ad.payload[0] = 0xAA;
1215  000e a6aa          	ld	a,#170
1216  0010 6b04          	ld	(OFST-29,sp),a
1217                     ; 232 		ad.payload[1] = 0x05;
1219  0012 a605          	ld	a,#5
1220  0014 6b05          	ld	(OFST-28,sp),a
1221                     ; 233 		ad.payload[2] = slc.MDID;
1223  0016 b662          	ld	a,_slc+20
1224  0018 6b06          	ld	(OFST-27,sp),a
1225                     ; 234 		ad.payload[3] = slc.ch1_status;
1227  001a b663          	ld	a,_slc+21
1228  001c 6b07          	ld	(OFST-26,sp),a
1229                     ; 235 		ad.payload[4] = slc.ch2_status;
1231  001e b664          	ld	a,_slc+22
1232  0020 6b08          	ld	(OFST-25,sp),a
1233                     ; 236 		ad.payload[5] = slc.ch3_status;
1235  0022 b665          	ld	a,_slc+23
1236  0024 6b09          	ld	(OFST-24,sp),a
1237                     ; 237 		ad.payload[6] = slc.ch4_status;
1239  0026 b666          	ld	a,_slc+24
1240  0028 6b0a          	ld	(OFST-23,sp),a
1241                     ; 238 		i2c_init_message(&ad,7);
1243  002a 4b07          	push	#7
1244  002c 96            	ldw	x,sp
1245  002d 1c0002        	addw	x,#OFST-31
1246  0030 cd0000        	call	_i2c_init_message
1248  0033 84            	pop	a
1249                     ; 239 	}
1252  0034 5b21          	addw	sp,#33
1253  0036 81            	ret
1278                     ; 243 	void I2C_transaction_end(void)
1278                     ; 244 	{
1279                     .text:	section	.text,new
1280  0000               _I2C_transaction_end:
1284                     ; 245 		ReceiveState = IIC_STATE_END;
1286  0000 35030001      	mov	_ReceiveState,#3
1287                     ; 246 	}	
1290  0004 81            	ret
1315                     ; 248 	void I2C_transaction_receive(void)
1315                     ; 249 	{
1316                     .text:	section	.text,new
1317  0000               _I2C_transaction_receive:
1321                     ; 250 		ReceiveState = IIC_STATE_RECEIVEING;
1323  0000 35020001      	mov	_ReceiveState,#2
1324                     ; 251 	}
1327  0004 81            	ret
1364                     ; 253 	void I2C_byte_received(uint8_t RxData)
1364                     ; 254 	{
1365                     .text:	section	.text,new
1366  0000               _I2C_byte_received:
1368  0000 88            	push	a
1369       00000000      OFST:	set	0
1372                     ; 255 		if(GetDataIndex < MAX_BUFFER) {
1374  0001 b600          	ld	a,_GetDataIndex
1375  0003 a120          	cp	a,#32
1376  0005 2410          	jruge	L524
1377                     ; 256 			IIC_RxBuffer[GetDataIndex++] = RxData;
1379  0007 b600          	ld	a,_GetDataIndex
1380  0009 97            	ld	xl,a
1381  000a 3c00          	inc	_GetDataIndex
1382  000c 9f            	ld	a,xl
1383  000d 5f            	clrw	x
1384  000e 97            	ld	xl,a
1385  000f 7b01          	ld	a,(OFST+1,sp)
1386  0011 e72c          	ld	(_IIC_RxBuffer,x),a
1387                     ; 257 			ReceiveState = IIC_STATE_RECEIVEING;
1389  0013 35020001      	mov	_ReceiveState,#2
1390  0017               L524:
1391                     ; 259 	}
1394  0017 84            	pop	a
1395  0018 81            	ret
1420                     ; 261 	uint8_t I2C_byte_write(void)
1420                     ; 262 	{
1421                     .text:	section	.text,new
1422  0000               _I2C_byte_write:
1426                     ; 263 			return IIC_TxBuffer[SendDataIndex++];
1428  0000 b602          	ld	a,_SendDataIndex
1429  0002 97            	ld	xl,a
1430  0003 3c02          	inc	_SendDataIndex
1431  0005 9f            	ld	a,xl
1432  0006 5f            	clrw	x
1433  0007 97            	ld	xl,a
1434  0008 e60c          	ld	a,(_IIC_TxBuffer,x)
1437  000a 81            	ret
1440                     	switch	.ubsct
1441  0000               L734_sr1:
1442  0000 00            	ds.b	1
1443  0001               L144_sr2:
1444  0001 00            	ds.b	1
1445  0002               L344_sr3:
1446  0002 00            	ds.b	1
1502                     ; 273 @far @interrupt void I2C_Slave_check_event(void) {
1504                     .text:	section	.text,new
1505  0000               f_I2C_Slave_check_event:
1508  0000 3b0002        	push	c_x+2
1509  0003 be00          	ldw	x,c_x
1510  0005 89            	pushw	x
1511  0006 3b0002        	push	c_y+2
1512  0009 be00          	ldw	x,c_y
1513  000b 89            	pushw	x
1516                     ; 280 	sr1 = I2C->SR1;
1518  000c 5552170000    	mov	L734_sr1,21015
1519                     ; 281 	sr2 = I2C->SR2;
1521  0011 5552180001    	mov	L144_sr2,21016
1522                     ; 282 	sr3 = I2C->SR3;
1524  0016 5552190002    	mov	L344_sr3,21017
1525                     ; 285   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
1527  001b b601          	ld	a,L144_sr2
1528  001d a52b          	bcp	a,#43
1529  001f 2708          	jreq	L374
1530                     ; 287     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
1532  0021 72125211      	bset	21009,#1
1533                     ; 288     I2C->SR2= 0;					    // clear all error flags
1535  0025 725f5218      	clr	21016
1536  0029               L374:
1537                     ; 291   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
1539  0029 b600          	ld	a,L734_sr1
1540  002b a444          	and	a,#68
1541  002d a144          	cp	a,#68
1542  002f 2606          	jrne	L574
1543                     ; 293     I2C_byte_received(I2C->DR);
1545  0031 c65216        	ld	a,21014
1546  0034 cd0000        	call	_I2C_byte_received
1548  0037               L574:
1549                     ; 296   if (sr1 & I2C_SR1_RXNE)
1551  0037 b600          	ld	a,L734_sr1
1552  0039 a540          	bcp	a,#64
1553  003b 2706          	jreq	L774
1554                     ; 298     I2C_byte_received(I2C->DR);
1556  003d c65216        	ld	a,21014
1557  0040 cd0000        	call	_I2C_byte_received
1559  0043               L774:
1560                     ; 301   if (sr2 & I2C_SR2_AF)
1562  0043 b601          	ld	a,L144_sr2
1563  0045 a504          	bcp	a,#4
1564  0047 2707          	jreq	L105
1565                     ; 303     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
1567  0049 72155218      	bres	21016,#2
1568                     ; 304 		I2C_transaction_end();
1570  004d cd0000        	call	_I2C_transaction_end
1572  0050               L105:
1573                     ; 307   if (sr1 & I2C_SR1_STOPF) 
1575  0050 b600          	ld	a,L734_sr1
1576  0052 a510          	bcp	a,#16
1577  0054 2707          	jreq	L305
1578                     ; 309     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
1580  0056 72145211      	bset	21009,#2
1581                     ; 310 		I2C_transaction_end();
1583  005a cd0000        	call	_I2C_transaction_end
1585  005d               L305:
1586                     ; 313   if (sr1 & I2C_SR1_ADDR)
1588  005d b600          	ld	a,L734_sr1
1589  005f a502          	bcp	a,#2
1590  0061 270e          	jreq	L505
1591                     ; 315 		if(sr3 & I2C_SR3_TRA){//从机发送数据
1593  0063 b602          	ld	a,L344_sr3
1594  0065 a504          	bcp	a,#4
1595  0067 2705          	jreq	L705
1596                     ; 316 			I2C_transaction_begin();
1598  0069 cd0000        	call	_I2C_transaction_begin
1601  006c 2003          	jra	L505
1602  006e               L705:
1603                     ; 318 			I2C_receive_begin();//从机接收数据
1605  006e cd0000        	call	_I2C_receive_begin
1607  0071               L505:
1608                     ; 322   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
1610  0071 b600          	ld	a,L734_sr1
1611  0073 a484          	and	a,#132
1612  0075 a184          	cp	a,#132
1613  0077 2606          	jrne	L315
1614                     ; 324 		I2C->DR = I2C_byte_write();
1616  0079 cd0000        	call	_I2C_byte_write
1618  007c c75216        	ld	21014,a
1619  007f               L315:
1620                     ; 327   if (sr1 & I2C_SR1_TXE)
1622  007f b600          	ld	a,L734_sr1
1623  0081 a580          	bcp	a,#128
1624  0083 2706          	jreq	L515
1625                     ; 329 		I2C->DR = I2C_byte_write();
1627  0085 cd0000        	call	_I2C_byte_write
1629  0088 c75216        	ld	21014,a
1630  008b               L515:
1631                     ; 332 }
1634  008b 85            	popw	x
1635  008c bf00          	ldw	c_y,x
1636  008e 320002        	pop	c_y+2
1637  0091 85            	popw	x
1638  0092 bf00          	ldw	c_x,x
1639  0094 320002        	pop	c_x+2
1640  0097 80            	iret
1663                     ; 337 void IIC_SlaveConfig (void)
1663                     ; 338 {
1665                     .text:	section	.text,new
1666  0000               _IIC_SlaveConfig:
1670                     ; 340 	GPIOD->DDR &= ~(0xF<<1);
1672  0000 c65011        	ld	a,20497
1673  0003 a4e1          	and	a,#225
1674  0005 c75011        	ld	20497,a
1675                     ; 341 	GPIOD->CR1 |= (0xF<<1);//上拉
1677  0008 c65012        	ld	a,20498
1678  000b aa1e          	or	a,#30
1679  000d c75012        	ld	20498,a
1680                     ; 342 	GPIOD->CR2 &= ~(0xF<<1);//External interrupt disabled
1682  0010 c65013        	ld	a,20499
1683  0013 a4e1          	and	a,#225
1684  0015 c75013        	ld	20499,a
1685                     ; 344   GPIOB->ODR |= (1<<4)|(1<<5);                //define SDA, SCL outputs, HiZ, Open drain, Fast
1687  0018 c65005        	ld	a,20485
1688  001b aa30          	or	a,#48
1689  001d c75005        	ld	20485,a
1690                     ; 345   GPIOB->DDR |= (1<<4)|(1<<5);
1692  0020 c65007        	ld	a,20487
1693  0023 aa30          	or	a,#48
1694  0025 c75007        	ld	20487,a
1695                     ; 346   GPIOB->CR2 |= (1<<4)|(1<<5);
1697  0028 c65009        	ld	a,20489
1698  002b aa30          	or	a,#48
1699  002d c75009        	ld	20489,a
1700                     ; 349 		I2C->CR1 |= 0x01;				        	// Enable I2C peripheral
1702  0030 72105210      	bset	21008,#0
1703                     ; 350 		I2C->CR2 = 0x04;					      		// Enable I2C acknowledgement
1705  0034 35045211      	mov	21009,#4
1706                     ; 352 		I2C->FREQR = 8;
1708  0038 35085212      	mov	21010,#8
1709                     ; 353 		I2C->OARL = (SLAVE_ADDRESS << 1) ;	// set slave address to 0x51 (put 0xA2 for the register dues to7bit address) 
1711  003c b64d          	ld	a,_slave_address
1712  003e 48            	sll	a
1713  003f c75213        	ld	21011,a
1714                     ; 354 		I2C->OARH = 0x40;					      	// Set 7bit address mode
1716  0042 35405214      	mov	21012,#64
1717                     ; 367 	I2C->ITR	= 0x07;					      // all I2C interrupt enable  
1719  0046 3507521a      	mov	21018,#7
1720                     ; 368 }
1723  004a 81            	ret
2109                     	xdef	_I2C_byte_write
2110                     	xdef	_I2C_byte_received
2111                     	xdef	_I2C_transaction_receive
2112                     	xdef	_I2C_transaction_end
2113                     	xdef	_I2C_transaction_begin
2114                     	xdef	_I2C_receive_begin
2115                     	xdef	_i2c_init_message
2116                     	xdef	_Check_Sum
2117                     	xdef	_mymemcpy
2118                     	switch	.ubsct
2119  0003               _action_flag:
2120  0003 00            	ds.b	1
2121                     	xdef	_action_flag
2122                     	xdef	_down
2123                     	xdef	_up
2124  0004               _change_step:
2125  0004 00            	ds.b	1
2126                     	xdef	_change_step
2127  0005               _change_time:
2128  0005 00            	ds.b	1
2129                     	xdef	_change_time
2130  0006               _aim_bright:
2131  0006 00            	ds.b	1
2132                     	xdef	_aim_bright
2133  0007               _aim_bright_float:
2134  0007 00000000      	ds.b	4
2135                     	xdef	_aim_bright_float
2136  000b               _channel:
2137  000b 00            	ds.b	1
2138                     	xdef	_channel
2139                     	xref.b	_last_bright
2140                     	xdef	_SendDataIndex
2141                     	xdef	_ReceiveState
2142                     	xdef	_GetDataIndex
2143  000c               _IIC_TxBuffer:
2144  000c 000000000000  	ds.b	32
2145                     	xdef	_IIC_TxBuffer
2146  002c               _IIC_RxBuffer:
2147  002c 000000000000  	ds.b	32
2148                     	xdef	_IIC_RxBuffer
2149  004c               _action_done:
2150  004c 00            	ds.b	1
2151                     	xdef	_action_done
2152  004d               _slave_address:
2153  004d 00            	ds.b	1
2154                     	xdef	_slave_address
2155  004e               _slc:
2156  004e 000000000000  	ds.b	25
2157                     	xdef	_slc
2158                     	xdef	_rev_action_dimmer_done
2159                     	xdef	_rev_action_dimmer_OK
2160                     	xdef	_rev_heart_breat
2161                     	xdef	_init_device_info
2162                     	xdef	f_I2C_Slave_check_event
2163                     	xdef	_IIC_SlaveConfig
2164                     .const:	section	.text
2165  0000               L352:
2166  0000 40200000      	dc.w	16416,0
2167                     	xref.b	c_lreg
2168                     	xref.b	c_x
2169                     	xref.b	c_y
2189                     	xref	c_idiv
2190                     	xref	c_ftol
2191                     	xref	c_rtol
2192                     	xref	c_fmul
2193                     	xref	c_itof
2194                     	xref	c_lrzmp
2195                     	xref	c_lgsbc
2196                     	xref	c_ltor
2197                     	end
