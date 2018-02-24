   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               _channel1:
   6  0000 00            	dc.b	0
   7  0001               _channel2:
   8  0001 00            	dc.b	0
   9  0002               _sys:
  10  0002 00            	dc.b	0
  11  0003 000000        	ds.b	3
  12  0006 000000000000  	ds.b	25
  13  001f               _tick:
  14  001f 0000          	dc.w	0
  15  0021 00000000      	ds.b	4
  95                     ; 78 void mymemcpy(void *des, void *src, u32 n)  
  95                     ; 79 {  
  97                     .text:	section	.text,new
  98  0000               _mymemcpy:
 100  0000 89            	pushw	x
 101  0001 5204          	subw	sp,#4
 102       00000004      OFST:	set	4
 105                     ; 80 	u8 *xdes = des;
 107  0003 1f01          	ldw	(OFST-3,sp),x
 108                     ; 81 	u8 *xsrc = src; 
 110  0005 1e09          	ldw	x,(OFST+5,sp)
 111  0007 1f03          	ldw	(OFST-1,sp),x
 113  0009 2016          	jra	L56
 114  000b               L16:
 115                     ; 82   	while(n--) *xdes++ = *xsrc++;  
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
 127  0021               L56:
 130  0021 96            	ldw	x,sp
 131  0022 1c000b        	addw	x,#OFST+7
 132  0025 cd0000        	call	c_ltor
 134  0028 96            	ldw	x,sp
 135  0029 1c000b        	addw	x,#OFST+7
 136  002c a601          	ld	a,#1
 137  002e cd0000        	call	c_lgsbc
 139  0031 cd0000        	call	c_lrzmp
 141  0034 26d5          	jrne	L16
 142                     ; 83 }  
 145  0036 5b06          	addw	sp,#6
 146  0038 81            	ret
 198                     ; 89 void delay(u16 Count)
 198                     ; 90 {
 199                     .text:	section	.text,new
 200  0000               _delay:
 202  0000 89            	pushw	x
 203  0001 89            	pushw	x
 204       00000002      OFST:	set	2
 207  0002 2014          	jra	L121
 208  0004               L711:
 209                     ; 95 		for(i=0;i<100;i++)
 211  0004 0f01          	clr	(OFST-1,sp)
 212  0006               L521:
 213                     ; 96 		for(j=0;j<50;j++);
 215  0006 0f02          	clr	(OFST+0,sp)
 216  0008               L331:
 220  0008 0c02          	inc	(OFST+0,sp)
 223  000a 7b02          	ld	a,(OFST+0,sp)
 224  000c a132          	cp	a,#50
 225  000e 25f8          	jrult	L331
 226                     ; 95 		for(i=0;i<100;i++)
 228  0010 0c01          	inc	(OFST-1,sp)
 231  0012 7b01          	ld	a,(OFST-1,sp)
 232  0014 a164          	cp	a,#100
 233  0016 25ee          	jrult	L521
 234  0018               L121:
 235                     ; 94 	while (Count--){
 237  0018 1e03          	ldw	x,(OFST+1,sp)
 238  001a 1d0001        	subw	x,#1
 239  001d 1f03          	ldw	(OFST+1,sp),x
 240  001f 1c0001        	addw	x,#1
 241  0022 a30000        	cpw	x,#0
 242  0025 26dd          	jrne	L711
 243                     ; 99 }
 246  0027 5b04          	addw	sp,#4
 247  0029 81            	ret
 270                     ; 105  void system_clock_set(void)
 270                     ; 106  {
 271                     .text:	section	.text,new
 272  0000               _system_clock_set:
 276                     ; 109 	 CLK->SWCR |= 0x02; //开启切换
 278  0000 721250c5      	bset	20677,#1
 279                     ; 111 	 CLK->SWR	= 0xb4; 	  //选择时钟为外部16M
 281  0004 35b450c4      	mov	20676,#180
 283  0008               L551:
 284                     ; 112 	 while((CLK->SWCR & 0x01) == 0x01);
 286  0008 c650c5        	ld	a,20677
 287  000b a401          	and	a,#1
 288  000d a101          	cp	a,#1
 289  000f 27f7          	jreq	L551
 290                     ; 113 	 CLK->CKDIVR = 0x80;	//不分频
 292  0011 358050c6      	mov	20678,#128
 293                     ; 115 	 CLK->SWCR	&= ~0x02; //关闭切换
 295  0015 721350c5      	bres	20677,#1
 296                     ; 117  }
 299  0019 81            	ret
 336                     ; 122  u8 system_addr_get(void)
 336                     ; 123  {
 337                     .text:	section	.text,new
 338  0000               _system_addr_get:
 340  0000 88            	push	a
 341       00000001      OFST:	set	1
 344                     ; 124 	uint8_t slave_address = 0;
 346  0001 0f01          	clr	(OFST+0,sp)
 347                     ; 127 	 slave_address = 0; 
 349  0003 0f01          	clr	(OFST+0,sp)
 350                     ; 128 	 GPIO_Init(GPIOD, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
 352  0005 4b00          	push	#0
 353  0007 4b04          	push	#4
 354  0009 ae500f        	ldw	x,#20495
 355  000c cd0000        	call	_GPIO_Init
 357  000f 85            	popw	x
 358                     ; 129 	 GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
 360  0010 4b00          	push	#0
 361  0012 4b20          	push	#32
 362  0014 ae500a        	ldw	x,#20490
 363  0017 cd0000        	call	_GPIO_Init
 365  001a 85            	popw	x
 366                     ; 130 	 GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
 368  001b 4b00          	push	#0
 369  001d 4b40          	push	#64
 370  001f ae500a        	ldw	x,#20490
 371  0022 cd0000        	call	_GPIO_Init
 373  0025 85            	popw	x
 374                     ; 131 	 GPIO_Init(GPIOC, (GPIO_Pin_TypeDef)GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);
 376  0026 4b00          	push	#0
 377  0028 4b80          	push	#128
 378  002a ae500a        	ldw	x,#20490
 379  002d cd0000        	call	_GPIO_Init
 381  0030 85            	popw	x
 382                     ; 134 	 delay(100);
 384  0031 ae0064        	ldw	x,#100
 385  0034 cd0000        	call	_delay
 387                     ; 136 	 if(GPIO_ReadInputData(GPIOD) & 0x04)	 slave_address |= 0x08;
 389  0037 ae500f        	ldw	x,#20495
 390  003a cd0000        	call	_GPIO_ReadInputData
 392  003d a504          	bcp	a,#4
 393  003f 2706          	jreq	L771
 396  0041 7b01          	ld	a,(OFST+0,sp)
 397  0043 aa08          	or	a,#8
 398  0045 6b01          	ld	(OFST+0,sp),a
 399  0047               L771:
 400                     ; 137 	 if(GPIO_ReadInputData(GPIOC) & 0x20)	 slave_address |= 0x04;
 402  0047 ae500a        	ldw	x,#20490
 403  004a cd0000        	call	_GPIO_ReadInputData
 405  004d a520          	bcp	a,#32
 406  004f 2706          	jreq	L102
 409  0051 7b01          	ld	a,(OFST+0,sp)
 410  0053 aa04          	or	a,#4
 411  0055 6b01          	ld	(OFST+0,sp),a
 412  0057               L102:
 413                     ; 138 	 if(GPIO_ReadInputData(GPIOC) & 0x40)	 slave_address |= 0x02;
 415  0057 ae500a        	ldw	x,#20490
 416  005a cd0000        	call	_GPIO_ReadInputData
 418  005d a540          	bcp	a,#64
 419  005f 2706          	jreq	L302
 422  0061 7b01          	ld	a,(OFST+0,sp)
 423  0063 aa02          	or	a,#2
 424  0065 6b01          	ld	(OFST+0,sp),a
 425  0067               L302:
 426                     ; 139 	 if(GPIO_ReadInputData(GPIOC) & 0x80)	 slave_address |= 0x01;
 428  0067 ae500a        	ldw	x,#20490
 429  006a cd0000        	call	_GPIO_ReadInputData
 431  006d a580          	bcp	a,#128
 432  006f 2706          	jreq	L502
 435  0071 7b01          	ld	a,(OFST+0,sp)
 436  0073 aa01          	or	a,#1
 437  0075 6b01          	ld	(OFST+0,sp),a
 438  0077               L502:
 439                     ; 141 	return slave_address;
 441  0077 7b01          	ld	a,(OFST+0,sp)
 444  0079 5b01          	addw	sp,#1
 445  007b 81            	ret
 492                     .const:	section	.text
 493  0000               L61:
 494  0000 00004000      	dc.l	16384
 495                     ; 151  void MEEPROM_WriteByte(u16 dLocal_Addr, u8 dLocal_Data)
 495                     ; 152  {
 496                     .text:	section	.text,new
 497  0000               _MEEPROM_WriteByte:
 499  0000 89            	pushw	x
 500       00000000      OFST:	set	0
 503                     ; 153 	FLASH_Unlock(FLASH_MEMTYPE_DATA);
 505  0001 a6f7          	ld	a,#247
 506  0003 cd0000        	call	_FLASH_Unlock
 509  0006               L332:
 510                     ; 154 	while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);
 512  0006 a608          	ld	a,#8
 513  0008 cd0000        	call	_FLASH_GetFlagStatus
 515  000b 4d            	tnz	a
 516  000c 27f8          	jreq	L332
 517                     ; 156 	FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr, dLocal_Data);
 519  000e 7b05          	ld	a,(OFST+5,sp)
 520  0010 88            	push	a
 521  0011 1e02          	ldw	x,(OFST+2,sp)
 522  0013 cd0000        	call	c_uitolx
 524  0016 ae0000        	ldw	x,#L61
 525  0019 cd0000        	call	c_ladd
 527  001c be02          	ldw	x,c_lreg+2
 528  001e 89            	pushw	x
 529  001f be00          	ldw	x,c_lreg
 530  0021 89            	pushw	x
 531  0022 cd0000        	call	_FLASH_ProgramByte
 533  0025 5b05          	addw	sp,#5
 534                     ; 157 	FLASH_Lock(FLASH_MEMTYPE_DATA);
 536  0027 a6f7          	ld	a,#247
 537  0029 cd0000        	call	_FLASH_Lock
 539                     ; 159  }
 542  002c 85            	popw	x
 543  002d 81            	ret
 587                     ; 167   u8 MEEPROM_ReadByte(u16 dLocal_Addr)
 587                     ; 168   {
 588                     .text:	section	.text,new
 589  0000               _MEEPROM_ReadByte:
 591  0000 88            	push	a
 592       00000001      OFST:	set	1
 595                     ; 170 	  dLocal_1 = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr);
 597  0001 cd0000        	call	c_uitolx
 599  0004 ae0000        	ldw	x,#L61
 600  0007 cd0000        	call	c_ladd
 602  000a be02          	ldw	x,c_lreg+2
 603  000c 89            	pushw	x
 604  000d be00          	ldw	x,c_lreg
 605  000f 89            	pushw	x
 606  0010 cd0000        	call	_FLASH_ReadByte
 608  0013 5b04          	addw	sp,#4
 609  0015 6b01          	ld	(OFST+0,sp),a
 610                     ; 171 	  return dLocal_1;
 612  0017 7b01          	ld	a,(OFST+0,sp)
 615  0019 5b01          	addw	sp,#1
 616  001b 81            	ret
 645                     ; 179  void channel_status_save(void)
 645                     ; 180 {
 646                     .text:	section	.text,new
 647  0000               _channel_status_save:
 651                     ; 181 	FLASH_Unlock(FLASH_MEMTYPE_DATA);
 653  0000 a6f7          	ld	a,#247
 654  0002 cd0000        	call	_FLASH_Unlock
 657  0005               L372:
 658                     ; 182 	while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);
 660  0005 a608          	ld	a,#8
 661  0007 cd0000        	call	_FLASH_GetFlagStatus
 663  000a 4d            	tnz	a
 664  000b 27f8          	jreq	L372
 665                     ; 184 	FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_STATUS_ADDRESS, slc.ch1_status);
 667  000d 3b003b        	push	_slc+31
 668  0010 ae402d        	ldw	x,#16429
 669  0013 89            	pushw	x
 670  0014 ae0000        	ldw	x,#0
 671  0017 89            	pushw	x
 672  0018 cd0000        	call	_FLASH_ProgramByte
 674  001b 5b05          	addw	sp,#5
 675                     ; 185 	FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH2_STATUS_ADDRESS, slc.ch2_status);
 677  001d 3b003c        	push	_slc+32
 678  0020 ae402e        	ldw	x,#16430
 679  0023 89            	pushw	x
 680  0024 ae0000        	ldw	x,#0
 681  0027 89            	pushw	x
 682  0028 cd0000        	call	_FLASH_ProgramByte
 684  002b 5b05          	addw	sp,#5
 685                     ; 187 	FLASH_Lock(FLASH_MEMTYPE_DATA);
 687  002d a6f7          	ld	a,#247
 688  002f cd0000        	call	_FLASH_Lock
 690                     ; 189 }
 693  0032 81            	ret
 718                     ; 197 void default_info_set(void)
 718                     ; 198 {	 
 719                     .text:	section	.text,new
 720  0000               _default_info_set:
 724                     ; 199 	slc.ch1_status = 0;
 726  0000 3f3b          	clr	_slc+31
 727                     ; 200 	slc.ch2_status = 0;
 729  0002 3f3c          	clr	_slc+32
 730                     ; 201 	slc.ch3_status = 0;
 732  0004 3f3d          	clr	_slc+33
 733                     ; 202 	slc.ch4_status = 0;
 735  0006 3f3e          	clr	_slc+34
 736                     ; 204 	channel_status_save();
 738  0008 cd0000        	call	_channel_status_save
 740                     ; 206 }
 743  000b 81            	ret
 786                     ; 212  void device_info_read(void)
 786                     ; 213  {
 787                     .text:	section	.text,new
 788  0000               _device_info_read:
 790  0000 88            	push	a
 791       00000001      OFST:	set	1
 794                     ; 214 	u8 temp = 0;
 796  0001 0f01          	clr	(OFST+0,sp)
 797                     ; 216 	slc.savFlag = 0;
 799  0003 3f3a          	clr	_slc+30
 800                     ; 218 	slc.model = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MODEL_ADDRESS);
 802  0005 ae400b        	ldw	x,#16395
 803  0008 89            	pushw	x
 804  0009 ae0000        	ldw	x,#0
 805  000c 89            	pushw	x
 806  000d cd0000        	call	_FLASH_ReadByte
 808  0010 5b04          	addw	sp,#4
 809  0012 b720          	ld	_slc+4,a
 810                     ; 219  	slc.firmware_version = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_FW_VERSION_ADDRESS);	
 812  0014 ae400d        	ldw	x,#16397
 813  0017 89            	pushw	x
 814  0018 ae0000        	ldw	x,#0
 815  001b 89            	pushw	x
 816  001c cd0000        	call	_FLASH_ReadByte
 818  001f 5b04          	addw	sp,#4
 819  0021 b721          	ld	_slc+5,a
 820                     ; 220 	if(slc.firmware_version == 1){		/* 第一版本，device ID 4个字节  */		
 822  0023 b621          	ld	a,_slc+5
 823  0025 a101          	cp	a,#1
 824  0027 263c          	jrne	L523
 825                     ; 221 		slc.deviceID[0] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 3);
 827  0029 ae4004        	ldw	x,#16388
 828  002c 89            	pushw	x
 829  002d ae0000        	ldw	x,#0
 830  0030 89            	pushw	x
 831  0031 cd0000        	call	_FLASH_ReadByte
 833  0034 5b04          	addw	sp,#4
 834  0036 b71c          	ld	_slc,a
 835                     ; 222 		slc.deviceID[1] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 2);
 837  0038 ae4003        	ldw	x,#16387
 838  003b 89            	pushw	x
 839  003c ae0000        	ldw	x,#0
 840  003f 89            	pushw	x
 841  0040 cd0000        	call	_FLASH_ReadByte
 843  0043 5b04          	addw	sp,#4
 844  0045 b71d          	ld	_slc+1,a
 845                     ; 223 		slc.deviceID[2] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 1);
 847  0047 ae4002        	ldw	x,#16386
 848  004a 89            	pushw	x
 849  004b ae0000        	ldw	x,#0
 850  004e 89            	pushw	x
 851  004f cd0000        	call	_FLASH_ReadByte
 853  0052 5b04          	addw	sp,#4
 854  0054 b71e          	ld	_slc+2,a
 855                     ; 224 		slc.deviceID[3] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 0);
 857  0056 ae4001        	ldw	x,#16385
 858  0059 89            	pushw	x
 859  005a ae0000        	ldw	x,#0
 860  005d 89            	pushw	x
 861  005e cd0000        	call	_FLASH_ReadByte
 863  0061 5b04          	addw	sp,#4
 864  0063 b71f          	ld	_slc+3,a
 865  0065               L523:
 866                     ; 226 	slc.HW_version = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_HW_VERSION_ADDRESS);
 868  0065 ae400f        	ldw	x,#16399
 869  0068 89            	pushw	x
 870  0069 ae0000        	ldw	x,#0
 871  006c 89            	pushw	x
 872  006d cd0000        	call	_FLASH_ReadByte
 874  0070 5b04          	addw	sp,#4
 875  0072 b722          	ld	_slc+6,a
 876                     ; 228 	temp = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_BASH_ADDRESS + 0);
 878  0074 ae4011        	ldw	x,#16401
 879  0077 89            	pushw	x
 880  0078 ae0000        	ldw	x,#0
 881  007b 89            	pushw	x
 882  007c cd0000        	call	_FLASH_ReadByte
 884  007f 5b04          	addw	sp,#4
 885  0081 6b01          	ld	(OFST+0,sp),a
 886                     ; 229 	slc.bash = temp + 256 * FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_BASH_ADDRESS + 1);
 888  0083 ae4012        	ldw	x,#16402
 889  0086 89            	pushw	x
 890  0087 ae0000        	ldw	x,#0
 891  008a 89            	pushw	x
 892  008b cd0000        	call	_FLASH_ReadByte
 894  008e 5b04          	addw	sp,#4
 895  0090 5f            	clrw	x
 896  0091 97            	ld	xl,a
 897  0092 4f            	clr	a
 898  0093 02            	rlwa	x,a
 899  0094 01            	rrwa	x,a
 900  0095 1b01          	add	a,(OFST+0,sp)
 901  0097 2401          	jrnc	L03
 902  0099 5c            	incw	x
 903  009a               L03:
 904  009a b728          	ld	_slc+12,a
 905  009c 9f            	ld	a,xl
 906  009d b727          	ld	_slc+11,a
 907                     ; 231 	slc.manaYear = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_YEAR_ADDRESS);
 909  009f ae4013        	ldw	x,#16403
 910  00a2 89            	pushw	x
 911  00a3 ae0000        	ldw	x,#0
 912  00a6 89            	pushw	x
 913  00a7 cd0000        	call	_FLASH_ReadByte
 915  00aa 5b04          	addw	sp,#4
 916  00ac b724          	ld	_slc+8,a
 917                     ; 232 	slc.manaMonth = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_MONTH_ADDRESS);
 919  00ae ae4014        	ldw	x,#16404
 920  00b1 89            	pushw	x
 921  00b2 ae0000        	ldw	x,#0
 922  00b5 89            	pushw	x
 923  00b6 cd0000        	call	_FLASH_ReadByte
 925  00b9 5b04          	addw	sp,#4
 926  00bb b725          	ld	_slc+9,a
 927                     ; 233 	slc.manaDay = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_DAY_ADDRESS);
 929  00bd ae4015        	ldw	x,#16405
 930  00c0 89            	pushw	x
 931  00c1 ae0000        	ldw	x,#0
 932  00c4 89            	pushw	x
 933  00c5 cd0000        	call	_FLASH_ReadByte
 935  00c8 5b04          	addw	sp,#4
 936  00ca b726          	ld	_slc+10,a
 937                     ; 235 	slc.ch1_status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_STATUS_ADDRESS);
 939  00cc ae402d        	ldw	x,#16429
 940  00cf 89            	pushw	x
 941  00d0 ae0000        	ldw	x,#0
 942  00d3 89            	pushw	x
 943  00d4 cd0000        	call	_FLASH_ReadByte
 945  00d7 5b04          	addw	sp,#4
 946  00d9 b73b          	ld	_slc+31,a
 947                     ; 236 	slc.ch2_status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH2_STATUS_ADDRESS);
 949  00db ae402e        	ldw	x,#16430
 950  00de 89            	pushw	x
 951  00df ae0000        	ldw	x,#0
 952  00e2 89            	pushw	x
 953  00e3 cd0000        	call	_FLASH_ReadByte
 955  00e6 5b04          	addw	sp,#4
 956  00e8 b73c          	ld	_slc+32,a
 957                     ; 238 	realtime_bright1 = slc.ch1_status;
 959  00ea 453b13        	mov	_realtime_bright1,_slc+31
 960                     ; 239 	sys.light1.briVal = realtime_bright1;
 962  00ed 451304        	mov	_sys+2,_realtime_bright1
 963                     ; 241 	realtime_bright2 = slc.ch2_status;
 965  00f0 453c12        	mov	_realtime_bright2,_slc+32
 966                     ; 242 	sys.light2.briVal = realtime_bright2;
 968  00f3 451208        	mov	_sys+6,_realtime_bright2
 969                     ; 244 	aim_bright1 = ((float)realtime_bright1) / 100.0;
 971  00f6 b613          	ld	a,_realtime_bright1
 972  00f8 5f            	clrw	x
 973  00f9 97            	ld	xl,a
 974  00fa cd0000        	call	c_itof
 976  00fd ae0014        	ldw	x,#L333
 977  0100 cd0000        	call	c_fdiv
 979  0103 ae000d        	ldw	x,#_aim_bright1
 980  0106 cd0000        	call	c_rtol
 982                     ; 245 	aim_bright2 = ((float)realtime_bright2) / 100.0;
 984  0109 b612          	ld	a,_realtime_bright2
 985  010b 5f            	clrw	x
 986  010c 97            	ld	xl,a
 987  010d cd0000        	call	c_itof
 989  0110 ae0014        	ldw	x,#L333
 990  0113 cd0000        	call	c_fdiv
 992  0116 ae0009        	ldw	x,#_aim_bright2
 993  0119 cd0000        	call	c_rtol
 995                     ; 247 	last_bright1 = aim_bright1;
 997  011c be0f          	ldw	x,_aim_bright1+2
 998  011e bf1a          	ldw	_last_bright1+2,x
 999  0120 be0d          	ldw	x,_aim_bright1
