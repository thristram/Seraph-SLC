   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               L51_id:
   6  0000 00            	dc.b	0
  46                     ; 31 u8 get_message_id(void)
  46                     ; 32 {
  48                     .text:	section	.text,new
  49  0000               _get_message_id:
  53                     ; 35 	id++;
  55  0000 3c00          	inc	L51_id
  56                     ; 37 	if(id == 0){
  58  0002 3d00          	tnz	L51_id
  59  0004 2604          	jrne	L34
  60                     ; 38 		id = 1;
  62  0006 35010000      	mov	L51_id,#1
  63  000a               L34:
  64                     ; 41 	return id;
  66  000a b600          	ld	a,L51_id
  69  000c 81            	ret
 122                     ; 52 u8 random(u8 xxx)  
 122                     ; 53 {  
 123                     .text:	section	.text,new
 124  0000               _random:
 126  0000 88            	push	a
 127  0001 89            	pushw	x
 128       00000002      OFST:	set	2
 131                     ; 55 	for(iii=0; iii<xxx; iii++)  
 133  0002 0f02          	clr	(OFST+0,sp)
 135  0004 2011          	jra	L77
 136  0006               L37:
 137                     ; 57 		value = rand() % (MAX + 1- MIN) + MIN; //获取一个随机数1~255
 139  0006 cd0000        	call	_rand
 141  0009 90ae00ff      	ldw	y,#255
 142  000d cd0000        	call	c_idiv
 144  0010 51            	exgw	x,y
 145  0011 9f            	ld	a,xl
 146  0012 4c            	inc	a
 147  0013 6b01          	ld	(OFST-1,sp),a
 148                     ; 55 	for(iii=0; iii<xxx; iii++)  
 150  0015 0c02          	inc	(OFST+0,sp)
 151  0017               L77:
 154  0017 7b02          	ld	a,(OFST+0,sp)
 155  0019 1103          	cp	a,(OFST+1,sp)
 156  001b 25e9          	jrult	L37
 157                     ; 59 	return value;  
 159  001d 7b01          	ld	a,(OFST-1,sp)
 162  001f 5b03          	addw	sp,#3
 163  0021 81            	ret
 225                     ; 68 u8 uart1_check_sum(u8 *buf, u8 length)
 225                     ; 69 {
 226                     .text:	section	.text,new
 227  0000               _uart1_check_sum:
 229  0000 89            	pushw	x
 230  0001 89            	pushw	x
 231       00000002      OFST:	set	2
 234                     ; 71 	u8 result = *buf++;
 236  0002 1e03          	ldw	x,(OFST+1,sp)
 237  0004 1c0001        	addw	x,#1
 238  0007 1f03          	ldw	(OFST+1,sp),x
 239  0009 1d0001        	subw	x,#1
 240  000c f6            	ld	a,(x)
 241  000d 6b01          	ld	(OFST-1,sp),a
 242                     ; 73 	for(i = 1; i < length; i++)
 244  000f a601          	ld	a,#1
 245  0011 6b02          	ld	(OFST+0,sp),a
 247  0013 2011          	jra	L141
 248  0015               L531:
 249                     ; 75 		result ^= *buf++;
 251  0015 1e03          	ldw	x,(OFST+1,sp)
 252  0017 1c0001        	addw	x,#1
 253  001a 1f03          	ldw	(OFST+1,sp),x
 254  001c 1d0001        	subw	x,#1
 255  001f 7b01          	ld	a,(OFST-1,sp)
 256  0021 f8            	xor	a,	(x)
 257  0022 6b01          	ld	(OFST-1,sp),a
 258                     ; 73 	for(i = 1; i < length; i++)
 260  0024 0c02          	inc	(OFST+0,sp)
 261  0026               L141:
 264  0026 7b02          	ld	a,(OFST+0,sp)
 265  0028 1107          	cp	a,(OFST+5,sp)
 266  002a 25e9          	jrult	L531
 267                     ; 78 	return result;
 269  002c 7b01          	ld	a,(OFST-1,sp)
 272  002e 5b04          	addw	sp,#4
 273  0030 81            	ret
 301                     ; 87 void uart1_init(void)
 301                     ; 88 {
 302                     .text:	section	.text,new
 303  0000               _uart1_init:
 307                     ; 89 	UART1_DeInit();
 309  0000 cd0000        	call	_UART1_DeInit
 311                     ; 92 	UART1_Init((u32)19200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 313  0003 4b0c          	push	#12
 314  0005 4b80          	push	#128
 315  0007 4b00          	push	#0
 316  0009 4b00          	push	#0
 317  000b 4b00          	push	#0
 318  000d ae4b00        	ldw	x,#19200
 319  0010 89            	pushw	x
 320  0011 ae0000        	ldw	x,#0
 321  0014 89            	pushw	x
 322  0015 cd0000        	call	_UART1_Init
 324  0018 5b09          	addw	sp,#9
 325                     ; 94 	UART1_ITConfig(UART1_IT_TC, ENABLE);//发送完成中断
 327  001a 4b01          	push	#1
 328  001c ae0266        	ldw	x,#614
 329  001f cd0000        	call	_UART1_ITConfig
 331  0022 84            	pop	a
 332                     ; 95 	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);//接收非空中断
 334  0023 4b01          	push	#1
 335  0025 ae0205        	ldw	x,#517
 336  0028 cd0000        	call	_UART1_ITConfig
 338  002b 84            	pop	a
 339                     ; 96 	UART1_Cmd(ENABLE);//启用uart1接口
 341  002c a601          	ld	a,#1
 342  002e cd0000        	call	_UART1_Cmd
 344                     ; 98 	uart1_frame.rxflag = 0;
 346  0031 3f01          	clr	_uart1_frame+1
 347                     ; 100 }
 350  0033 81            	ret
 396                     ; 108 void uart1_Send(u8 *buf, u16 len)
 396                     ; 109 {
 397                     .text:	section	.text,new
 398  0000               _uart1_Send:
 400  0000 89            	pushw	x
 401       00000000      OFST:	set	0
 404                     ; 110 	if(len >= UART1_SEND_LEN)	
 406  0001 1e05          	ldw	x,(OFST+5,sp)
 407  0003 a30028        	cpw	x,#40
 408  0006 2505          	jrult	L771
 409                     ; 111 		len = UART1_SEND_LEN;
 411  0008 ae0028        	ldw	x,#40
 412  000b 1f05          	ldw	(OFST+5,sp),x
 413  000d               L771:
 414                     ; 113 	mymemcpy(uart1_frame.txbuf, buf, len);
 416  000d 1e05          	ldw	x,(OFST+5,sp)
 417  000f cd0000        	call	c_uitolx
 419  0012 be02          	ldw	x,c_lreg+2
 420  0014 89            	pushw	x
 421  0015 be00          	ldw	x,c_lreg
 422  0017 89            	pushw	x
 423  0018 1e05          	ldw	x,(OFST+5,sp)
 424  001a 89            	pushw	x
 425  001b ae0030        	ldw	x,#_uart1_frame+48
 426  001e cd0000        	call	_mymemcpy
 428  0021 5b06          	addw	sp,#6
 429                     ; 115 	uart1_frame.txlen = len;
 431  0023 1e05          	ldw	x,(OFST+5,sp)
 432  0025 bf04          	ldw	_uart1_frame+4,x
 433                     ; 116 	uart1_frame.txhas = 1;
 435  0027 ae0001        	ldw	x,#1
 436  002a bf06          	ldw	_uart1_frame+6,x
 437                     ; 117 	UART1->DR = uart1_frame.txbuf[0];
 439  002c 5500305231    	mov	21041,_uart1_frame+48
 440                     ; 119 }
 443  0031 85            	popw	x
 444  0032 81            	ret
 471                     ; 127 void uart1_init_device_info(void)
 471                     ; 128 {
 472                     .text:	section	.text,new
 473  0000               _uart1_init_device_info:
 477                     ; 129 	uart1_frame.txbuf[0] = 0x7e;
 479  0000 357e0030      	mov	_uart1_frame+48,#126
 480                     ; 130 	uart1_frame.txbuf[1] = 0x7e;
 482  0004 357e0031      	mov	_uart1_frame+49,#126
 483                     ; 131 	uart1_frame.txbuf[2] = slc.MDID;		//addr
 485  0008 451d32        	mov	_uart1_frame+50,_slc+29
 486                     ; 132 	uart1_frame.txbuf[3] = uart1_frame.rxbuf[3];	//message id
 488  000b 450b33        	mov	_uart1_frame+51,_uart1_frame+11
 489                     ; 133 	uart1_frame.txbuf[4] = 12;	//len
 491  000e 350c0034      	mov	_uart1_frame+52,#12
 492                     ; 134 	uart1_frame.txbuf[5] = 0xB2;	//payload
 494  0012 35b20035      	mov	_uart1_frame+53,#178
 495                     ; 135 	uart1_frame.txbuf[6] = slc.deviceID[0];
 497  0016 450036        	mov	_uart1_frame+54,_slc
 498                     ; 136 	uart1_frame.txbuf[7] = slc.deviceID[1];
 500  0019 450137        	mov	_uart1_frame+55,_slc+1
 501                     ; 137 	uart1_frame.txbuf[8] = slc.deviceID[2];
 503  001c 450238        	mov	_uart1_frame+56,_slc+2
 504                     ; 138 	uart1_frame.txbuf[9] = slc.deviceID[3];
 506  001f 450339        	mov	_uart1_frame+57,_slc+3
 507                     ; 139 	uart1_frame.txbuf[10] = slc.model;
 509  0022 45043a        	mov	_uart1_frame+58,_slc+4
 510                     ; 140 	uart1_frame.txbuf[11] = slc.firmware_version;
 512  0025 45053b        	mov	_uart1_frame+59,_slc+5
 513                     ; 141 	uart1_frame.txbuf[12] = slc.f_mal.byte;
 515  0028 45073c        	mov	_uart1_frame+60,_slc+7
 516                     ; 142 	uart1_frame.txbuf[13] = slc.MDID;	
 518  002b 451d3d        	mov	_uart1_frame+61,_slc+29
 519                     ; 143 	uart1_frame.txbuf[14] = uart1_check_sum(&uart1_frame.txbuf[2], uart1_frame.txbuf[4]);
 521  002e 3b0034        	push	_uart1_frame+52
 522  0031 ae0032        	ldw	x,#_uart1_frame+50
 523  0034 cd0000        	call	_uart1_check_sum
 525  0037 5b01          	addw	sp,#1
 526  0039 b73e          	ld	_uart1_frame+62,a
 527                     ; 145 	uart1_frame.txlen = uart1_frame.txbuf[4] + 3;
 529  003b a600          	ld	a,#0
 530  003d 97            	ld	xl,a
 531  003e a603          	ld	a,#3
 532  0040 bb34          	add	a,_uart1_frame+52
 533  0042 2401          	jrnc	L02
 534  0044 5c            	incw	x
 535  0045               L02:
 536  0045 b705          	ld	_uart1_frame+5,a
 537  0047 9f            	ld	a,xl
 538  0048 b704          	ld	_uart1_frame+4,a
 539                     ; 146 	uart1_frame.txhas = 1;
 541  004a ae0001        	ldw	x,#1
 542  004d bf06          	ldw	_uart1_frame+6,x
 543                     ; 147 	UART1->DR = uart1_frame.txbuf[0];
 545  004f 5500305231    	mov	21041,_uart1_frame+48
 546                     ; 150 }
 549  0054 81            	ret
 576                     ; 157 void uart1_rev_heart_breat(void)
 576                     ; 158 {
 577                     .text:	section	.text,new
 578  0000               _uart1_rev_heart_breat:
 582                     ; 159 	uart1_frame.txbuf[0] = 0x7e;
 584  0000 357e0030      	mov	_uart1_frame+48,#126
 585                     ; 160 	uart1_frame.txbuf[1] = 0x7e;
 587  0004 357e0031      	mov	_uart1_frame+49,#126
 588                     ; 161 	uart1_frame.txbuf[2] = slc.MDID;		//addr
 590  0008 451d32        	mov	_uart1_frame+50,_slc+29
 591                     ; 162 	uart1_frame.txbuf[3] = uart1_frame.rxbuf[3];	//message id
 593  000b 450b33        	mov	_uart1_frame+51,_uart1_frame+11
 594                     ; 163 	uart1_frame.txbuf[4] = 10;	//len
 596  000e 350a0034      	mov	_uart1_frame+52,#10
 597                     ; 164 	uart1_frame.txbuf[5] = 0x06;	//payload
 599  0012 35060035      	mov	_uart1_frame+53,#6
 600                     ; 165 	uart1_frame.txbuf[6] = slc.MDID;
 602  0016 451d36        	mov	_uart1_frame+54,_slc+29
 603                     ; 166 	uart1_frame.txbuf[7] = slc.ch1_status;
 605  0019 451f37        	mov	_uart1_frame+55,_slc+31
 606                     ; 167 	uart1_frame.txbuf[8] = slc.ch2_status;
 608  001c 452038        	mov	_uart1_frame+56,_slc+32
 609                     ; 168 	uart1_frame.txbuf[9] = slc.ch3_status;
 611  001f 452139        	mov	_uart1_frame+57,_slc+33
 612                     ; 169 	uart1_frame.txbuf[10] = slc.ch4_status;
 614  0022 45223a        	mov	_uart1_frame+58,_slc+34
 615                     ; 170 	uart1_frame.txbuf[11] = slc.f_mal.byte;
 617  0025 45073b        	mov	_uart1_frame+59,_slc+7
 618                     ; 171 	uart1_frame.txbuf[12] = uart1_check_sum(&uart1_frame.txbuf[2], uart1_frame.txbuf[4]);
 620  0028 3b0034        	push	_uart1_frame+52
 621  002b ae0032        	ldw	x,#_uart1_frame+50
 622  002e cd0000        	call	_uart1_check_sum
 624  0031 5b01          	addw	sp,#1
 625  0033 b73c          	ld	_uart1_frame+60,a
 626                     ; 173 	uart1_frame.txlen = uart1_frame.txbuf[4] + 3;
 628  0035 a600          	ld	a,#0
 629  0037 97            	ld	xl,a
 630  0038 a603          	ld	a,#3
 631  003a bb34          	add	a,_uart1_frame+52
 632  003c 2401          	jrnc	L42
 633  003e 5c            	incw	x
 634  003f               L42:
 635  003f b705          	ld	_uart1_frame+5,a
 636  0041 9f            	ld	a,xl
 637  0042 b704          	ld	_uart1_frame+4,a
 638                     ; 174 	uart1_frame.txhas = 1;
 640  0044 ae0001        	ldw	x,#1
 641  0047 bf06          	ldw	_uart1_frame+6,x
 642                     ; 175 	UART1->DR = uart1_frame.txbuf[0];
 644  0049 5500305231    	mov	21041,_uart1_frame+48
 645                     ; 177 }
 648  004e 81            	ret
 675                     ; 185 void uart1_rev_action_dimmer_OK(void)
 675                     ; 186 {
 676                     .text:	section	.text,new
 677  0000               _uart1_rev_action_dimmer_OK:
 681                     ; 187 	uart1_frame.txbuf[0] = 0x7e;
 683  0000 357e0030      	mov	_uart1_frame+48,#126
 684                     ; 188 	uart1_frame.txbuf[1] = 0x7e;
 686  0004 357e0031      	mov	_uart1_frame+49,#126
 687                     ; 189 	uart1_frame.txbuf[2] = slc.MDID;		//addr
 689  0008 451d32        	mov	_uart1_frame+50,_slc+29
 690                     ; 190 	uart1_frame.txbuf[3] = uart1_frame.rxbuf[3];	//message id
 692  000b 450b33        	mov	_uart1_frame+51,_uart1_frame+11
 693                     ; 191 	uart1_frame.txbuf[4] = 6;	//len
 695  000e 35060034      	mov	_uart1_frame+52,#6
 696                     ; 192 	uart1_frame.txbuf[5] = 0xAA;	//payload
 698  0012 35aa0035      	mov	_uart1_frame+53,#170
 699                     ; 193 	uart1_frame.txbuf[6] = 0x02;
 701  0016 35020036      	mov	_uart1_frame+54,#2
 702                     ; 194 	uart1_frame.txbuf[7] = slc.MDID;
 704  001a 451d37        	mov	_uart1_frame+55,_slc+29
 705                     ; 195 	uart1_frame.txbuf[8] = uart1_check_sum(&uart1_frame.txbuf[2], uart1_frame.txbuf[4]);
 707  001d 3b0034        	push	_uart1_frame+52
 708  0020 ae0032        	ldw	x,#_uart1_frame+50
 709  0023 cd0000        	call	_uart1_check_sum
 711  0026 5b01          	addw	sp,#1
 712  0028 b738          	ld	_uart1_frame+56,a
 713                     ; 197 	uart1_frame.txlen = uart1_frame.txbuf[4] + 3;
 715  002a a600          	ld	a,#0
 716  002c 97            	ld	xl,a
 717  002d a603          	ld	a,#3
 718  002f bb34          	add	a,_uart1_frame+52
 719  0031 2401          	jrnc	L03
 720  0033 5c            	incw	x
 721  0034               L03:
 722  0034 b705          	ld	_uart1_frame+5,a
 723  0036 9f            	ld	a,xl
 724  0037 b704          	ld	_uart1_frame+4,a
 725                     ; 198 	uart1_frame.txhas = 1;
 727  0039 ae0001        	ldw	x,#1
 728  003c bf06          	ldw	_uart1_frame+6,x
 729                     ; 199 	UART1->DR = uart1_frame.txbuf[0];
 731  003e 5500305231    	mov	21041,_uart1_frame+48
 732                     ; 201 }
 735  0043 81            	ret
 762                     ; 209 void uart1_rev_action_dimmer_done(void)
 762                     ; 210 {
 763                     .text:	section	.text,new
 764  0000               _uart1_rev_action_dimmer_done:
 768                     ; 211 	uart1_frame.txbuf[0] = 0x7e;
 770  0000 357e0030      	mov	_uart1_frame+48,#126
 771                     ; 212 	uart1_frame.txbuf[1] = 0x7e;
 773  0004 357e0031      	mov	_uart1_frame+49,#126
 774                     ; 213 	uart1_frame.txbuf[2] = slc.MDID;		//addr
 776  0008 451d32        	mov	_uart1_frame+50,_slc+29
 777                     ; 214 	uart1_frame.txbuf[3] = uart1_frame.rxbuf[3];	//message id
 779  000b 450b33        	mov	_uart1_frame+51,_uart1_frame+11
 780                     ; 215 	uart1_frame.txbuf[4] = 10;	//len
 782  000e 350a0034      	mov	_uart1_frame+52,#10
 783                     ; 216 	uart1_frame.txbuf[5] = 0xAA;	//payload
 785  0012 35aa0035      	mov	_uart1_frame+53,#170
 786                     ; 217 	uart1_frame.txbuf[6] = 0x05;	//payload
 788  0016 35050036      	mov	_uart1_frame+54,#5
 789                     ; 218 	uart1_frame.txbuf[7] = slc.MDID;
 791  001a 451d37        	mov	_uart1_frame+55,_slc+29
 792                     ; 219 	uart1_frame.txbuf[8] = slc.ch1_status;
 794  001d 451f38        	mov	_uart1_frame+56,_slc+31
 795                     ; 220 	uart1_frame.txbuf[9] = slc.ch2_status;
 797  0020 452039        	mov	_uart1_frame+57,_slc+32
 798                     ; 221 	uart1_frame.txbuf[10] = slc.ch3_status;
 800  0023 45213a        	mov	_uart1_frame+58,_slc+33
 801                     ; 222 	uart1_frame.txbuf[11] = slc.ch4_status;
 803  0026 45223b        	mov	_uart1_frame+59,_slc+34
 804                     ; 223 	uart1_frame.txbuf[12] = uart1_check_sum(&uart1_frame.txbuf[2], uart1_frame.txbuf[4]);
 806  0029 3b0034        	push	_uart1_frame+52
 807  002c ae0032        	ldw	x,#_uart1_frame+50
 808  002f cd0000        	call	_uart1_check_sum
 810  0032 5b01          	addw	sp,#1
 811  0034 b73c          	ld	_uart1_frame+60,a
 812                     ; 225 	uart1_frame.txlen = uart1_frame.txbuf[4] + 3;
 814  0036 a600          	ld	a,#0
 815  0038 97            	ld	xl,a
 816  0039 a603          	ld	a,#3
 817  003b bb34          	add	a,_uart1_frame+52
 818  003d 2401          	jrnc	L43
 819  003f 5c            	incw	x
 820  0040               L43:
 821  0040 b705          	ld	_uart1_frame+5,a
 822  0042 9f            	ld	a,xl
 823  0043 b704          	ld	_uart1_frame+4,a
 824                     ; 226 	uart1_frame.txhas = 1;
 826  0045 ae0001        	ldw	x,#1
 827  0048 bf06          	ldw	_uart1_frame+6,x
 828                     ; 227 	UART1->DR = uart1_frame.txbuf[0];
 830  004a 5500305231    	mov	21041,_uart1_frame+48
 831                     ; 229 }
 834  004f 81            	ret
 892                     ; 238 void uart1_recv_handle(void)
 892                     ; 239 {
 893                     .text:	section	.text,new
 894  0000               _uart1_recv_handle:
 896  0000 5206          	subw	sp,#6
 897       00000006      OFST:	set	6
 900                     ; 240 	u8 change_time = 0;
 902  0002 7b06          	ld	a,(OFST+0,sp)
 903  0004 97            	ld	xl,a
 904                     ; 241 	u8 chl = 0;
 906  0005 7b05          	ld	a,(OFST-1,sp)
 907  0007 97            	ld	xl,a
 908                     ; 245 	switch(uart1_frame.rxbuf[UART1_POSITION_COMMAND]){
 910  0008 b60d          	ld	a,_uart1_frame+13
 912                     ; 326 		default:
 912                     ; 327 			break;
 913  000a a003          	sub	a,#3
 914  000c 272b          	jreq	L342
 915  000e a04e          	sub	a,#78
 916  0010 2752          	jreq	L542
 917  0012 4a            	dec	a
 918  0013 274f          	jreq	L542
 919  0015 4a            	dec	a
 920  0016 274c          	jreq	L542
 921  0018 4a            	dec	a
 922  0019 2749          	jreq	L542
 923  001b a005          	sub	a,#5
 924  001d 2603          	jrne	L04
 925  001f cc0132        	jp	L742
 926  0022               L04:
 927  0022 a0a5          	sub	a,#165
 928  0024 2703          	jreq	L24
 929  0026 cc013b        	jp	L772
 930  0029               L24:
 931                     ; 246 		case 0xFE:
 931                     ; 247 			if(uart1_frame.rxbuf[6] == 0x01)
 933  0029 b60e          	ld	a,_uart1_frame+14
 934  002b a101          	cp	a,#1
 935  002d 2703          	jreq	L44
 936  002f cc013b        	jp	L772
 937  0032               L44:
 938                     ; 248 				uart1_init_device_info();
 940  0032 cd0000        	call	_uart1_init_device_info
 942  0035 ac3b013b      	jpf	L772
 943  0039               L342:
 944                     ; 250 		case 0x03:
 944                     ; 251 			if((uart1_frame.rxbuf[6] == 0x03) && (uart1_frame.rxbuf[7] == slc.MDID)){
 946  0039 b60e          	ld	a,_uart1_frame+14
 947  003b a103          	cp	a,#3
 948  003d 2703          	jreq	L64
 949  003f cc013b        	jp	L772
 950  0042               L64:
 952  0042 b60f          	ld	a,_uart1_frame+15
 953  0044 b11d          	cp	a,_slc+29
 954  0046 2703          	jreq	L05
 955  0048 cc013b        	jp	L772
 956  004b               L05:
 957                     ; 253 				if(uart1_check_sum(&uart1_frame.rxbuf[2], uart1_frame.rxbuf[4]) == uart1_frame.rxbuf[8]){
 959  004b 3b000c        	push	_uart1_frame+12
 960  004e ae000a        	ldw	x,#_uart1_frame+10
 961  0051 cd0000        	call	_uart1_check_sum
 963  0054 5b01          	addw	sp,#1
 964  0056 b110          	cp	a,_uart1_frame+16
 965  0058 2703          	jreq	L25
 966  005a cc013b        	jp	L772
 967  005d               L25:
 968                     ; 254 					uart1_rev_heart_breat();
 970  005d cd0000        	call	_uart1_rev_heart_breat
 972  0060 ac3b013b      	jpf	L772
 973  0064               L542:
 974                     ; 258 		case 0x51://Linear
 974                     ; 259 		case 0x52://Erase in
 974                     ; 260 		case 0x53://Erase out
 974                     ; 261 		case 0x54://Swing
 974                     ; 262 			if(((uart1_frame.rxbuf[6] & 0xf0) >> 4) == slc.MDID){
 976  0064 b60e          	ld	a,_uart1_frame+14
 977  0066 a4f0          	and	a,#240
 978  0068 4e            	swap	a
 979  0069 a40f          	and	a,#15
 980  006b 5f            	clrw	x
 981  006c 97            	ld	xl,a
 982  006d b61d          	ld	a,_slc+29
 983  006f 905f          	clrw	y
 984  0071 9097          	ld	yl,a
 985  0073 90bf01        	ldw	c_y+1,y
 986  0076 b301          	cpw	x,c_y+1
 987  0078 2703          	jreq	L45
 988  007a cc013b        	jp	L772
 989  007d               L45:
 990                     ; 264 				chl = (uart1_frame.rxbuf[6] & 0x0f);
 992  007d b60e          	ld	a,_uart1_frame+14
 993  007f a40f          	and	a,#15
 994  0081 6b05          	ld	(OFST-1,sp),a
 995                     ; 265 				change_time = uart1_frame.rxbuf[8];
 997  0083 b610          	ld	a,_uart1_frame+16
 998  0085 6b06          	ld	(OFST+0,sp),a
 999                     ; 267 				if((chl & 0x01) == 0x01)
1001  0087 7b05          	ld	a,(OFST-1,sp)
1002  0089 a401          	and	a,#1
1003  008b a101          	cp	a,#1
1004  008d 2657          	jrne	L113
1005                     ; 283 					channel1 = 1;
1007  008f 35010000      	mov	_channel1,#1
1008                     ; 284 					aim_bright1 = ((float)uart1_frame.rxbuf[7]) / 100.0;
1010  0093 b60f          	ld	a,_uart1_frame+15
1011  0095 5f            	clrw	x
1012  0096 97            	ld	xl,a
1013  0097 cd0000        	call	c_itof
1015  009a ae0000        	ldw	x,#L713
1016  009d cd0000        	call	c_fdiv
1018  00a0 ae0000        	ldw	x,#_aim_bright1
1019  00a3 cd0000        	call	c_rtol
1021                     ; 285 					if(change_time){
1023  00a6 0d06          	tnz	(OFST+0,sp)
1024  00a8 272a          	jreq	L323
1025                     ; 286 						change_step1 = (aim_bright1 - last_bright1) /(change_time * 2); //change_step1可正可负
1027  00aa 7b06          	ld	a,(OFST+0,sp)
1028  00ac 5f            	clrw	x
1029  00ad 97            	ld	xl,a
1030  00ae 58            	sllw	x
1031  00af cd0000        	call	c_itof
1033  00b2 96            	ldw	x,sp
1034  00b3 1c0001        	addw	x,#OFST-5
1035  00b6 cd0000        	call	c_rtol
1037  00b9 ae0000        	ldw	x,#_aim_bright1
1038  00bc cd0000        	call	c_ltor
1040  00bf ae0000        	ldw	x,#_last_bright1
1041  00c2 cd0000        	call	c_fsub
1043  00c5 96            	ldw	x,sp
1044  00c6 1c0001        	addw	x,#OFST-5
1045  00c9 cd0000        	call	c_fdiv
1047  00cc ae0000        	ldw	x,#_change_step1
1048  00cf cd0000        	call	c_rtol
1051  00d2 2012          	jra	L113
1052  00d4               L323:
1053                     ; 288 						change_step1 = aim_bright1 - last_bright1;
1055  00d4 ae0000        	ldw	x,#_aim_bright1
1056  00d7 cd0000        	call	c_ltor
1058  00da ae0000        	ldw	x,#_last_bright1
1059  00dd cd0000        	call	c_fsub
1061  00e0 ae0000        	ldw	x,#_change_step1
1062  00e3 cd0000        	call	c_rtol
1064  00e6               L113:
1065                     ; 293 				if((chl & 0x02) == 0x02)
1067  00e6 7b05          	ld	a,(OFST-1,sp)
1068  00e8 a402          	and	a,#2
1069  00ea a102          	cp	a,#2
1070  00ec 263f          	jrne	L723
1071                     ; 307 					channel2 = 1;
1073  00ee 35010000      	mov	_channel2,#1
1074                     ; 308 					aim_bright2 = ((float)uart1_frame.rxbuf[7]) / 100.0;
1076  00f2 b60f          	ld	a,_uart1_frame+15
1077  00f4 5f            	clrw	x
1078  00f5 97            	ld	xl,a
1079  00f6 cd0000        	call	c_itof
1081  00f9 ae0000        	ldw	x,#L713
1082  00fc cd0000        	call	c_fdiv
1084  00ff ae0000        	ldw	x,#_aim_bright2
1085  0102 cd0000        	call	c_rtol
1087                     ; 309 					change_step2 = (aim_bright2 - last_bright2) /(change_time * 2);
1089  0105 7b06          	ld	a,(OFST+0,sp)
1090  0107 5f            	clrw	x
1091  0108 97            	ld	xl,a
1092  0109 58            	sllw	x
1093  010a cd0000        	call	c_itof
1095  010d 96            	ldw	x,sp
1096  010e 1c0001        	addw	x,#OFST-5
1097  0111 cd0000        	call	c_rtol
1099  0114 ae0000        	ldw	x,#_aim_bright2
1100  0117 cd0000        	call	c_ltor
1102  011a ae0000        	ldw	x,#_last_bright2
1103  011d cd0000        	call	c_fsub
1105  0120 96            	ldw	x,sp
1106  0121 1c0001        	addw	x,#OFST-5
1107  0124 cd0000        	call	c_fdiv
1109  0127 ae0000        	ldw	x,#_change_step2
1110  012a cd0000        	call	c_rtol
1112  012d               L723:
1113                     ; 313 				uart1_rev_action_dimmer_OK();
1115  012d cd0000        	call	_uart1_rev_action_dimmer_OK
1117  0130 2009          	jra	L772
1118  0132               L742:
1119                     ; 319 		case 0x59://调光时间结束后SC发送查询ch状态
1119                     ; 320 		
1119                     ; 321 			if(uart1_frame.rxbuf[6] == slc.MDID){//查询action dimmer执行后SLC状态
1121  0132 b60e          	ld	a,_uart1_frame+14
1122  0134 b11d          	cp	a,_slc+29
1123  0136 2603          	jrne	L772
1124                     ; 322 				uart1_rev_action_dimmer_done();
1126  0138 cd0000        	call	_uart1_rev_action_dimmer_done
1128  013b               L152:
1129                     ; 326 		default:
1129                     ; 327 			break;
1131  013b               L772:
1132                     ; 331 }
1135  013b 5b06          	addw	sp,#6
1136  013d 81            	ret
1160                     ; 339 @interrupt void UART1_TX_ISR(void) 
1160                     ; 340 {
1161                     .text:	section	.text,new
1162  0000               _UART1_TX_ISR:
1167                     ; 345 	UART1->SR &= ~0x40; 	//清除发送完成标志位
1169  0000 721d5230      	bres	21040,#6
1170                     ; 347 	if (uart1_frame.txhas < uart1_frame.txlen){
1172  0004 be06          	ldw	x,_uart1_frame+6
1173  0006 b304          	cpw	x,_uart1_frame+4
1174  0008 2410          	jruge	L343
1175                     ; 349 		UART1->DR = uart1_frame.txbuf[uart1_frame.txhas];
1177  000a be06          	ldw	x,_uart1_frame+6
1178  000c e630          	ld	a,(_uart1_frame+48,x)
1179  000e c75231        	ld	21041,a
1180                     ; 350 		uart1_frame.txhas++;
1182  0011 be06          	ldw	x,_uart1_frame+6
1183  0013 1c0001        	addw	x,#1
1184  0016 bf06          	ldw	_uart1_frame+6,x
1186  0018 2006          	jra	L543
1187  001a               L343:
1188                     ; 354 		uart1_frame.txhas = 0;
1190  001a 5f            	clrw	x
1191  001b bf06          	ldw	_uart1_frame+6,x
1192                     ; 355 		uart1_frame.txlen = 0;
1194  001d 5f            	clrw	x
1195  001e bf04          	ldw	_uart1_frame+4,x
1196  0020               L543:
1197                     ; 360 }
1200  0020 80            	iret
1237                     ; 369 @interrupt void UART1_RX_ISR(void)
1237                     ; 370 {
1238                     .text:	section	.text,new
1239  0000               _UART1_RX_ISR:
1242       00000001      OFST:	set	1
1243  0000 3b0002        	push	c_x+2
1244  0003 be00          	ldw	x,c_x
1245  0005 89            	pushw	x
1246  0006 3b0002        	push	c_y+2
1247  0009 be00          	ldw	x,c_y
1248  000b 89            	pushw	x
1249  000c 88            	push	a
1252                     ; 371 	u8 temp = 0;
1254  000d 0f01          	clr	(OFST+0,sp)
1255                     ; 373 	temp = UART1->DR;
1257  000f c65231        	ld	a,21041
1258  0012 6b01          	ld	(OFST+0,sp),a
1259                     ; 374 	uart1_frame.rxbuf[uart1_frame.rxlen] = temp;
1261  0014 7b01          	ld	a,(OFST+0,sp)
1262  0016 be02          	ldw	x,_uart1_frame+2
1263  0018 e708          	ld	(_uart1_frame+8,x),a
1264                     ; 375 	uart1_frame.rxlen++;
1266  001a be02          	ldw	x,_uart1_frame+2
1267  001c 1c0001        	addw	x,#1
1268  001f bf02          	ldw	_uart1_frame+2,x
1269                     ; 377 	switch(uart1_frame.rxlen){
1271  0021 be02          	ldw	x,_uart1_frame+2
1273                     ; 412 			break;
1274  0023 5a            	decw	x
1275  0024 2734          	jreq	L743
1276  0026 5a            	decw	x
1277  0027 273c          	jreq	L153
1278  0029 5a            	decw	x
1279  002a 2744          	jreq	L353
1280  002c               L553:
1281                     ; 391 		default:
1281                     ; 392 			//接收到长度以后再判断数据是否接收完成
1281                     ; 393 			if(uart1_frame.rxlen > UART1_AFTER_LENGTH_BYTES){	
1283  002c be02          	ldw	x,_uart1_frame+2
1284  002e a30006        	cpw	x,#6
1285  0031 254b          	jrult	L704
1286                     ; 395 				if (uart1_frame.rxlen >= uart1_frame.rxbuf[UART1_POSITION_LENGTH] + 3){	//接收数据完成					
1288  0033 a600          	ld	a,#0
1289  0035 97            	ld	xl,a
1290  0036 a603          	ld	a,#3
1291  0038 bb0c          	add	a,_uart1_frame+12
1292  003a 2401          	jrnc	L26
1293  003c 5c            	incw	x
1294  003d               L26:
1295  003d 02            	rlwa	x,a
1296  003e b302          	cpw	x,_uart1_frame+2
1297  0040 223c          	jrugt	L704
1298                     ; 397 					if (uart1_check_sum(uart1_frame.rxbuf + 2, uart1_frame.rxbuf[UART1_POSITION_LENGTH]) == uart1_frame.rxbuf[uart1_frame.rxlen - 1]){
1300  0042 3b000c        	push	_uart1_frame+12
1301  0045 ae000a        	ldw	x,#_uart1_frame+10
1302  0048 cd0000        	call	_uart1_check_sum
1304  004b 5b01          	addw	sp,#1
1305  004d be02          	ldw	x,_uart1_frame+2
1306  004f 5a            	decw	x
1307  0050 e108          	cp	a,(_uart1_frame+8,x)
1308  0052 2627          	jrne	L314
1309                     ; 399 						uart1_frame.rxflag = 1;
1311  0054 35010001      	mov	_uart1_frame+1,#1
1312  0058 2021          	jra	L314
1313  005a               L743:
1314                     ; 379 		case 1:
1314                     ; 380 			if (temp != 0x7e) uart1_frame.rxlen = 0;
1316  005a 7b01          	ld	a,(OFST+0,sp)
1317  005c a17e          	cp	a,#126
1318  005e 2728          	jreq	L773
1321  0060 5f            	clrw	x
1322  0061 bf02          	ldw	_uart1_frame+2,x
1323  0063 2023          	jra	L773
1324  0065               L153:
1325                     ; 383 		case 2:
1325                     ; 384 			if (temp != 0x7e) uart1_frame.rxlen = 0;
1327  0065 7b01          	ld	a,(OFST+0,sp)
1328  0067 a17e          	cp	a,#126
1329  0069 271d          	jreq	L773
1332  006b 5f            	clrw	x
1333  006c bf02          	ldw	_uart1_frame+2,x
1334  006e 2018          	jra	L773
1335  0070               L353:
1336                     ; 387 		case 3:
1336                     ; 388 			if (temp != slc.MDID) uart1_frame.rxlen = 0;
1338  0070 7b01          	ld	a,(OFST+0,sp)
1339  0072 b11d          	cp	a,_slc+29
1340  0074 2712          	jreq	L773
1343  0076 5f            	clrw	x
1344  0077 bf02          	ldw	_uart1_frame+2,x
1345  0079 200d          	jra	L773
1346  007b               L314:
1347                     ; 402 					uart1_frame.rxlen = 0;
1349  007b 5f            	clrw	x
1350  007c bf02          	ldw	_uart1_frame+2,x
1351  007e               L704:
1352                     ; 408 			if (uart1_frame.rxlen >= UART1_RECV_LEN){
1354  007e be02          	ldw	x,_uart1_frame+2
1355  0080 a30028        	cpw	x,#40
1356  0083 2503          	jrult	L773
1357                     ; 409 				uart1_frame.rxlen = 0;
1359  0085 5f            	clrw	x
1360  0086 bf02          	ldw	_uart1_frame+2,x
1361  0088               L773:
1362                     ; 416 	if (UART1->SR & 0x20){
1364  0088 c65230        	ld	a,21040
1365  008b a520          	bcp	a,#32
1366  008d 2705          	jreq	L714
1367                     ; 417 		temp = UART1->DR;
1369  008f c65231        	ld	a,21041
1370  0092 6b01          	ld	(OFST+0,sp),a
1371  0094               L714:
1372                     ; 420 }
1375  0094 84            	pop	a
1376  0095 85            	popw	x
1377  0096 bf00          	ldw	c_y,x
1378  0098 320002        	pop	c_y+2
1379  009b 85            	popw	x
1380  009c bf00          	ldw	c_x,x
1381  009e 320002        	pop	c_x+2
1382  00a1 80            	iret
1469                     	xdef	_uart1_rev_action_dimmer_done
1470                     	xdef	_uart1_rev_action_dimmer_OK
1471                     	xdef	_uart1_rev_heart_breat
1472                     	xdef	_uart1_init_device_info
1473                     	xdef	_uart1_check_sum
1474                     	xdef	_random
1475                     	xref	_mymemcpy
1476                     	xref.b	_change_step2
1477                     	xref.b	_change_step1
1478                     	xref.b	_aim_bright2
1479                     	xref.b	_aim_bright1
1480                     	xref.b	_channel2
1481                     	xref.b	_channel1
1482                     	xref.b	_last_bright2
1483                     	xref.b	_last_bright1
1484                     	xref.b	_slc
1485                     	xdef	_UART1_RX_ISR
1486                     	xdef	_UART1_TX_ISR
1487                     	xdef	_uart1_recv_handle
1488                     	xdef	_uart1_Send
1489                     	xdef	_uart1_init
1490                     	xdef	_get_message_id
1491                     	switch	.ubsct
1492  0000               _uart1_frame:
1493  0000 000000000000  	ds.b	88
1494                     	xdef	_uart1_frame
1495                     	xref	_UART1_ITConfig
1496                     	xref	_UART1_Cmd
1497                     	xref	_UART1_Init
1498                     	xref	_UART1_DeInit
1499                     	xref	_rand
1500                     .const:	section	.text
1501  0000               L713:
1502  0000 42c80000      	dc.w	17096,0
1503                     	xref.b	c_lreg
1504                     	xref.b	c_x
1505                     	xref.b	c_y
1525                     	xref	c_fsub
1526                     	xref	c_ltor
1527                     	xref	c_rtol
1528                     	xref	c_fdiv
1529                     	xref	c_itof
1530                     	xref	c_uitolx
1531                     	xref	c_idiv
1532                     	end
