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
      000024                         31 _timeGet::
      000024                         32 	.ds 2
      000026                         33 _timeBack::
      000026                         34 	.ds 2
      000028                         35 _timeTickMs::
      000028                         36 	.ds 4
      00002C                         37 _timeTickUs::
      00002C                         38 	.ds 1
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
      008BCC                         67 _TIMER_Init:
                                     68 ;	user/timerTick.c: 20: CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4 , ENABLE); 
      008BCC 4B 01            [ 1]   69 	push	#0x01
      008BCE 4B 04            [ 1]   70 	push	#0x04
      008BD0 CD 8D 49         [ 4]   71 	call	_CLK_PeripheralClockConfig
      008BD3 85               [ 2]   72 	popw	x
                                     73 ;	user/timerTick.c: 21: TIM4_DeInit(); 
      008BD4 CD 8F 32         [ 4]   74 	call	_TIM4_DeInit
                                     75 ;	user/timerTick.c: 23: TIM4_TimeBaseInit(TIM4_PRESCALER_16, CYCLE_US);
      008BD7 4B C8            [ 1]   76 	push	#0xc8
      008BD9 4B 04            [ 1]   77 	push	#0x04
      008BDB CD 8F 4B         [ 4]   78 	call	_TIM4_TimeBaseInit
      008BDE 85               [ 2]   79 	popw	x
                                     80 ;	user/timerTick.c: 24: TIM4_ClearFlag(TIM4_FLAG_UPDATE); 
      008BDF 4B 01            [ 1]   81 	push	#0x01
      008BE1 CD 8F 7B         [ 4]   82 	call	_TIM4_ClearFlag
      008BE4 84               [ 1]   83 	pop	a
                                     84 ;	user/timerTick.c: 25: TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
      008BE5 4B 01            [ 1]   85 	push	#0x01
      008BE7 4B 01            [ 1]   86 	push	#0x01
      008BE9 CD 8F 5D         [ 4]   87 	call	_TIM4_ITConfig
      008BEC 85               [ 2]   88 	popw	x
                                     89 ;	user/timerTick.c: 26: TIM4_Cmd(ENABLE);    // Enable TIM4 
      008BED 4B 01            [ 1]   90 	push	#0x01
      008BEF CD 8F 58         [ 4]   91 	call	_TIM4_Cmd
      008BF2 84               [ 1]   92 	pop	a
                                     93 ;	user/timerTick.c: 27: timeTickMs = 0;
      008BF3 5F               [ 1]   94 	clrw	x
      008BF4 CF 00 2A         [ 2]   95 	ldw	_timeTickMs+2, x
      008BF7 CF 00 28         [ 2]   96 	ldw	_timeTickMs+0, x
                                     97 ;	user/timerTick.c: 28: timeTickUs = 0;
      008BFA 72 5F 00 2C      [ 1]   98 	clr	_timeTickUs+0
      008BFE 81               [ 4]   99 	ret
                                    100 ;	user/timerTick.c: 31: void TIMER_Inc(void)
                                    101 ;	-----------------------------------------
                                    102 ;	 function TIMER_Inc
                                    103 ;	-----------------------------------------
      008BFF                        104 _TIMER_Inc:
                                    105 ;	user/timerTick.c: 33: timeTickUs++;
      008BFF 72 5C 00 2C      [ 1]  106 	inc	_timeTickUs+0
                                    107 ;	user/timerTick.c: 34: if(timeTickUs%5 == 0){
      008C03 5F               [ 1]  108 	clrw	x
      008C04 C6 00 2C         [ 1]  109 	ld	a, _timeTickUs+0
      008C07 97               [ 1]  110 	ld	xl, a
      008C08 A6 05            [ 1]  111 	ld	a, #0x05
      008C0A 62               [ 2]  112 	div	x, a
      008C0B 4D               [ 1]  113 	tnz	a
      008C0C 27 01            [ 1]  114 	jreq	00109$
      008C0E 81               [ 4]  115 	ret
      008C0F                        116 00109$:
                                    117 ;	user/timerTick.c: 35: timeTickMs++;
      008C0F CE 00 2A         [ 2]  118 	ldw	x, _timeTickMs+2
      008C12 1C 00 01         [ 2]  119 	addw	x, #0x0001
      008C15 C6 00 29         [ 1]  120 	ld	a, _timeTickMs+1
      008C18 A9 00            [ 1]  121 	adc	a, #0x00
      008C1A 90 97            [ 1]  122 	ld	yl, a
      008C1C C6 00 28         [ 1]  123 	ld	a, _timeTickMs+0
      008C1F A9 00            [ 1]  124 	adc	a, #0x00
      008C21 90 95            [ 1]  125 	ld	yh, a
      008C23 CF 00 2A         [ 2]  126 	ldw	_timeTickMs+2, x
      008C26 90 CF 00 28      [ 2]  127 	ldw	_timeTickMs+0, y
      008C2A 81               [ 4]  128 	ret
                                    129 ;	user/timerTick.c: 39: void TIMER_InitTime(TIME *pTime)
                                    130 ;	-----------------------------------------
                                    131 ;	 function TIMER_InitTime
                                    132 ;	-----------------------------------------
      008C2B                        133 _TIMER_InitTime:
                                    134 ;	user/timerTick.c: 41: pTime->timeMS = timeTickMs;
      008C2B 1E 03            [ 2]  135 	ldw	x, (0x03, sp)
      008C2D 5C               [ 2]  136 	incw	x
      008C2E 5C               [ 2]  137 	incw	x
      008C2F 90 CE 00 2A      [ 2]  138 	ldw	y, _timeTickMs+2
      008C33 EF 02            [ 2]  139 	ldw	(0x2, x), y
      008C35 90 CE 00 28      [ 2]  140 	ldw	y, _timeTickMs+0
      008C39 FF               [ 2]  141 	ldw	(x), y
      008C3A 81               [ 4]  142 	ret
                                    143 ;	user/timerTick.c: 44: uint8_t TIMER_CheckTimeUS(TIME *pTime, uint16_t time)
                                    144 ;	-----------------------------------------
                                    145 ;	 function TIMER_CheckTimeUS
                                    146 ;	-----------------------------------------
      008C3B                        147 _TIMER_CheckTimeUS:
      008C3B 52 04            [ 2]  148 	sub	sp, #4
                                    149 ;	user/timerTick.c: 46: timeGet = TIM4_GetCounter();
      008C3D CD 8F 68         [ 4]  150 	call	_TIM4_GetCounter
      008C40 5F               [ 1]  151 	clrw	x
      008C41 97               [ 1]  152 	ld	xl, a
      008C42 CF 00 24         [ 2]  153 	ldw	_timeGet+0, x
                                    154 ;	user/timerTick.c: 47: if(((timeGet > pTime->timeUS)&&((timeGet - pTime->timeUS) >= time))||((timeGet < pTime->timeUS)&&(((CYCLE_US -  pTime->timeUS) + timeGet + 1) >= time))){
      008C45 16 07            [ 2]  155 	ldw	y, (0x07, sp)
      008C47 17 01            [ 2]  156 	ldw	(0x01, sp), y
      008C49 1E 01            [ 2]  157 	ldw	x, (0x01, sp)
      008C4B FE               [ 2]  158 	ldw	x, (x)
      008C4C 1F 03            [ 2]  159 	ldw	(0x03, sp), x
      008C4E 1E 03            [ 2]  160 	ldw	x, (0x03, sp)
      008C50 C3 00 24         [ 2]  161 	cpw	x, _timeGet+0
      008C53 24 0A            [ 1]  162 	jrnc	00105$
      008C55 CE 00 24         [ 2]  163 	ldw	x, _timeGet+0
      008C58 72 F0 03         [ 2]  164 	subw	x, (0x03, sp)
      008C5B 13 09            [ 2]  165 	cpw	x, (0x09, sp)
      008C5D 24 14            [ 1]  166 	jrnc	00101$
      008C5F                        167 00105$:
      008C5F 1E 03            [ 2]  168 	ldw	x, (0x03, sp)
      008C61 C3 00 24         [ 2]  169 	cpw	x, _timeGet+0
      008C64 23 17            [ 2]  170 	jrule	00102$
      008C66 CE 00 24         [ 2]  171 	ldw	x, _timeGet+0
      008C69 1C 00 C9         [ 2]  172 	addw	x, #0x00c9
      008C6C 72 F0 03         [ 2]  173 	subw	x, (0x03, sp)
      008C6F 13 09            [ 2]  174 	cpw	x, (0x09, sp)
      008C71 25 0A            [ 1]  175 	jrc	00102$
      008C73                        176 00101$:
                                    177 ;	user/timerTick.c: 48: pTime->timeUS = timeGet;
      008C73 1E 01            [ 2]  178 	ldw	x, (0x01, sp)
      008C75 90 CE 00 24      [ 2]  179 	ldw	y, _timeGet+0
      008C79 FF               [ 2]  180 	ldw	(x), y
                                    181 ;	user/timerTick.c: 49: return 0;
      008C7A 4F               [ 1]  182 	clr	a
      008C7B 20 02            [ 2]  183 	jra	00106$
      008C7D                        184 00102$:
                                    185 ;	user/timerTick.c: 51: return 1;
      008C7D A6 01            [ 1]  186 	ld	a, #0x01
      008C7F                        187 00106$:
      008C7F 5B 04            [ 2]  188 	addw	sp, #4
      008C81 81               [ 4]  189 	ret
                                    190 ;	user/timerTick.c: 54: uint8_t TIMER_CheckTimeMS(TIME *pTime, uint32_t time)
                                    191 ;	-----------------------------------------
                                    192 ;	 function TIMER_CheckTimeMS
                                    193 ;	-----------------------------------------
      008C82                        194 _TIMER_CheckTimeMS:
      008C82 52 0B            [ 2]  195 	sub	sp, #11
                                    196 ;	user/timerTick.c: 56: if(((timeTickMs > pTime->timeMS)&&((timeTickMs - pTime->timeMS) >= time))||((timeTickMs < pTime->timeMS)&&(((CYCLE_MS -  pTime->timeMS) + timeTickMs + 1) >= time))){
      008C84 1E 0E            [ 2]  197 	ldw	x, (0x0e, sp)
      008C86 5C               [ 2]  198 	incw	x
      008C87 5C               [ 2]  199 	incw	x
      008C88 1F 0A            [ 2]  200 	ldw	(0x0a, sp), x
      008C8A 1E 0A            [ 2]  201 	ldw	x, (0x0a, sp)
      008C8C E6 03            [ 1]  202 	ld	a, (0x3, x)
      008C8E 6B 09            [ 1]  203 	ld	(0x09, sp), a
      008C90 E6 02            [ 1]  204 	ld	a, (0x2, x)
      008C92 6B 08            [ 1]  205 	ld	(0x08, sp), a
      008C94 FE               [ 2]  206 	ldw	x, (x)
      008C95 1F 06            [ 2]  207 	ldw	(0x06, sp), x
      008C97 CE 00 2A         [ 2]  208 	ldw	x, _timeTickMs+2
      008C9A 72 F0 08         [ 2]  209 	subw	x, (0x08, sp)
      008C9D C6 00 29         [ 1]  210 	ld	a, _timeTickMs+1
      008CA0 12 07            [ 1]  211 	sbc	a, (0x07, sp)
      008CA2 88               [ 1]  212 	push	a
      008CA3 C6 00 28         [ 1]  213 	ld	a, _timeTickMs+0
      008CA6 12 07            [ 1]  214 	sbc	a, (0x07, sp)
      008CA8 6B 03            [ 1]  215 	ld	(0x03, sp), a
      008CAA 84               [ 1]  216 	pop	a
      008CAB 88               [ 1]  217 	push	a
      008CAC 13 13            [ 2]  218 	cpw	x, (0x13, sp)
      008CAE 84               [ 1]  219 	pop	a
      008CAF 12 11            [ 1]  220 	sbc	a, (0x11, sp)
      008CB1 7B 02            [ 1]  221 	ld	a, (0x02, sp)
      008CB3 12 10            [ 1]  222 	sbc	a, (0x10, sp)
      008CB5 4F               [ 1]  223 	clr	a
      008CB6 49               [ 1]  224 	rlc	a
      008CB7 6B 01            [ 1]  225 	ld	(0x01, sp), a
      008CB9 1E 08            [ 2]  226 	ldw	x, (0x08, sp)
      008CBB C3 00 2A         [ 2]  227 	cpw	x, _timeTickMs+2
      008CBE 7B 07            [ 1]  228 	ld	a, (0x07, sp)
      008CC0 C2 00 29         [ 1]  229 	sbc	a, _timeTickMs+1
      008CC3 7B 06            [ 1]  230 	ld	a, (0x06, sp)
      008CC5 C2 00 28         [ 1]  231 	sbc	a, _timeTickMs+0
      008CC8 24 04            [ 1]  232 	jrnc	00105$
      008CCA 0D 01            [ 1]  233 	tnz	(0x01, sp)
      008CCC 27 15            [ 1]  234 	jreq	00101$
      008CCE                        235 00105$:
      008CCE CE 00 2A         [ 2]  236 	ldw	x, _timeTickMs+2
      008CD1 13 08            [ 2]  237 	cpw	x, (0x08, sp)
      008CD3 C6 00 29         [ 1]  238 	ld	a, _timeTickMs+1
      008CD6 12 07            [ 1]  239 	sbc	a, (0x07, sp)
      008CD8 C6 00 28         [ 1]  240 	ld	a, _timeTickMs+0
      008CDB 12 06            [ 1]  241 	sbc	a, (0x06, sp)
      008CDD 24 14            [ 1]  242 	jrnc	00102$
      008CDF 0D 01            [ 1]  243 	tnz	(0x01, sp)
      008CE1 26 10            [ 1]  244 	jrne	00102$
      008CE3                        245 00101$:
                                    246 ;	user/timerTick.c: 57: pTime->timeMS = timeTickMs;
      008CE3 1E 0A            [ 2]  247 	ldw	x, (0x0a, sp)
      008CE5 90 CE 00 2A      [ 2]  248 	ldw	y, _timeTickMs+2
      008CE9 EF 02            [ 2]  249 	ldw	(0x2, x), y
      008CEB 90 CE 00 28      [ 2]  250 	ldw	y, _timeTickMs+0
      008CEF FF               [ 2]  251 	ldw	(x), y
                                    252 ;	user/timerTick.c: 58: return 0;
      008CF0 4F               [ 1]  253 	clr	a
      008CF1 20 02            [ 2]  254 	jra	00106$
      008CF3                        255 00102$:
                                    256 ;	user/timerTick.c: 60: return 1;
      008CF3 A6 01            [ 1]  257 	ld	a, #0x01
      008CF5                        258 00106$:
      008CF5 5B 0B            [ 2]  259 	addw	sp, #11
      008CF7 81               [ 4]  260 	ret
                                    261 	.area CODE
                                    262 	.area INITIALIZER
                                    263 	.area CABS (ABS)