1000  0122 bf18          	ldw	_last_bright1,x
1001                     ; 248 	last_bright2 = aim_bright2;
1003  0124 be0b          	ldw	x,_aim_bright2+2
1004  0126 bf16          	ldw	_last_bright2+2,x
1005  0128 be09          	ldw	x,_aim_bright2
1006  012a bf14          	ldw	_last_bright2,x
1007                     ; 251  }
1010  012c 84            	pop	a
1011  012d 81            	ret
1050                     ; 258  void MEEPROM_Init(void)
1050                     ; 259  {
1051                     .text:	section	.text,new
1052  0000               _MEEPROM_Init:
1054  0000 88            	push	a
1055       00000001      OFST:	set	1
1058                     ; 260 	u8 temp = 0;
1060  0001 0f01          	clr	(OFST+0,sp)
1061                     ; 262 	FLASH_DeInit();
1063  0003 cd0000        	call	_FLASH_DeInit
1065                     ; 263 	temp = MEEPROM_ReadByte(EEPROM_INIT_ADDRESS);
1067  0006 5f            	clrw	x
1068  0007 cd0000        	call	_MEEPROM_ReadByte
1070  000a 6b01          	ld	(OFST+0,sp),a
1071                     ; 266 	if(temp == EEPROM_INIT_FLAG) {		
1073  000c 7b01          	ld	a,(OFST+0,sp)
1074  000e a155          	cp	a,#85
1075  0010 260a          	jrne	L553
1076                     ; 267 		MEEPROM_WriteByte(EEPROM_INIT_ADDRESS, EEPROM_INIT_FLAG);
1078  0012 4b55          	push	#85
1079  0014 5f            	clrw	x
1080  0015 cd0000        	call	_MEEPROM_WriteByte
1082  0018 84            	pop	a
1083                     ; 268 		default_info_set();
1085  0019 cd0000        	call	_default_info_set
1087  001c               L553:
1088                     ; 271 	device_info_read();
1090  001c cd0000        	call	_device_info_read
1092                     ; 273  }
1095  001f 84            	pop	a
1096  0020 81            	ret
1124                     ; 278  void interrupt_priority_set(void)
1124                     ; 279  {
1125                     .text:	section	.text,new
1126  0000               _interrupt_priority_set:
1130                     ; 282 	 disableInterrupts();
1133  0000 9b            sim
1135                     ; 284 	 ITC_DeInit();
1138  0001 cd0000        	call	_ITC_DeInit
1140                     ; 286 	 ITC_SetSoftwarePriority(ITC_IRQ_PORTD, ITC_PRIORITYLEVEL_3);
1142  0004 ae0003        	ldw	x,#3
1143  0007 a606          	ld	a,#6
1144  0009 95            	ld	xh,a
1145  000a cd0000        	call	_ITC_SetSoftwarePriority
1147                     ; 287 	 ITC_SetSoftwarePriority(ITC_IRQ_TIM2_OVF, ITC_PRIORITYLEVEL_3);
1149  000d ae0003        	ldw	x,#3
1150  0010 a60d          	ld	a,#13
1151  0012 95            	ld	xh,a
1152  0013 cd0000        	call	_ITC_SetSoftwarePriority
1154                     ; 288 	 ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF, ITC_PRIORITYLEVEL_3);
1156  0016 ae0003        	ldw	x,#3
1157  0019 a617          	ld	a,#23
1158  001b 95            	ld	xh,a
1159  001c cd0000        	call	_ITC_SetSoftwarePriority
1161                     ; 290 	 ITC_SetSoftwarePriority(ITC_IRQ_UART1_TX, ITC_PRIORITYLEVEL_2);
1163  001f 5f            	clrw	x
1164  0020 a611          	ld	a,#17
1165  0022 95            	ld	xh,a
1166  0023 cd0000        	call	_ITC_SetSoftwarePriority
1168                     ; 291 	 ITC_SetSoftwarePriority(ITC_IRQ_UART1_RX, ITC_PRIORITYLEVEL_2);
1170  0026 5f            	clrw	x
1171  0027 a612          	ld	a,#18
1172  0029 95            	ld	xh,a
1173  002a cd0000        	call	_ITC_SetSoftwarePriority
1175                     ; 294 	 enableInterrupts();
1178  002d 9a            rim
1180                     ; 297  }
1184  002e 81            	ret
1214                     ; 302  static void Sys_Init(void)
1214                     ; 303  {
1215                     .text:	section	.text,new
1216  0000               L3_Sys_Init:
1220                     ; 304 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
1222  0000 ae0001        	ldw	x,#1
1223  0003 a604          	ld	a,#4
1224  0005 95            	ld	xh,a
1225  0006 cd0000        	call	_CLK_PeripheralClockConfig
1227                     ; 305 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, ENABLE);
1229  0009 ae0001        	ldw	x,#1
1230  000c a605          	ld	a,#5
1231  000e 95            	ld	xh,a
1232  000f cd0000        	call	_CLK_PeripheralClockConfig
1234                     ; 307 	sys.light1.briVal = DEFAULT_BRIGHTNESS;
1236  0012 3f04          	clr	_sys+2
1237                     ; 308 	sys.light2.briVal = DEFAULT_BRIGHTNESS; 
1239  0014 3f08          	clr	_sys+6
1240                     ; 311 	sys.gotHzFlag = FALSE;    
1242  0016 3f0b          	clr	_sys+9
1243                     ; 312 	sys.reqCalHzFlag = FALSE;
1245  0018 3f0a          	clr	_sys+8
1246                     ; 313 	sys.calHzIntCnt = GET_AC_FRE_CNT;
1248  001a 350a000d      	mov	_sys+11,#10
1249                     ; 314 	sys.hzCnt = 0;
1251  001e 5f            	clrw	x
1252  001f bf0e          	ldw	_sys+12,x
1253                     ; 315 	sys.checkAcCnt = CHECK_AC_INPUT_CNT;
1255  0021 ae07d0        	ldw	x,#2000
1256  0024 bf10          	ldw	_sys+14,x
1257                     ; 317 	sys.acOkFlag = FALSE;
1259  0026 3f15          	clr	_sys+19
1260                     ; 318 	sys.acErrFlag = TRUE;
1262  0028 35010014      	mov	_sys+18,#1
1263                     ; 320 	slc.f_mal.byte = 0;
1265  002c 3f23          	clr	_slc+7
1266                     ; 322 	slc.ch1_status = 0;
1268  002e 3f3b          	clr	_slc+31
1269                     ; 323 	slc.ch2_status = 0;
1271  0030 3f3c          	clr	_slc+32
1272                     ; 324 	slc.ch3_status = 0;
1274  0032 3f3d          	clr	_slc+33
1275                     ; 325 	slc.ch4_status = 0;
1277  0034 3f3e          	clr	_slc+34
1278                     ; 327 	last_bright1	 = 0;
1280  0036 ae0000        	ldw	x,#0
1281  0039 bf1a          	ldw	_last_bright1+2,x
1282  003b ae0000        	ldw	x,#0
1283  003e bf18          	ldw	_last_bright1,x
1284                     ; 328 	aim_bright1	 = 0;
1286  0040 ae0000        	ldw	x,#0
1287  0043 bf0f          	ldw	_aim_bright1+2,x
1288  0045 ae0000        	ldw	x,#0
1289  0048 bf0d          	ldw	_aim_bright1,x
1290                     ; 329 	last_bright2	 = 0;
1292  004a ae0000        	ldw	x,#0
1293  004d bf16          	ldw	_last_bright2+2,x
1294  004f ae0000        	ldw	x,#0
1295  0052 bf14          	ldw	_last_bright2,x
1296                     ; 330 	aim_bright2	 = 0;
1298  0054 ae0000        	ldw	x,#0
1299  0057 bf0b          	ldw	_aim_bright2+2,x
1300  0059 ae0000        	ldw	x,#0
1301  005c bf09          	ldw	_aim_bright2,x
1302                     ; 332  }
1305  005e 81            	ret
1350                     ; 340 void main(void)
1350                     ; 341 {	
1351                     .text:	section	.text,new
1352  0000               _main:
1356                     ; 343 	system_clock_set();
1358  0000 cd0000        	call	_system_clock_set
1360                     ; 345 	slc.MDID = system_addr_get();
1362  0003 cd0000        	call	_system_addr_get
1364  0006 b739          	ld	_slc+29,a
1365                     ; 347 	GPIO_Config();
1367  0008 cd0000        	call	L5_GPIO_Config
1369                     ; 348 	uart1_init();
1371  000b cd0000        	call	_uart1_init
1373                     ; 349 	Sys_Init();
1375  000e cd0000        	call	L3_Sys_Init
1377                     ; 350 	ExtInterrupt_Config();
1379  0011 cd0000        	call	L7_ExtInterrupt_Config
1381                     ; 351 	TIMER4_Init();	
1383  0014 cd0000        	call	L31_TIMER4_Init
1385                     ; 354 	interrupt_priority_set();
1387  0017 cd0000        	call	_interrupt_priority_set
1389                     ; 388 	TIMER2_Init();
1391  001a cd0000        	call	L11_TIMER2_Init
1393                     ; 390 	MEEPROM_Init();
1395  001d cd0000        	call	_MEEPROM_Init
1397  0020               L704:
1398                     ; 395 		if (sys.checkAcCnt == 0 && sys.acErrFlag == FALSE){			/* 在已经检测出强电之后再检测到故障 */
1400  0020 be10          	ldw	x,_sys+14
1401  0022 2610          	jrne	L314
1403  0024 3d14          	tnz	_sys+18
1404  0026 260c          	jrne	L314
1405                     ; 399 			 sys.acErrFlag = TRUE;
1407  0028 35010014      	mov	_sys+18,#1
1408                     ; 400 			 sys.acOkFlag = FALSE;
1410  002c 3f15          	clr	_sys+19
1411                     ; 401 			 slc.f_mal.bit.f_ac = 1;
1413  002e 72160023      	bset	_slc+7,#3
1414                     ; 404 			sys.gotHzFlag = FALSE;    
1416  0032 3f0b          	clr	_sys+9
1417  0034               L314:
1418                     ; 408 		if(!sys.gotHzFlag){				/* 还未计算出频率 */
1420  0034 3d0b          	tnz	_sys+9
1421  0036 2618          	jrne	L514
1422                     ; 410 			if (sys.checkAcCnt == 0){	   	/* 第一次没有检测到故障 */
1424  0038 be10          	ldw	x,_sys+14
1425  003a 2614          	jrne	L514
1426                     ; 411 				sys.gotHzFlag = FALSE;	 
1428  003c 3f0b          	clr	_sys+9
1429                     ; 412 				sys.reqCalHzFlag = FALSE;
1431  003e 3f0a          	clr	_sys+8
1432                     ; 413 				sys.calHzIntCnt = GET_AC_FRE_CNT;
1434  0040 350a000d      	mov	_sys+11,#10
1435                     ; 414 				sys.hzCnt = 0;
1437  0044 5f            	clrw	x
1438  0045 bf0e          	ldw	_sys+12,x
1439                     ; 415 				sys.checkAcCnt = CHECK_AC_INPUT_CNT;				
1441  0047 ae07d0        	ldw	x,#2000
1442  004a bf10          	ldw	_sys+14,x
1443                     ; 416 				slc.f_mal.bit.f_ac = 1;
1445  004c 72160023      	bset	_slc+7,#3
1446  0050               L514:
1447                     ; 420 		if (sys.acOkFlag == FALSE && sys.acErrFlag == FALSE){
1449  0050 3d15          	tnz	_sys+19
1450  0052 2624          	jrne	L124
1452  0054 3d14          	tnz	_sys+18
1453  0056 2620          	jrne	L124
1454                     ; 424 			if(sys.gotHzFlag){
1456  0058 3d0b          	tnz	_sys+9
1457  005a 2717          	jreq	L324
1458                     ; 425 				sys.acOkFlag = TRUE;
1460  005c 35010015      	mov	_sys+19,#1
1461                     ; 426 				slc.f_mal.bit.f_ac = 0;
1463  0060 72170023      	bres	_slc+7,#3
1464                     ; 427 				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
1466  0064 3d0c          	tnz	_sys+10
1467  0066 2705          	jreq	L24
1468  0068 ae0064        	ldw	x,#100
1469  006b 2003          	jra	L44
1470  006d               L24:
1471  006d ae0053        	ldw	x,#83
1472  0070               L44:
1473  0070 cd0000        	call	_TIM2_SetAutoreload
1475  0073               L324:
1476                     ; 429 			sys.cnt1s = CNT_1S;
1478  0073 ae4e20        	ldw	x,#20000
1479  0076 bf12          	ldw	_sys+16,x
1480  0078               L124:
1481                     ; 434 		if(uart1_frame.rxflag == 1){
1483  0078 b601          	ld	a,_uart1_frame+1
1484  007a a101          	cp	a,#1
1485  007c 2605          	jrne	L524
1486                     ; 435 			uart1_frame.rxflag = 0;
1488  007e 3f01          	clr	_uart1_frame+1
1489                     ; 436 			uart1_recv_handle();
1491  0080 cd0000        	call	_uart1_recv_handle
1493  0083               L524:
1494                     ; 446 		if(tick.f_50ms){
1496  0083 be21          	ldw	x,_tick+2
1497  0085 2706          	jreq	L724
1498                     ; 447 			tick.f_50ms = 0;
1500  0087 5f            	clrw	x
1501  0088 bf21          	ldw	_tick+2,x
1502                     ; 448 			lightCtrl_50ms();		
1504  008a cd0000        	call	_lightCtrl_50ms
1506  008d               L724:
1507                     ; 466 		if(channel1){
1509  008d 3d00          	tnz	_channel1
1510  008f 2706          	jreq	L134
1511                     ; 467 			sys.light1.briVal = realtime_bright1;
1513  0091 451304        	mov	_sys+2,_realtime_bright1
1514                     ; 468 			slc.ch1_status = realtime_bright1;
1516  0094 45133b        	mov	_slc+31,_realtime_bright1
1517  0097               L134:
1518                     ; 471 		if(channel2){
1520  0097 3d01          	tnz	_channel2
1521  0099 2706          	jreq	L334
1522                     ; 472 			sys.light2.briVal = realtime_bright2;
1524  009b 451208        	mov	_sys+6,_realtime_bright2
1525                     ; 473 			slc.ch2_status = realtime_bright2;
1527  009e 45123c        	mov	_slc+32,_realtime_bright2
1528  00a1               L334:
1529                     ; 477 		if(slc.savFlag == 1){
1531  00a1 b63a          	ld	a,_slc+30
1532  00a3 a101          	cp	a,#1
1533  00a5 2605          	jrne	L534
1534                     ; 478 			slc.savFlag = 0;
1536  00a7 3f3a          	clr	_slc+30
1537                     ; 479 			channel_status_save();
1539  00a9 cd0000        	call	_channel_status_save
1541  00ac               L534:
1542                     ; 482 		if (sys.acOkFlag && sys.cnt1s == 0)
1544  00ac 3d15          	tnz	_sys+19
1545  00ae 2603          	jrne	L64
1546  00b0 cc0020        	jp	L704
1547  00b3               L64:
1549  00b3 be12          	ldw	x,_sys+16
1550  00b5 2703          	jreq	L05
1551  00b7 cc0020        	jp	L704
1552  00ba               L05:
1553                     ; 487 			sys.cnt1s = CNT_1S;
1555  00ba ae4e20        	ldw	x,#20000
1556  00bd bf12          	ldw	_sys+16,x
1557  00bf ac200020      	jpf	L704
1592                     ; 505 void assert_failed(uint8_t* file, uint32_t line)
1592                     ; 506 { 
1593                     .text:	section	.text,new
1594  0000               _assert_failed:
1598  0000               L754:
1599  0000 20fe          	jra	L754
1624                     ; 525 static void GPIO_Config(void)
1624                     ; 526 {
1625                     .text:	section	.text,new
1626  0000               L5_GPIO_Config:
1630                     ; 528  	GPIO_Init(L1_EN_PIN_PORT, (GPIO_Pin_TypeDef)L1_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);
1632  0000 4bd0          	push	#208
1633  0002 4b10          	push	#16
1634  0004 ae500a        	ldw	x,#20490
1635  0007 cd0000        	call	_GPIO_Init
1637  000a 85            	popw	x
1638                     ; 529 	GPIO_Init(L2_EN_PIN_PORT, (GPIO_Pin_TypeDef)L2_EN_PIN, GPIO_MODE_OUT_PP_HIGH_SLOW);   
1640  000b 4bd0          	push	#208
1641  000d 4b08          	push	#8
1642  000f ae500a        	ldw	x,#20490
1643  0012 cd0000        	call	_GPIO_Init
1645  0015 85            	popw	x
1646                     ; 530 	L1_EN_OFF;
1648  0016 4b10          	push	#16
1649  0018 ae500a        	ldw	x,#20490
1650  001b cd0000        	call	_GPIO_WriteHigh
1652  001e 84            	pop	a
1653                     ; 531 	L2_EN_OFF;
1655  001f 4b08          	push	#8
1656  0021 ae500a        	ldw	x,#20490
1657  0024 cd0000        	call	_GPIO_WriteHigh
1659  0027 84            	pop	a
1660                     ; 532     	GPIO_Init(ZD_PIN_PORT, (GPIO_Pin_TypeDef)ZD_PIN, GPIO_MODE_IN_FL_IT);  
1662  0028 4b20          	push	#32
1663  002a 4b08          	push	#8
1664  002c ae500f        	ldw	x,#20495
1665  002f cd0000        	call	_GPIO_Init
1667  0032 85            	popw	x
1668                     ; 534 }
1671  0033 81            	ret
1697                     ; 540 static void ExtInterrupt_Config(void)
1697                     ; 541 {
1698                     .text:	section	.text,new
1699  0000               L7_ExtInterrupt_Config:
1703                     ; 542 	EXTI_DeInit();
1705  0000 cd0000        	call	_EXTI_DeInit
1707                     ; 543 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_FALL_ONLY);
1709  0003 ae0002        	ldw	x,#2
1710  0006 a603          	ld	a,#3
1711  0008 95            	ld	xh,a
1712  0009 cd0000        	call	_EXTI_SetExtIntSensitivity
1714                     ; 545 }
1717  000c 81            	ret
1747                     ; 552 @far @interrupt void Ext_PortD_ISR(void)
1747                     ; 553 {
1749                     .text:	section	.text,new
1750  0000               f_Ext_PortD_ISR:
1753  0000 3b0002        	push	c_x+2
1754  0003 be00          	ldw	x,c_x
1755  0005 89            	pushw	x
1756  0006 3b0002        	push	c_y+2
1757  0009 be00          	ldw	x,c_y
1758  000b 89            	pushw	x
1761                     ; 555 	if (ZD_STATUS == 0)
1763  000c ae500f        	ldw	x,#20495
1764  000f cd0000        	call	_GPIO_ReadOutputData
1766  0012 a508          	bcp	a,#8
1767  0014 2704          	jreq	L66
1768  0016 accf00cf      	jpf	L315
1769  001a               L66:
1770                     ; 557 		sys.checkAcCnt = CHECK_AC_INPUT_CNT;
1772  001a ae07d0        	ldw	x,#2000
1773  001d bf10          	ldw	_sys+14,x
1774                     ; 558 		sys.acErrFlag = FALSE;
1776  001f 3f14          	clr	_sys+18
1777                     ; 561 		if (!sys.gotHzFlag){		/* 还未获取频率值 */	
1779  0021 3d0b          	tnz	_sys+9
1780  0023 2636          	jrne	L515
1781                     ; 562 			if (!sys.reqCalHzFlag){
1783  0025 3d0a          	tnz	_sys+8
1784  0027 2610          	jrne	L715
1785                     ; 563 				TIM4_SetAutoreload(TIMER4_INT_TIME);				
1787  0029 a632          	ld	a,#50
1788  002b cd0000        	call	_TIM4_SetAutoreload
1790                     ; 564 				sys.reqCalHzFlag = TRUE;				/* 强制开始计算频率 */
1792  002e 3501000a      	mov	_sys+8,#1
1793                     ; 565 				sys.hzCnt = 0;						/* fyl: */
1795  0032 5f            	clrw	x
1796  0033 bf0e          	ldw	_sys+12,x
1797                     ; 566 				sys.calHzIntCnt = GET_AC_FRE_CNT;
1799  0035 350a000d      	mov	_sys+11,#10
1800  0039               L715:
1801                     ; 568 			if (sys.calHzIntCnt == 0){
1803  0039 3d0d          	tnz	_sys+11
1804  003b 261a          	jrne	L125
1805                     ; 570 				if ((sys.hzCnt /GET_AC_FRE_CNT) >= HZ_COUNT){
1807  003d be0e          	ldw	x,_sys+12
1808  003f a60a          	ld	a,#10
1809  0041 62            	div	x,a
1810  0042 a300b4        	cpw	x,#180
1811  0045 2506          	jrult	L325
1812                     ; 572 					sys.hz50Flag = TRUE;
1814  0047 3501000c      	mov	_sys+10,#1
1816  004b 2002          	jra	L525
1817  004d               L325:
1818                     ; 576 					sys.hz50Flag = FALSE;
1820  004d 3f0c          	clr	_sys+10
1821  004f               L525:
1822                     ; 580 				sys.gotHzFlag = TRUE;				/* */
1824  004f 3501000b      	mov	_sys+9,#1
1825                     ; 581 				sys.reqCalHzFlag = FALSE;			/* 计算完 */
1827  0053 3f0a          	clr	_sys+8
1829  0055 2078          	jra	L315
1830  0057               L125:
1831                     ; 585 				sys.calHzIntCnt--;
1833  0057 3a0d          	dec	_sys+11
1834  0059 2074          	jra	L315
1835  005b               L515:
1836                     ; 591 			if (sys.light1.briVal == MAX_BRIGHTNESS){
1838  005b b604          	ld	a,_sys+2
1839  005d a164          	cp	a,#100
1840  005f 2615          	jrne	L335
1841                     ; 595 				L1_EN_ON;
1843  0061 4b10          	push	#16
1844  0063 ae500a        	ldw	x,#20490
1845  0066 cd0000        	call	_GPIO_WriteLow
1847  0069 84            	pop	a
1850  006a 35280003      	mov	_sys+1,#40
1851                     ; 596 				sys.light1.briCnt = 0;
1853  006e 3f02          	clr	_sys
1854                     ; 597 				sys.light1.onFlag = TRUE;		
1856  0070 35010005      	mov	_sys+3,#1
1858  0074 2011          	jra	L535
1859  0076               L335:
1860                     ; 602 				sys.light1.briCnt = MAX_BRIGHTNESS - sys.light1.briVal;				
1862  0076 a664          	ld	a,#100
1863  0078 b004          	sub	a,_sys+2
1864  007a b702          	ld	_sys,a
1865                     ; 603 				sys.light1.onFlag = FALSE;
1867  007c 3f05          	clr	_sys+3
1868                     ; 604 				L1_EN_OFF;
1870  007e 4b10          	push	#16
1871  0080 ae500a        	ldw	x,#20490
1872  0083 cd0000        	call	_GPIO_WriteHigh
1874  0086 84            	pop	a
1875  0087               L535:
1876                     ; 607 			if (sys.light2.briVal == MAX_BRIGHTNESS){
1878  0087 b608          	ld	a,_sys+6
1879  0089 a164          	cp	a,#100
1880  008b 2615          	jrne	L735
1881                     ; 608 				L2_EN_ON;
1883  008d 4b08          	push	#8
1884  008f ae500a        	ldw	x,#20490
1885  0092 cd0000        	call	_GPIO_WriteLow
1887  0095 84            	pop	a
1890  0096 35280007      	mov	_sys+5,#40
1891                     ; 609 				sys.light2.briCnt = 0;
1893  009a 3f06          	clr	_sys+4
1894                     ; 610 				sys.light2.onFlag = TRUE;		
1896  009c 35010009      	mov	_sys+7,#1
1898  00a0 2011          	jra	L145
1899  00a2               L735:
1900                     ; 613 				sys.light2.briCnt = MAX_BRIGHTNESS - sys.light2.briVal;
1902  00a2 a664          	ld	a,#100
1903  00a4 b008          	sub	a,_sys+6
1904  00a6 b706          	ld	_sys+4,a
1905                     ; 614 				sys.light2.onFlag = FALSE;				
1907  00a8 3f09          	clr	_sys+7
1908                     ; 615 				L2_EN_OFF;
1910  00aa 4b08          	push	#8
1911  00ac ae500a        	ldw	x,#20490
1912  00af cd0000        	call	_GPIO_WriteHigh
1914  00b2 84            	pop	a
1915  00b3               L145:
1916                     ; 619 			if (sys.light1.briCnt || sys.light2.briCnt){
1918  00b3 3d02          	tnz	_sys
1919  00b5 2604          	jrne	L545
1921  00b7 3d06          	tnz	_sys+4
1922  00b9 2714          	jreq	L315
1923  00bb               L545:
1924                     ; 621 				TIM2_SetAutoreload(sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
1926  00bb 3d0c          	tnz	_sys+10
1927  00bd 2705          	jreq	L26
1928  00bf ae0064        	ldw	x,#100
1929  00c2 2003          	jra	L46
1930  00c4               L26:
1931  00c4 ae0053        	ldw	x,#83
1932  00c7               L46:
1933  00c7 cd0000        	call	_TIM2_SetAutoreload
1935                     ; 622 				TIM2_Cmd(ENABLE);
1937  00ca a601          	ld	a,#1
1938  00cc cd0000        	call	_TIM2_Cmd
1940  00cf               L315:
1941                     ; 629 }
1944  00cf 85            	popw	x
1945  00d0 bf00          	ldw	c_y,x
1946  00d2 320002        	pop	c_y+2
1947  00d5 85            	popw	x
1948  00d6 bf00          	ldw	c_x,x
1949  00d8 320002        	pop	c_x+2
1950  00db 80            	iret
1976                     ; 654 static void TIMER4_Init(void)
1976                     ; 655 {    
1978                     .text:	section	.text,new
1979  0000               L31_TIMER4_Init:
1983                     ; 656 	TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIMER4_INT_TIME);
1985  0000 ae0032        	ldw	x,#50
1986  0003 a604          	ld	a,#4
1987  0005 95            	ld	xh,a
1988  0006 cd0000        	call	_TIM4_TimeBaseInit
1990                     ; 657 	TIM4_ClearFlag(TIM4_FLAG_UPDATE);
1992  0009 a601          	ld	a,#1
1993  000b cd0000        	call	_TIM4_ClearFlag
1995                     ; 658 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);	
1997  000e ae0001        	ldw	x,#1
1998  0011 a601          	ld	a,#1
1999  0013 95            	ld	xh,a
2000  0014 cd0000        	call	_TIM4_ITConfig
2002                     ; 659 	TIM4_Cmd(ENABLE);
2004  0017 a601          	ld	a,#1
2005  0019 cd0000        	call	_TIM4_Cmd
2007                     ; 660 }
2010  001c 81            	ret
2037                     ; 665 @far @interrupt void Timer4_ISR(void) 
2037                     ; 666 {
2039                     .text:	section	.text,new
2040  0000               f_Timer4_ISR:
2043  0000 3b0002        	push	c_x+2
2044  0003 be00          	ldw	x,c_x
2045  0005 89            	pushw	x
2046  0006 3b0002        	push	c_y+2
2047  0009 be00          	ldw	x,c_y
2048  000b 89            	pushw	x
2051                     ; 667 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);  
2053  000c a601          	ld	a,#1
2054  000e cd0000        	call	_TIM4_ClearITPendingBit
2056                     ; 670 	if (sys.reqCalHzFlag){
2058  0011 3d0a          	tnz	_sys+8
2059  0013 2707          	jreq	L765
2060                     ; 671 	 	sys.hzCnt++; 	  
2062  0015 be0e          	ldw	x,_sys+12
2063  0017 1c0001        	addw	x,#1
2064  001a bf0e          	ldw	_sys+12,x
2065  001c               L765:
2066                     ; 675 	if (sys.light1.triacTriggeTime)
2068  001c 3d03          	tnz	_sys+1
2069  001e 270f          	jreq	L175
2070                     ; 677 		sys.light1.triacTriggeTime--;
2072  0020 3a03          	dec	_sys+1
2073                     ; 678 		if (sys.light1.triacTriggeTime == 0)
2075  0022 3d03          	tnz	_sys+1
2076  0024 2609          	jrne	L175
2077                     ; 680 			L1_EN_OFF;
2079  0026 4b10          	push	#16
2080  0028 ae500a        	ldw	x,#20490
2081  002b cd0000        	call	_GPIO_WriteHigh
2083  002e 84            	pop	a
2084  002f               L175:
2085                     ; 684 	 if (sys.light2.triacTriggeTime)
2087  002f 3d07          	tnz	_sys+5
2088  0031 270f          	jreq	L575
2089                     ; 686 		sys.light2.triacTriggeTime--;
2091  0033 3a07          	dec	_sys+5
2092                     ; 687 		 if (sys.light2.triacTriggeTime == 0)
2094  0035 3d07          	tnz	_sys+5
2095  0037 2609          	jrne	L575
2096                     ; 689 			 L2_EN_OFF;
2098  0039 4b08          	push	#8
2099  003b ae500a        	ldw	x,#20490
2100  003e cd0000        	call	_GPIO_WriteHigh
2102  0041 84            	pop	a
2103  0042               L575:
2104                     ; 694 	 if (sys.checkAcCnt){
2106  0042 be10          	ldw	x,_sys+14
2107  0044 2707          	jreq	L106
2108                     ; 695 		sys.checkAcCnt--;
2110  0046 be10          	ldw	x,_sys+14
2111  0048 1d0001        	subw	x,#1
2112  004b bf10          	ldw	_sys+14,x
2113  004d               L106:
2114                     ; 698 	 if (sys.cnt1s){
2116  004d be12          	ldw	x,_sys+16
2117  004f 2707          	jreq	L306
2118                     ; 699 		sys.cnt1s--;
2120  0051 be12          	ldw	x,_sys+16
2121  0053 1d0001        	subw	x,#1
2122  0056 bf12          	ldw	_sys+16,x
2123  0058               L306:
2124                     ; 702 	tick.c_50ms++;
2126  0058 be1f          	ldw	x,_tick
2127  005a 1c0001        	addw	x,#1
2128  005d bf1f          	ldw	_tick,x
2129                     ; 703 	if(tick.c_50ms >= 1000){
2131  005f be1f          	ldw	x,_tick
2132  0061 a303e8        	cpw	x,#1000
2133  0064 2516          	jrult	L506
2134                     ; 704 		tick.c_50ms = 0;
2136  0066 5f            	clrw	x
2137  0067 bf1f          	ldw	_tick,x
2138                     ; 705 		tick.f_50ms = 1;
2140  0069 ae0001        	ldw	x,#1
2141  006c bf21          	ldw	_tick+2,x
2142                     ; 707 		tick.c_100ms++;
2144  006e 3c23          	inc	_tick+4
2145                     ; 708 		if(tick.c_100ms >= 2){
2147  0070 b623          	ld	a,_tick+4
2148  0072 a102          	cp	a,#2
2149  0074 2506          	jrult	L506
2150                     ; 709 			tick.c_100ms = 0;
2152  0076 3f23          	clr	_tick+4
2153                     ; 710 			tick.f_100ms = 1;
2155  0078 35010024      	mov	_tick+5,#1
2156  007c               L506:
2157                     ; 716 }
2160  007c 85            	popw	x
2161  007d bf00          	ldw	c_y,x
2162  007f 320002        	pop	c_y+2
2163  0082 85            	popw	x
2164  0083 bf00          	ldw	c_x,x
2165  0085 320002        	pop	c_x+2
2166  0088 80            	iret
2192                     ; 723 static void TIMER2_Init(void)
2192                     ; 724 {    
2194                     .text:	section	.text,new
2195  0000               L11_TIMER2_Init:
2199                     ; 725 	TIM2_TimeBaseInit(TIM2_PRESCALER_16, sys.hz50Flag ? TIMER2_INT_TIME_50HZ: TIMER2_INT_TIME_60HZ);
2201  0000 3d0c          	tnz	_sys+10
2202  0002 2705          	jreq	L67
2203  0004 ae0064        	ldw	x,#100
2204  0007 2003          	jra	L001
2205  0009               L67:
2206  0009 ae0053        	ldw	x,#83
2207  000c               L001:
2208  000c 89            	pushw	x
2209  000d a604          	ld	a,#4
2210  000f cd0000        	call	_TIM2_TimeBaseInit
2212  0012 85            	popw	x
2213                     ; 726    	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
2215  0013 ae0001        	ldw	x,#1
2216  0016 cd0000        	call	_TIM2_ClearFlag
2218                     ; 727    	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	   
2220  0019 ae0001        	ldw	x,#1
2221  001c a601          	ld	a,#1
2222  001e 95            	ld	xh,a
2223  001f cd0000        	call	_TIM2_ITConfig
2225                     ; 728 }
2228  0022 81            	ret
2255                     ; 733 @far @interrupt void Timer2_ISR(void) 
2255                     ; 734 {
2257                     .text:	section	.text,new
2258  0000               f_Timer2_ISR:
2261  0000 3b0002        	push	c_x+2
2262  0003 be00          	ldw	x,c_x
2263  0005 89            	pushw	x
2264  0006 3b0002        	push	c_y+2
2265  0009 be00          	ldw	x,c_y
2266  000b 89            	pushw	x
2269                     ; 736 	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);  
2271  000c a601          	ld	a,#1
2272  000e cd0000        	call	_TIM2_ClearITPendingBit
2274                     ; 738 	if (sys.light1.briCnt) {
2276  0011 3d02          	tnz	_sys
2277  0013 2702          	jreq	L136
2278                     ; 739 		sys.light1.briCnt--;			
2280  0015 3a02          	dec	_sys
2281  0017               L136:
2282                     ; 742 	if ((sys.light1.briCnt == 0) && (!sys.light1.onFlag)){
2284  0017 3d02          	tnz	_sys
2285  0019 2615          	jrne	L336
2287  001b 3d05          	tnz	_sys+3
2288  001d 2611          	jrne	L336
2289                     ; 743 		L1_EN_ON;
2291  001f 4b10          	push	#16
2292  0021 ae500a        	ldw	x,#20490
2293  0024 cd0000        	call	_GPIO_WriteLow
2295  0027 84            	pop	a
2298  0028 35280003      	mov	_sys+1,#40
2299                     ; 744 		sys.light1.onFlag = TRUE;		
2301  002c 35010005      	mov	_sys+3,#1
2302  0030               L336:
2303                     ; 747 	if (sys.light2.briCnt) {
2305  0030 3d06          	tnz	_sys+4
2306  0032 2702          	jreq	L536
2307                     ; 748 		sys.light2.briCnt--;		
2309  0034 3a06          	dec	_sys+4
2310  0036               L536:
2311                     ; 751 	if ((sys.light2.briCnt == 0) && (!sys.light2.onFlag)){
2313  0036 3d06          	tnz	_sys+4
2314  0038 2615          	jrne	L736
2316  003a 3d09          	tnz	_sys+7
2317  003c 2611          	jrne	L736
2318                     ; 752 		L2_EN_ON;
2320  003e 4b08          	push	#8
2321  0040 ae500a        	ldw	x,#20490
2322  0043 cd0000        	call	_GPIO_WriteLow
2324  0046 84            	pop	a
2327  0047 35280007      	mov	_sys+5,#40
2328                     ; 753 		sys.light2.onFlag = TRUE;
2330  004b 35010009      	mov	_sys+7,#1
2331  004f               L736:
2332                     ; 761 	if ((sys.light1.briCnt == 0) &&  (sys.light2.briCnt == 0)){
2334  004f 3d02          	tnz	_sys
2335  0051 2608          	jrne	L146
2337  0053 3d06          	tnz	_sys+4
2338  0055 2604          	jrne	L146
2339                     ; 762 		TIM2_Cmd(DISABLE);
2341  0057 4f            	clr	a
2342  0058 cd0000        	call	_TIM2_Cmd
2344  005b               L146:
2345                     ; 768 }
2348  005b 85            	popw	x
2349  005c bf00          	ldw	c_y,x
2350  005e 320002        	pop	c_y+2
2351  0061 85            	popw	x
2352  0062 bf00          	ldw	c_x,x
2353  0064 320002        	pop	c_x+2
2354  0067 80            	iret
2405                     ; 803 u8 Linear(float t)
2405                     ; 804 {
2407                     .text:	section	.text,new
2408  0000               _Linear:
2410  0000 5209          	subw	sp,#9
2411       00000009      OFST:	set	9
2414                     ; 805 	float 	temp1 = t * MAX_BRIGHTNESS;
2416  0002 96            	ldw	x,sp
2417  0003 1c000c        	addw	x,#OFST+3
2418  0006 cd0000        	call	c_ltor
2420  0009 ae0014        	ldw	x,#L333
2421  000c cd0000        	call	c_fmul
2423  000f 96            	ldw	x,sp
2424  0010 1c0005        	addw	x,#OFST-4
2425  0013 cd0000        	call	c_rtol
2427                     ; 806 	u8	temp2 = (u8)(t * MAX_BRIGHTNESS);
2429  0016 96            	ldw	x,sp
2430  0017 1c000c        	addw	x,#OFST+3
2431  001a cd0000        	call	c_ltor
2433  001d ae0014        	ldw	x,#L333
2434  0020 cd0000        	call	c_fmul
2436  0023 cd0000        	call	c_ftol
2438  0026 b603          	ld	a,c_lreg+3
2439  0028 6b09          	ld	(OFST+0,sp),a
2440                     ; 808 	if((t >= 0) && (t <= 1)){
2442  002a 9c            	rvf
2443  002b 0d0c          	tnz	(OFST+3,sp)
2444  002d 2f4c          	jrslt	L176
2446  002f 9c            	rvf
2447  0030 a601          	ld	a,#1
2448  0032 cd0000        	call	c_ctof
2450  0035 96            	ldw	x,sp
2451  0036 1c0001        	addw	x,#OFST-8
2452  0039 cd0000        	call	c_rtol
2454  003c 96            	ldw	x,sp
2455  003d 1c000c        	addw	x,#OFST+3
2456  0040 cd0000        	call	c_ltor
2458  0043 96            	ldw	x,sp
2459  0044 1c0001        	addw	x,#OFST-8
2460  0047 cd0000        	call	c_fcmp
2462  004a 2c2f          	jrsgt	L176
2463                     ; 810 		if(temp1 - temp2 >= 0.5){
2465  004c 9c            	rvf
2466  004d 7b09          	ld	a,(OFST+0,sp)
2467  004f 5f            	clrw	x
2468  0050 97            	ld	xl,a
2469  0051 cd0000        	call	c_itof
2471  0054 96            	ldw	x,sp
2472  0055 1c0001        	addw	x,#OFST-8
2473  0058 cd0000        	call	c_rtol
2475  005b 96            	ldw	x,sp
2476  005c 1c0005        	addw	x,#OFST-4
2477  005f cd0000        	call	c_ltor
2479  0062 96            	ldw	x,sp
2480  0063 1c0001        	addw	x,#OFST-8
2481  0066 cd0000        	call	c_fsub
2483  0069 ae0010        	ldw	x,#L107
2484  006c cd0000        	call	c_fcmp
2486  006f 2f05          	jrslt	L376
2487                     ; 811 			return (temp2 + 1);
2489  0071 7b09          	ld	a,(OFST+0,sp)
2490  0073 4c            	inc	a
2492  0074 2002          	jra	L601
2493  0076               L376:
2494                     ; 813 			return temp2;
2496  0076 7b09          	ld	a,(OFST+0,sp)
2498  0078               L601:
2500  0078 5b09          	addw	sp,#9
2501  007a 81            	ret
2502  007b               L176:
2503                     ; 818 		return DEFAULT_BRIGHTNESS;
2505  007b 4f            	clr	a
2507  007c 20fa          	jra	L601
2541                     ; 824 u8 EraseIn(float t)
2541                     ; 825 {
2542                     .text:	section	.text,new
2543  0000               _EraseIn:
2545  0000 5204          	subw	sp,#4
2546       00000004      OFST:	set	4
2549                     ; 826 	if((t >= 0)&&(t <=1))
2551  0002 9c            	rvf
2552  0003 0d07          	tnz	(OFST+3,sp)
2553  0005 2f38          	jrslt	L727
2555  0007 9c            	rvf
2556  0008 a601          	ld	a,#1
2557  000a cd0000        	call	c_ctof
2559  000d 96            	ldw	x,sp
2560  000e 1c0001        	addw	x,#OFST-3
2561  0011 cd0000        	call	c_rtol
2563  0014 96            	ldw	x,sp
2564  0015 1c0007        	addw	x,#OFST+3
2565  0018 cd0000        	call	c_ltor
2567  001b 96            	ldw	x,sp
2568  001c 1c0001        	addw	x,#OFST-3
2569  001f cd0000        	call	c_fcmp
2571  0022 2c1b          	jrsgt	L727
2572                     ; 827 		return (u8)(t*t*MAX_BRIGHTNESS);
2574  0024 96            	ldw	x,sp
2575  0025 1c0007        	addw	x,#OFST+3
2576  0028 cd0000        	call	c_ltor
2578  002b 96            	ldw	x,sp
2579  002c 1c0007        	addw	x,#OFST+3
2580  002f cd0000        	call	c_fmul
2582  0032 ae0014        	ldw	x,#L333
2583  0035 cd0000        	call	c_fmul
2585  0038 cd0000        	call	c_ftol
2587  003b b603          	ld	a,c_lreg+3
2589  003d 2001          	jra	L211
2590  003f               L727:
2591                     ; 829 		return DEFAULT_BRIGHTNESS;
2593  003f 4f            	clr	a
2595  0040               L211:
2597  0040 5b04          	addw	sp,#4
2598  0042 81            	ret
2632                     ; 832 u8 EraseOut(float t)
2632                     ; 833 {
2633                     .text:	section	.text,new
2634  0000               _EraseOut:
2636  0000 5204          	subw	sp,#4
2637       00000004      OFST:	set	4
2640                     ; 834 	if((t >= 0)&&(t <=1))
2642  0002 9c            	rvf
2643  0003 0d07          	tnz	(OFST+3,sp)
2644  0005 2f3d          	jrslt	L157
2646  0007 9c            	rvf
2647  0008 a601          	ld	a,#1
2648  000a cd0000        	call	c_ctof
2650  000d 96            	ldw	x,sp
2651  000e 1c0001        	addw	x,#OFST-3
2652  0011 cd0000        	call	c_rtol
2654  0014 96            	ldw	x,sp
2655  0015 1c0007        	addw	x,#OFST+3
2656  0018 cd0000        	call	c_ltor
2658  001b 96            	ldw	x,sp
2659  001c 1c0001        	addw	x,#OFST-3
2660  001f cd0000        	call	c_fcmp
2662  0022 2c20          	jrsgt	L157
2663                     ; 835 		return (u8)((2-t) * t * MAX_BRIGHTNESS);
2665  0024 a602          	ld	a,#2
2666  0026 cd0000        	call	c_ctof
2668  0029 96            	ldw	x,sp
2669  002a 1c0007        	addw	x,#OFST+3
2670  002d cd0000        	call	c_fsub
2672  0030 96            	ldw	x,sp
2673  0031 1c0007        	addw	x,#OFST+3
2674  0034 cd0000        	call	c_fmul
2676  0037 ae0014        	ldw	x,#L333
2677  003a cd0000        	call	c_fmul
2679  003d cd0000        	call	c_ftol
2681  0040 b603          	ld	a,c_lreg+3
2683  0042 2001          	jra	L611
2684  0044               L157:
2685                     ; 837 		return DEFAULT_BRIGHTNESS;
2687  0044 4f            	clr	a
2689  0045               L611:
2691  0045 5b04          	addw	sp,#4
2692  0047 81            	ret
2726                     ; 840 u8 Swing(float t)
2726                     ; 841 {
2727                     .text:	section	.text,new
2728  0000               _Swing:
2730  0000 5204          	subw	sp,#4
2731       00000004      OFST:	set	4
2734                     ; 842 	if((t >= 0)&&(t <=1)){
2736  0002 9c            	rvf
2737  0003 0d07          	tnz	(OFST+3,sp)
2738  0005 2e03          	jrsge	L421
2739  0007 cc0093        	jp	L377
2740  000a               L421:
2742  000a 9c            	rvf
2743  000b a601          	ld	a,#1
2744  000d cd0000        	call	c_ctof
2746  0010 96            	ldw	x,sp
2747  0011 1c0001        	addw	x,#OFST-3
2748  0014 cd0000        	call	c_rtol
2750  0017 96            	ldw	x,sp
2751  0018 1c0007        	addw	x,#OFST+3
2752  001b cd0000        	call	c_ltor
2754  001e 96            	ldw	x,sp
2755  001f 1c0001        	addw	x,#OFST-3
2756  0022 cd0000        	call	c_fcmp
2758  0025 2c6c          	jrsgt	L377
2759                     ; 843 		if(t < 0.5)
2761  0027 9c            	rvf
2762  0028 96            	ldw	x,sp
2763  0029 1c0007        	addw	x,#OFST+3
2764  002c cd0000        	call	c_ltor
2766  002f ae0010        	ldw	x,#L107
2767  0032 cd0000        	call	c_fcmp
2769  0035 2e21          	jrsge	L577
2770                     ; 844 			return (u8)(2 * t * t * MAX_BRIGHTNESS);
2772  0037 96            	ldw	x,sp
2773  0038 1c0007        	addw	x,#OFST+3
2774  003b cd0000        	call	c_ltor
2776  003e ae000c        	ldw	x,#L3001
2777  0041 cd0000        	call	c_fmul
2779  0044 96            	ldw	x,sp
2780  0045 1c0007        	addw	x,#OFST+3
2781  0048 cd0000        	call	c_fmul
2783  004b ae0014        	ldw	x,#L333
2784  004e cd0000        	call	c_fmul
2786  0051 cd0000        	call	c_ftol
2788  0054 b603          	ld	a,c_lreg+3
2790  0056 2038          	jra	L221
2791  0058               L577:
2792                     ; 846 			return (u8)(((4-2*t)*t - 1) * MAX_BRIGHTNESS);
2794  0058 96            	ldw	x,sp
2795  0059 1c0007        	addw	x,#OFST+3
2796  005c cd0000        	call	c_ltor
2798  005f ae000c        	ldw	x,#L3001
2799  0062 cd0000        	call	c_fmul
2801  0065 96            	ldw	x,sp
2802  0066 1c0001        	addw	x,#OFST-3
2803  0069 cd0000        	call	c_rtol
2805  006c a604          	ld	a,#4
2806  006e cd0000        	call	c_ctof
2808  0071 96            	ldw	x,sp
2809  0072 1c0001        	addw	x,#OFST-3
2810  0075 cd0000        	call	c_fsub
2812  0078 96            	ldw	x,sp
2813  0079 1c0007        	addw	x,#OFST+3
2814  007c cd0000        	call	c_fmul
2816  007f ae0008        	ldw	x,#L5101
2817  0082 cd0000        	call	c_fsub
2819  0085 ae0014        	ldw	x,#L333
2820  0088 cd0000        	call	c_fmul
2822  008b cd0000        	call	c_ftol
2824  008e b603          	ld	a,c_lreg+3
2826  0090               L221:
2828  0090 5b04          	addw	sp,#4
2829  0092 81            	ret
2830  0093               L377:
2831                     ; 849 		return DEFAULT_BRIGHTNESS;
2833  0093 4f            	clr	a
2835  0094 20fa          	jra	L221
2869                     ; 854 void lightCtrl100ms(void)
2869                     ; 855 {
2870                     .text:	section	.text,new
2871  0000               _lightCtrl100ms:
2873  0000 5204          	subw	sp,#4
2874       00000004      OFST:	set	4
2877                     ; 857 	if(channel & 0x01){
2879  0002 b611          	ld	a,_channel
2880  0004 a501          	bcp	a,#1
2881  0006 2603          	jrne	L031
2882  0008 cc00b3        	jp	L3301
2883  000b               L031:
2884                     ; 858 		if(linear1_begin){//channel Linear调光开始
2886  000b b600          	ld	a,_action_flag
2887  000d a501          	bcp	a,#1
2888  000f 2603          	jrne	L231
2889  0011 cc00b3        	jp	L3301
2890  0014               L231:
2891                     ; 860 			if(last_bright1 == aim_bright1){
2893  0014 ae0018        	ldw	x,#_last_bright1
2894  0017 cd0000        	call	c_ltor
2896  001a ae000d        	ldw	x,#_aim_bright1
2897  001d cd0000        	call	c_fcmp
2899  0020 260c          	jrne	L7301
2900                     ; 861 				linear1_begin = 0;
2902  0022 72110000      	bres	_action_flag,#0
2903                     ; 862 				channel &= ~(0x01);
2905  0026 72110011      	bres	_channel,#0
2907  002a acb300b3      	jpf	L3301
2908  002e               L7301:
2909                     ; 866 				if(last_bright1 > aim_bright1){
2911  002e 9c            	rvf
2912  002f ae0018        	ldw	x,#_last_bright1
2913  0032 cd0000        	call	c_ltor
2915  0035 ae000d        	ldw	x,#_aim_bright1
2916  0038 cd0000        	call	c_fcmp
2918  003b 2d3e          	jrsle	L3401
2919                     ; 867 					if((last_bright1 - aim_bright1) < (0 -change_step1)){
2921  003d 9c            	rvf
2922  003e ae0005        	ldw	x,#_change_step1
2923  0041 cd0000        	call	c_ltor
2925  0044 cd0000        	call	c_fneg
2927  0047 96            	ldw	x,sp
2928  0048 1c0001        	addw	x,#OFST-3
2929  004b cd0000        	call	c_rtol
2931  004e ae0018        	ldw	x,#_last_bright1
2932  0051 cd0000        	call	c_ltor
2934  0054 ae000d        	ldw	x,#_aim_bright1
2935  0057 cd0000        	call	c_fsub
2937  005a 96            	ldw	x,sp
2938  005b 1c0001        	addw	x,#OFST-3
2939  005e cd0000        	call	c_fcmp
2941  0061 2e0a          	jrsge	L5401
2942                     ; 868 						last_bright1 = aim_bright1;
2944  0063 be0f          	ldw	x,_aim_bright1+2
2945  0065 bf1a          	ldw	_last_bright1+2,x
2946  0067 be0d          	ldw	x,_aim_bright1
2947  0069 bf18          	ldw	_last_bright1,x
2949  006b 2039          	jra	L1501
2950  006d               L5401:
2951                     ; 870 						last_bright1 += change_step1;
2953  006d ae0005        	ldw	x,#_change_step1
2954  0070 cd0000        	call	c_ltor
2956  0073 ae0018        	ldw	x,#_last_bright1
2957  0076 cd0000        	call	c_fgadd
2959  0079 202b          	jra	L1501
2960  007b               L3401:
2961                     ; 874 					if((aim_bright1 - last_bright1) < change_step1){
2963  007b 9c            	rvf
2964  007c ae000d        	ldw	x,#_aim_bright1
2965  007f cd0000        	call	c_ltor
2967  0082 ae0018        	ldw	x,#_last_bright1
2968  0085 cd0000        	call	c_fsub
2970  0088 ae0005        	ldw	x,#_change_step1
2971  008b cd0000        	call	c_fcmp
2973  008e 2e0a          	jrsge	L3501
2974                     ; 875 						last_bright1 = aim_bright1;
2976  0090 be0f          	ldw	x,_aim_bright1+2
2977  0092 bf1a          	ldw	_last_bright1+2,x
2978  0094 be0d          	ldw	x,_aim_bright1
2979  0096 bf18          	ldw	_last_bright1,x
2981  0098 200c          	jra	L1501
2982  009a               L3501:
2983                     ; 877 						last_bright1 += change_step1;
2985  009a ae0005        	ldw	x,#_change_step1
2986  009d cd0000        	call	c_ltor
2988  00a0 ae0018        	ldw	x,#_last_bright1
2989  00a3 cd0000        	call	c_fgadd
2991  00a6               L1501:
2992                     ; 880 				realtime_bright1 = Linear(last_bright1);
2994  00a6 be1a          	ldw	x,_last_bright1+2
2995  00a8 89            	pushw	x
2996  00a9 be18          	ldw	x,_last_bright1
2997  00ab 89            	pushw	x
2998  00ac cd0000        	call	_Linear
3000  00af 5b04          	addw	sp,#4
3001  00b1 b713          	ld	_realtime_bright1,a
3002  00b3               L3301:
3003                     ; 905 	if(channel & 0x02){
3005  00b3 b611          	ld	a,_channel
3006  00b5 a502          	bcp	a,#2
3007  00b7 2603          	jrne	L431
3008  00b9 cc0164        	jp	L7501
3009  00bc               L431:
3010                     ; 906 		if(linear2_begin){//channel2 Linear调光开始
3012  00bc b600          	ld	a,_action_flag
3013  00be a502          	bcp	a,#2
3014  00c0 2603          	jrne	L631
3015  00c2 cc0164        	jp	L7501
3016  00c5               L631:
3017                     ; 909 			if(last_bright2 == aim_bright2){
3019  00c5 ae0014        	ldw	x,#_last_bright2
3020  00c8 cd0000        	call	c_ltor
3022  00cb ae0009        	ldw	x,#_aim_bright2
3023  00ce cd0000        	call	c_fcmp
3025  00d1 260c          	jrne	L3601
3026                     ; 910 				linear2_begin = 0;
3028  00d3 72130000      	bres	_action_flag,#1
3029                     ; 911 				channel &= ~(0x02);
3031  00d7 72130011      	bres	_channel,#1
3033  00db ac640164      	jpf	L7501
3034  00df               L3601:
3035                     ; 915 				if(last_bright2 > aim_bright2){
3037  00df 9c            	rvf
3038  00e0 ae0014        	ldw	x,#_last_bright2
3039  00e3 cd0000        	call	c_ltor
3041  00e6 ae0009        	ldw	x,#_aim_bright2
3042  00e9 cd0000        	call	c_fcmp
3044  00ec 2d3e          	jrsle	L7601
3045                     ; 916 					if((last_bright2 - aim_bright2) < (0 -change_step2)){
3047  00ee 9c            	rvf
3048  00ef ae0001        	ldw	x,#_change_step2
3049  00f2 cd0000        	call	c_ltor
3051  00f5 cd0000        	call	c_fneg
3053  00f8 96            	ldw	x,sp
3054  00f9 1c0001        	addw	x,#OFST-3
3055  00fc cd0000        	call	c_rtol
3057  00ff ae0014        	ldw	x,#_last_bright2
3058  0102 cd0000        	call	c_ltor
3060  0105 ae0009        	ldw	x,#_aim_bright2
3061  0108 cd0000        	call	c_fsub
3063  010b 96            	ldw	x,sp
3064  010c 1c0001        	addw	x,#OFST-3
3065  010f cd0000        	call	c_fcmp
3067  0112 2e0a          	jrsge	L1701
3068                     ; 917 						last_bright2 = aim_bright2;
3070  0114 be0b          	ldw	x,_aim_bright2+2
3071  0116 bf16          	ldw	_last_bright2+2,x
3072  0118 be09          	ldw	x,_aim_bright2
3073  011a bf14          	ldw	_last_bright2,x
3075  011c 2039          	jra	L5701
3076  011e               L1701:
3077                     ; 919 						last_bright2 += change_step2;
3079  011e ae0001        	ldw	x,#_change_step2
3080  0121 cd0000        	call	c_ltor
3082  0124 ae0014        	ldw	x,#_last_bright2
3083  0127 cd0000        	call	c_fgadd
3085  012a 202b          	jra	L5701
3086  012c               L7601:
3087                     ; 923 					if((aim_bright2 - last_bright2) < change_step2){
3089  012c 9c            	rvf
3090  012d ae0009        	ldw	x,#_aim_bright2
3091  0130 cd0000        	call	c_ltor
3093  0133 ae0014        	ldw	x,#_last_bright2
3094  0136 cd0000        	call	c_fsub
3096  0139 ae0001        	ldw	x,#_change_step2
3097  013c cd0000        	call	c_fcmp
3099  013f 2e0a          	jrsge	L7701
3100                     ; 924 						last_bright2 = aim_bright2;
3102  0141 be0b          	ldw	x,_aim_bright2+2
3103  0143 bf16          	ldw	_last_bright2+2,x
3104  0145 be09          	ldw	x,_aim_bright2
3105  0147 bf14          	ldw	_last_bright2,x
3107  0149 200c          	jra	L5701
3108  014b               L7701:
3109                     ; 926 						last_bright2 += change_step2;
3111  014b ae0001        	ldw	x,#_change_step2
3112  014e cd0000        	call	c_ltor
3114  0151 ae0014        	ldw	x,#_last_bright2
3115  0154 cd0000        	call	c_fgadd
3117  0157               L5701:
3118                     ; 929 				realtime_bright2 = Linear(last_bright2);
3120  0157 be16          	ldw	x,_last_bright2+2
3121  0159 89            	pushw	x
3122  015a be14          	ldw	x,_last_bright2
3123  015c 89            	pushw	x
3124  015d cd0000        	call	_Linear
3126  0160 5b04          	addw	sp,#4
3127  0162 b712          	ld	_realtime_bright2,a
3128  0164               L7501:
3129                     ; 1038 }
3132  0164 5b04          	addw	sp,#4
3133  0166 81            	ret
3168                     ; 1044 void lightCtrl_50ms(void)
3168                     ; 1045 {
3169                     .text:	section	.text,new
3170  0000               _lightCtrl_50ms:
3172  0000 5204          	subw	sp,#4
3173       00000004      OFST:	set	4
3176                     ; 1103 	if(channel1){
3178  0002 3d00          	tnz	_channel1
3179  0004 2603          	jrne	L241
3180  0006 cc00bd        	jp	L3111
3181  0009               L241:
3182                     ; 1105 		if(last_bright1 == aim_bright1){		//channel1 Linear调光开始
3184  0009 ae0018        	ldw	x,#_last_bright1
3185  000c cd0000        	call	c_ltor
3187  000f ae000d        	ldw	x,#_aim_bright1
3188  0012 cd0000        	call	c_fcmp
3190  0015 260a          	jrne	L5111
3191                     ; 1106 			channel1 = 0;
3193  0017 3f00          	clr	_channel1
3194                     ; 1107 			slc.savFlag = 1;
3196  0019 3501003a      	mov	_slc+30,#1
3198  001d acbd00bd      	jpf	L3111
3199  0021               L5111:
3200                     ; 1111 			if(last_bright1 > aim_bright1){
3202  0021 9c            	rvf
3203  0022 ae0018        	ldw	x,#_last_bright1
3204  0025 cd0000        	call	c_ltor
3206  0028 ae000d        	ldw	x,#_aim_bright1
3207  002b cd0000        	call	c_fcmp
3209  002e 2d41          	jrsle	L1211
3210                     ; 1112 				if((last_bright1 - aim_bright1) <= (0.000001 -change_step1)){
3212  0030 9c            	rvf
3213  0031 ae0004        	ldw	x,#L1311
3214  0034 cd0000        	call	c_ltor
3216  0037 ae0005        	ldw	x,#_change_step1
3217  003a cd0000        	call	c_fsub
3219  003d 96            	ldw	x,sp
3220  003e 1c0001        	addw	x,#OFST-3
3221  0041 cd0000        	call	c_rtol
3223  0044 ae0018        	ldw	x,#_last_bright1
3224  0047 cd0000        	call	c_ltor
3226  004a ae000d        	ldw	x,#_aim_bright1
3227  004d cd0000        	call	c_fsub
3229  0050 96            	ldw	x,sp
3230  0051 1c0001        	addw	x,#OFST-3
3231  0054 cd0000        	call	c_fcmp
3233  0057 2c0a          	jrsgt	L3211
3234                     ; 1113 					last_bright1 = aim_bright1;
3236  0059 be0f          	ldw	x,_aim_bright1+2
3237  005b bf1a          	ldw	_last_bright1+2,x
3238  005d be0d          	ldw	x,_aim_bright1
3239  005f bf18          	ldw	_last_bright1,x
3241  0061 204d          	jra	L7311
3242  0063               L3211:
3243                     ; 1115 					last_bright1 += change_step1;
3245  0063 ae0005        	ldw	x,#_change_step1
3246  0066 cd0000        	call	c_ltor
3248  0069 ae0018        	ldw	x,#_last_bright1
3249  006c cd0000        	call	c_fgadd
3251  006f 203f          	jra	L7311
3252  0071               L1211:
3253                     ; 1119 				if((aim_bright1 - last_bright1) <= (change_step1 + 0.000001)){
3255  0071 9c            	rvf
3256  0072 ae0005        	ldw	x,#_change_step1
3257  0075 cd0000        	call	c_ltor
3259  0078 ae0004        	ldw	x,#L1311
3260  007b cd0000        	call	c_fadd
3262  007e 96            	ldw	x,sp
3263  007f 1c0001        	addw	x,#OFST-3
3264  0082 cd0000        	call	c_rtol
3266  0085 ae000d        	ldw	x,#_aim_bright1
3267  0088 cd0000        	call	c_ltor
3269  008b ae0018        	ldw	x,#_last_bright1
3270  008e cd0000        	call	c_fsub
3272  0091 96            	ldw	x,sp
3273  0092 1c0001        	addw	x,#OFST-3
3274  0095 cd0000        	call	c_fcmp
3276  0098 2c0a          	jrsgt	L1411
3277                     ; 1120 					last_bright1 = aim_bright1;
3279  009a be0f          	ldw	x,_aim_bright1+2
3280  009c bf1a          	ldw	_last_bright1+2,x
3281  009e be0d          	ldw	x,_aim_bright1
3282  00a0 bf18          	ldw	_last_bright1,x
3284  00a2 200c          	jra	L7311
3285  00a4               L1411:
3286                     ; 1122 					last_bright1 += change_step1;
3288  00a4 ae0005        	ldw	x,#_change_step1
3289  00a7 cd0000        	call	c_ltor
3291  00aa ae0018        	ldw	x,#_last_bright1
3292  00ad cd0000        	call	c_fgadd
3294  00b0               L7311:
3295                     ; 1125 			realtime_bright1 = Linear(last_bright1);
3297  00b0 be1a          	ldw	x,_last_bright1+2
3298  00b2 89            	pushw	x
3299  00b3 be18          	ldw	x,_last_bright1
3300  00b5 89            	pushw	x
3301  00b6 cd0000        	call	_Linear
3303  00b9 5b04          	addw	sp,#4
3304  00bb b713          	ld	_realtime_bright1,a
3305  00bd               L3111:
3306                     ; 1130 	if(channel2){
3308  00bd 3d01          	tnz	_channel2
3309  00bf 2603          	jrne	L441
3310  00c1 cc0178        	jp	L5411
3311  00c4               L441:
3312                     ; 1132 		if(last_bright2 == aim_bright2){
3314  00c4 ae0014        	ldw	x,#_last_bright2
3315  00c7 cd0000        	call	c_ltor
3317  00ca ae0009        	ldw	x,#_aim_bright2
3318  00cd cd0000        	call	c_fcmp
3320  00d0 260a          	jrne	L7411
3321                     ; 1133 			channel2 = 0;
3323  00d2 3f01          	clr	_channel2
3324                     ; 1134 			slc.savFlag = 1;
3326  00d4 3501003a      	mov	_slc+30,#1
3328  00d8 ac780178      	jpf	L5411
3329  00dc               L7411:
3330                     ; 1138 			if(last_bright2 > aim_bright2){
3332  00dc 9c            	rvf
3333  00dd ae0014        	ldw	x,#_last_bright2
3334  00e0 cd0000        	call	c_ltor
3336  00e3 ae0009        	ldw	x,#_aim_bright2
3337  00e6 cd0000        	call	c_fcmp
3339  00e9 2d41          	jrsle	L3511
3340                     ; 1139 				if((last_bright2 - aim_bright2) <= (0.000001 -change_step2)){
3342  00eb 9c            	rvf
3343  00ec ae0004        	ldw	x,#L1311
3344  00ef cd0000        	call	c_ltor
3346  00f2 ae0001        	ldw	x,#_change_step2
3347  00f5 cd0000        	call	c_fsub
3349  00f8 96            	ldw	x,sp
3350  00f9 1c0001        	addw	x,#OFST-3
3351  00fc cd0000        	call	c_rtol
3353  00ff ae0014        	ldw	x,#_last_bright2
3354  0102 cd0000        	call	c_ltor
3356  0105 ae0009        	ldw	x,#_aim_bright2
3357  0108 cd0000        	call	c_fsub
3359  010b 96            	ldw	x,sp
3360  010c 1c0001        	addw	x,#OFST-3
3361  010f cd0000        	call	c_fcmp
3363  0112 2c0a          	jrsgt	L5511
3364                     ; 1140 					last_bright2 = aim_bright2;
3366  0114 be0b          	ldw	x,_aim_bright2+2
3367  0116 bf16          	ldw	_last_bright2+2,x
3368  0118 be09          	ldw	x,_aim_bright2
3369  011a bf14          	ldw	_last_bright2,x
3371  011c 204d          	jra	L1611
3372  011e               L5511:
3373                     ; 1142 					last_bright2 += change_step2;
3375  011e ae0001        	ldw	x,#_change_step2
3376  0121 cd0000        	call	c_ltor
3378  0124 ae0014        	ldw	x,#_last_bright2
3379  0127 cd0000        	call	c_fgadd
3381  012a 203f          	jra	L1611
3382  012c               L3511:
3383                     ; 1146 				if((aim_bright2 - last_bright2) <= (change_step2 + 0.000001)){
3385  012c 9c            	rvf
3386  012d ae0001        	ldw	x,#_change_step2
3387  0130 cd0000        	call	c_ltor
3389  0133 ae0004        	ldw	x,#L1311
3390  0136 cd0000        	call	c_fadd
3392  0139 96            	ldw	x,sp
3393  013a 1c0001        	addw	x,#OFST-3
3394  013d cd0000        	call	c_rtol
3396  0140 ae0009        	ldw	x,#_aim_bright2
3397  0143 cd0000        	call	c_ltor
3399  0146 ae0014        	ldw	x,#_last_bright2
3400  0149 cd0000        	call	c_fsub
3402  014c 96            	ldw	x,sp
3403  014d 1c0001        	addw	x,#OFST-3
3404  0150 cd0000        	call	c_fcmp
3406  0153 2c0a          	jrsgt	L3611
3407                     ; 1147 					last_bright2 = aim_bright2;
3409  0155 be0b          	ldw	x,_aim_bright2+2
3410  0157 bf16          	ldw	_last_bright2+2,x
3411  0159 be09          	ldw	x,_aim_bright2
3412  015b bf14          	ldw	_last_bright2,x
3414  015d 200c          	jra	L1611
3415  015f               L3611:
3416                     ; 1149 					last_bright2 += change_step2;
3418  015f ae0001        	ldw	x,#_change_step2
3419  0162 cd0000        	call	c_ltor
3421  0165 ae0014        	ldw	x,#_last_bright2
3422  0168 cd0000        	call	c_fgadd
3424  016b               L1611:
3425                     ; 1152 			realtime_bright2 = Linear(last_bright2);
3427  016b be16          	ldw	x,_last_bright2+2
3428  016d 89            	pushw	x
3429  016e be14          	ldw	x,_last_bright2
3430  0170 89            	pushw	x
3431  0171 cd0000        	call	_Linear
3433  0174 5b04          	addw	sp,#4
3434  0176 b712          	ld	_realtime_bright2,a
3435  0178               L5411:
3436                     ; 1160 }
3439  0178 5b04          	addw	sp,#4
3440  017a 81            	ret
4207                     	xdef	_Swing
4208                     	xdef	_EraseOut
4209                     	xdef	_EraseIn
4210                     	xdef	_Linear
4211                     	xdef	_assert_failed
4212                     	xdef	_main
4213                     	xdef	_interrupt_priority_set
4214                     	xdef	_MEEPROM_Init
4215                     	xdef	_device_info_read
4216                     	xdef	_default_info_set
4217                     	xdef	_channel_status_save
4218                     	xdef	_MEEPROM_ReadByte
4219                     	xdef	_MEEPROM_WriteByte
4220                     	xdef	_system_addr_get
4221                     	xdef	_system_clock_set
4222                     	xdef	_delay
4223                     	xref	_uart1_recv_handle
4224                     	xref	_uart1_init
4225                     	xref.b	_uart1_frame
4226                     	xdef	f_Timer4_ISR
4227                     	xdef	f_Timer2_ISR
4228                     	xdef	f_Ext_PortD_ISR
4229                     	xdef	_mymemcpy
4230                     	xdef	_lightCtrl_50ms
4231                     	xdef	_lightCtrl100ms
4232                     	switch	.ubsct
4233  0000               _action_flag:
4234  0000 00            	ds.b	1
4235                     	xdef	_action_flag
4236  0001               _change_step2:
4237  0001 00000000      	ds.b	4
4238                     	xdef	_change_step2
4239  0005               _change_step1:
4240  0005 00000000      	ds.b	4
4241                     	xdef	_change_step1
4242  0009               _aim_bright2:
4243  0009 00000000      	ds.b	4
4244                     	xdef	_aim_bright2
4245  000d               _aim_bright1:
4246  000d 00000000      	ds.b	4
4247                     	xdef	_aim_bright1
4248                     	xdef	_channel2
4249                     	xdef	_channel1
4250  0011               _channel:
4251  0011 00            	ds.b	1
4252                     	xdef	_channel
4253  0012               _realtime_bright2:
4254  0012 00            	ds.b	1
4255                     	xdef	_realtime_bright2
4256  0013               _realtime_bright1:
4257  0013 00            	ds.b	1
4258                     	xdef	_realtime_bright1
4259  0014               _last_bright2:
4260  0014 00000000      	ds.b	4
4261                     	xdef	_last_bright2
4262  0018               _last_bright1:
4263  0018 00000000      	ds.b	4
4264                     	xdef	_last_bright1
4265  001c               _slc:
4266  001c 000000000000  	ds.b	35
4267                     	xdef	_slc
4268                     	xdef	_sys
4269                     	xdef	_tick
4270                     	xref	_TIM4_ClearITPendingBit
4271                     	xref	_TIM4_ClearFlag
4272                     	xref	_TIM4_SetAutoreload
4273                     	xref	_TIM4_ITConfig
4274                     	xref	_TIM4_Cmd
4275                     	xref	_TIM4_TimeBaseInit
4276                     	xref	_TIM2_ClearITPendingBit
4277                     	xref	_TIM2_ClearFlag
4278                     	xref	_TIM2_SetAutoreload
4279                     	xref	_TIM2_ITConfig
4280                     	xref	_TIM2_Cmd
4281                     	xref	_TIM2_TimeBaseInit
4282                     	xref	_ITC_SetSoftwarePriority
4283                     	xref	_ITC_DeInit
4284                     	xref	_GPIO_ReadOutputData
4285                     	xref	_GPIO_ReadInputData
4286                     	xref	_GPIO_WriteLow
4287                     	xref	_GPIO_WriteHigh
4288                     	xref	_GPIO_Init
4289                     	xref	_FLASH_GetFlagStatus
4290                     	xref	_FLASH_ReadByte
4291                     	xref	_FLASH_ProgramByte
4292                     	xref	_FLASH_DeInit
4293                     	xref	_FLASH_Lock
4294                     	xref	_FLASH_Unlock
4295                     	xref	_EXTI_SetExtIntSensitivity
4296                     	xref	_EXTI_DeInit
4297                     	xref	_CLK_PeripheralClockConfig
4298                     	switch	.const
4299  0004               L1311:
4300  0004 358637bd      	dc.w	13702,14269
4301  0008               L5101:
4302  0008 3f800000      	dc.w	16256,0
4303  000c               L3001:
4304  000c 40000000      	dc.w	16384,0
4305  0010               L107:
4306  0010 3f000000      	dc.w	16128,0
4307  0014               L333:
4308  0014 42c80000      	dc.w	17096,0
4309                     	xref.b	c_lreg
4310                     	xref.b	c_x
4311                     	xref.b	c_y
4331                     	xref	c_fadd
4332                     	xref	c_fgadd
4333                     	xref	c_fneg
4334                     	xref	c_fsub
4335                     	xref	c_fcmp
4336                     	xref	c_ctof
4337                     	xref	c_ftol
4338                     	xref	c_fmul
4339                     	xref	c_rtol
4340                     	xref	c_fdiv
4341                     	xref	c_itof
4342                     	xref	c_ladd
4343                     	xref	c_uitolx
4344                     	xref	c_lrzmp
4345                     	xref	c_lgsbc
4346                     	xref	c_ltor
4347                     	end
