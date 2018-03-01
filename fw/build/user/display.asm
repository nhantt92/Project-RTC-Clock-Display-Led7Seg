;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (Mac OS X x86_64)
;--------------------------------------------------------
	.module display
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _code7Seg
	.globl _offLed
	.globl _onLed
	.globl _writeBuffer
	.globl _memset
	.globl _GPIO_WriteLow
	.globl _GPIO_WriteHigh
	.globl _GPIO_Init
	.globl _display
	.globl _displayInit
	.globl _shiftOut595
	.globl _latch595
	.globl _clear595
	.globl _screen
	.globl _setDigit
	.globl _display_test
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_display::
	.ds 16
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
;	user/display.c: 8: static void delay_us(uint16_t x)
;	-----------------------------------------
;	 function delay_us
;	-----------------------------------------
_delay_us:
	pushw	x
;	user/display.c: 10: while(x--);
	ldw	x, (0x05, sp)
00101$:
	ldw	(0x01, sp), x
	decw	x
	ldw	y, (0x01, sp)
	jrne	00101$
	popw	x
	ret
;	user/display.c: 13: void displayInit(GPIO_TypeDef* portData, GPIO_TypeDef* portScan, uint8_t data, uint8_t clk, uint8_t lat, uint8_t clr, uint8_t led1, uint8_t led2, uint8_t led3, uint8_t led4)
;	-----------------------------------------
;	 function displayInit
;	-----------------------------------------
_displayInit:
	sub	sp, #16
;	user/display.c: 15: display.portData = portData;
	ldw	x, #_display+0
	ldw	y, (0x13, sp)
	ldw	(x), y
;	user/display.c: 16: display.portScan = portScan;
	ldw	x, #_display+0
	ldw	(0x0f, sp), x
	ldw	x, (0x0f, sp)
	incw	x
	incw	x
	ldw	(0x0d, sp), x
	ldw	x, (0x0d, sp)
	ldw	y, (0x15, sp)
	ldw	(x), y
;	user/display.c: 17: display.data = data;
	ldw	x, (0x0f, sp)
	ld	a, (0x17, sp)
	ld	(0x0004, x), a
;	user/display.c: 18: display.clk = clk;
	ldw	x, (0x0f, sp)
	ld	a, (0x18, sp)
	ld	(0x0005, x), a
;	user/display.c: 19: display.lat = lat;
	ldw	x, (0x0f, sp)
	ld	a, (0x19, sp)
	ld	(0x0006, x), a
;	user/display.c: 20: display.clr = clr;
	ldw	x, (0x0f, sp)
	addw	x, #0x0007
	ldw	(0x0b, sp), x
	ldw	x, (0x0b, sp)
	ld	a, (0x1a, sp)
	ld	(x), a
;	user/display.c: 21: display.led[0] = led1;
	ldw	x, (0x0f, sp)
	addw	x, #0x0008
	ldw	(0x09, sp), x
	ldw	x, (0x09, sp)
	ld	a, (0x1b, sp)
	ld	(x), a
;	user/display.c: 22: display.led[1] = led2;
	ldw	x, (0x0f, sp)
	addw	x, #0x0009
	ldw	(0x07, sp), x
	ldw	x, (0x07, sp)
	ld	a, (0x1c, sp)
	ld	(x), a
;	user/display.c: 23: display.led[2] = led3;
	ldw	x, (0x0f, sp)
	addw	x, #0x000a
	ldw	(0x05, sp), x
	ldw	x, (0x05, sp)
	ld	a, (0x1d, sp)
	ld	(x), a
;	user/display.c: 24: display.led[3] = led4;
	ldw	x, (0x0f, sp)
	addw	x, #0x000b
	ldw	(0x03, sp), x
	ldw	x, (0x03, sp)
	ld	a, (0x1e, sp)
	ld	(x), a
;	user/display.c: 25: GPIO_Init(display.portData, display.data|display.clk|display.lat|display.clr|display.led[3], GPIO_MODE_OUT_PP_HIGH_FAST);
	ld	a, (0x17, sp)
	or	a, (0x18, sp)
	or	a, (0x19, sp)
	or	a, (0x1a, sp)
	or	a, (0x1e, sp)
	ldw	x, (0x0f, sp)
	ldw	x, (x)
	push	#0xf0
	push	a
	pushw	x
	call	_GPIO_Init
	addw	sp, #4
