                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.6.0 #9615 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module timerTick
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _TIM4_ClearFlag
                                     12 	.globl _TIM4_GetCounter
                                     13 	.globl _TIM4_ITConfig
                                     14 	.globl _TIM4_Cmd
                                     15 	.globl _TIM4_TimeBaseInit
                                     16 	.globl _TIM4_DeInit
                                     17 	.globl _CLK_PeripheralClockConfig
                                     18 	.globl _timeTickUs
                                     19 	.globl _timeTickMs
                                     20 	.globl _timeBack
                                     21 	.globl _timeGet
                                     22 	.globl _TIMER_Init
                                     23 	.globl _TIMER_Inc
                                     24 	.globl _TIMER_InitTime
                                     25 	.globl _TIMER_CheckTimeUS
                                     26 	.globl _TIMER_CheckTimeMS
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DATA
      000017                         31 _timeGet::
      000017                         32 	.ds 2
      000019                         33 _timeBack::
      000019                         34 	.ds 2
      00001B                         35 _timeTickMs::
      00001B                         36 	.ds 4
      00001F                         37 _timeTickUs::
      00001F                         38 	.ds 1
                                     39 ;--------------------------------------------------------
                                     40 ; ram data
                                     41 ;--------------------------------------------------------
                                     42 	.area INITIALIZED
                                     43 ;--------------------------------------------------------
                                     44 ; absolute external ram data
                                     45 ;--------------------------------------------------------
                                     46 	.area DABS (ABS)
                                     47 ;--------------------------------------------------------
                                     48 ; global & static initialisations
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area GSINIT
                                     52 	.area GSFINAL
                                     53 	.area GSINIT
                                     54 ;--------------------------------------------------------
                                     55 ; Home
                                     56 ;--------------------------------------------------------
                                     57 	.area HOME
                                     58 	.area HOME
                                     59 ;--------------------------------------------------------
                                     60 ; code
                                     61 ;--------------------------------------------------------
                                     62 	.area CODE
                                     63 ;	user/timerTick.c: 18: void TIMER_Init(void)
                                     64 ;	-----------------------------------------
                                     65 ;	 function TIMER_Init
                                     66 ;	-----------------------------------------
      008515                         67 _TIMER_Init:
                                     68 ;	user/timerTick.c: 20: CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4 , ENABLE); 
      008515 4B 01            [ 1]   69 	push	#0x01
      008517 4B 04            [ 1]   70 	push	#0x04
      008519 CD 86 92         [ 4]   71 	call	_CLK_PeripheralClockConfig
      00851C 85               [ 2]   72 	popw	x
                                     73 ;	user/timerTick.c: 21: TIM4_DeInit(); 
      00851D CD 89 F2         [ 4]   74 	call	_TIM4_DeInit
                                     75 ;	user/timerTick.c: 23: TIM4_TimeBaseInit(TIM4_PRESCALER_16, CYCLE_US);
      008520 4B C8            [ 1]   76 	push	#0xc8
      008522 4B 04            [ 1]   77 	push	#0x04
      008524 CD 8A 0B         [ 4]   78 	call	_TIM4_TimeBaseInit
      008527 85               [ 2]   79 	popw	x
                                     80 ;	user/timerTick.c: 24: TIM4_ClearFlag(TIM4_FLAG_UPDATE); 
      008528 4B 01            [ 1]   81 	push	#0x01
      00852A CD 8A 3B         [ 4]   82 	call	_TIM4_ClearFlag
      00852D 84               [ 1]   83 	pop	a
                                     84 ;	user/timerTick.c: 25: TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
      00852E 4B 01            [ 1]   85 	push	#0x01
      008530 4B 01            [ 1]   86 	push	#0x01
      008532 CD 8A 1D         [ 4]   87 	call	_TIM4_ITConfig
      008535 85               [ 2]   88 	popw	x
                                     89 ;	user/timerTick.c: 26: TIM4_Cmd(ENABLE);    // Enable TIM4 
      008536 4B 01            [ 1]   90 	push	#0x01
      008538 CD 8A 18         [ 4]   91 	call	_TIM4_Cmd
      00853B 84               [ 1]   92 	pop	a
                                     93 ;	user/timerTick.c: 27: timeTickMs = 0;
      00853C 5F               [ 1]   94 	clrw	x
      00853D CF 00 1D         [ 2]   95 	ldw	_timeTickMs+2, x
      008540 CF 00 1B         [ 2]   96 	ldw	_timeTickMs+0, x
                                     97 ;	user/timerTick.c: 28: timeTickUs = 0;
      008543 72 5F 00 1F      [ 1]   98 	clr	_timeTickUs+0
      008547 81               [ 4]   99 	ret
                                    100 ;	user/timerTick.c: 31: void TIMER_Inc(void)
                                    101 ;	-----------------------------------------
                                    102 ;	 function TIMER_Inc
                                    103 ;	-----------------------------------------
      008548                        104 _TIMER_Inc:
                                    105 ;	user/timerTick.c: 33: timeTickUs++;
      008548 72 5C 00 1F      [ 1]  106 	inc	_timeTickUs+0
                                    107 ;	user/timerTick.c: 34: if(timeTickUs%5 == 0){
      00854C 5F               [ 1]  108 	clrw	x
      00854D C6 00 1F         [ 1]  109 	ld	a, _timeTickUs+0
      008550 97               [ 1]  110 	ld	xl, a
      008551 A6 05            [ 1]  111 	ld	a, #0x05
      008553 62               [ 2]  112 	div	x, a
      008554 4D               [ 1]  113 	tnz	a
      008555 27 01            [ 1]  114 	jreq	00109$
      008557 81               [ 4]  115 	ret
      008558                        116 00109$:
                                    117 ;	user/timerTick.c: 35: timeTickMs++;
      008558 CE 00 1D         [ 2]  118 	ldw	x, _timeTickMs+2
      00855B 1C 00 01         [ 2]  119 	addw	x, #0x0001
      00855E C6 00 1C         [ 1]  120 	ld	a, _timeTickMs+1
      008561 A9 00            [ 1]  121 	adc	a, #0x00
      008563 90 97            [ 1]  122 	ld	yl, a
      008565 C6 00 1B         [ 1]  123 	ld	a, _timeTickMs+0
      008568 A9 00            [ 1]  124 	adc	a, #0x00
      00856A 90 95            [ 1]  125 	ld	yh, a
      00856C CF 00 1D         [ 2]  126 	ldw	_timeTickMs+2, x
      00856F 90 CF 00 1B      [ 2]  127 	ldw	_timeTickMs+0, y
      008573 81               [ 4]  128 	ret
                                    129 ;	user/timerTick.c: 39: void TIMER_InitTime(TIME *pTime)
                                    130 ;	-----------------------------------------
                                    131 ;	 function TIMER_InitTime
                                    132 ;	-----------------------------------------
      008574                        133 _TIMER_InitTime:
                                    134 ;	user/timerTick.c: 41: pTime->timeMS = timeTickMs;
      008574 1E 03            [ 2]  135 	ldw	x, (0x03, sp)
      008576 5C               [ 2]  136 	incw	x
      008577 5C               [ 2]  137 	incw	x
      008578 90 CE 00 1D      [ 2]  138 	ldw	y, _timeTickMs+2
      00857C EF 02            [ 2]  139 	ldw	(0x2, x), y
      00857E 90 CE 00 1B      [ 2]  140 	ldw	y, _timeTickMs+0
      008582 FF               [ 2]  141 	ldw	(x), y
      008583 81               [ 4]  142 	ret
                                    143 ;	user/timerTick.c: 44: uint8_t TIMER_CheckTimeUS(TIME *pTime, uint16_t time)
                                    144 ;	-----------------------------------------
                                    145 ;	 function TIMER_CheckTimeUS
                                    146 ;	-----------------------------------------
      008584                        147 _TIMER_CheckTimeUS:
      008584 52 04            [ 2]  148 	sub	sp, #4
                                    149 ;	user/timerTick.c: 46: timeGet = TIM4_GetCounter();
      008586 CD 8A 28         [ 4]  150 	call	_TIM4_GetCounter
      008589 5F               [ 1]  151 	clrw	x
      00858A 97               [ 1]  152 	ld	xl, a
      00858B CF 00 17         [ 2]  153 	ldw	_timeGet+0, x
                                    154 ;	user/timerTick.c: 47: if(((timeGet > pTime->timeUS)&&((timeGet - pTime->timeUS) >= time))||((timeGet < pTime->timeUS)&&(((CYCLE_US -  pTime->timeUS) + timeGet + 1) >= time))){
      00858E 16 07            [ 2]  155 	ldw	y, (0x07, sp)
      008590 17 03            [ 2]  156 	ldw	(0x03, sp), y
      008592 1E 03            [ 2]  157 	ldw	x, (0x03, sp)
      008594 FE               [ 2]  158 	ldw	x, (x)
      008595 1F 01            [ 2]  159 	ldw	(0x01, sp), x
      008597 1E 01            [ 2]  160 	ldw	x, (0x01, sp)
      008599 C3 00 17         [ 2]  161 	cpw	x, _timeGet+0
      00859C 24 0A            [ 1]  162 	jrnc	00105$
      00859E CE 00 17         [ 2]  163 	ldw	x, _timeGet+0
      0085A1 72 F0 01         [ 2]  164 	subw	x, (0x01, sp)
      0085A4 13 09            [ 2]  165 	cpw	x, (0x09, sp)
      0085A6 24 14            [ 1]  166 	jrnc	00101$
      0085A8                        167 00105$:
      0085A8 1E 01            [ 2]  168 	ldw	x, (0x01, sp)
      0085AA C3 00 17         [ 2]  169 	cpw	x, _timeGet+0
      0085AD 23 17            [ 2]  170 	jrule	00102$
      0085AF CE 00 17         [ 2]  171 	ldw	x, _timeGet+0
      0085B2 1C 00 C9         [ 2]  172 	addw	x, #0x00c9
      0085B5 72 F0 01         [ 2]  173 	subw	x, (0x01, sp)
      0085B8 13 09            [ 2]  174 	cpw	x, (0x09, sp)
      0085BA 25 0A            [ 1]  175 	jrc	00102$
      0085BC                        176 00101$:
                                    177 ;	user/timerTick.c: 48: pTime->timeUS = timeGet;
      0085BC 1E 03            [ 2]  178 	ldw	x, (0x03, sp)
      0085BE 90 CE 00 17      [ 2]  179 	ldw	y, _timeGet+0
      0085C2 FF               [ 2]  180 	ldw	(x), y
                                    181 ;	user/timerTick.c: 49: return 0;
      0085C3 4F               [ 1]  182 	clr	a
      0085C4 20 02            [ 2]  183 	jra	00106$
      0085C6                        184 00102$:
                                    185 ;	user/timerTick.c: 51: return 1;
      0085C6 A6 01            [ 1]  186 	ld	a, #0x01
      0085C8                        187 00106$:
      0085C8 5B 04            [ 2]  188 	addw	sp, #4
      0085CA 81               [ 4]  189 	ret
                                    190 ;	user/timerTick.c: 54: uint8_t TIMER_CheckTimeMS(TIME *pTime, uint32_t time)
                                    191 ;	-----------------------------------------
                                    192 ;	 function TIMER_CheckTimeMS
                                    193 ;	-----------------------------------------
      0085CB                        194 _TIMER_CheckTimeMS:
      0085CB 52 0B            [ 2]  195 	sub	sp, #11
                                    196 ;	user/timerTick.c: 56: if(((timeTickMs > pTime->timeMS)&&((timeTickMs - pTime->timeMS) >= time))||((timeTickMs < pTime->timeMS)&&(((CYCLE_MS -  pTime->timeMS) + timeTickMs + 1) >= time))){
      0085CD 1E 0E            [ 2]  197 	ldw	x, (0x0e, sp)
      0085CF 5C               [ 2]  198 	incw	x
      0085D0 5C               [ 2]  199 	incw	x
      0085D1 1F 0A            [ 2]  200 	ldw	(0x0a, sp), x
      0085D3 1E 0A            [ 2]  201 	ldw	x, (0x0a, sp)
      0085D5 E6 03            [ 1]  202 	ld	a, (0x3, x)
      0085D7 6B 09            [ 1]  203 	ld	(0x09, sp), a
      0085D9 E6 02            [ 1]  204 	ld	a, (0x2, x)
      0085DB 6B 08            [ 1]  205 	ld	(0x08, sp), a
      0085DD FE               [ 2]  206 	ldw	x, (x)
      0085DE 1F 06            [ 2]  207 	ldw	(0x06, sp), x
      0085E0 CE 00 1D         [ 2]  208 	ldw	x, _timeTickMs+2
      0085E3 72 F0 08         [ 2]  209 	subw	x, (0x08, sp)
      0085E6 C6 00 1C         [ 1]  210 	ld	a, _timeTickMs+1
      0085E9 12 07            [ 1]  211 	sbc	a, (0x07, sp)
      0085EB 88               [ 1]  212 	push	a
      0085EC C6 00 1B         [ 1]  213 	ld	a, _timeTickMs+0
      0085EF 12 07            [ 1]  214 	sbc	a, (0x07, sp)
      0085F1 6B 03            [ 1]  215 	ld	(0x03, sp), a
      0085F3 84               [ 1]  216 	pop	a
      0085F4 88               [ 1]  217 	push	a
      0085F5 13 13            [ 2]  218 	cpw	x, (0x13, sp)
      0085F7 84               [ 1]  219 	pop	a
      0085F8 12 11            [ 1]  220 	sbc	a, (0x11, sp)
      0085FA 7B 02            [ 1]  221 	ld	a, (0x02, sp)
      0085FC 12 10            [ 1]  222 	sbc	a, (0x10, sp)
      0085FE 4F               [ 1]  223 	clr	a
      0085FF 49               [ 1]  224 	rlc	a
      008600 6B 01            [ 1]  225 	ld	(0x01, sp), a
      008602 1E 08            [ 2]  226 	ldw	x, (0x08, sp)
      008604 C3 00 1D         [ 2]  227 	cpw	x, _timeTickMs+2
      008607 7B 07            [ 1]  228 	ld	a, (0x07, sp)
      008609 C2 00 1C         [ 1]  229 	sbc	a, _timeTickMs+1
      00860C 7B 06            [ 1]  230 	ld	a, (0x06, sp)
      00860E C2 00 1B         [ 1]  231 	sbc	a, _timeTickMs+0
      008611 24 04            [ 1]  232 	jrnc	00105$
      008613 0D 01            [ 1]  233 	tnz	(0x01, sp)
      008615 27 15            [ 1]  234 	jreq	00101$
      008617                        235 00105$:
      008617 CE 00 1D         [ 2]  236 	ldw	x, _timeTickMs+2
      00861A 13 08            [ 2]  237 	cpw	x, (0x08, sp)
      00861C C6 00 1C         [ 1]  238 	ld	a, _timeTickMs+1
      00861F 12 07            [ 1]  239 	sbc	a, (0x07, sp)
      008621 C6 00 1B         [ 1]  240 	ld	a, _timeTickMs+0
      008624 12 06            [ 1]  241 	sbc	a, (0x06, sp)
      008626 24 14            [ 1]  242 	jrnc	00102$
      008628 0D 01            [ 1]  243 	tnz	(0x01, sp)
      00862A 26 10            [ 1]  244 	jrne	00102$
      00862C                        245 00101$:
                                    246 ;	user/timerTick.c: 57: pTime->timeMS = timeTickMs;
      00862C 1E 0A            [ 2]  247 	ldw	x, (0x0a, sp)
      00862E 90 CE 00 1D      [ 2]  248 	ldw	y, _timeTickMs+2
      008632 EF 02            [ 2]  249 	ldw	(0x2, x), y
      008634 90 CE 00 1B      [ 2]  250 	ldw	y, _timeTickMs+0
      008638 FF               [ 2]  251 	ldw	(x), y
                                    252 ;	user/timerTick.c: 58: return 0;
      008639 4F               [ 1]  253 	clr	a
      00863A 20 02            [ 2]  254 	jra	00106$
      00863C                        255 00102$:
                                    256 ;	user/timerTick.c: 60: return 1;
      00863C A6 01            [ 1]  257 	ld	a, #0x01
      00863E                        258 00106$:
      00863E 5B 0B            [ 2]  259 	addw	sp, #11
      008640 81               [ 4]  260 	ret
                                    261 	.area CODE
                                    262 	.area INITIALIZER
                                    263 	.area CABS (ABS)
