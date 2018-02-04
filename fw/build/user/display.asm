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
	sub	sp, #18
;	user/display.c: 15: display.portData = portData;
	ldw	x, #_display+0
	ldw	y, (0x15, sp)
	ldw	(x), y
;	user/display.c: 16: display.portScan = portScan;
	ldw	x, #_display+0
	ldw	(0x11, sp), x
	ldw	x, (0x11, sp)
	incw	x
	incw	x
	ldw	(0x0f, sp), x
	ldw	x, (0x0f, sp)
	ldw	y, (0x17, sp)
	ldw	(x), y
;	user/display.c: 17: display.data = data;
	ldw	x, (0x11, sp)
	ld	a, (0x19, sp)
	ld	(0x0004, x), a
;	user/display.c: 18: display.clk = clk;
	ldw	x, (0x11, sp)
	ld	a, (0x1a, sp)
	ld	(0x0005, x), a
;	user/display.c: 19: display.lat = lat;
	ldw	x, (0x11, sp)
	ld	a, (0x1b, sp)
	ld	(0x0006, x), a
;	user/display.c: 20: display.clr = clr;
	ldw	x, (0x11, sp)
	addw	x, #0x0007
	ldw	(0x0d, sp), x
	ldw	x, (0x0d, sp)
	ld	a, (0x1c, sp)
	ld	(x), a
;	user/display.c: 21: display.led[0] = led1;
	ldw	x, (0x11, sp)
	addw	x, #0x0008
	ldw	(0x0b, sp), x
	ldw	x, (0x0b, sp)
	ld	a, (0x1d, sp)
	ld	(x), a
;	user/display.c: 22: display.led[1] = led2;
	ldw	x, (0x11, sp)
	addw	x, #0x0009
	ldw	(0x09, sp), x
	ldw	x, (0x09, sp)
	ld	a, (0x1e, sp)
	ld	(x), a
;	user/display.c: 23: display.led[2] = led3;
	ldw	x, (0x11, sp)
	addw	x, #0x000a
	ldw	(0x07, sp), x
	ldw	x, (0x07, sp)
	ld	a, (0x1f, sp)
	ld	(x), a
;	user/display.c: 24: display.led[3] = led4;
	ldw	x, (0x11, sp)
	addw	x, #0x000b
	ldw	(0x05, sp), x
	ldw	x, (0x05, sp)
	ld	a, (0x20, sp)
	ld	(x), a
;	user/display.c: 25: GPIO_Init(display.portData, display.data|display.clk|display.lat|display.clr|display.led[3], GPIO_MODE_OUT_PP_HIGH_FAST);
	ld	a, (0x19, sp)
	or	a, (0x1a, sp)
	or	a, (0x1b, sp)
	or	a, (0x1c, sp)
	or	a, (0x20, sp)
	ldw	x, (0x11, sp)
	ldw	x, (x)
	push	#0xf0
	push	a
	pushw	x
	call	_GPIO_Init
	addw	sp, #4
;	user/display.c: 26: GPIO_Init(display.portScan, display.led[0]|display.led[1]|display.led[2], GPIO_MODE_OUT_PP_HIGH_FAST);
	ldw	x, (0x0b, sp)
	ld	a, (x)
	ld	(0x04, sp), a
	ldw	x, (0x09, sp)
	ld	a, (x)
	or	a, (0x04, sp)
	ld	(0x03, sp), a
	ldw	x, (0x07, sp)
	ld	a, (x)
	or	a, (0x03, sp)
	ldw	x, (0x0f, sp)
	ldw	x, (x)
	push	#0xf0
	push	a
	pushw	x
	call	_GPIO_Init
	addw	sp, #4
