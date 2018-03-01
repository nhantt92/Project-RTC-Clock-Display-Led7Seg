;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (Mac OS X x86_64)
;--------------------------------------------------------
	.module i2c_drv
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _TIMER_CheckTimeUS
	.globl _TIMER_InitTime
	.globl _GPIO_ReadInputPin
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteHigh
	.globl _GPIO_Init
	.globl _softI2cTime
	.globl _SoftI2CInit
	.globl _SoftI2CStart
	.globl _SoftI2CStop
	.globl _SoftI2CWriteByte
	.globl _SoftI2CReadByte
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_softI2cTime::
	.ds 6
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	user/i2c_drv.c: 8: void SoftI2CInit()
;	-----------------------------------------
;	 function SoftI2CInit
;	-----------------------------------------
_SoftI2CInit:
;	user/i2c_drv.c: 10: SOFT_I2C_SDA_OUT;
	push	#0xb0
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_Init
	addw	sp, #4
;	user/i2c_drv.c: 11: SOFT_I2C_SCL_OUT;
	push	#0xb0
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_Init
	addw	sp, #4
;	user/i2c_drv.c: 13: SOFT_I2C_SDA_HIGH;
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 14: SOFT_I2C_SCL_HIGH;      
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 15: TIMER_InitTime(&softI2cTime);
	ldw	x, #_softI2cTime+0
	pushw	x
	call	_TIMER_InitTime
	popw	x
	ret
;	user/i2c_drv.c: 18: void SoftI2CStart()
;	-----------------------------------------
;	 function SoftI2CStart
;	-----------------------------------------
_SoftI2CStart:
	sub	sp, #4
;	user/i2c_drv.c: 20: SOFT_I2C_SCL_HIGH;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 21: H_DEL;
	ldw	x, #_softI2cTime+0
	ldw	(0x03, sp), x