;	user/display.c: 26: GPIO_Init(display.portScan, display.led[0]|display.led[1]|display.led[2], GPIO_MODE_OUT_PP_HIGH_FAST);
	ldw	x, (0x09, sp)
	ld	a, (x)
	ld	(0x02, sp), a
	ldw	x, (0x07, sp)
	ld	a, (x)
	or	a, (0x02, sp)
	ld	(0x01, sp), a
	ldw	x, (0x05, sp)
	ld	a, (x)
	or	a, (0x01, sp)
	ldw	x, (0x0d, sp)
	ldw	x, (x)
	push	#0xf0
	push	a
	pushw	x
	call	_GPIO_Init
	addw	sp, #4
;	user/display.c: 29: GPIO_WriteHigh(display.portData, display.clr);
	ldw	x, (0x0b, sp)
	ld	a, (x)
	ldw	x, (0x0f, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 30: GPIO_WriteLow(display.portScan, display.led[0]);
	ldw	x, (0x09, sp)
	ld	a, (x)
	ldw	x, (0x0d, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 31: GPIO_WriteLow(display.portScan, display.led[1]);
	ldw	x, (0x07, sp)
	ld	a, (x)
	ldw	x, (0x0d, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 32: GPIO_WriteLow(display.portScan, display.led[2]);
	ldw	x, (0x05, sp)
	ld	a, (x)
	ldw	x, (0x0d, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 33: GPIO_WriteLow(display.portData, display.led[3]);
	ldw	x, (0x03, sp)
	ld	a, (x)
	ldw	x, (0x0f, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 34: memset(display.buffer, 0x00, sizeof(display.buffer));
	ldw	x, (0x0f, sp)
	addw	x, #0x000c
	push	#0x04
	push	#0x00
	push	#0x00
	push	#0x00
	pushw	x
	call	_memset
	addw	sp, #22
	ret
;	user/display.c: 41: void shiftOut595(uint8_t data)
;	-----------------------------------------
;	 function shiftOut595
;	-----------------------------------------
_shiftOut595:
	sub	sp, #6
;	user/display.c: 44: temp = data;
	ld	a, (0x09, sp)
	ld	(0x02, sp), a
;	user/display.c: 46: for(i = 0; i< 8; i++)
	ldw	x, #_display+0
	ldw	(0x03, sp), x
	ldw	x, (0x03, sp)
	addw	x, #0x0005
	ldw	(0x05, sp), x
	clr	(0x01, sp)
00105$:
;	user/display.c: 48: GPIO_WriteLow(display.portData, display.clk);
	ldw	x, (0x05, sp)
	ld	a, (x)
	ldw	x, (0x03, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
	ldw	x, (0x03, sp)
	ldw	x, (x)
;	user/display.c: 49: if(temp&0x80) GPIO_WriteHigh(display.portData, display.data);
	ldw	y, (0x03, sp)
	ld	a, (0x4, y)
	tnz	(0x02, sp)
	jrpl	00102$
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
	jra	00103$
00102$:
;	user/display.c: 50: else GPIO_WriteLow(display.portData, display.data);
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
00103$:
;	user/display.c: 51: delay_us(5);
	push	#0x05
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 52: GPIO_WriteHigh(display.portData, display.clk);
	ldw	x, (0x05, sp)
	ld	a, (x)
	ldw	x, (0x03, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 53: temp <<= 1;
	sll	(0x02, sp)
;	user/display.c: 46: for(i = 0; i< 8; i++)
	inc	(0x01, sp)
	ld	a, (0x01, sp)
	cp	a, #0x08
	jrc	00105$
	addw	sp, #6
	ret
;	user/display.c: 57: void latch595(void)
;	-----------------------------------------
;	 function latch595
;	-----------------------------------------
_latch595:
	pushw	x
;	user/display.c: 59: GPIO_WriteHigh(display.portData, display.lat);
	ldw	x, #_display+0
	ldw	(0x01, sp), x
	ldw	x, (0x01, sp)
	addw	x, #0x0006
	ld	a, (x)
	ldw	y, (0x01, sp)
	ldw	y, (y)
	pushw	x
	push	a
	pushw	y
	call	_GPIO_WriteHigh
	addw	sp, #3
	popw	x
;	user/display.c: 60: GPIO_WriteLow(display.portData, display.lat);
	ld	a, (x)
	ldw	x, (0x01, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 61: delay_us(5);
	push	#0x05
	push	#0x00
	call	_delay_us
	addw	sp, #4
	ret
;	user/display.c: 64: void clear595(void)
;	-----------------------------------------
;	 function clear595
;	-----------------------------------------
_clear595:
	pushw	x
;	user/display.c: 66: GPIO_WriteHigh(display.portData, display.clr);
	ldw	x, #_display+0
	ldw	(0x01, sp), x
	ldw	x, (0x01, sp)
	addw	x, #0x0007
	ld	a, (x)
	ldw	y, (0x01, sp)
	ldw	y, (y)
	pushw	x
	push	a
	pushw	y
	call	_GPIO_WriteHigh
	addw	sp, #3
	popw	x
;	user/display.c: 67: GPIO_WriteLow(display.portData, display.clr);
	ld	a, (x)
	ldw	x, (0x01, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 68: delay_us(100);
	push	#0x64
	push	#0x00
	call	_delay_us
	addw	sp, #4
	ret
;	user/display.c: 71: void writeBuffer(uint8_t pos)
;	-----------------------------------------
;	 function writeBuffer
;	-----------------------------------------
_writeBuffer:
	pushw	x
;	user/display.c: 73: shiftOut595(display.buffer[pos]);
	ldw	x, #_display+12
	ldw	(0x01, sp), x
	ld	a, (0x05, sp)
	clrw	x
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, (x)
	push	a
	call	_shiftOut595
	pop	a
;	user/display.c: 74: latch595();
	call	_latch595
	popw	x
	ret
;	user/display.c: 77: void onLed(uint8_t led)
;	-----------------------------------------
;	 function onLed
;	-----------------------------------------
_onLed:
	sub	sp, #8
;	user/display.c: 79: switch(led)
	ld	a, (0x0b, sp)
	cp	a, #0x01
	jreq	00101$
	ld	a, (0x0b, sp)
	cp	a, #0x02
	jreq	00102$
	ld	a, (0x0b, sp)
	cp	a, #0x03
	jreq	00103$
	ld	a, (0x0b, sp)
	cp	a, #0x04
	jreq	00104$
	jra	00107$
;	user/display.c: 81: case 1: {
00101$:
;	user/display.c: 82: GPIO_WriteHigh(display.portScan, display.led[0]);
	ldw	x, #_display+0
	ldw	(0x07, sp), x
	ldw	y, (0x07, sp)
	ld	a, (0x8, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 83: break;
	jra	00107$
;	user/display.c: 85: case 2:{
00102$:
;	user/display.c: 86: GPIO_WriteHigh(display.portScan, display.led[1]);
	ldw	x, #_display+0
	ldw	(0x05, sp), x
	ldw	y, (0x05, sp)
	ld	a, (0x9, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 87: break;
	jra	00107$
;	user/display.c: 89: case 3:{
00103$:
;	user/display.c: 90: GPIO_WriteHigh(display.portScan, display.led[2]);
	ldw	x, #_display+0
	ldw	(0x03, sp), x
	ldw	y, (0x03, sp)
	ld	a, (0xa, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 91: break;
	jra	00107$
;	user/display.c: 93: case 4:{
00104$:
;	user/display.c: 94: GPIO_WriteHigh(display.portData, display.led[3]);
	ldw	x, #_display+0
	ldw	(0x01, sp), x
	ldw	y, (0x01, sp)
	ld	a, (0xb, y)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 98: }
00107$:
	addw	sp, #8
	ret
;	user/display.c: 101: void offLed(uint8_t led)
;	-----------------------------------------
;	 function offLed
;	-----------------------------------------
_offLed:
	sub	sp, #8
;	user/display.c: 103: switch(led)
	ld	a, (0x0b, sp)
	cp	a, #0x01
	jreq	00101$
	ld	a, (0x0b, sp)
	cp	a, #0x02
	jreq	00102$
	ld	a, (0x0b, sp)
	cp	a, #0x03
	jreq	00103$
	ld	a, (0x0b, sp)
	cp	a, #0x04
	jreq	00104$
	jra	00107$
;	user/display.c: 105: case 1: {
00101$:
;	user/display.c: 106: GPIO_WriteLow(display.portScan, display.led[0]);
	ldw	x, #_display+0
	ldw	(0x07, sp), x
	ldw	y, (0x07, sp)
	ld	a, (0x8, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 107: break;
	jra	00107$
;	user/display.c: 109: case 2:{
00102$:
;	user/display.c: 110: GPIO_WriteLow(display.portScan, display.led[1]);
	ldw	x, #_display+0
	ldw	(0x05, sp), x
	ldw	y, (0x05, sp)
	ld	a, (0x9, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 111: break;
	jra	00107$
;	user/display.c: 113: case 3:{
00103$:
;	user/display.c: 114: GPIO_WriteLow(display.portScan, display.led[2]);
	ldw	x, #_display+0
	ldw	(0x03, sp), x
	ldw	y, (0x03, sp)
	ld	a, (0xa, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 115: break;
	jra	00107$
;	user/display.c: 117: case 4:{
00104$:
;	user/display.c: 118: GPIO_WriteLow(display.portData, display.led[3]);
	ldw	x, #_display+0
	ldw	(0x01, sp), x
	ldw	y, (0x01, sp)
	ld	a, (0xb, y)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 122: }
00107$:
	addw	sp, #8
	ret
;	user/display.c: 125: void screen(uint8_t intensy)
;	-----------------------------------------
;	 function screen
;	-----------------------------------------
_screen:
	sub	sp, #3
;	user/display.c: 128: for(i = 0; i < 4; i++)
	clr	a
00102$:
;	user/display.c: 130: writeBuffer(i);
	push	a
	push	a
	call	_writeBuffer
	pop	a
	pop	a
;	user/display.c: 131: onLed(i+1);
	inc	a
	ld	(0x01, sp), a
	ld	a, (0x01, sp)
	push	a
	call	_onLed
	pop	a
;	user/display.c: 132: delay_us(intensy);
	clrw	x
	ld	a, (0x06, sp)
	ld	xl, a
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 133: offLed(i+1);
	ld	a, (0x01, sp)
	push	a
	call	_offLed
	pop	a
;	user/display.c: 134: delay_us(255-intensy);
	ld	a, (0x06, sp)
	ld	(0x03, sp), a
	clr	(0x02, sp)
	ldw	x, #0x00ff
	subw	x, (0x02, sp)
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 128: for(i = 0; i < 4; i++)
	ld	a, (0x01, sp)
	cp	a, #0x04
	jrc	00102$
	addw	sp, #3
	ret
;	user/display.c: 138: void setDigit(uint8_t led, uint8_t bcd)
;	-----------------------------------------
;	 function setDigit
;	-----------------------------------------
_setDigit:
	pushw	x
;	user/display.c: 140: display.buffer[led-1] = code7Seg[bcd];
	ldw	x, #_display+12
	ldw	(0x01, sp), x
	ld	a, (0x05, sp)
	dec	a
	clrw	y
	ld	yl, a
	addw	y, (0x01, sp)
	ldw	x, #_code7Seg+0
	ld	a, xl
	add	a, (0x06, sp)
	rlwa	x
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	ld	(y), a
	popw	x
	ret
;	user/display.c: 143: void display_test(uint8_t intensy)
;	-----------------------------------------
;	 function display_test
;	-----------------------------------------
_display_test:
	sub	sp, #19
;	user/display.c: 146: for(i = 0; i < 20; i++)
	ldw	x, #_display+0
	ldw	(0x02, sp), x
	ldw	x, (0x02, sp)
	addw	x, #0x0008
	ldw	(0x12, sp), x
	ldw	x, (0x02, sp)
	incw	x
	incw	x
	ldw	(0x10, sp), x
	ldw	x, (0x02, sp)
	addw	x, #0x0009
	ldw	(0x0e, sp), x
	ldw	x, (0x02, sp)
	addw	x, #0x000a
	ldw	(0x0c, sp), x
	ldw	x, (0x02, sp)
	addw	x, #0x000b
	ldw	(0x0a, sp), x
	clr	(0x01, sp)
00102$:
;	user/display.c: 148: shiftOut595(0x3F);
	push	#0x3f
	call	_shiftOut595
	pop	a
;	user/display.c: 149: latch595();
	call	_latch595
;	user/display.c: 150: GPIO_WriteHigh(display.portScan, display.led[0]);
	ldw	x, (0x12, sp)
	ld	a, (x)
	ldw	x, (0x10, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 151: delay_us(intensy);
	ld	a, (0x16, sp)
	ld	(0x09, sp), a
	clr	(0x08, sp)
	ldw	x, (0x08, sp)
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 152: GPIO_WriteLow(display.portScan, display.led[0]);
	ldw	x, (0x12, sp)
	ld	a, (x)
	ldw	x, (0x10, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 153: delay_us(255-intensy);
	ld	a, (0x16, sp)
	ld	(0x07, sp), a
	clr	(0x06, sp)
	ld	a, #0xff
	sub	a, (0x07, sp)
	ld	(0x05, sp), a
	clr	a
	sbc	a, (0x06, sp)
	ld	(0x04, sp), a
	ldw	x, (0x04, sp)
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 154: shiftOut595(0x06);
	push	#0x06
	call	_shiftOut595
	pop	a
;	user/display.c: 155: latch595();
	call	_latch595
;	user/display.c: 156: GPIO_WriteHigh(display.portScan, display.led[1]);
	ldw	x, (0x0e, sp)
	ld	a, (x)
	ldw	x, (0x10, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 157: delay_us(intensy);
	ldw	x, (0x08, sp)
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 158: GPIO_WriteLow(display.portScan, display.led[1]);
	ldw	x, (0x0e, sp)
	ld	a, (x)
	ldw	x, (0x10, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 159: delay_us(255-intensy);
	ldw	x, (0x04, sp)
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 160: shiftOut595(0x5B);
	push	#0x5b
	call	_shiftOut595
	pop	a
;	user/display.c: 161: latch595();
	call	_latch595
;	user/display.c: 162: GPIO_WriteHigh(display.portScan, display.led[2]);
	ldw	x, (0x0c, sp)
	ld	a, (x)
	ldw	x, (0x10, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 163: delay_us(intensy);
	ldw	x, (0x08, sp)
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 164: GPIO_WriteLow(display.portScan, display.led[2]);
	ldw	x, (0x0c, sp)
	ld	a, (x)
	ldw	x, (0x10, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 165: delay_us(255-intensy);
	ldw	x, (0x04, sp)
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 166: shiftOut595(0x4F);
	push	#0x4f
	call	_shiftOut595
	pop	a
;	user/display.c: 167: latch595();
	call	_latch595
;	user/display.c: 168: GPIO_WriteHigh(display.portData, display.led[3]);
	ldw	x, (0x0a, sp)
	ld	a, (x)
	ldw	x, (0x02, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 169: delay_us(intensy);
	ldw	x, (0x08, sp)
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 170: GPIO_WriteLow(display.portData, display.led[3]);
	ldw	x, (0x0a, sp)
	ld	a, (x)
	ldw	x, (0x02, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 171: delay_us(255-intensy);
	ldw	x, (0x04, sp)
	pushw	x
	call	_delay_us
	popw	x
;	user/display.c: 146: for(i = 0; i < 20; i++)
	inc	(0x01, sp)
	ld	a, (0x01, sp)
	cp	a, #0x14
	jrnc	00111$
	jp	00102$
00111$:
	addw	sp, #19
	ret
	.area CODE
_code7Seg:
	.db #0x3f	; 63
	.db #0x06	; 6
	.db #0x5b	; 91
	.db #0x4f	; 79	'O'
	.db #0x66	; 102	'f'
	.db #0x6d	; 109	'm'
	.db #0x7d	; 125
	.db #0x07	; 7
	.db #0x7f	; 127
	.db #0x6f	; 111	'o'
	.area INITIALIZER
	.area CABS (ABS)
