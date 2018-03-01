;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (Mac OS X x86_64)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _TIM4_UPD_OVF_IRQHandler
	.globl _delay
	.globl _RTC_GetDateTime
	.globl _RTC_Init
	.globl _screen
	.globl _setDigit
	.globl _displayInit
	.globl _TIMER_CheckTimeMS
	.globl _TIMER_InitTime
	.globl _TIMER_Inc
	.globl _TIMER_Init
	.globl _TIM4_ClearITPendingBit
	.globl _IWDG_ReloadCounter
	.globl _tick
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_tick::
	.ds 6
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ;reset
	int 0x0000 ;trap
	int 0x0000 ;int0
	int 0x0000 ;int1
	int 0x0000 ;int2
	int 0x0000 ;int3
	int 0x0000 ;int4
	int 0x0000 ;int5
	int 0x0000 ;int6
	int 0x0000 ;int7
	int 0x0000 ;int8
	int 0x0000 ;int9
	int 0x0000 ;int10
	int 0x0000 ;int11
	int 0x0000 ;int12
	int 0x0000 ;int13
	int 0x0000 ;int14
	int 0x0000 ;int15
	int 0x0000 ;int16
	int 0x0000 ;int17
	int 0x0000 ;int18
	int 0x0000 ;int19
	int 0x0000 ;int20
	int 0x0000 ;int21
	int 0x0000 ;int22
	int _TIM4_UPD_OVF_IRQHandler ;int23
	int 0x0000 ;int24
	int 0x0000 ;int25
	int 0x0000 ;int26
	int 0x0000 ;int27
	int 0x0000 ;int28
	int 0x0000 ;int29
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_gs_init_startup:
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	user/main.c: 26: void delay(uint16_t x)
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	pushw	x
;	user/main.c: 28: while(x--);
	ldw	x, (0x05, sp)
00101$:
	ldw	(0x01, sp), x
	decw	x
	ldw	y, (0x01, sp)
	jrne	00101$
	popw	x
	ret
;	user/main.c: 31: INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
;	-----------------------------------------
;	 function TIM4_UPD_OVF_IRQHandler
;	-----------------------------------------
_TIM4_UPD_OVF_IRQHandler:
	div	x, a
;	user/main.c: 33: TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
	push	#0x01
	call	_TIM4_ClearITPendingBit
	pop	a
;	user/main.c: 34: TIMER_Inc();
	call	_TIMER_Inc
;	user/main.c: 35: IWDG_ReloadCounter();
	call	_IWDG_ReloadCounter
	iret
;	user/main.c: 56: void main() 
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #11
;	user/main.c: 61: RTC_Init();
	call	_RTC_Init
;	user/main.c: 62: displayInit(GPIOC, GPIOA, GPIO_PIN_6, GPIO_PIN_5, GPIO_PIN_7, GPIO_PIN_4, GPIO_PIN_3, GPIO_PIN_2, GPIO_PIN_1, GPIO_PIN_3);
	push	#0x08
	push	#0x02
	push	#0x04
	push	#0x08
	push	#0x10
	push	#0x80
	push	#0x20
	push	#0x40
	push	#0x00
	push	#0x50
	push	#0x0a
	push	#0x50
	call	_displayInit
	addw	sp, #12
;	user/main.c: 63: TIMER_Init();
	call	_TIMER_Init
;	user/main.c: 64: TIMER_InitTime(&tick);
	ldw	x, #_tick+0
	ldw	(0x0a, sp), x
	ldw	x, (0x0a, sp)
	pushw	x
	call	_TIMER_InitTime
	popw	x
;	user/main.c: 67: enableInterrupts();
	rim
;	user/main.c: 68: while(TRUE) 
00104$:
;	user/main.c: 70: if(TIMER_CheckTimeMS(&tick, 50) == 0)
	ldw	y, (0x0a, sp)
	push	#0x32
	clrw	x
	pushw	x
	push	#0x00
	pushw	y
	call	_TIMER_CheckTimeMS
	addw	sp, #6
	tnz	a
	jrne	00102$
;	user/main.c: 72: RTC_GetDateTime(&time);
	ldw	x, sp
	incw	x
	ldw	(0x08, sp), x
	ldw	x, (0x08, sp)
	pushw	x
	call	_RTC_GetDateTime
	popw	x
;	user/main.c: 73: setDigit(1, time.sec/10);
	ldw	x, (0x08, sp)
	ld	a, (x)
	clrw	x
	ld	xl, a
	ld	a, #0x0a
	div	x, a
	ld	a, xl
	push	a
	push	#0x01
	call	_setDigit
	popw	x
;	user/main.c: 74: setDigit(2, time.sec%10);
	ldw	x, (0x08, sp)
	ld	a, (x)
	clrw	x
	ld	xl, a
	ld	a, #0x0a
	div	x, a
	push	a
	push	#0x02
	call	_setDigit
	popw	x
00102$:
;	user/main.c: 76: screen(250);
	push	#0xfa
	call	_screen
	pop	a
	jra	00104$
	addw	sp, #11
	ret
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
