   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 67 void I2C_DeInit(void)
  32                     ; 68 {
  34                     .text:	section	.text,new
  35  0000               _I2C_DeInit:
  39                     ; 69   I2C->CR1 = I2C_CR1_RESET_VALUE;
  41  0000 725f5210      	clr	21008
  42                     ; 70   I2C->CR2 = I2C_CR2_RESET_VALUE;
  44  0004 725f5211      	clr	21009
  45                     ; 71   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  47  0008 725f5212      	clr	21010
  48                     ; 72   I2C->OARL = I2C_OARL_RESET_VALUE;
  50  000c 725f5213      	clr	21011
  51                     ; 73   I2C->OARH = I2C_OARH_RESET_VALUE;
  53  0010 725f5214      	clr	21012
  54                     ; 74   I2C->ITR = I2C_ITR_RESET_VALUE;
  56  0014 725f521a      	clr	21018
  57                     ; 75   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  59  0018 725f521b      	clr	21019
  60                     ; 76   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  62  001c 725f521c      	clr	21020
  63                     ; 77   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  65  0020 3502521d      	mov	21021,#2
  66                     ; 78 }
  69  0024 81            	ret
 248                     .const:	section	.text
 249  0000               L01:
 250  0000 000186a1      	dc.l	100001
 251  0004               L21:
 252  0004 000f4240      	dc.l	1000000
 253                     ; 96 void I2C_Init(uint32_t OutputClockFrequencyHz, uint16_t OwnAddress, 
 253                     ; 97               I2C_DutyCycle_TypeDef I2C_DutyCycle, I2C_Ack_TypeDef Ack, 
 253                     ; 98               I2C_AddMode_TypeDef AddMode, uint8_t InputClockFrequencyMHz )
 253                     ; 99 {
 254                     .text:	section	.text,new
 255  0000               _I2C_Init:
 257  0000 5209          	subw	sp,#9
 258       00000009      OFST:	set	9
 261                     ; 100   uint16_t result = 0x0004;
 263  0002 1e08          	ldw	x,(OFST-1,sp)
 264                     ; 101   uint16_t tmpval = 0;
 266  0004 1e05          	ldw	x,(OFST-4,sp)
 267                     ; 102   uint8_t tmpccrh = 0;
 269  0006 0f07          	clr	(OFST-2,sp)
 270                     ; 105   assert_param(IS_I2C_ACK_OK(Ack));
 272                     ; 106   assert_param(IS_I2C_ADDMODE_OK(AddMode));
 274                     ; 107   assert_param(IS_I2C_OWN_ADDRESS_OK(OwnAddress));
 276                     ; 108   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));  
 278                     ; 109   assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(InputClockFrequencyMHz));
 280                     ; 110   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(OutputClockFrequencyHz));
 282                     ; 115   I2C->FREQR &= (uint8_t)(~I2C_FREQR_FREQ);
 284  0008 c65212        	ld	a,21010
 285  000b a4c0          	and	a,#192
 286  000d c75212        	ld	21010,a
 287                     ; 117   I2C->FREQR |= InputClockFrequencyMHz;
 289  0010 c65212        	ld	a,21010
 290  0013 1a15          	or	a,(OFST+12,sp)
 291  0015 c75212        	ld	21010,a
 292                     ; 121   I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 294  0018 72115210      	bres	21008,#0
 295                     ; 124   I2C->CCRH &= (uint8_t)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 297  001c c6521c        	ld	a,21020
 298  001f a430          	and	a,#48
 299  0021 c7521c        	ld	21020,a
 300                     ; 125   I2C->CCRL &= (uint8_t)(~I2C_CCRL_CCR);
 302  0024 725f521b      	clr	21019
 303                     ; 128   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 305  0028 96            	ldw	x,sp
 306  0029 1c000c        	addw	x,#OFST+3
 307  002c cd0000        	call	c_ltor
 309  002f ae0000        	ldw	x,#L01
 310  0032 cd0000        	call	c_lcmp
 312  0035 2403          	jruge	L61
 313  0037 cc00c4        	jp	L131
 314  003a               L61:
 315                     ; 131     tmpccrh = I2C_CCRH_FS;
 317  003a a680          	ld	a,#128
 318  003c 6b07          	ld	(OFST-2,sp),a
 319                     ; 133     if (I2C_DutyCycle == I2C_DUTYCYCLE_2)
 321  003e 0d12          	tnz	(OFST+9,sp)
 322  0040 2630          	jrne	L331
 323                     ; 136       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 325  0042 96            	ldw	x,sp
 326  0043 1c000c        	addw	x,#OFST+3
 327  0046 cd0000        	call	c_ltor
 329  0049 a603          	ld	a,#3
 330  004b cd0000        	call	c_smul
 332  004e 96            	ldw	x,sp
 333  004f 1c0001        	addw	x,#OFST-8
 334  0052 cd0000        	call	c_rtol
 336  0055 7b15          	ld	a,(OFST+12,sp)
 337  0057 b703          	ld	c_lreg+3,a
 338  0059 3f02          	clr	c_lreg+2
 339  005b 3f01          	clr	c_lreg+1
 340  005d 3f00          	clr	c_lreg
 341  005f ae0004        	ldw	x,#L21
 342  0062 cd0000        	call	c_lmul
 344  0065 96            	ldw	x,sp
 345  0066 1c0001        	addw	x,#OFST-8
 346  0069 cd0000        	call	c_ludv
 348  006c be02          	ldw	x,c_lreg+2
 349  006e 1f08          	ldw	(OFST-1,sp),x
 351  0070 2034          	jra	L531
 352  0072               L331:
 353                     ; 141       result = (uint16_t) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 355  0072 96            	ldw	x,sp
 356  0073 1c000c        	addw	x,#OFST+3
 357  0076 cd0000        	call	c_ltor
 359  0079 a619          	ld	a,#25
 360  007b cd0000        	call	c_smul
 362  007e 96            	ldw	x,sp
 363  007f 1c0001        	addw	x,#OFST-8
 364  0082 cd0000        	call	c_rtol
 366  0085 7b15          	ld	a,(OFST+12,sp)
 367  0087 b703          	ld	c_lreg+3,a
 368  0089 3f02          	clr	c_lreg+2
 369  008b 3f01          	clr	c_lreg+1
 370  008d 3f00          	clr	c_lreg
 371  008f ae0004        	ldw	x,#L21
 372  0092 cd0000        	call	c_lmul
 374  0095 96            	ldw	x,sp
 375  0096 1c0001        	addw	x,#OFST-8
 376  0099 cd0000        	call	c_ludv
 378  009c be02          	ldw	x,c_lreg+2
 379  009e 1f08          	ldw	(OFST-1,sp),x
 380                     ; 143       tmpccrh |= I2C_CCRH_DUTY;
 382  00a0 7b07          	ld	a,(OFST-2,sp)
 383  00a2 aa40          	or	a,#64
 384  00a4 6b07          	ld	(OFST-2,sp),a
 385  00a6               L531:
 386                     ; 147     if (result < (uint16_t)0x01)
 388  00a6 1e08          	ldw	x,(OFST-1,sp)
 389  00a8 2605          	jrne	L731
 390                     ; 150       result = (uint16_t)0x0001;
 392  00aa ae0001        	ldw	x,#1
 393  00ad 1f08          	ldw	(OFST-1,sp),x
 394  00af               L731:
 395                     ; 156     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 397  00af 7b15          	ld	a,(OFST+12,sp)
 398  00b1 97            	ld	xl,a
 399  00b2 a603          	ld	a,#3
 400  00b4 42            	mul	x,a
 401  00b5 a60a          	ld	a,#10
 402  00b7 cd0000        	call	c_sdivx
 404  00ba 5c            	incw	x
 405  00bb 1f05          	ldw	(OFST-4,sp),x
 406                     ; 157     I2C->TRISER = (uint8_t)tmpval;
 408  00bd 7b06          	ld	a,(OFST-3,sp)
 409  00bf c7521d        	ld	21021,a
 411  00c2 2043          	jra	L141
 412  00c4               L131:
 413                     ; 164     result = (uint16_t)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (uint8_t)1));
 415  00c4 96            	ldw	x,sp
 416  00c5 1c000c        	addw	x,#OFST+3
 417  00c8 cd0000        	call	c_ltor
 419  00cb 3803          	sll	c_lreg+3
 420  00cd 3902          	rlc	c_lreg+2
 421  00cf 3901          	rlc	c_lreg+1
 422  00d1 3900          	rlc	c_lreg
 423  00d3 96            	ldw	x,sp
 424  00d4 1c0001        	addw	x,#OFST-8
 425  00d7 cd0000        	call	c_rtol
 427  00da 7b15          	ld	a,(OFST+12,sp)
 428  00dc b703          	ld	c_lreg+3,a
 429  00de 3f02          	clr	c_lreg+2
 430  00e0 3f01          	clr	c_lreg+1
 431  00e2 3f00          	clr	c_lreg
 432  00e4 ae0004        	ldw	x,#L21
 433  00e7 cd0000        	call	c_lmul
 435  00ea 96            	ldw	x,sp
 436  00eb 1c0001        	addw	x,#OFST-8
 437  00ee cd0000        	call	c_ludv
 439  00f1 be02          	ldw	x,c_lreg+2
 440  00f3 1f08          	ldw	(OFST-1,sp),x
 441                     ; 167     if (result < (uint16_t)0x0004)
 443  00f5 1e08          	ldw	x,(OFST-1,sp)
 444  00f7 a30004        	cpw	x,#4
 445  00fa 2405          	jruge	L341
 446                     ; 170       result = (uint16_t)0x0004;
 448  00fc ae0004        	ldw	x,#4
 449  00ff 1f08          	ldw	(OFST-1,sp),x
 450  0101               L341:
 451                     ; 176     I2C->TRISER = (uint8_t)(InputClockFrequencyMHz + (uint8_t)1);
 453  0101 7b15          	ld	a,(OFST+12,sp)
 454  0103 4c            	inc	a
 455  0104 c7521d        	ld	21021,a
 456  0107               L141:
 457                     ; 181   I2C->CCRL = (uint8_t)result;
 459  0107 7b09          	ld	a,(OFST+0,sp)
 460  0109 c7521b        	ld	21019,a
 461                     ; 182   I2C->CCRH = (uint8_t)((uint8_t)((uint8_t)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 463  010c 7b08          	ld	a,(OFST-1,sp)
 464  010e a40f          	and	a,#15
 465  0110 1a07          	or	a,(OFST-2,sp)
 466  0112 c7521c        	ld	21020,a
 467                     ; 185   I2C->CR1 |= I2C_CR1_PE;
 469  0115 72105210      	bset	21008,#0
 470                     ; 188   I2C_AcknowledgeConfig(Ack);
 472  0119 7b13          	ld	a,(OFST+10,sp)
 473  011b cd0000        	call	_I2C_AcknowledgeConfig
 475                     ; 191   I2C->OARL = (uint8_t)(OwnAddress);
 477  011e 7b11          	ld	a,(OFST+8,sp)
 478  0120 c75213        	ld	21011,a
 479                     ; 192   I2C->OARH = (uint8_t)((uint8_t)(AddMode | I2C_OARH_ADDCONF) |
 479                     ; 193                    (uint8_t)((OwnAddress & (uint16_t)0x0300) >> (uint8_t)7));
 481  0123 7b10          	ld	a,(OFST+7,sp)
 482  0125 97            	ld	xl,a
 483  0126 7b11          	ld	a,(OFST+8,sp)
 484  0128 9f            	ld	a,xl
 485  0129 a403          	and	a,#3
 486  012b 97            	ld	xl,a
 487  012c 4f            	clr	a
 488  012d 02            	rlwa	x,a
 489  012e a607          	ld	a,#7
 490  0130               L41:
 491  0130 54            	srlw	x
 492  0131 4a            	dec	a
 493  0132 26fc          	jrne	L41
 494  0134 9f            	ld	a,xl
 495  0135 6b04          	ld	(OFST-5,sp),a
 496  0137 7b14          	ld	a,(OFST+11,sp)
 497  0139 aa40          	or	a,#64
 498  013b 1a04          	or	a,(OFST-5,sp)
 499  013d c75214        	ld	21012,a
 500                     ; 194 }
 503  0140 5b09          	addw	sp,#9
 504  0142 81            	ret
 559                     ; 202 void I2C_Cmd(FunctionalState NewState)
 559                     ; 203 {
 560                     .text:	section	.text,new
 561  0000               _I2C_Cmd:
 565                     ; 205   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 567                     ; 207   if (NewState != DISABLE)
 569  0000 4d            	tnz	a
 570  0001 2706          	jreq	L371
 571                     ; 210     I2C->CR1 |= I2C_CR1_PE;
 573  0003 72105210      	bset	21008,#0
 575  0007 2004          	jra	L571
 576  0009               L371:
 577                     ; 215     I2C->CR1 &= (uint8_t)(~I2C_CR1_PE);
 579  0009 72115210      	bres	21008,#0
 580  000d               L571:
 581                     ; 217 }
 584  000d 81            	ret
 619                     ; 225 void I2C_GeneralCallCmd(FunctionalState NewState)
 619                     ; 226 {
 620                     .text:	section	.text,new
 621  0000               _I2C_GeneralCallCmd:
 625                     ; 228   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 627                     ; 230   if (NewState != DISABLE)
 629  0000 4d            	tnz	a
 630  0001 2706          	jreq	L512
 631                     ; 233     I2C->CR1 |= I2C_CR1_ENGC;
 633  0003 721c5210      	bset	21008,#6
 635  0007 2004          	jra	L712
 636  0009               L512:
 637                     ; 238     I2C->CR1 &= (uint8_t)(~I2C_CR1_ENGC);
 639  0009 721d5210      	bres	21008,#6
 640  000d               L712:
 641                     ; 240 }
 644  000d 81            	ret
 679                     ; 250 void I2C_GenerateSTART(FunctionalState NewState)
 679                     ; 251 {
 680                     .text:	section	.text,new
 681  0000               _I2C_GenerateSTART:
 685                     ; 253   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 687                     ; 255   if (NewState != DISABLE)
 689  0000 4d            	tnz	a
 690  0001 2706          	jreq	L732
 691                     ; 258     I2C->CR2 |= I2C_CR2_START;
 693  0003 72105211      	bset	21009,#0
 695  0007 2004          	jra	L142
 696  0009               L732:
 697                     ; 263     I2C->CR2 &= (uint8_t)(~I2C_CR2_START);
 699  0009 72115211      	bres	21009,#0
 700  000d               L142:
 701                     ; 265 }
 704  000d 81            	ret
 739                     ; 273 void I2C_GenerateSTOP(FunctionalState NewState)
 739                     ; 274 {
 740                     .text:	section	.text,new
 741  0000               _I2C_GenerateSTOP:
 745                     ; 276   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 747                     ; 278   if (NewState != DISABLE)
 749  0000 4d            	tnz	a
 750  0001 2706          	jreq	L162
 751                     ; 281     I2C->CR2 |= I2C_CR2_STOP;
 753  0003 72125211      	bset	21009,#1
 755  0007 2004          	jra	L362
 756  0009               L162:
 757                     ; 286     I2C->CR2 &= (uint8_t)(~I2C_CR2_STOP);
 759  0009 72135211      	bres	21009,#1
 760  000d               L362:
 761                     ; 288 }
 764  000d 81            	ret
 800                     ; 296 void I2C_SoftwareResetCmd(FunctionalState NewState)
 800                     ; 297 {
 801                     .text:	section	.text,new
 802  0000               _I2C_SoftwareResetCmd:
 806                     ; 299   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 808                     ; 301   if (NewState != DISABLE)
 810  0000 4d            	tnz	a
 811  0001 2706          	jreq	L303
 812                     ; 304     I2C->CR2 |= I2C_CR2_SWRST;
 814  0003 721e5211      	bset	21009,#7
 816  0007 2004          	jra	L503
 817  0009               L303:
 818                     ; 309     I2C->CR2 &= (uint8_t)(~I2C_CR2_SWRST);
 820  0009 721f5211      	bres	21009,#7
 821  000d               L503:
 822                     ; 311 }
 825  000d 81            	ret
 861                     ; 320 void I2C_StretchClockCmd(FunctionalState NewState)
 861                     ; 321 {
 862                     .text:	section	.text,new
 863  0000               _I2C_StretchClockCmd:
 867                     ; 323   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 869                     ; 325   if (NewState != DISABLE)
 871  0000 4d            	tnz	a
 872  0001 2706          	jreq	L523
 873                     ; 328     I2C->CR1 &= (uint8_t)(~I2C_CR1_NOSTRETCH);
 875  0003 721f5210      	bres	21008,#7
 877  0007 2004          	jra	L723
 878  0009               L523:
 879                     ; 334     I2C->CR1 |= I2C_CR1_NOSTRETCH;
 881  0009 721e5210      	bset	21008,#7
 882  000d               L723:
 883                     ; 336 }
 886  000d 81            	ret
 922                     ; 345 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
 922                     ; 346 {
 923                     .text:	section	.text,new
 924  0000               _I2C_AcknowledgeConfig:
 926  0000 88            	push	a
 927       00000000      OFST:	set	0
 930                     ; 348   assert_param(IS_I2C_ACK_OK(Ack));
 932                     ; 350   if (Ack == I2C_ACK_NONE)
 934  0001 4d            	tnz	a
 935  0002 2606          	jrne	L743
 936                     ; 353     I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);
 938  0004 72155211      	bres	21009,#2
 940  0008 2014          	jra	L153
 941  000a               L743:
 942                     ; 358     I2C->CR2 |= I2C_CR2_ACK;
 944  000a 72145211      	bset	21009,#2
 945                     ; 360     if (Ack == I2C_ACK_CURR)
 947  000e 7b01          	ld	a,(OFST+1,sp)
 948  0010 a101          	cp	a,#1
 949  0012 2606          	jrne	L353
 950                     ; 363       I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);
 952  0014 72175211      	bres	21009,#3
 954  0018 2004          	jra	L153
 955  001a               L353:
 956                     ; 368       I2C->CR2 |= I2C_CR2_POS;
 958  001a 72165211      	bset	21009,#3
 959  001e               L153:
 960                     ; 371 }
 963  001e 84            	pop	a
 964  001f 81            	ret
