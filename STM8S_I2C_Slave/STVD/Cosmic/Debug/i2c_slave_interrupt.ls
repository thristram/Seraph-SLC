   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	bsct
   5  0000               _ReceiveState:
   6  0000 00            	dc.b	0
 330                     	switch	.ubsct
 331  0000               _action_flag:
 332  0000 00            	ds.b	1
 333                     	xdef	_action_flag
 334  0001               _change_step2:
 335  0001 00000000      	ds.b	4
 336                     	xdef	_change_step2
 337  0005               _change_step1:
 338  0005 00000000      	ds.b	4
 339                     	xdef	_change_step1
 340  0009               _change_time:
 341  0009 00            	ds.b	1
 342                     	xdef	_change_time
 343  000a               _aim_bright2:
 344  000a 00000000      	ds.b	4
 345                     	xdef	_aim_bright2
 346  000e               _aim_bright1:
 347  000e 00000000      	ds.b	4
 348                     	xdef	_aim_bright1
 349  0012               _channel:
 350  0012 00            	ds.b	1
 351                     	xdef	_channel
 352                     	xdef	_ReceiveState
 353  0013               _action_done:
 354  0013 00            	ds.b	1
 355                     	xdef	_action_done
 356  0014               _slave_address:
 357  0014 00            	ds.b	1
 358                     	xdef	_slave_address
 359  0015               _slc:
 360  0015 000000000000  	ds.b	25
 361                     	xdef	_slc
 381                     	end
