                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.6.0 #9615 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module i2c_drv
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _TIMER_CheckTimeUS
                                     12 	.globl _TIMER_InitTime
                                     13 	.globl _GPIO_ReadInputPin
                                     14 	.globl _GPIO_WriteLow
                                     15 	.globl _GPIO_WriteHigh
                                     16 	.globl _GPIO_Init
                                     17 	.globl _softI2cTime
                                     18 	.globl _SoftI2CInit
                                     19 	.globl _SoftI2CStart
                                     20 	.globl _SoftI2CStop
                                     21 	.globl _SoftI2CWriteByte
                                     22 	.globl _SoftI2CReadByte
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DATA
      000011                         27 _softI2cTime::
      000011                         28 	.ds 6
                                     29 ;--------------------------------------------------------
                                     30 ; ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area INITIALIZED
                                     33 ;--------------------------------------------------------
                                     34 ; absolute external ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area DABS (ABS)
                                     37 ;--------------------------------------------------------
                                     38 ; global & static initialisations
                                     39 ;--------------------------------------------------------
                                     40 	.area HOME
                                     41 	.area GSINIT
                                     42 	.area GSFINAL
                                     43 	.area GSINIT
                                     44 ;--------------------------------------------------------
                                     45 ; Home
                                     46 ;--------------------------------------------------------
                                     47 	.area HOME
                                     48 	.area HOME
                                     49 ;--------------------------------------------------------
                                     50 ; code
                                     51 ;--------------------------------------------------------
                                     52 	.area CODE
                                     53 ;	user/i2c_drv.c: 8: void SoftI2CInit()
                                     54 ;	-----------------------------------------
                                     55 ;	 function SoftI2CInit
                                     56 ;	-----------------------------------------
      0084CA                         57 _SoftI2CInit:
                                     58 ;	user/i2c_drv.c: 10: SOFT_I2C_SDA_OUT;
      0084CA 4B B0            [ 1]   59 	push	#0xb0
      0084CC 4B 20            [ 1]   60 	push	#0x20
      0084CE 4B 05            [ 1]   61 	push	#0x05
      0084D0 4B 50            [ 1]   62 	push	#0x50
      0084D2 CD 8E 4E         [ 4]   63 	call	_GPIO_Init
      0084D5 5B 04            [ 2]   64 	addw	sp, #4
                                     65 ;	user/i2c_drv.c: 11: SOFT_I2C_SCL_OUT;
      0084D7 4B B0            [ 1]   66 	push	#0xb0
      0084D9 4B 10            [ 1]   67 	push	#0x10
      0084DB 4B 05            [ 1]   68 	push	#0x05
      0084DD 4B 50            [ 1]   69 	push	#0x50
      0084DF CD 8E 4E         [ 4]   70 	call	_GPIO_Init
      0084E2 5B 04            [ 2]   71 	addw	sp, #4
                                     72 ;	user/i2c_drv.c: 13: SOFT_I2C_SDA_HIGH;
      0084E4 4B 20            [ 1]   73 	push	#0x20
      0084E6 4B 05            [ 1]   74 	push	#0x05
      0084E8 4B 50            [ 1]   75 	push	#0x50
      0084EA CD 8E CC         [ 4]   76 	call	_GPIO_WriteHigh
      0084ED 5B 03            [ 2]   77 	addw	sp, #3
                                     78 ;	user/i2c_drv.c: 14: SOFT_I2C_SCL_HIGH;      
      0084EF 4B 10            [ 1]   79 	push	#0x10
      0084F1 4B 05            [ 1]   80 	push	#0x05
      0084F3 4B 50            [ 1]   81 	push	#0x50
      0084F5 CD 8E CC         [ 4]   82 	call	_GPIO_WriteHigh
      0084F8 5B 03            [ 2]   83 	addw	sp, #3
                                     84 ;	user/i2c_drv.c: 15: TIMER_InitTime(&softI2cTime);
      0084FA AE 00 11         [ 2]   85 	ldw	x, #_softI2cTime+0
      0084FD 89               [ 2]   86 	pushw	x
      0084FE CD 8C 2B         [ 4]   87 	call	_TIMER_InitTime
      008501 85               [ 2]   88 	popw	x
      008502 81               [ 4]   89 	ret
                                     90 ;	user/i2c_drv.c: 18: void SoftI2CStart()
                                     91 ;	-----------------------------------------
                                     92 ;	 function SoftI2CStart
                                     93 ;	-----------------------------------------
      008503                         94 _SoftI2CStart:
      008503 52 04            [ 2]   95 	sub	sp, #4
                                     96 ;	user/i2c_drv.c: 20: SOFT_I2C_SCL_HIGH;
      008505 4B 10            [ 1]   97 	push	#0x10
      008507 4B 05            [ 1]   98 	push	#0x05
      008509 4B 50            [ 1]   99 	push	#0x50
      00850B CD 8E CC         [ 4]  100 	call	_GPIO_WriteHigh
      00850E 5B 03            [ 2]  101 	addw	sp, #3
                                    102 ;	user/i2c_drv.c: 21: H_DEL;
      008510 AE 00 11         [ 2]  103 	ldw	x, #_softI2cTime+0
      008513 1F 03            [ 2]  104 	ldw	(0x03, sp), x
      008515                        105 00101$:
      008515 1E 03            [ 2]  106 	ldw	x, (0x03, sp)
      008517 4B 32            [ 1]  107 	push	#0x32
      008519 4B 00            [ 1]  108 	push	#0x00
      00851B 89               [ 2]  109 	pushw	x
      00851C CD 8C 3B         [ 4]  110 	call	_TIMER_CheckTimeUS
      00851F 5B 04            [ 2]  111 	addw	sp, #4
      008521 4D               [ 1]  112 	tnz	a
      008522 26 F1            [ 1]  113 	jrne	00101$
                                    114 ;	user/i2c_drv.c: 23: SOFT_I2C_SDA_LOW;   
      008524 4B 20            [ 1]  115 	push	#0x20
      008526 4B 05            [ 1]  116 	push	#0x05
      008528 4B 50            [ 1]  117 	push	#0x50
      00852A CD 8E D3         [ 4]  118 	call	_GPIO_WriteLow
      00852D 5B 03            [ 2]  119 	addw	sp, #3
                                    120 ;	user/i2c_drv.c: 24: H_DEL;      
      00852F 16 03            [ 2]  121 	ldw	y, (0x03, sp)
      008531 17 01            [ 2]  122 	ldw	(0x01, sp), y
      008533                        123 00104$:
      008533 1E 01            [ 2]  124 	ldw	x, (0x01, sp)
      008535 4B 32            [ 1]  125 	push	#0x32
      008537 4B 00            [ 1]  126 	push	#0x00
      008539 89               [ 2]  127 	pushw	x
      00853A CD 8C 3B         [ 4]  128 	call	_TIMER_CheckTimeUS
      00853D 5B 04            [ 2]  129 	addw	sp, #4
      00853F 4D               [ 1]  130 	tnz	a
      008540 26 F1            [ 1]  131 	jrne	00104$
      008542 5B 04            [ 2]  132 	addw	sp, #4
      008544 81               [ 4]  133 	ret
                                    134 ;	user/i2c_drv.c: 27: void SoftI2CStop()
                                    135 ;	-----------------------------------------
                                    136 ;	 function SoftI2CStop
                                    137 ;	-----------------------------------------
      008545                        138 _SoftI2CStop:
      008545 52 06            [ 2]  139 	sub	sp, #6
                                    140 ;	user/i2c_drv.c: 29: SOFT_I2C_SDA_LOW;
      008547 4B 20            [ 1]  141 	push	#0x20
      008549 4B 05            [ 1]  142 	push	#0x05
      00854B 4B 50            [ 1]  143 	push	#0x50
      00854D CD 8E D3         [ 4]  144 	call	_GPIO_WriteLow
      008550 5B 03            [ 2]  145 	addw	sp, #3
                                    146 ;	user/i2c_drv.c: 30: H_DEL;
      008552 AE 00 11         [ 2]  147 	ldw	x, #_softI2cTime+0
      008555 1F 01            [ 2]  148 	ldw	(0x01, sp), x
      008557                        149 00101$:
      008557 1E 01            [ 2]  150 	ldw	x, (0x01, sp)
      008559 4B 32            [ 1]  151 	push	#0x32
      00855B 4B 00            [ 1]  152 	push	#0x00
      00855D 89               [ 2]  153 	pushw	x
      00855E CD 8C 3B         [ 4]  154 	call	_TIMER_CheckTimeUS
      008561 5B 04            [ 2]  155 	addw	sp, #4
      008563 4D               [ 1]  156 	tnz	a
      008564 26 F1            [ 1]  157 	jrne	00101$
                                    158 ;	user/i2c_drv.c: 31: SOFT_I2C_SCL_HIGH;
      008566 4B 10            [ 1]  159 	push	#0x10
      008568 4B 05            [ 1]  160 	push	#0x05
      00856A 4B 50            [ 1]  161 	push	#0x50
      00856C CD 8E CC         [ 4]  162 	call	_GPIO_WriteHigh
      00856F 5B 03            [ 2]  163 	addw	sp, #3
                                    164 ;	user/i2c_drv.c: 32: Q_DEL;
      008571 16 01            [ 2]  165 	ldw	y, (0x01, sp)
      008573 17 05            [ 2]  166 	ldw	(0x05, sp), y
      008575                        167 00104$:
      008575 1E 05            [ 2]  168 	ldw	x, (0x05, sp)
      008577 4B 14            [ 1]  169 	push	#0x14
      008579 4B 00            [ 1]  170 	push	#0x00
      00857B 89               [ 2]  171 	pushw	x
      00857C CD 8C 3B         [ 4]  172 	call	_TIMER_CheckTimeUS
      00857F 5B 04            [ 2]  173 	addw	sp, #4
      008581 4D               [ 1]  174 	tnz	a
      008582 26 F1            [ 1]  175 	jrne	00104$
                                    176 ;	user/i2c_drv.c: 33: SOFT_I2C_SDA_HIGH;
      008584 4B 20            [ 1]  177 	push	#0x20
      008586 4B 05            [ 1]  178 	push	#0x05
      008588 4B 50            [ 1]  179 	push	#0x50
      00858A CD 8E CC         [ 4]  180 	call	_GPIO_WriteHigh
      00858D 5B 03            [ 2]  181 	addw	sp, #3
                                    182 ;	user/i2c_drv.c: 34: H_DEL;
      00858F 16 01            [ 2]  183 	ldw	y, (0x01, sp)
      008591 17 03            [ 2]  184 	ldw	(0x03, sp), y
      008593                        185 00107$:
      008593 1E 03            [ 2]  186 	ldw	x, (0x03, sp)
      008595 4B 32            [ 1]  187 	push	#0x32
      008597 4B 00            [ 1]  188 	push	#0x00
      008599 89               [ 2]  189 	pushw	x
      00859A CD 8C 3B         [ 4]  190 	call	_TIMER_CheckTimeUS
      00859D 5B 04            [ 2]  191 	addw	sp, #4
      00859F 4D               [ 1]  192 	tnz	a
      0085A0 26 F1            [ 1]  193 	jrne	00107$
      0085A2 5B 06            [ 2]  194 	addw	sp, #6
      0085A4 81               [ 4]  195 	ret
                                    196 ;	user/i2c_drv.c: 37: uint8_t SoftI2CWriteByte(uint8_t data)
                                    197 ;	-----------------------------------------
                                    198 ;	 function SoftI2CWriteByte
                                    199 ;	-----------------------------------------
      0085A5                        200 _SoftI2CWriteByte:
      0085A5 52 12            [ 2]  201 	sub	sp, #18
                                    202 ;	user/i2c_drv.c: 41: for(i=0;i<8;i++)
      0085A7 AE 00 11         [ 2]  203 	ldw	x, #_softI2cTime+0
      0085AA 1F 11            [ 2]  204 	ldw	(0x11, sp), x
      0085AC 16 11            [ 2]  205 	ldw	y, (0x11, sp)
      0085AE 17 0D            [ 2]  206 	ldw	(0x0d, sp), y
      0085B0 16 11            [ 2]  207 	ldw	y, (0x11, sp)
      0085B2 17 03            [ 2]  208 	ldw	(0x03, sp), y
      0085B4 16 11            [ 2]  209 	ldw	y, (0x11, sp)
      0085B6 17 05            [ 2]  210 	ldw	(0x05, sp), y
      0085B8 0F 02            [ 1]  211 	clr	(0x02, sp)
      0085BA                        212 00129$:
                                    213 ;	user/i2c_drv.c: 43: SOFT_I2C_SCL_LOW;
      0085BA 4B 10            [ 1]  214 	push	#0x10
      0085BC 4B 05            [ 1]  215 	push	#0x05
      0085BE 4B 50            [ 1]  216 	push	#0x50
      0085C0 CD 8E D3         [ 4]  217 	call	_GPIO_WriteLow
      0085C3 5B 03            [ 2]  218 	addw	sp, #3
                                    219 ;	user/i2c_drv.c: 44: Q_DEL;
      0085C5                        220 00101$:
      0085C5 1E 11            [ 2]  221 	ldw	x, (0x11, sp)
      0085C7 4B 14            [ 1]  222 	push	#0x14
      0085C9 4B 00            [ 1]  223 	push	#0x00
      0085CB 89               [ 2]  224 	pushw	x
      0085CC CD 8C 3B         [ 4]  225 	call	_TIMER_CheckTimeUS
      0085CF 5B 04            [ 2]  226 	addw	sp, #4
      0085D1 4D               [ 1]  227 	tnz	a
      0085D2 26 F1            [ 1]  228 	jrne	00101$
                                    229 ;	user/i2c_drv.c: 46: if(data & 0x80)
      0085D4 0D 15            [ 1]  230 	tnz	(0x15, sp)
      0085D6 2A 0D            [ 1]  231 	jrpl	00105$
                                    232 ;	user/i2c_drv.c: 47: SOFT_I2C_SDA_HIGH;
      0085D8 4B 20            [ 1]  233 	push	#0x20
      0085DA 4B 05            [ 1]  234 	push	#0x05
      0085DC 4B 50            [ 1]  235 	push	#0x50
      0085DE CD 8E CC         [ 4]  236 	call	_GPIO_WriteHigh
      0085E1 5B 03            [ 2]  237 	addw	sp, #3
      0085E3 20 0B            [ 2]  238 	jra	00107$
      0085E5                        239 00105$:
                                    240 ;	user/i2c_drv.c: 49: SOFT_I2C_SDA_LOW;        
      0085E5 4B 20            [ 1]  241 	push	#0x20
      0085E7 4B 05            [ 1]  242 	push	#0x05
      0085E9 4B 50            [ 1]  243 	push	#0x50
      0085EB CD 8E D3         [ 4]  244 	call	_GPIO_WriteLow
      0085EE 5B 03            [ 2]  245 	addw	sp, #3
                                    246 ;	user/i2c_drv.c: 50: H_DEL;
      0085F0                        247 00107$:
      0085F0 1E 0D            [ 2]  248 	ldw	x, (0x0d, sp)
      0085F2 4B 32            [ 1]  249 	push	#0x32
      0085F4 4B 00            [ 1]  250 	push	#0x00
      0085F6 89               [ 2]  251 	pushw	x
      0085F7 CD 8C 3B         [ 4]  252 	call	_TIMER_CheckTimeUS
      0085FA 5B 04            [ 2]  253 	addw	sp, #4
      0085FC 4D               [ 1]  254 	tnz	a
      0085FD 26 F1            [ 1]  255 	jrne	00107$
                                    256 ;	user/i2c_drv.c: 52: SOFT_I2C_SCL_HIGH;
      0085FF 4B 10            [ 1]  257 	push	#0x10
      008601 4B 05            [ 1]  258 	push	#0x05
      008603 4B 50            [ 1]  259 	push	#0x50
      008605 CD 8E CC         [ 4]  260 	call	_GPIO_WriteHigh
      008608 5B 03            [ 2]  261 	addw	sp, #3
                                    262 ;	user/i2c_drv.c: 53: H_DEL;
      00860A                        263 00110$:
      00860A 1E 03            [ 2]  264 	ldw	x, (0x03, sp)
      00860C 4B 32            [ 1]  265 	push	#0x32
      00860E 4B 00            [ 1]  266 	push	#0x00
      008610 89               [ 2]  267 	pushw	x
      008611 CD 8C 3B         [ 4]  268 	call	_TIMER_CheckTimeUS
      008614 5B 04            [ 2]  269 	addw	sp, #4
      008616 4D               [ 1]  270 	tnz	a
      008617 26 F1            [ 1]  271 	jrne	00110$
                                    272 ;	user/i2c_drv.c: 59: data=data<<1;
      008619 7B 15            [ 1]  273 	ld	a, (0x15, sp)
      00861B 48               [ 1]  274 	sll	a
      00861C 6B 15            [ 1]  275 	ld	(0x15, sp), a
                                    276 ;	user/i2c_drv.c: 60: Q_DEL;
      00861E                        277 00113$:
      00861E 1E 05            [ 2]  278 	ldw	x, (0x05, sp)
      008620 4B 14            [ 1]  279 	push	#0x14
      008622 4B 00            [ 1]  280 	push	#0x00
      008624 89               [ 2]  281 	pushw	x
      008625 CD 8C 3B         [ 4]  282 	call	_TIMER_CheckTimeUS
      008628 5B 04            [ 2]  283 	addw	sp, #4
      00862A 4D               [ 1]  284 	tnz	a
      00862B 26 F1            [ 1]  285 	jrne	00113$
                                    286 ;	user/i2c_drv.c: 41: for(i=0;i<8;i++)
      00862D 0C 02            [ 1]  287 	inc	(0x02, sp)
      00862F 7B 02            [ 1]  288 	ld	a, (0x02, sp)
      008631 A1 08            [ 1]  289 	cp	a, #0x08
      008633 25 85            [ 1]  290 	jrc	00129$
                                    291 ;	user/i2c_drv.c: 64: SOFT_I2C_SCL_LOW;
      008635 4B 10            [ 1]  292 	push	#0x10
      008637 4B 05            [ 1]  293 	push	#0x05
      008639 4B 50            [ 1]  294 	push	#0x50
      00863B CD 8E D3         [ 4]  295 	call	_GPIO_WriteLow
      00863E 5B 03            [ 2]  296 	addw	sp, #3
                                    297 ;	user/i2c_drv.c: 65: Q_DEL;
      008640 16 11            [ 2]  298 	ldw	y, (0x11, sp)
      008642 17 0F            [ 2]  299 	ldw	(0x0f, sp), y
      008644                        300 00117$:
      008644 1E 0F            [ 2]  301 	ldw	x, (0x0f, sp)
      008646 4B 14            [ 1]  302 	push	#0x14
      008648 4B 00            [ 1]  303 	push	#0x00
      00864A 89               [ 2]  304 	pushw	x
      00864B CD 8C 3B         [ 4]  305 	call	_TIMER_CheckTimeUS
      00864E 5B 04            [ 2]  306 	addw	sp, #4
      008650 4D               [ 1]  307 	tnz	a
      008651 26 F1            [ 1]  308 	jrne	00117$
                                    309 ;	user/i2c_drv.c: 67: SOFT_I2C_SDA_HIGH;      
      008653 4B 20            [ 1]  310 	push	#0x20
      008655 4B 05            [ 1]  311 	push	#0x05
      008657 4B 50            [ 1]  312 	push	#0x50
      008659 CD 8E CC         [ 4]  313 	call	_GPIO_WriteHigh
      00865C 5B 03            [ 2]  314 	addw	sp, #3
                                    315 ;	user/i2c_drv.c: 68: H_DEL;
      00865E 16 11            [ 2]  316 	ldw	y, (0x11, sp)
      008660 17 0B            [ 2]  317 	ldw	(0x0b, sp), y
      008662                        318 00120$:
      008662 1E 0B            [ 2]  319 	ldw	x, (0x0b, sp)
      008664 4B 32            [ 1]  320 	push	#0x32
      008666 4B 00            [ 1]  321 	push	#0x00
      008668 89               [ 2]  322 	pushw	x
      008669 CD 8C 3B         [ 4]  323 	call	_TIMER_CheckTimeUS
      00866C 5B 04            [ 2]  324 	addw	sp, #4
      00866E 4D               [ 1]  325 	tnz	a
      00866F 26 F1            [ 1]  326 	jrne	00120$
                                    327 ;	user/i2c_drv.c: 70: SOFT_I2C_SCL_HIGH;
      008671 4B 10            [ 1]  328 	push	#0x10
      008673 4B 05            [ 1]  329 	push	#0x05
      008675 4B 50            [ 1]  330 	push	#0x50
      008677 CD 8E CC         [ 4]  331 	call	_GPIO_WriteHigh
      00867A 5B 03            [ 2]  332 	addw	sp, #3
                                    333 ;	user/i2c_drv.c: 71: H_DEL;  
      00867C 16 11            [ 2]  334 	ldw	y, (0x11, sp)
      00867E 17 09            [ 2]  335 	ldw	(0x09, sp), y
      008680                        336 00123$:
      008680 1E 09            [ 2]  337 	ldw	x, (0x09, sp)
      008682 4B 32            [ 1]  338 	push	#0x32
      008684 4B 00            [ 1]  339 	push	#0x00
      008686 89               [ 2]  340 	pushw	x
      008687 CD 8C 3B         [ 4]  341 	call	_TIMER_CheckTimeUS
      00868A 5B 04            [ 2]  342 	addw	sp, #4
      00868C 4D               [ 1]  343 	tnz	a
      00868D 26 F1            [ 1]  344 	jrne	00123$
                                    345 ;	user/i2c_drv.c: 73: SOFT_I2C_SDA_IN;
      00868F 4B 00            [ 1]  346 	push	#0x00
      008691 4B 20            [ 1]  347 	push	#0x20
      008693 4B 05            [ 1]  348 	push	#0x05
      008695 4B 50            [ 1]  349 	push	#0x50
      008697 CD 8E 4E         [ 4]  350 	call	_GPIO_Init
      00869A 5B 04            [ 2]  351 	addw	sp, #4
                                    352 ;	user/i2c_drv.c: 74: ack=!(SOFT_I2C_SDA_PIN & (1<<SOFT_SDA));
      00869C 4B 20            [ 1]  353 	push	#0x20
      00869E 4B 05            [ 1]  354 	push	#0x05
      0086A0 4B 50            [ 1]  355 	push	#0x50
      0086A2 CD 8E F1         [ 4]  356 	call	_GPIO_ReadInputPin
      0086A5 5B 03            [ 2]  357 	addw	sp, #3
      0086A7 44               [ 1]  358 	srl	a
      0086A8 44               [ 1]  359 	srl	a
      0086A9 A4 01            [ 1]  360 	and	a, #0x01
      0086AB A0 01            [ 1]  361 	sub	a, #0x01
      0086AD 4F               [ 1]  362 	clr	a
      0086AE 49               [ 1]  363 	rlc	a
      0086AF 6B 01            [ 1]  364 	ld	(0x01, sp), a
                                    365 ;	user/i2c_drv.c: 75: SOFT_I2C_SDA_OUT;
      0086B1 4B B0            [ 1]  366 	push	#0xb0
      0086B3 4B 20            [ 1]  367 	push	#0x20
      0086B5 4B 05            [ 1]  368 	push	#0x05
      0086B7 4B 50            [ 1]  369 	push	#0x50
      0086B9 CD 8E 4E         [ 4]  370 	call	_GPIO_Init
      0086BC 5B 04            [ 2]  371 	addw	sp, #4
                                    372 ;	user/i2c_drv.c: 77: SOFT_I2C_SCL_LOW;
      0086BE 4B 10            [ 1]  373 	push	#0x10
      0086C0 4B 05            [ 1]  374 	push	#0x05
      0086C2 4B 50            [ 1]  375 	push	#0x50
      0086C4 CD 8E D3         [ 4]  376 	call	_GPIO_WriteLow
      0086C7 5B 03            [ 2]  377 	addw	sp, #3
                                    378 ;	user/i2c_drv.c: 78: H_DEL;
      0086C9 16 11            [ 2]  379 	ldw	y, (0x11, sp)
      0086CB 17 07            [ 2]  380 	ldw	(0x07, sp), y
      0086CD                        381 00126$:
      0086CD 1E 07            [ 2]  382 	ldw	x, (0x07, sp)
      0086CF 4B 32            [ 1]  383 	push	#0x32
      0086D1 4B 00            [ 1]  384 	push	#0x00
      0086D3 89               [ 2]  385 	pushw	x
      0086D4 CD 8C 3B         [ 4]  386 	call	_TIMER_CheckTimeUS
      0086D7 5B 04            [ 2]  387 	addw	sp, #4
      0086D9 4D               [ 1]  388 	tnz	a
      0086DA 26 F1            [ 1]  389 	jrne	00126$
                                    390 ;	user/i2c_drv.c: 80: return ack;   
      0086DC 7B 01            [ 1]  391 	ld	a, (0x01, sp)
      0086DE 5B 12            [ 2]  392 	addw	sp, #18
      0086E0 81               [ 4]  393 	ret
                                    394 ;	user/i2c_drv.c: 83: uint8_t SoftI2CReadByte(uint8_t ack)
                                    395 ;	-----------------------------------------
                                    396 ;	 function SoftI2CReadByte
                                    397 ;	-----------------------------------------
      0086E1                        398 _SoftI2CReadByte:
      0086E1 52 12            [ 2]  399 	sub	sp, #18
                                    400 ;	user/i2c_drv.c: 85: uint8_t data=0x00;
      0086E3 0F 02            [ 1]  401 	clr	(0x02, sp)
                                    402 ;	user/i2c_drv.c: 87: SOFT_I2C_SDA_IN;
      0086E5 4B 00            [ 1]  403 	push	#0x00
      0086E7 4B 20            [ 1]  404 	push	#0x20
      0086E9 4B 05            [ 1]  405 	push	#0x05
      0086EB 4B 50            [ 1]  406 	push	#0x50
      0086ED CD 8E 4E         [ 4]  407 	call	_GPIO_Init
      0086F0 5B 04            [ 2]  408 	addw	sp, #4
                                    409 ;	user/i2c_drv.c: 88: for(i=0;i<8;i++)
      0086F2 AE 00 11         [ 2]  410 	ldw	x, #_softI2cTime+0
      0086F5 1F 11            [ 2]  411 	ldw	(0x11, sp), x
      0086F7 16 11            [ 2]  412 	ldw	y, (0x11, sp)
      0086F9 17 0F            [ 2]  413 	ldw	(0x0f, sp), y
      0086FB 16 11            [ 2]  414 	ldw	y, (0x11, sp)
      0086FD 17 0D            [ 2]  415 	ldw	(0x0d, sp), y
      0086FF 0F 01            [ 1]  416 	clr	(0x01, sp)
      008701                        417 00128$:
                                    418 ;	user/i2c_drv.c: 90: SOFT_I2C_SCL_LOW;
      008701 4B 10            [ 1]  419 	push	#0x10
      008703 4B 05            [ 1]  420 	push	#0x05
      008705 4B 50            [ 1]  421 	push	#0x50
      008707 CD 8E D3         [ 4]  422 	call	_GPIO_WriteLow
      00870A 5B 03            [ 2]  423 	addw	sp, #3
                                    424 ;	user/i2c_drv.c: 91: H_DEL;
      00870C                        425 00101$:
      00870C 16 11            [ 2]  426 	ldw	y, (0x11, sp)
      00870E 17 0B            [ 2]  427 	ldw	(0x0b, sp), y
      008710 4B 32            [ 1]  428 	push	#0x32
      008712 4B 00            [ 1]  429 	push	#0x00
      008714 1E 0D            [ 2]  430 	ldw	x, (0x0d, sp)
      008716 89               [ 2]  431 	pushw	x
      008717 CD 8C 3B         [ 4]  432 	call	_TIMER_CheckTimeUS
      00871A 5B 04            [ 2]  433 	addw	sp, #4
      00871C 4D               [ 1]  434 	tnz	a
      00871D 26 ED            [ 1]  435 	jrne	00101$
                                    436 ;	user/i2c_drv.c: 92: SOFT_I2C_SCL_HIGH;
      00871F 4B 10            [ 1]  437 	push	#0x10
      008721 4B 05            [ 1]  438 	push	#0x05
      008723 4B 50            [ 1]  439 	push	#0x50
      008725 CD 8E CC         [ 4]  440 	call	_GPIO_WriteHigh
      008728 5B 03            [ 2]  441 	addw	sp, #3
                                    442 ;	user/i2c_drv.c: 93: H_DEL;
      00872A                        443 00104$:
      00872A 1E 0F            [ 2]  444 	ldw	x, (0x0f, sp)
      00872C 4B 32            [ 1]  445 	push	#0x32
      00872E 4B 00            [ 1]  446 	push	#0x00
      008730 89               [ 2]  447 	pushw	x
      008731 CD 8C 3B         [ 4]  448 	call	_TIMER_CheckTimeUS
      008734 5B 04            [ 2]  449 	addw	sp, #4
      008736 4D               [ 1]  450 	tnz	a
      008737 26 F1            [ 1]  451 	jrne	00104$
                                    452 ;	user/i2c_drv.c: 98: if(SOFT_I2C_SDA_PIN &(1<<SOFT_SDA))
      008739 4B 20            [ 1]  453 	push	#0x20
      00873B 4B 05            [ 1]  454 	push	#0x05
      00873D 4B 50            [ 1]  455 	push	#0x50
      00873F CD 8E F1         [ 4]  456 	call	_GPIO_ReadInputPin
      008742 5B 03            [ 2]  457 	addw	sp, #3
      008744 A5 04            [ 1]  458 	bcp	a, #0x04
      008746 27 11            [ 1]  459 	jreq	00109$
                                    460 ;	user/i2c_drv.c: 99: data|=(0x80>>i);    
      008748 A6 80            [ 1]  461 	ld	a, #0x80
      00874A 88               [ 1]  462 	push	a
      00874B 7B 02            [ 1]  463 	ld	a, (0x02, sp)
      00874D 27 05            [ 1]  464 	jreq	00209$
      00874F                        465 00208$:
      00874F 04 01            [ 1]  466 	srl	(1, sp)
      008751 4A               [ 1]  467 	dec	a
      008752 26 FB            [ 1]  468 	jrne	00208$
      008754                        469 00209$:
      008754 84               [ 1]  470 	pop	a
      008755 1A 02            [ 1]  471 	or	a, (0x02, sp)
      008757 6B 02            [ 1]  472 	ld	(0x02, sp), a
                                    473 ;	user/i2c_drv.c: 101: Q_DEL;
      008759                        474 00109$:
      008759 1E 0D            [ 2]  475 	ldw	x, (0x0d, sp)
      00875B 4B 14            [ 1]  476 	push	#0x14
      00875D 4B 00            [ 1]  477 	push	#0x00
      00875F 89               [ 2]  478 	pushw	x
      008760 CD 8C 3B         [ 4]  479 	call	_TIMER_CheckTimeUS
      008763 5B 04            [ 2]  480 	addw	sp, #4
      008765 4D               [ 1]  481 	tnz	a
      008766 26 F1            [ 1]  482 	jrne	00109$
                                    483 ;	user/i2c_drv.c: 88: for(i=0;i<8;i++)
      008768 0C 01            [ 1]  484 	inc	(0x01, sp)
      00876A 7B 01            [ 1]  485 	ld	a, (0x01, sp)
      00876C A1 08            [ 1]  486 	cp	a, #0x08
      00876E 25 91            [ 1]  487 	jrc	00128$
                                    488 ;	user/i2c_drv.c: 103: SOFT_I2C_SDA_OUT;
      008770 4B B0            [ 1]  489 	push	#0xb0
      008772 4B 20            [ 1]  490 	push	#0x20
      008774 4B 05            [ 1]  491 	push	#0x05
      008776 4B 50            [ 1]  492 	push	#0x50
      008778 CD 8E 4E         [ 4]  493 	call	_GPIO_Init
      00877B 5B 04            [ 2]  494 	addw	sp, #4
                                    495 ;	user/i2c_drv.c: 104: SOFT_I2C_SCL_LOW;
      00877D 4B 10            [ 1]  496 	push	#0x10
      00877F 4B 05            [ 1]  497 	push	#0x05
      008781 4B 50            [ 1]  498 	push	#0x50
      008783 CD 8E D3         [ 4]  499 	call	_GPIO_WriteLow
      008786 5B 03            [ 2]  500 	addw	sp, #3
                                    501 ;	user/i2c_drv.c: 105: Q_DEL;                      //Soft_I2C_Put_Ack  
      008788 16 11            [ 2]  502 	ldw	y, (0x11, sp)
      00878A 17 09            [ 2]  503 	ldw	(0x09, sp), y
      00878C                        504 00113$:
      00878C 1E 09            [ 2]  505 	ldw	x, (0x09, sp)
      00878E 4B 14            [ 1]  506 	push	#0x14
      008790 4B 00            [ 1]  507 	push	#0x00
      008792 89               [ 2]  508 	pushw	x
      008793 CD 8C 3B         [ 4]  509 	call	_TIMER_CheckTimeUS
      008796 5B 04            [ 2]  510 	addw	sp, #4
      008798 4D               [ 1]  511 	tnz	a
      008799 26 F1            [ 1]  512 	jrne	00113$
                                    513 ;	user/i2c_drv.c: 106: if(ack)
      00879B 0D 15            [ 1]  514 	tnz	(0x15, sp)
      00879D 27 0D            [ 1]  515 	jreq	00117$
                                    516 ;	user/i2c_drv.c: 108: SOFT_I2C_SDA_LOW;   
      00879F 4B 20            [ 1]  517 	push	#0x20
      0087A1 4B 05            [ 1]  518 	push	#0x05
      0087A3 4B 50            [ 1]  519 	push	#0x50
      0087A5 CD 8E D3         [ 4]  520 	call	_GPIO_WriteLow
      0087A8 5B 03            [ 2]  521 	addw	sp, #3
      0087AA 20 0B            [ 2]  522 	jra	00144$
      0087AC                        523 00117$:
                                    524 ;	user/i2c_drv.c: 112: SOFT_I2C_SDA_HIGH;
      0087AC 4B 20            [ 1]  525 	push	#0x20
      0087AE 4B 05            [ 1]  526 	push	#0x05
      0087B0 4B 50            [ 1]  527 	push	#0x50
      0087B2 CD 8E CC         [ 4]  528 	call	_GPIO_WriteHigh
      0087B5 5B 03            [ 2]  529 	addw	sp, #3
                                    530 ;	user/i2c_drv.c: 114: H_DEL;   
      0087B7                        531 00144$:
      0087B7 16 11            [ 2]  532 	ldw	y, (0x11, sp)
      0087B9 17 07            [ 2]  533 	ldw	(0x07, sp), y
      0087BB                        534 00119$:
      0087BB 1E 07            [ 2]  535 	ldw	x, (0x07, sp)
      0087BD 4B 32            [ 1]  536 	push	#0x32
      0087BF 4B 00            [ 1]  537 	push	#0x00
      0087C1 89               [ 2]  538 	pushw	x
      0087C2 CD 8C 3B         [ 4]  539 	call	_TIMER_CheckTimeUS
      0087C5 5B 04            [ 2]  540 	addw	sp, #4
      0087C7 4D               [ 1]  541 	tnz	a
      0087C8 26 F1            [ 1]  542 	jrne	00119$
                                    543 ;	user/i2c_drv.c: 115: SOFT_I2C_SCL_HIGH;
      0087CA 4B 10            [ 1]  544 	push	#0x10
      0087CC 4B 05            [ 1]  545 	push	#0x05
      0087CE 4B 50            [ 1]  546 	push	#0x50
      0087D0 CD 8E CC         [ 4]  547 	call	_GPIO_WriteHigh
      0087D3 5B 03            [ 2]  548 	addw	sp, #3
                                    549 ;	user/i2c_drv.c: 116: H_DEL;   
      0087D5 16 11            [ 2]  550 	ldw	y, (0x11, sp)
      0087D7 17 05            [ 2]  551 	ldw	(0x05, sp), y
      0087D9                        552 00122$:
      0087D9 1E 05            [ 2]  553 	ldw	x, (0x05, sp)
      0087DB 4B 32            [ 1]  554 	push	#0x32
      0087DD 4B 00            [ 1]  555 	push	#0x00
      0087DF 89               [ 2]  556 	pushw	x
      0087E0 CD 8C 3B         [ 4]  557 	call	_TIMER_CheckTimeUS
      0087E3 5B 04            [ 2]  558 	addw	sp, #4
      0087E5 4D               [ 1]  559 	tnz	a
      0087E6 26 F1            [ 1]  560 	jrne	00122$
                                    561 ;	user/i2c_drv.c: 117: SOFT_I2C_SCL_LOW;
      0087E8 4B 10            [ 1]  562 	push	#0x10
      0087EA 4B 05            [ 1]  563 	push	#0x05
      0087EC 4B 50            [ 1]  564 	push	#0x50
      0087EE CD 8E D3         [ 4]  565 	call	_GPIO_WriteLow
      0087F1 5B 03            [ 2]  566 	addw	sp, #3
                                    567 ;	user/i2c_drv.c: 118: H_DEL;           
      0087F3 16 11            [ 2]  568 	ldw	y, (0x11, sp)
      0087F5 17 03            [ 2]  569 	ldw	(0x03, sp), y
      0087F7                        570 00125$:
      0087F7 1E 03            [ 2]  571 	ldw	x, (0x03, sp)
      0087F9 4B 32            [ 1]  572 	push	#0x32
      0087FB 4B 00            [ 1]  573 	push	#0x00
      0087FD 89               [ 2]  574 	pushw	x
      0087FE CD 8C 3B         [ 4]  575 	call	_TIMER_CheckTimeUS
      008801 5B 04            [ 2]  576 	addw	sp, #4
      008803 4D               [ 1]  577 	tnz	a
      008804 26 F1            [ 1]  578 	jrne	00125$
                                    579 ;	user/i2c_drv.c: 119: return data;  
      008806 7B 02            [ 1]  580 	ld	a, (0x02, sp)
      008808 5B 12            [ 2]  581 	addw	sp, #18
      00880A 81               [ 4]  582 	ret
                                    583 	.area CODE
                                    584 	.area INITIALIZER
                                    585 	.area CABS (ABS)