00101$:
	ldw	x, (0x03, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00101$
;	user/i2c_drv.c: 23: SOFT_I2C_SDA_LOW;   
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/i2c_drv.c: 24: H_DEL;      
	ldw	y, (0x03, sp)
	ldw	(0x01, sp), y
00104$:
	ldw	x, (0x01, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00104$
	addw	sp, #4
	ret
;	user/i2c_drv.c: 27: void SoftI2CStop()
;	-----------------------------------------
;	 function SoftI2CStop
;	-----------------------------------------
_SoftI2CStop:
	sub	sp, #6
;	user/i2c_drv.c: 29: SOFT_I2C_SDA_LOW;
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/i2c_drv.c: 30: H_DEL;
	ldw	x, #_softI2cTime+0
	ldw	(0x01, sp), x
00101$:
	ldw	x, (0x01, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00101$
;	user/i2c_drv.c: 31: SOFT_I2C_SCL_HIGH;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 32: Q_DEL;
	ldw	y, (0x01, sp)
	ldw	(0x05, sp), y
00104$:
	ldw	x, (0x05, sp)
	push	#0x14
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00104$
;	user/i2c_drv.c: 33: SOFT_I2C_SDA_HIGH;
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 34: H_DEL;
	ldw	y, (0x01, sp)
	ldw	(0x03, sp), y
00107$:
	ldw	x, (0x03, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00107$
	addw	sp, #6
	ret
;	user/i2c_drv.c: 37: uint8_t SoftI2CWriteByte(uint8_t data)
;	-----------------------------------------
;	 function SoftI2CWriteByte
;	-----------------------------------------
_SoftI2CWriteByte:
	sub	sp, #18
;	user/i2c_drv.c: 41: for(i=0;i<8;i++)
	ldw	x, #_softI2cTime+0
	ldw	(0x11, sp), x
	ldw	y, (0x11, sp)
	ldw	(0x0d, sp), y
	ldw	y, (0x11, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x11, sp)
	ldw	(0x05, sp), y
	clr	(0x02, sp)
00129$:
;	user/i2c_drv.c: 43: SOFT_I2C_SCL_LOW;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/i2c_drv.c: 44: Q_DEL;
00101$:
	ldw	x, (0x11, sp)
	push	#0x14
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00101$
;	user/i2c_drv.c: 46: if(data & 0x80)
	tnz	(0x15, sp)
	jrpl	00105$
;	user/i2c_drv.c: 47: SOFT_I2C_SDA_HIGH;
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
	jra	00107$
00105$:
;	user/i2c_drv.c: 49: SOFT_I2C_SDA_LOW;        
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/i2c_drv.c: 50: H_DEL;
00107$:
	ldw	x, (0x0d, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00107$
;	user/i2c_drv.c: 52: SOFT_I2C_SCL_HIGH;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 53: H_DEL;
00110$:
	ldw	x, (0x03, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00110$
;	user/i2c_drv.c: 59: data=data<<1;
	ld	a, (0x15, sp)
	sll	a
	ld	(0x15, sp), a
;	user/i2c_drv.c: 60: Q_DEL;
00113$:
	ldw	x, (0x05, sp)
	push	#0x14
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00113$
;	user/i2c_drv.c: 41: for(i=0;i<8;i++)
	inc	(0x02, sp)
	ld	a, (0x02, sp)
	cp	a, #0x08
	jrc	00129$
;	user/i2c_drv.c: 64: SOFT_I2C_SCL_LOW;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/i2c_drv.c: 65: Q_DEL;
	ldw	y, (0x11, sp)
	ldw	(0x0f, sp), y
00117$:
	ldw	x, (0x0f, sp)
	push	#0x14
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00117$
;	user/i2c_drv.c: 67: SOFT_I2C_SDA_HIGH;      
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 68: H_DEL;
	ldw	y, (0x11, sp)
	ldw	(0x0b, sp), y
00120$:
	ldw	x, (0x0b, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00120$
;	user/i2c_drv.c: 70: SOFT_I2C_SCL_HIGH;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 71: H_DEL;  
	ldw	y, (0x11, sp)
	ldw	(0x09, sp), y
00123$:
	ldw	x, (0x09, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00123$
;	user/i2c_drv.c: 73: SOFT_I2C_SDA_IN;
	push	#0x00
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_Init
	addw	sp, #4
;	user/i2c_drv.c: 74: ack=!(SOFT_I2C_SDA_PIN & (1<<SOFT_SDA));
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_ReadInputPin
	addw	sp, #3
	srl	a
	srl	a
	and	a, #0x01
	sub	a, #0x01
	clr	a
	rlc	a
	ld	(0x01, sp), a
;	user/i2c_drv.c: 75: SOFT_I2C_SDA_OUT;
	push	#0xb0
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_Init
	addw	sp, #4
;	user/i2c_drv.c: 77: SOFT_I2C_SCL_LOW;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/i2c_drv.c: 78: H_DEL;
	ldw	y, (0x11, sp)
	ldw	(0x07, sp), y
00126$:
	ldw	x, (0x07, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00126$
;	user/i2c_drv.c: 80: return ack;   
	ld	a, (0x01, sp)
	addw	sp, #18
	ret
;	user/i2c_drv.c: 83: uint8_t SoftI2CReadByte(uint8_t ack)
;	-----------------------------------------
;	 function SoftI2CReadByte
;	-----------------------------------------
_SoftI2CReadByte:
	sub	sp, #18
;	user/i2c_drv.c: 85: uint8_t data=0x00;
	clr	(0x02, sp)
;	user/i2c_drv.c: 87: SOFT_I2C_SDA_IN;
	push	#0x00
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_Init
	addw	sp, #4
;	user/i2c_drv.c: 88: for(i=0;i<8;i++)
	ldw	x, #_softI2cTime+0
	ldw	(0x11, sp), x
	ldw	y, (0x11, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x11, sp)
	ldw	(0x0d, sp), y
	clr	(0x01, sp)
00128$:
;	user/i2c_drv.c: 90: SOFT_I2C_SCL_LOW;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/i2c_drv.c: 91: H_DEL;
00101$:
	ldw	y, (0x11, sp)
	ldw	(0x0b, sp), y
	push	#0x32
	push	#0x00
	ldw	x, (0x0d, sp)
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00101$
;	user/i2c_drv.c: 92: SOFT_I2C_SCL_HIGH;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 93: H_DEL;
00104$:
	ldw	x, (0x0f, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00104$
;	user/i2c_drv.c: 98: if(SOFT_I2C_SDA_PIN &(1<<SOFT_SDA))
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_ReadInputPin
	addw	sp, #3
	bcp	a, #0x04
	jreq	00109$
;	user/i2c_drv.c: 99: data|=(0x80>>i);    
	ld	a, #0x80
	push	a
	ld	a, (0x02, sp)
	jreq	00209$
00208$:
	srl	(1, sp)
	dec	a
	jrne	00208$
00209$:
	pop	a
	or	a, (0x02, sp)
	ld	(0x02, sp), a
;	user/i2c_drv.c: 101: Q_DEL;
00109$:
	ldw	x, (0x0d, sp)
	push	#0x14
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00109$
;	user/i2c_drv.c: 88: for(i=0;i<8;i++)
	inc	(0x01, sp)
	ld	a, (0x01, sp)
	cp	a, #0x08
	jrc	00128$
;	user/i2c_drv.c: 103: SOFT_I2C_SDA_OUT;
	push	#0xb0
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_Init
	addw	sp, #4
;	user/i2c_drv.c: 104: SOFT_I2C_SCL_LOW;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/i2c_drv.c: 105: Q_DEL;                      //Soft_I2C_Put_Ack  
	ldw	y, (0x11, sp)
	ldw	(0x09, sp), y
00113$:
	ldw	x, (0x09, sp)
	push	#0x14
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00113$
;	user/i2c_drv.c: 106: if(ack)
	tnz	(0x15, sp)
	jreq	00117$
;	user/i2c_drv.c: 108: SOFT_I2C_SDA_LOW;   
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
	jra	00144$
00117$:
;	user/i2c_drv.c: 112: SOFT_I2C_SDA_HIGH;
	push	#0x20
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 114: H_DEL;   
00144$:
	ldw	y, (0x11, sp)
	ldw	(0x07, sp), y
00119$:
	ldw	x, (0x07, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00119$
;	user/i2c_drv.c: 115: SOFT_I2C_SCL_HIGH;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/i2c_drv.c: 116: H_DEL;   
	ldw	y, (0x11, sp)
	ldw	(0x05, sp), y
00122$:
	ldw	x, (0x05, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00122$
;	user/i2c_drv.c: 117: SOFT_I2C_SCL_LOW;
	push	#0x10
	push	#0x05
	push	#0x50
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/i2c_drv.c: 118: H_DEL;           
	ldw	y, (0x11, sp)
	ldw	(0x03, sp), y
00125$:
	ldw	x, (0x03, sp)
	push	#0x32
	push	#0x00
	pushw	x
	call	_TIMER_CheckTimeUS
	addw	sp, #4
	tnz	a
	jrne	00125$
;	user/i2c_drv.c: 119: return data;  
	ld	a, (0x02, sp)
	addw	sp, #18
	ret
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