;	user/display.c: 29: GPIO_WriteHigh(display.portData, display.clr);
	ldw	x, (0x0d, sp)
	ld	a, (x)
	ldw	x, (0x11, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 30: GPIO_WriteLow(display.portScan, display.led[0]);
	ldw	x, (0x0b, sp)
	ld	a, (x)
	ldw	x, (0x0f, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 31: GPIO_WriteLow(display.portScan, display.led[1]);
	ldw	x, (0x09, sp)
	ld	a, (x)
	ldw	x, (0x0f, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 32: GPIO_WriteLow(display.portScan, display.led[2]);
	ldw	x, (0x07, sp)
	ld	a, (x)
	ldw	x, (0x0f, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 33: GPIO_WriteLow(display.portData, display.led[3]);
	ldw	x, (0x05, sp)
	ld	a, (x)
	ldw	x, (0x11, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 34: memset(display.buffer, 0x00, sizeof(display.buffer));
	ldw	x, (0x11, sp)
	addw	x, #0x000c
	ldw	(0x01, sp), x
	ldw	y, (0x01, sp)
	push	#0x04
	push	#0x00
	clrw	x
	pushw	x
	pushw	y
	call	_memset
	addw	sp, #6
;	user/display.c: 39: memset(display.buffer, 0xff, sizeof(display.buffer));
	ldw	x, (0x01, sp)
	push	#0x04
	push	#0x00
	push	#0xff
	push	#0x00
	pushw	x
	call	_memset
	addw	sp, #24
	ret
;	user/display.c: 42: void shiftOut595(uint8_t data)
;	-----------------------------------------
;	 function shiftOut595
;	-----------------------------------------
_shiftOut595:
	sub	sp, #6
;	user/display.c: 45: temp = data;
	ld	a, (0x09, sp)
	ld	(0x02, sp), a
;	user/display.c: 47: for(i = 0; i< 8; i++)
	ldw	x, #_display+0
	ldw	(0x03, sp), x
	ldw	x, (0x03, sp)
	addw	x, #0x0005
	ldw	(0x05, sp), x
	clr	(0x01, sp)
00105$:
;	user/display.c: 49: GPIO_WriteLow(display.portData, display.clk);
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
;	user/display.c: 50: if(temp&0x80) GPIO_WriteHigh(display.portData, display.data);
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
;	user/display.c: 51: else GPIO_WriteLow(display.portData, display.data);
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
00103$:
;	user/display.c: 52: delay_us(5);
	push	#0x05
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 53: GPIO_WriteHigh(display.portData, display.clk);
	ldw	x, (0x05, sp)
	ld	a, (x)
	ldw	x, (0x03, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 54: temp <<= 1;
	sll	(0x02, sp)
;	user/display.c: 47: for(i = 0; i< 8; i++)
	inc	(0x01, sp)
	ld	a, (0x01, sp)
	cp	a, #0x08
	jrc	00105$
	addw	sp, #6
	ret
;	user/display.c: 58: void latch595(void)
;	-----------------------------------------
;	 function latch595
;	-----------------------------------------
_latch595:
	pushw	x
;	user/display.c: 60: GPIO_WriteHigh(display.portData, display.lat);
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
;	user/display.c: 61: GPIO_WriteLow(display.portData, display.lat);
	ld	a, (x)
	ldw	x, (0x01, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 62: delay_us(5);
	push	#0x05
	push	#0x00
	call	_delay_us
	addw	sp, #4
	ret
;	user/display.c: 65: void clear595(void)
;	-----------------------------------------
;	 function clear595
;	-----------------------------------------
_clear595:
	pushw	x
;	user/display.c: 67: GPIO_WriteHigh(display.portData, display.clr);
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
;	user/display.c: 68: GPIO_WriteLow(display.portData, display.clr);
	ld	a, (x)
	ldw	x, (0x01, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 69: delay_us(100);
	push	#0x64
	push	#0x00
	call	_delay_us
	addw	sp, #4
	ret
;	user/display.c: 72: void writeBuffer(uint8_t pos)
;	-----------------------------------------
;	 function writeBuffer
;	-----------------------------------------
_writeBuffer:
	pushw	x
;	user/display.c: 74: shiftOut595(display.buffer[pos]);
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
;	user/display.c: 75: latch595();
	call	_latch595
	popw	x
	ret
;	user/display.c: 78: void onLed(uint8_t led)
;	-----------------------------------------
;	 function onLed
;	-----------------------------------------
_onLed:
	sub	sp, #8
;	user/display.c: 80: switch(led)
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
;	user/display.c: 82: case 1: {
00101$:
;	user/display.c: 83: GPIO_WriteHigh(display.portScan, display.led[0]);
	ldw	x, #_display+0
	ldw	(0x07, sp), x
	ldw	y, (0x07, sp)
	ld	a, (0x8, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 84: break;
	jra	00107$
;	user/display.c: 86: case 2:{
00102$:
;	user/display.c: 87: GPIO_WriteHigh(display.portScan, display.led[1]);
	ldw	x, #_display+0
	ldw	(0x05, sp), x
	ldw	y, (0x05, sp)
	ld	a, (0x9, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 88: break;
	jra	00107$
;	user/display.c: 90: case 3:{
00103$:
;	user/display.c: 91: GPIO_WriteHigh(display.portScan, display.led[2]);
	ldw	x, #_display+0
	ldw	(0x03, sp), x
	ldw	y, (0x03, sp)
	ld	a, (0xa, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 92: break;
	jra	00107$
;	user/display.c: 94: case 4:{
00104$:
;	user/display.c: 95: GPIO_WriteHigh(display.portData, display.led[3]);
	ldw	x, #_display+0
	ldw	(0x01, sp), x
	ldw	y, (0x01, sp)
	ld	a, (0xb, y)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 99: }
00107$:
	addw	sp, #8
	ret
;	user/display.c: 102: void offLed(uint8_t led)
;	-----------------------------------------
;	 function offLed
;	-----------------------------------------
_offLed:
	sub	sp, #8
;	user/display.c: 104: switch(led)
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
;	user/display.c: 106: case 1: {
00101$:
;	user/display.c: 107: GPIO_WriteLow(display.portScan, display.led[0]);
	ldw	x, #_display+0
	ldw	(0x07, sp), x
	ldw	y, (0x07, sp)
	ld	a, (0x8, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 108: break;
	jra	00107$
;	user/display.c: 110: case 2:{
00102$:
;	user/display.c: 111: GPIO_WriteLow(display.portScan, display.led[1]);
	ldw	x, #_display+0
	ldw	(0x05, sp), x
	ldw	y, (0x05, sp)
	ld	a, (0x9, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 112: break;
	jra	00107$
;	user/display.c: 114: case 3:{
00103$:
;	user/display.c: 115: GPIO_WriteLow(display.portScan, display.led[2]);
	ldw	x, #_display+0
	ldw	(0x03, sp), x
	ldw	y, (0x03, sp)
	ld	a, (0xa, y)
	ldw	x, (0x2, x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 116: break;
	jra	00107$
;	user/display.c: 118: case 4:{
00104$:
;	user/display.c: 119: GPIO_WriteLow(display.portData, display.led[3]);
	ldw	x, #_display+0
	ldw	(0x01, sp), x
	ldw	y, (0x01, sp)
	ld	a, (0xb, y)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 123: }
00107$:
	addw	sp, #8
	ret
;	user/display.c: 126: void screen(void)
;	-----------------------------------------
;	 function screen
;	-----------------------------------------
_screen:
;	user/display.c: 129: for(i = 0; i < 4; i++)
	clr	a
00102$:
;	user/display.c: 131: writeBuffer(i);
	push	a
	push	a
	call	_writeBuffer
	pop	a
	pop	a
;	user/display.c: 132: onLed(i+1);
	inc	a
	push	a
	push	a
	call	_onLed
	pop	a
	push	#0xc8
	push	#0x00
	call	_delay_us
	popw	x
	pop	a
;	user/display.c: 134: offLed(i+1);
	push	a
	push	a
	call	_offLed
	pop	a
	push	#0x0a
	push	#0x00
	call	_delay_us
	popw	x
	pop	a
;	user/display.c: 129: for(i = 0; i < 4; i++)
	cp	a, #0x04
	jrc	00102$
	ret
;	user/display.c: 139: void display_test(void)
;	-----------------------------------------
;	 function display_test
;	-----------------------------------------
_display_test:
	sub	sp, #13
;	user/display.c: 142: for(i = 0; i < 20; i++)
	ldw	x, #_display+0
	ldw	(0x0c, sp), x
	ldw	x, (0x0c, sp)
	addw	x, #0x0008
	ldw	(0x0a, sp), x
	ldw	x, (0x0c, sp)
	incw	x
	incw	x
	ldw	(0x08, sp), x
	ldw	x, (0x0c, sp)
	addw	x, #0x0009
	ldw	(0x06, sp), x
	ldw	x, (0x0c, sp)
	addw	x, #0x000a
	ldw	(0x04, sp), x
	ldw	x, (0x0c, sp)
	addw	x, #0x000b
	ldw	(0x02, sp), x
	clr	(0x01, sp)
00102$:
;	user/display.c: 144: shiftOut595(0x3F);
	push	#0x3f
	call	_shiftOut595
	pop	a
;	user/display.c: 145: latch595();
	call	_latch595
;	user/display.c: 146: GPIO_WriteHigh(display.portScan, display.led[0]);
	ldw	x, (0x0a, sp)
	ld	a, (x)
	ldw	x, (0x08, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 147: delay_us(50);
	push	#0x32
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 148: GPIO_WriteLow(display.portScan, display.led[0]);
	ldw	x, (0x0a, sp)
	ld	a, (x)
	ldw	x, (0x08, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 149: delay_us(10);
	push	#0x0a
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 150: shiftOut595(0x06);
	push	#0x06
	call	_shiftOut595
	pop	a
;	user/display.c: 151: latch595();
	call	_latch595
;	user/display.c: 152: GPIO_WriteHigh(display.portScan, display.led[1]);
	ldw	x, (0x06, sp)
	ld	a, (x)
	ldw	x, (0x08, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 153: delay_us(50);
	push	#0x32
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 154: GPIO_WriteLow(display.portScan, display.led[1]);
	ldw	x, (0x06, sp)
	ld	a, (x)
	ldw	x, (0x08, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 155: delay_us(10);
	push	#0x0a
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 156: shiftOut595(0x5B);
	push	#0x5b
	call	_shiftOut595
	pop	a
;	user/display.c: 157: latch595();
	call	_latch595
;	user/display.c: 158: GPIO_WriteHigh(display.portScan, display.led[2]);
	ldw	x, (0x04, sp)
	ld	a, (x)
	ldw	x, (0x08, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 159: delay_us(50);
	push	#0x32
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 160: GPIO_WriteLow(display.portScan, display.led[2]);
	ldw	x, (0x04, sp)
	ld	a, (x)
	ldw	x, (0x08, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 161: delay_us(10);
	push	#0x0a
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 162: shiftOut595(0x4F);
	push	#0x4f
	call	_shiftOut595
	pop	a
;	user/display.c: 163: latch595();
	call	_latch595
;	user/display.c: 164: GPIO_WriteHigh(display.portData, display.led[3]);
	ldw	x, (0x02, sp)
	ld	a, (x)
	ldw	x, (0x0c, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteHigh
	addw	sp, #3
;	user/display.c: 165: delay_us(50);
	push	#0x32
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 166: GPIO_WriteLow(display.portData, display.led[3]);
	ldw	x, (0x02, sp)
	ld	a, (x)
	ldw	x, (0x0c, sp)
	ldw	x, (x)
	push	a
	pushw	x
	call	_GPIO_WriteLow
	addw	sp, #3
;	user/display.c: 167: delay_us(10);
	push	#0x0a
	push	#0x00
	call	_delay_us
	popw	x
;	user/display.c: 142: for(i = 0; i < 20; i++)
	inc	(0x01, sp)
	ld	a, (0x01, sp)
	cp	a, #0x14
	jrnc	00111$
	jp	00102$
00111$:
	addw	sp, #13
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