1036                     ; 381 void I2C_ITConfig(I2C_IT_TypeDef I2C_IT, FunctionalState NewState)
1036                     ; 382 {
1037                     .text:	section	.text,new
1038  0000               _I2C_ITConfig:
1040  0000 89            	pushw	x
1041       00000000      OFST:	set	0
1044                     ; 384   assert_param(IS_I2C_INTERRUPT_OK(I2C_IT));
1046                     ; 385   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1048                     ; 387   if (NewState != DISABLE)
1050  0001 9f            	ld	a,xl
1051  0002 4d            	tnz	a
1052  0003 2709          	jreq	L314
1053                     ; 390     I2C->ITR |= (uint8_t)I2C_IT;
1055  0005 9e            	ld	a,xh
1056  0006 ca521a        	or	a,21018
1057  0009 c7521a        	ld	21018,a
1059  000c 2009          	jra	L514
1060  000e               L314:
1061                     ; 395     I2C->ITR &= (uint8_t)(~(uint8_t)I2C_IT);
1063  000e 7b01          	ld	a,(OFST+1,sp)
1064  0010 43            	cpl	a
1065  0011 c4521a        	and	a,21018
1066  0014 c7521a        	ld	21018,a
1067  0017               L514:
1068                     ; 397 }
1071  0017 85            	popw	x
1072  0018 81            	ret
1108                     ; 405 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef I2C_DutyCycle)
1108                     ; 406 {
1109                     .text:	section	.text,new
1110  0000               _I2C_FastModeDutyCycleConfig:
1114                     ; 408   assert_param(IS_I2C_DUTYCYCLE_OK(I2C_DutyCycle));
1116                     ; 410   if (I2C_DutyCycle == I2C_DUTYCYCLE_16_9)
1118  0000 a140          	cp	a,#64
1119  0002 2606          	jrne	L534
1120                     ; 413     I2C->CCRH |= I2C_CCRH_DUTY;
1122  0004 721c521c      	bset	21020,#6
1124  0008 2004          	jra	L734
1125  000a               L534:
1126                     ; 418     I2C->CCRH &= (uint8_t)(~I2C_CCRH_DUTY);
1128  000a 721d521c      	bres	21020,#6
1129  000e               L734:
1130                     ; 420 }
1133  000e 81            	ret
1156                     ; 427 uint8_t I2C_ReceiveData(void)
1156                     ; 428 {
1157                     .text:	section	.text,new
1158  0000               _I2C_ReceiveData:
1162                     ; 430   return ((uint8_t)I2C->DR);
1164  0000 c65216        	ld	a,21014
1167  0003 81            	ret
1232                     ; 440 void I2C_Send7bitAddress(uint8_t Address, I2C_Direction_TypeDef Direction)
1232                     ; 441 {
1233                     .text:	section	.text,new
1234  0000               _I2C_Send7bitAddress:
1236  0000 89            	pushw	x
1237       00000000      OFST:	set	0
1240                     ; 443   assert_param(IS_I2C_ADDRESS_OK(Address));
1242                     ; 444   assert_param(IS_I2C_DIRECTION_OK(Direction));
1244                     ; 447   Address &= (uint8_t)0xFE;
1246  0001 7b01          	ld	a,(OFST+1,sp)
1247  0003 a4fe          	and	a,#254
1248  0005 6b01          	ld	(OFST+1,sp),a
1249                     ; 450   I2C->DR = (uint8_t)(Address | (uint8_t)Direction);
1251  0007 7b01          	ld	a,(OFST+1,sp)
1252  0009 1a02          	or	a,(OFST+2,sp)
1253  000b c75216        	ld	21014,a
1254                     ; 451 }
1257  000e 85            	popw	x
1258  000f 81            	ret
1292                     ; 458 void I2C_SendData(uint8_t Data)
1292                     ; 459 {
1293                     .text:	section	.text,new
1294  0000               _I2C_SendData:
1298                     ; 461   I2C->DR = Data;
1300  0000 c75216        	ld	21014,a
1301                     ; 462 }
1304  0003 81            	ret
1528                     ; 578 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
1528                     ; 579 {
1529                     .text:	section	.text,new
1530  0000               _I2C_CheckEvent:
1532  0000 89            	pushw	x
1533  0001 5206          	subw	sp,#6
1534       00000006      OFST:	set	6
1537                     ; 580   __IO uint16_t lastevent = 0x00;
1539  0003 5f            	clrw	x
1540  0004 1f04          	ldw	(OFST-2,sp),x
1541                     ; 581   uint8_t flag1 = 0x00 ;
1543  0006 7b03          	ld	a,(OFST-3,sp)
1544  0008 97            	ld	xl,a
1545                     ; 582   uint8_t flag2 = 0x00;
1547  0009 7b06          	ld	a,(OFST+0,sp)
1548  000b 97            	ld	xl,a
1549                     ; 583   ErrorStatus status = ERROR;
1551  000c 7b06          	ld	a,(OFST+0,sp)
1552  000e 97            	ld	xl,a
1553                     ; 586   assert_param(IS_I2C_EVENT_OK(I2C_Event));
1555                     ; 588   if (I2C_Event == I2C_EVENT_SLAVE_ACK_FAILURE)
1557  000f 1e07          	ldw	x,(OFST+1,sp)
1558  0011 a30004        	cpw	x,#4
1559  0014 260b          	jrne	L136
1560                     ; 590     lastevent = I2C->SR2 & I2C_SR2_AF;
1562  0016 c65218        	ld	a,21016
1563  0019 a404          	and	a,#4
1564  001b 5f            	clrw	x
1565  001c 97            	ld	xl,a
1566  001d 1f04          	ldw	(OFST-2,sp),x
1568  001f 201f          	jra	L336
1569  0021               L136:
1570                     ; 594     flag1 = I2C->SR1;
1572  0021 c65217        	ld	a,21015
1573  0024 6b03          	ld	(OFST-3,sp),a
1574                     ; 595     flag2 = I2C->SR3;
1576  0026 c65219        	ld	a,21017
1577  0029 6b06          	ld	(OFST+0,sp),a
1578                     ; 596     lastevent = ((uint16_t)((uint16_t)flag2 << (uint16_t)8) | (uint16_t)flag1);
1580  002b 7b03          	ld	a,(OFST-3,sp)
1581  002d 5f            	clrw	x
1582  002e 97            	ld	xl,a
1583  002f 1f01          	ldw	(OFST-5,sp),x
1584  0031 7b06          	ld	a,(OFST+0,sp)
1585  0033 5f            	clrw	x
1586  0034 97            	ld	xl,a
1587  0035 4f            	clr	a
1588  0036 02            	rlwa	x,a
1589  0037 01            	rrwa	x,a
1590  0038 1a02          	or	a,(OFST-4,sp)
1591  003a 01            	rrwa	x,a
1592  003b 1a01          	or	a,(OFST-5,sp)
1593  003d 01            	rrwa	x,a
1594  003e 1f04          	ldw	(OFST-2,sp),x
1595  0040               L336:
1596                     ; 599   if (((uint16_t)lastevent & (uint16_t)I2C_Event) == (uint16_t)I2C_Event)
1598  0040 1e04          	ldw	x,(OFST-2,sp)
1599  0042 01            	rrwa	x,a
1600  0043 1408          	and	a,(OFST+2,sp)
1601  0045 01            	rrwa	x,a
1602  0046 1407          	and	a,(OFST+1,sp)
1603  0048 01            	rrwa	x,a
1604  0049 1307          	cpw	x,(OFST+1,sp)
1605  004b 2606          	jrne	L536
1606                     ; 602     status = SUCCESS;
1608  004d a601          	ld	a,#1
1609  004f 6b06          	ld	(OFST+0,sp),a
1611  0051 2002          	jra	L736
1612  0053               L536:
1613                     ; 607     status = ERROR;
1615  0053 0f06          	clr	(OFST+0,sp)
1616  0055               L736:
1617                     ; 611   return status;
1619  0055 7b06          	ld	a,(OFST+0,sp)
1622  0057 5b08          	addw	sp,#8
1623  0059 81            	ret
1676                     ; 628 I2C_Event_TypeDef I2C_GetLastEvent(void)
1676                     ; 629 {
1677                     .text:	section	.text,new
1678  0000               _I2C_GetLastEvent:
1680  0000 5206          	subw	sp,#6
1681       00000006      OFST:	set	6
1684                     ; 630   __IO uint16_t lastevent = 0;
1686  0002 5f            	clrw	x
1687  0003 1f05          	ldw	(OFST-1,sp),x
1688                     ; 631   uint16_t flag1 = 0;
1690  0005 1e01          	ldw	x,(OFST-5,sp)
1691                     ; 632   uint16_t flag2 = 0;
1693  0007 1e03          	ldw	x,(OFST-3,sp)
1694                     ; 634   if ((I2C->SR2 & I2C_SR2_AF) != 0x00)
1696  0009 c65218        	ld	a,21016
1697  000c a504          	bcp	a,#4
1698  000e 2707          	jreq	L766
1699                     ; 636     lastevent = I2C_EVENT_SLAVE_ACK_FAILURE;
1701  0010 ae0004        	ldw	x,#4
1702  0013 1f05          	ldw	(OFST-1,sp),x
1704  0015 201b          	jra	L176
1705  0017               L766:
1706                     ; 641     flag1 = I2C->SR1;
1708  0017 c65217        	ld	a,21015
1709  001a 5f            	clrw	x
1710  001b 97            	ld	xl,a
1711  001c 1f01          	ldw	(OFST-5,sp),x
1712                     ; 642     flag2 = I2C->SR3;
1714  001e c65219        	ld	a,21017
1715  0021 5f            	clrw	x
1716  0022 97            	ld	xl,a
1717  0023 1f03          	ldw	(OFST-3,sp),x
1718                     ; 645     lastevent = ((uint16_t)((uint16_t)flag2 << 8) | (uint16_t)flag1);
1720  0025 1e03          	ldw	x,(OFST-3,sp)
1721  0027 4f            	clr	a
1722  0028 02            	rlwa	x,a
1723  0029 01            	rrwa	x,a
1724  002a 1a02          	or	a,(OFST-4,sp)
1725  002c 01            	rrwa	x,a
1726  002d 1a01          	or	a,(OFST-5,sp)
1727  002f 01            	rrwa	x,a
1728  0030 1f05          	ldw	(OFST-1,sp),x
1729  0032               L176:
1730                     ; 648   return (I2C_Event_TypeDef)lastevent;
1732  0032 1e05          	ldw	x,(OFST-1,sp)
1735  0034 5b06          	addw	sp,#6
1736  0036 81            	ret
1951                     ; 679 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef I2C_Flag)
1951                     ; 680 {
1952                     .text:	section	.text,new
1953  0000               _I2C_GetFlagStatus:
1955  0000 89            	pushw	x
1956  0001 89            	pushw	x
1957       00000002      OFST:	set	2
1960                     ; 681   uint8_t tempreg = 0;
1962  0002 0f02          	clr	(OFST+0,sp)
1963                     ; 682   uint8_t regindex = 0;
1965  0004 7b01          	ld	a,(OFST-1,sp)
1966  0006 97            	ld	xl,a
1967                     ; 683   FlagStatus bitstatus = RESET;
1969  0007 7b02          	ld	a,(OFST+0,sp)
1970  0009 97            	ld	xl,a
1971                     ; 686   assert_param(IS_I2C_FLAG_OK(I2C_Flag));
1973                     ; 689   regindex = (uint8_t)((uint16_t)I2C_Flag >> 8);
1975  000a 7b03          	ld	a,(OFST+1,sp)
1976  000c 6b01          	ld	(OFST-1,sp),a
1977                     ; 691   switch (regindex)
1979  000e 7b01          	ld	a,(OFST-1,sp)
1981                     ; 708     default:
1981                     ; 709       break;
1982  0010 4a            	dec	a
1983  0011 2708          	jreq	L376
1984  0013 4a            	dec	a
1985  0014 270c          	jreq	L576
1986  0016 4a            	dec	a
1987  0017 2710          	jreq	L776
1988  0019 2013          	jra	L3101
1989  001b               L376:
1990                     ; 694     case 0x01:
1990                     ; 695       tempreg = (uint8_t)I2C->SR1;
1992  001b c65217        	ld	a,21015
1993  001e 6b02          	ld	(OFST+0,sp),a
1994                     ; 696       break;
1996  0020 200c          	jra	L3101
1997  0022               L576:
1998                     ; 699     case 0x02:
1998                     ; 700       tempreg = (uint8_t)I2C->SR2;
2000  0022 c65218        	ld	a,21016
2001  0025 6b02          	ld	(OFST+0,sp),a
2002                     ; 701       break;
2004  0027 2005          	jra	L3101
2005  0029               L776:
2006                     ; 704     case 0x03:
2006                     ; 705       tempreg = (uint8_t)I2C->SR3;
2008  0029 c65219        	ld	a,21017
2009  002c 6b02          	ld	(OFST+0,sp),a
2010                     ; 706       break;
2012  002e               L107:
2013                     ; 708     default:
2013                     ; 709       break;
2015  002e               L3101:
2016                     ; 713   if ((tempreg & (uint8_t)I2C_Flag ) != 0)
2018  002e 7b04          	ld	a,(OFST+2,sp)
2019  0030 1502          	bcp	a,(OFST+0,sp)
2020  0032 2706          	jreq	L5101
2021                     ; 716     bitstatus = SET;
2023  0034 a601          	ld	a,#1
2024  0036 6b02          	ld	(OFST+0,sp),a
2026  0038 2002          	jra	L7101
2027  003a               L5101:
2028                     ; 721     bitstatus = RESET;
2030  003a 0f02          	clr	(OFST+0,sp)
2031  003c               L7101:
2032                     ; 724   return bitstatus;
2034  003c 7b02          	ld	a,(OFST+0,sp)
2037  003e 5b04          	addw	sp,#4
2038  0040 81            	ret
2082                     ; 759 void I2C_ClearFlag(I2C_Flag_TypeDef I2C_FLAG)
2082                     ; 760 {
2083                     .text:	section	.text,new
2084  0000               _I2C_ClearFlag:
2086  0000 89            	pushw	x
2087  0001 89            	pushw	x
2088       00000002      OFST:	set	2
2091                     ; 761   uint16_t flagpos = 0;
2093  0002 5f            	clrw	x
2094  0003 1f01          	ldw	(OFST-1,sp),x
2095                     ; 763   assert_param(IS_I2C_CLEAR_FLAG_OK(I2C_FLAG));
2097                     ; 766   flagpos = (uint16_t)I2C_FLAG & FLAG_Mask;
2099  0005 7b03          	ld	a,(OFST+1,sp)
2100  0007 97            	ld	xl,a
2101  0008 7b04          	ld	a,(OFST+2,sp)
2102  000a a4ff          	and	a,#255
2103  000c 5f            	clrw	x
2104  000d 02            	rlwa	x,a
2105  000e 1f01          	ldw	(OFST-1,sp),x
2106  0010 01            	rrwa	x,a
2107                     ; 768   I2C->SR2 = (uint8_t)((uint16_t)(~flagpos));
2109  0011 7b02          	ld	a,(OFST+0,sp)
2110  0013 43            	cpl	a
2111  0014 c75218        	ld	21016,a
2112                     ; 769 }
2115  0017 5b04          	addw	sp,#4
2116  0019 81            	ret
2282                     ; 791 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2282                     ; 792 {
2283                     .text:	section	.text,new
2284  0000               _I2C_GetITStatus:
2286  0000 89            	pushw	x
2287  0001 5204          	subw	sp,#4
2288       00000004      OFST:	set	4
2291                     ; 793   ITStatus bitstatus = RESET;
2293  0003 7b04          	ld	a,(OFST+0,sp)
2294  0005 97            	ld	xl,a
2295                     ; 794   __IO uint8_t enablestatus = 0;
2297  0006 0f03          	clr	(OFST-1,sp)
2298                     ; 795   uint16_t tempregister = 0;
2300  0008 1e01          	ldw	x,(OFST-3,sp)
2301                     ; 798     assert_param(IS_I2C_ITPENDINGBIT_OK(I2C_ITPendingBit));
2303                     ; 800   tempregister = (uint8_t)( ((uint16_t)((uint16_t)I2C_ITPendingBit & ITEN_Mask)) >> 8);
2305  000a 7b05          	ld	a,(OFST+1,sp)
2306  000c 97            	ld	xl,a
2307  000d 7b06          	ld	a,(OFST+2,sp)
2308  000f 9f            	ld	a,xl
2309  0010 a407          	and	a,#7
2310  0012 97            	ld	xl,a
2311  0013 4f            	clr	a
2312  0014 02            	rlwa	x,a
2313  0015 4f            	clr	a
2314  0016 01            	rrwa	x,a
2315  0017 9f            	ld	a,xl
2316  0018 5f            	clrw	x
2317  0019 97            	ld	xl,a
2318  001a 1f01          	ldw	(OFST-3,sp),x
2319                     ; 803   enablestatus = (uint8_t)(I2C->ITR & ( uint8_t)tempregister);
2321  001c c6521a        	ld	a,21018
2322  001f 1402          	and	a,(OFST-2,sp)
2323  0021 6b03          	ld	(OFST-1,sp),a
2324                     ; 805   if ((uint16_t)((uint16_t)I2C_ITPendingBit & REGISTER_Mask) == REGISTER_SR1_Index)
2326  0023 7b05          	ld	a,(OFST+1,sp)
2327  0025 97            	ld	xl,a
2328  0026 7b06          	ld	a,(OFST+2,sp)
2329  0028 9f            	ld	a,xl
2330  0029 a430          	and	a,#48
2331  002b 97            	ld	xl,a
2332  002c 4f            	clr	a
2333  002d 02            	rlwa	x,a
2334  002e a30100        	cpw	x,#256
2335  0031 2615          	jrne	L1311
2336                     ; 808     if (((I2C->SR1 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2338  0033 c65217        	ld	a,21015
2339  0036 1506          	bcp	a,(OFST+2,sp)
2340  0038 270a          	jreq	L3311
2342  003a 0d03          	tnz	(OFST-1,sp)
2343  003c 2706          	jreq	L3311
2344                     ; 811       bitstatus = SET;
2346  003e a601          	ld	a,#1
2347  0040 6b04          	ld	(OFST+0,sp),a
2349  0042 2017          	jra	L7311
2350  0044               L3311:
2351                     ; 816       bitstatus = RESET;
2353  0044 0f04          	clr	(OFST+0,sp)
2354  0046 2013          	jra	L7311
2355  0048               L1311:
2356                     ; 822     if (((I2C->SR2 & (uint8_t)I2C_ITPendingBit) != RESET) && enablestatus)
2358  0048 c65218        	ld	a,21016
2359  004b 1506          	bcp	a,(OFST+2,sp)
2360  004d 270a          	jreq	L1411
2362  004f 0d03          	tnz	(OFST-1,sp)
2363  0051 2706          	jreq	L1411
2364                     ; 825       bitstatus = SET;
2366  0053 a601          	ld	a,#1
2367  0055 6b04          	ld	(OFST+0,sp),a
2369  0057 2002          	jra	L7311
2370  0059               L1411:
2371                     ; 830       bitstatus = RESET;
2373  0059 0f04          	clr	(OFST+0,sp)
2374  005b               L7311:
2375                     ; 834   return  bitstatus;
2377  005b 7b04          	ld	a,(OFST+0,sp)
2380  005d 5b06          	addw	sp,#6
2381  005f 81            	ret
2426                     ; 871 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef I2C_ITPendingBit)
2426                     ; 872 {
2427                     .text:	section	.text,new
2428  0000               _I2C_ClearITPendingBit:
2430  0000 89            	pushw	x
2431  0001 89            	pushw	x
2432       00000002      OFST:	set	2
2435                     ; 873   uint16_t flagpos = 0;
2437  0002 5f            	clrw	x
2438  0003 1f01          	ldw	(OFST-1,sp),x
2439                     ; 876   assert_param(IS_I2C_CLEAR_ITPENDINGBIT_OK(I2C_ITPendingBit));
2441                     ; 879   flagpos = (uint16_t)I2C_ITPendingBit & FLAG_Mask;
2443  0005 7b03          	ld	a,(OFST+1,sp)
2444  0007 97            	ld	xl,a
2445  0008 7b04          	ld	a,(OFST+2,sp)
2446  000a a4ff          	and	a,#255
2447  000c 5f            	clrw	x
2448  000d 02            	rlwa	x,a
2449  000e 1f01          	ldw	(OFST-1,sp),x
2450  0010 01            	rrwa	x,a
2451                     ; 882   I2C->SR2 = (uint8_t)((uint16_t)~flagpos);
2453  0011 7b02          	ld	a,(OFST+0,sp)
2454  0013 43            	cpl	a
2455  0014 c75218        	ld	21016,a
2456                     ; 883 }
2459  0017 5b04          	addw	sp,#4
2460  0019 81            	ret
2473                     	xdef	_I2C_ClearITPendingBit
2474                     	xdef	_I2C_GetITStatus
2475                     	xdef	_I2C_ClearFlag
2476                     	xdef	_I2C_GetFlagStatus
2477                     	xdef	_I2C_GetLastEvent
2478                     	xdef	_I2C_CheckEvent
2479                     	xdef	_I2C_SendData
2480                     	xdef	_I2C_Send7bitAddress
2481                     	xdef	_I2C_ReceiveData
2482                     	xdef	_I2C_ITConfig
2483                     	xdef	_I2C_FastModeDutyCycleConfig
2484                     	xdef	_I2C_AcknowledgeConfig
2485                     	xdef	_I2C_StretchClockCmd
2486                     	xdef	_I2C_SoftwareResetCmd
2487                     	xdef	_I2C_GenerateSTOP
2488                     	xdef	_I2C_GenerateSTART
2489                     	xdef	_I2C_GeneralCallCmd
2490                     	xdef	_I2C_Cmd
2491                     	xdef	_I2C_Init
2492                     	xdef	_I2C_DeInit
2493                     	xref.b	c_lreg
2512                     	xref	c_sdivx
2513                     	xref	c_ludv
2514                     	xref	c_rtol
2515                     	xref	c_smul
2516                     	xref	c_lmul
2517                     	xref	c_lcmp
2518                     	xref	c_ltor
2519                     	end
