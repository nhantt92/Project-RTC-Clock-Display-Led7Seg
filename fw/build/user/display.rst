                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.6.0 #9615 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module display
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _code7Seg
                                     12 	.globl _offLed
                                     13 	.globl _onLed
                                     14 	.globl _writeBuffer
                                     15 	.globl _memset
                                     16 	.globl _GPIO_WriteLow
                                     17 	.globl _GPIO_WriteHigh
                                     18 	.globl _GPIO_Init
                                     19 	.globl _display
                                     20 	.globl _displayInit
                                     21 	.globl _shiftOut595
                                     22 	.globl _latch595
                                     23 	.globl _clear595
                                     24 	.globl _screen
                                     25 	.globl _setDigit
                                     26 	.globl _display_test
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DATA
      000001                         31 _display::
      000001                         32 	.ds 16
                                     33 ;--------------------------------------------------------
                                     34 ; ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area INITIALIZED
                                     37 ;--------------------------------------------------------
                                     38 ; absolute external ram data
                                     39 ;--------------------------------------------------------
                                     40 	.area DABS (ABS)
                                     41 ;--------------------------------------------------------
                                     42 ; global & static initialisations
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area GSINIT
                                     46 	.area GSFINAL
                                     47 	.area GSINIT
                                     48 ;--------------------------------------------------------
                                     49 ; Home
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
                                     52 	.area HOME
                                     53 ;--------------------------------------------------------
                                     54 ; code
                                     55 ;--------------------------------------------------------
                                     56 	.area CODE
                                     57 ;	user/display.c: 8: static void delay_us(uint16_t x)
                                     58 ;	-----------------------------------------
                                     59 ;	 function delay_us
                                     60 ;	-----------------------------------------
      0080A0                         61 _delay_us:
      0080A0 89               [ 2]   62 	pushw	x
                                     63 ;	user/display.c: 10: while(x--);
      0080A1 1E 05            [ 2]   64 	ldw	x, (0x05, sp)
      0080A3                         65 00101$:
      0080A3 1F 01            [ 2]   66 	ldw	(0x01, sp), x
      0080A5 5A               [ 2]   67 	decw	x
      0080A6 16 01            [ 2]   68 	ldw	y, (0x01, sp)
      0080A8 26 F9            [ 1]   69 	jrne	00101$
      0080AA 85               [ 2]   70 	popw	x
      0080AB 81               [ 4]   71 	ret
                                     72 ;	user/display.c: 13: void displayInit(GPIO_TypeDef* portData, GPIO_TypeDef* portScan, uint8_t data, uint8_t clk, uint8_t lat, uint8_t clr, uint8_t led1, uint8_t led2, uint8_t led3, uint8_t led4)
                                     73 ;	-----------------------------------------
                                     74 ;	 function displayInit
                                     75 ;	-----------------------------------------
      0080AC                         76 _displayInit:
      0080AC 52 10            [ 2]   77 	sub	sp, #16
                                     78 ;	user/display.c: 15: display.portData = portData;
      0080AE AE 00 01         [ 2]   79 	ldw	x, #_display+0
      0080B1 16 13            [ 2]   80 	ldw	y, (0x13, sp)
      0080B3 FF               [ 2]   81 	ldw	(x), y
                                     82 ;	user/display.c: 16: display.portScan = portScan;
      0080B4 AE 00 01         [ 2]   83 	ldw	x, #_display+0
      0080B7 1F 0F            [ 2]   84 	ldw	(0x0f, sp), x
      0080B9 1E 0F            [ 2]   85 	ldw	x, (0x0f, sp)
      0080BB 5C               [ 2]   86 	incw	x
      0080BC 5C               [ 2]   87 	incw	x
      0080BD 1F 0D            [ 2]   88 	ldw	(0x0d, sp), x
      0080BF 1E 0D            [ 2]   89 	ldw	x, (0x0d, sp)
      0080C1 16 15            [ 2]   90 	ldw	y, (0x15, sp)
      0080C3 FF               [ 2]   91 	ldw	(x), y
                                     92 ;	user/display.c: 17: display.data = data;
      0080C4 1E 0F            [ 2]   93 	ldw	x, (0x0f, sp)
      0080C6 7B 17            [ 1]   94 	ld	a, (0x17, sp)
      0080C8 E7 04            [ 1]   95 	ld	(0x0004, x), a
                                     96 ;	user/display.c: 18: display.clk = clk;
      0080CA 1E 0F            [ 2]   97 	ldw	x, (0x0f, sp)
      0080CC 7B 18            [ 1]   98 	ld	a, (0x18, sp)
      0080CE E7 05            [ 1]   99 	ld	(0x0005, x), a
                                    100 ;	user/display.c: 19: display.lat = lat;
      0080D0 1E 0F            [ 2]  101 	ldw	x, (0x0f, sp)
      0080D2 7B 19            [ 1]  102 	ld	a, (0x19, sp)
      0080D4 E7 06            [ 1]  103 	ld	(0x0006, x), a
                                    104 ;	user/display.c: 20: display.clr = clr;
      0080D6 1E 0F            [ 2]  105 	ldw	x, (0x0f, sp)
      0080D8 1C 00 07         [ 2]  106 	addw	x, #0x0007
      0080DB 1F 0B            [ 2]  107 	ldw	(0x0b, sp), x
      0080DD 1E 0B            [ 2]  108 	ldw	x, (0x0b, sp)
      0080DF 7B 1A            [ 1]  109 	ld	a, (0x1a, sp)
      0080E1 F7               [ 1]  110 	ld	(x), a
                                    111 ;	user/display.c: 21: display.led[0] = led1;
      0080E2 1E 0F            [ 2]  112 	ldw	x, (0x0f, sp)
      0080E4 1C 00 08         [ 2]  113 	addw	x, #0x0008
      0080E7 1F 09            [ 2]  114 	ldw	(0x09, sp), x
      0080E9 1E 09            [ 2]  115 	ldw	x, (0x09, sp)
      0080EB 7B 1B            [ 1]  116 	ld	a, (0x1b, sp)
      0080ED F7               [ 1]  117 	ld	(x), a
                                    118 ;	user/display.c: 22: display.led[1] = led2;
      0080EE 1E 0F            [ 2]  119 	ldw	x, (0x0f, sp)
      0080F0 1C 00 09         [ 2]  120 	addw	x, #0x0009
      0080F3 1F 07            [ 2]  121 	ldw	(0x07, sp), x
      0080F5 1E 07            [ 2]  122 	ldw	x, (0x07, sp)
      0080F7 7B 1C            [ 1]  123 	ld	a, (0x1c, sp)
      0080F9 F7               [ 1]  124 	ld	(x), a
                                    125 ;	user/display.c: 23: display.led[2] = led3;
      0080FA 1E 0F            [ 2]  126 	ldw	x, (0x0f, sp)
      0080FC 1C 00 0A         [ 2]  127 	addw	x, #0x000a
      0080FF 1F 05            [ 2]  128 	ldw	(0x05, sp), x
      008101 1E 05            [ 2]  129 	ldw	x, (0x05, sp)
      008103 7B 1D            [ 1]  130 	ld	a, (0x1d, sp)
      008105 F7               [ 1]  131 	ld	(x), a
                                    132 ;	user/display.c: 24: display.led[3] = led4;
      008106 1E 0F            [ 2]  133 	ldw	x, (0x0f, sp)
      008108 1C 00 0B         [ 2]  134 	addw	x, #0x000b
      00810B 1F 03            [ 2]  135 	ldw	(0x03, sp), x
      00810D 1E 03            [ 2]  136 	ldw	x, (0x03, sp)
      00810F 7B 1E            [ 1]  137 	ld	a, (0x1e, sp)
      008111 F7               [ 1]  138 	ld	(x), a
                                    139 ;	user/display.c: 25: GPIO_Init(display.portData, display.data|display.clk|display.lat|display.clr|display.led[3], GPIO_MODE_OUT_PP_HIGH_FAST);
      008112 7B 17            [ 1]  140 	ld	a, (0x17, sp)
      008114 1A 18            [ 1]  141 	or	a, (0x18, sp)
      008116 1A 19            [ 1]  142 	or	a, (0x19, sp)
      008118 1A 1A            [ 1]  143 	or	a, (0x1a, sp)
      00811A 1A 1E            [ 1]  144 	or	a, (0x1e, sp)
      00811C 1E 0F            [ 2]  145 	ldw	x, (0x0f, sp)
      00811E FE               [ 2]  146 	ldw	x, (x)
      00811F 4B F0            [ 1]  147 	push	#0xf0
      008121 88               [ 1]  148 	push	a
      008122 89               [ 2]  149 	pushw	x
      008123 CD 8E 4E         [ 4]  150 	call	_GPIO_Init
      008126 5B 04            [ 2]  151 	addw	sp, #4
                                    152 ;	user/display.c: 26: GPIO_Init(display.portScan, display.led[0]|display.led[1]|display.led[2], GPIO_MODE_OUT_PP_HIGH_FAST);
      008128 1E 09            [ 2]  153 	ldw	x, (0x09, sp)
      00812A F6               [ 1]  154 	ld	a, (x)
      00812B 6B 02            [ 1]  155 	ld	(0x02, sp), a
      00812D 1E 07            [ 2]  156 	ldw	x, (0x07, sp)
      00812F F6               [ 1]  157 	ld	a, (x)
      008130 1A 02            [ 1]  158 	or	a, (0x02, sp)
      008132 6B 01            [ 1]  159 	ld	(0x01, sp), a
      008134 1E 05            [ 2]  160 	ldw	x, (0x05, sp)
      008136 F6               [ 1]  161 	ld	a, (x)
      008137 1A 01            [ 1]  162 	or	a, (0x01, sp)
      008139 1E 0D            [ 2]  163 	ldw	x, (0x0d, sp)
      00813B FE               [ 2]  164 	ldw	x, (x)
      00813C 4B F0            [ 1]  165 	push	#0xf0
      00813E 88               [ 1]  166 	push	a
      00813F 89               [ 2]  167 	pushw	x
      008140 CD 8E 4E         [ 4]  168 	call	_GPIO_Init
      008143 5B 04            [ 2]  169 	addw	sp, #4
                                    170 ;	user/display.c: 29: GPIO_WriteHigh(display.portData, display.clr);
      008145 1E 0B            [ 2]  171 	ldw	x, (0x0b, sp)
      008147 F6               [ 1]  172 	ld	a, (x)
      008148 1E 0F            [ 2]  173 	ldw	x, (0x0f, sp)
      00814A FE               [ 2]  174 	ldw	x, (x)
      00814B 88               [ 1]  175 	push	a
      00814C 89               [ 2]  176 	pushw	x
      00814D CD 8E CC         [ 4]  177 	call	_GPIO_WriteHigh
      008150 5B 03            [ 2]  178 	addw	sp, #3
                                    179 ;	user/display.c: 30: GPIO_WriteLow(display.portScan, display.led[0]);
      008152 1E 09            [ 2]  180 	ldw	x, (0x09, sp)
      008154 F6               [ 1]  181 	ld	a, (x)
      008155 1E 0D            [ 2]  182 	ldw	x, (0x0d, sp)
      008157 FE               [ 2]  183 	ldw	x, (x)
      008158 88               [ 1]  184 	push	a
      008159 89               [ 2]  185 	pushw	x
      00815A CD 8E D3         [ 4]  186 	call	_GPIO_WriteLow
      00815D 5B 03            [ 2]  187 	addw	sp, #3
                                    188 ;	user/display.c: 31: GPIO_WriteLow(display.portScan, display.led[1]);
      00815F 1E 07            [ 2]  189 	ldw	x, (0x07, sp)
      008161 F6               [ 1]  190 	ld	a, (x)
      008162 1E 0D            [ 2]  191 	ldw	x, (0x0d, sp)
      008164 FE               [ 2]  192 	ldw	x, (x)
      008165 88               [ 1]  193 	push	a
      008166 89               [ 2]  194 	pushw	x
      008167 CD 8E D3         [ 4]  195 	call	_GPIO_WriteLow
      00816A 5B 03            [ 2]  196 	addw	sp, #3
                                    197 ;	user/display.c: 32: GPIO_WriteLow(display.portScan, display.led[2]);
      00816C 1E 05            [ 2]  198 	ldw	x, (0x05, sp)
      00816E F6               [ 1]  199 	ld	a, (x)
      00816F 1E 0D            [ 2]  200 	ldw	x, (0x0d, sp)
      008171 FE               [ 2]  201 	ldw	x, (x)
      008172 88               [ 1]  202 	push	a
      008173 89               [ 2]  203 	pushw	x
      008174 CD 8E D3         [ 4]  204 	call	_GPIO_WriteLow
      008177 5B 03            [ 2]  205 	addw	sp, #3
                                    206 ;	user/display.c: 33: GPIO_WriteLow(display.portData, display.led[3]);
      008179 1E 03            [ 2]  207 	ldw	x, (0x03, sp)
      00817B F6               [ 1]  208 	ld	a, (x)
      00817C 1E 0F            [ 2]  209 	ldw	x, (0x0f, sp)
      00817E FE               [ 2]  210 	ldw	x, (x)
      00817F 88               [ 1]  211 	push	a
      008180 89               [ 2]  212 	pushw	x
      008181 CD 8E D3         [ 4]  213 	call	_GPIO_WriteLow
      008184 5B 03            [ 2]  214 	addw	sp, #3
                                    215 ;	user/display.c: 34: memset(display.buffer, 0x00, sizeof(display.buffer));
      008186 1E 0F            [ 2]  216 	ldw	x, (0x0f, sp)
      008188 1C 00 0C         [ 2]  217 	addw	x, #0x000c
      00818B 4B 04            [ 1]  218 	push	#0x04
      00818D 4B 00            [ 1]  219 	push	#0x00
      00818F 4B 00            [ 1]  220 	push	#0x00
      008191 4B 00            [ 1]  221 	push	#0x00
      008193 89               [ 2]  222 	pushw	x
      008194 CD 96 03         [ 4]  223 	call	_memset
      008197 5B 16            [ 2]  224 	addw	sp, #22
      008199 81               [ 4]  225 	ret
                                    226 ;	user/display.c: 41: void shiftOut595(uint8_t data)
                                    227 ;	-----------------------------------------
                                    228 ;	 function shiftOut595
                                    229 ;	-----------------------------------------
      00819A                        230 _shiftOut595:
      00819A 52 06            [ 2]  231 	sub	sp, #6
                                    232 ;	user/display.c: 44: temp = data;
      00819C 7B 09            [ 1]  233 	ld	a, (0x09, sp)
      00819E 6B 02            [ 1]  234 	ld	(0x02, sp), a
                                    235 ;	user/display.c: 46: for(i = 0; i< 8; i++)
      0081A0 AE 00 01         [ 2]  236 	ldw	x, #_display+0
      0081A3 1F 03            [ 2]  237 	ldw	(0x03, sp), x
      0081A5 1E 03            [ 2]  238 	ldw	x, (0x03, sp)
      0081A7 1C 00 05         [ 2]  239 	addw	x, #0x0005
      0081AA 1F 05            [ 2]  240 	ldw	(0x05, sp), x
      0081AC 0F 01            [ 1]  241 	clr	(0x01, sp)
      0081AE                        242 00105$:
                                    243 ;	user/display.c: 48: GPIO_WriteLow(display.portData, display.clk);
      0081AE 1E 05            [ 2]  244 	ldw	x, (0x05, sp)
      0081B0 F6               [ 1]  245 	ld	a, (x)
      0081B1 1E 03            [ 2]  246 	ldw	x, (0x03, sp)
      0081B3 FE               [ 2]  247 	ldw	x, (x)
      0081B4 88               [ 1]  248 	push	a
      0081B5 89               [ 2]  249 	pushw	x
      0081B6 CD 8E D3         [ 4]  250 	call	_GPIO_WriteLow
      0081B9 5B 03            [ 2]  251 	addw	sp, #3
      0081BB 1E 03            [ 2]  252 	ldw	x, (0x03, sp)
      0081BD FE               [ 2]  253 	ldw	x, (x)
                                    254 ;	user/display.c: 49: if(temp&0x80) GPIO_WriteHigh(display.portData, display.data);
      0081BE 16 03            [ 2]  255 	ldw	y, (0x03, sp)
      0081C0 90 E6 04         [ 1]  256 	ld	a, (0x4, y)
      0081C3 0D 02            [ 1]  257 	tnz	(0x02, sp)
      0081C5 2A 09            [ 1]  258 	jrpl	00102$
      0081C7 88               [ 1]  259 	push	a
      0081C8 89               [ 2]  260 	pushw	x
      0081C9 CD 8E CC         [ 4]  261 	call	_GPIO_WriteHigh
      0081CC 5B 03            [ 2]  262 	addw	sp, #3
      0081CE 20 07            [ 2]  263 	jra	00103$
      0081D0                        264 00102$:
                                    265 ;	user/display.c: 50: else GPIO_WriteLow(display.portData, display.data);
      0081D0 88               [ 1]  266 	push	a
      0081D1 89               [ 2]  267 	pushw	x
      0081D2 CD 8E D3         [ 4]  268 	call	_GPIO_WriteLow
      0081D5 5B 03            [ 2]  269 	addw	sp, #3
      0081D7                        270 00103$:
                                    271 ;	user/display.c: 51: delay_us(5);
      0081D7 4B 05            [ 1]  272 	push	#0x05
      0081D9 4B 00            [ 1]  273 	push	#0x00
      0081DB CD 80 A0         [ 4]  274 	call	_delay_us
      0081DE 85               [ 2]  275 	popw	x
                                    276 ;	user/display.c: 52: GPIO_WriteHigh(display.portData, display.clk);
      0081DF 1E 05            [ 2]  277 	ldw	x, (0x05, sp)
      0081E1 F6               [ 1]  278 	ld	a, (x)
      0081E2 1E 03            [ 2]  279 	ldw	x, (0x03, sp)
      0081E4 FE               [ 2]  280 	ldw	x, (x)
      0081E5 88               [ 1]  281 	push	a
      0081E6 89               [ 2]  282 	pushw	x
      0081E7 CD 8E CC         [ 4]  283 	call	_GPIO_WriteHigh
      0081EA 5B 03            [ 2]  284 	addw	sp, #3
                                    285 ;	user/display.c: 53: temp <<= 1;
      0081EC 08 02            [ 1]  286 	sll	(0x02, sp)
                                    287 ;	user/display.c: 46: for(i = 0; i< 8; i++)
      0081EE 0C 01            [ 1]  288 	inc	(0x01, sp)
      0081F0 7B 01            [ 1]  289 	ld	a, (0x01, sp)
      0081F2 A1 08            [ 1]  290 	cp	a, #0x08
      0081F4 25 B8            [ 1]  291 	jrc	00105$
      0081F6 5B 06            [ 2]  292 	addw	sp, #6
      0081F8 81               [ 4]  293 	ret
                                    294 ;	user/display.c: 57: void latch595(void)
                                    295 ;	-----------------------------------------
                                    296 ;	 function latch595
                                    297 ;	-----------------------------------------
      0081F9                        298 _latch595:
      0081F9 89               [ 2]  299 	pushw	x
                                    300 ;	user/display.c: 59: GPIO_WriteHigh(display.portData, display.lat);
      0081FA AE 00 01         [ 2]  301 	ldw	x, #_display+0
      0081FD 1F 01            [ 2]  302 	ldw	(0x01, sp), x
      0081FF 1E 01            [ 2]  303 	ldw	x, (0x01, sp)
      008201 1C 00 06         [ 2]  304 	addw	x, #0x0006
      008204 F6               [ 1]  305 	ld	a, (x)
      008205 16 01            [ 2]  306 	ldw	y, (0x01, sp)
      008207 90 FE            [ 2]  307 	ldw	y, (y)
      008209 89               [ 2]  308 	pushw	x
      00820A 88               [ 1]  309 	push	a
      00820B 90 89            [ 2]  310 	pushw	y
      00820D CD 8E CC         [ 4]  311 	call	_GPIO_WriteHigh
      008210 5B 03            [ 2]  312 	addw	sp, #3
      008212 85               [ 2]  313 	popw	x
                                    314 ;	user/display.c: 60: GPIO_WriteLow(display.portData, display.lat);
      008213 F6               [ 1]  315 	ld	a, (x)
      008214 1E 01            [ 2]  316 	ldw	x, (0x01, sp)
      008216 FE               [ 2]  317 	ldw	x, (x)
      008217 88               [ 1]  318 	push	a
      008218 89               [ 2]  319 	pushw	x
      008219 CD 8E D3         [ 4]  320 	call	_GPIO_WriteLow
      00821C 5B 03            [ 2]  321 	addw	sp, #3
                                    322 ;	user/display.c: 61: delay_us(5);
      00821E 4B 05            [ 1]  323 	push	#0x05
      008220 4B 00            [ 1]  324 	push	#0x00
      008222 CD 80 A0         [ 4]  325 	call	_delay_us
      008225 5B 04            [ 2]  326 	addw	sp, #4
      008227 81               [ 4]  327 	ret
                                    328 ;	user/display.c: 64: void clear595(void)
                                    329 ;	-----------------------------------------
                                    330 ;	 function clear595
                                    331 ;	-----------------------------------------
      008228                        332 _clear595:
      008228 89               [ 2]  333 	pushw	x
                                    334 ;	user/display.c: 66: GPIO_WriteHigh(display.portData, display.clr);
      008229 AE 00 01         [ 2]  335 	ldw	x, #_display+0
      00822C 1F 01            [ 2]  336 	ldw	(0x01, sp), x
      00822E 1E 01            [ 2]  337 	ldw	x, (0x01, sp)
      008230 1C 00 07         [ 2]  338 	addw	x, #0x0007
      008233 F6               [ 1]  339 	ld	a, (x)
      008234 16 01            [ 2]  340 	ldw	y, (0x01, sp)
      008236 90 FE            [ 2]  341 	ldw	y, (y)
      008238 89               [ 2]  342 	pushw	x
      008239 88               [ 1]  343 	push	a
      00823A 90 89            [ 2]  344 	pushw	y
      00823C CD 8E CC         [ 4]  345 	call	_GPIO_WriteHigh
      00823F 5B 03            [ 2]  346 	addw	sp, #3
      008241 85               [ 2]  347 	popw	x
                                    348 ;	user/display.c: 67: GPIO_WriteLow(display.portData, display.clr);
      008242 F6               [ 1]  349 	ld	a, (x)
      008243 1E 01            [ 2]  350 	ldw	x, (0x01, sp)
      008245 FE               [ 2]  351 	ldw	x, (x)
      008246 88               [ 1]  352 	push	a
      008247 89               [ 2]  353 	pushw	x
      008248 CD 8E D3         [ 4]  354 	call	_GPIO_WriteLow
      00824B 5B 03            [ 2]  355 	addw	sp, #3
                                    356 ;	user/display.c: 68: delay_us(100);
      00824D 4B 64            [ 1]  357 	push	#0x64
      00824F 4B 00            [ 1]  358 	push	#0x00
      008251 CD 80 A0         [ 4]  359 	call	_delay_us
      008254 5B 04            [ 2]  360 	addw	sp, #4
      008256 81               [ 4]  361 	ret
                                    362 ;	user/display.c: 71: void writeBuffer(uint8_t pos)
                                    363 ;	-----------------------------------------
                                    364 ;	 function writeBuffer
                                    365 ;	-----------------------------------------
      008257                        366 _writeBuffer:
      008257 89               [ 2]  367 	pushw	x
                                    368 ;	user/display.c: 73: shiftOut595(display.buffer[pos]);
      008258 AE 00 0D         [ 2]  369 	ldw	x, #_display+12
      00825B 1F 01            [ 2]  370 	ldw	(0x01, sp), x
      00825D 7B 05            [ 1]  371 	ld	a, (0x05, sp)
      00825F 5F               [ 1]  372 	clrw	x
      008260 97               [ 1]  373 	ld	xl, a
      008261 72 FB 01         [ 2]  374 	addw	x, (0x01, sp)
      008264 F6               [ 1]  375 	ld	a, (x)
      008265 88               [ 1]  376 	push	a
      008266 CD 81 9A         [ 4]  377 	call	_shiftOut595
      008269 84               [ 1]  378 	pop	a
                                    379 ;	user/display.c: 74: latch595();
      00826A CD 81 F9         [ 4]  380 	call	_latch595
      00826D 85               [ 2]  381 	popw	x
      00826E 81               [ 4]  382 	ret
                                    383 ;	user/display.c: 77: void onLed(uint8_t led)
                                    384 ;	-----------------------------------------
                                    385 ;	 function onLed
                                    386 ;	-----------------------------------------
      00826F                        387 _onLed:
      00826F 52 08            [ 2]  388 	sub	sp, #8
                                    389 ;	user/display.c: 79: switch(led)
      008271 7B 0B            [ 1]  390 	ld	a, (0x0b, sp)
      008273 A1 01            [ 1]  391 	cp	a, #0x01
      008275 27 14            [ 1]  392 	jreq	00101$
      008277 7B 0B            [ 1]  393 	ld	a, (0x0b, sp)
      008279 A1 02            [ 1]  394 	cp	a, #0x02
      00827B 27 23            [ 1]  395 	jreq	00102$
      00827D 7B 0B            [ 1]  396 	ld	a, (0x0b, sp)
      00827F A1 03            [ 1]  397 	cp	a, #0x03
      008281 27 32            [ 1]  398 	jreq	00103$
      008283 7B 0B            [ 1]  399 	ld	a, (0x0b, sp)
      008285 A1 04            [ 1]  400 	cp	a, #0x04
      008287 27 41            [ 1]  401 	jreq	00104$
      008289 20 51            [ 2]  402 	jra	00107$
                                    403 ;	user/display.c: 81: case 1: {
      00828B                        404 00101$:
                                    405 ;	user/display.c: 82: GPIO_WriteHigh(display.portScan, display.led[0]);
      00828B AE 00 01         [ 2]  406 	ldw	x, #_display+0
      00828E 1F 07            [ 2]  407 	ldw	(0x07, sp), x
      008290 16 07            [ 2]  408 	ldw	y, (0x07, sp)
      008292 90 E6 08         [ 1]  409 	ld	a, (0x8, y)
      008295 EE 02            [ 2]  410 	ldw	x, (0x2, x)
      008297 88               [ 1]  411 	push	a
      008298 89               [ 2]  412 	pushw	x
      008299 CD 8E CC         [ 4]  413 	call	_GPIO_WriteHigh
      00829C 5B 03            [ 2]  414 	addw	sp, #3
                                    415 ;	user/display.c: 83: break;
      00829E 20 3C            [ 2]  416 	jra	00107$
                                    417 ;	user/display.c: 85: case 2:{
      0082A0                        418 00102$:
                                    419 ;	user/display.c: 86: GPIO_WriteHigh(display.portScan, display.led[1]);
      0082A0 AE 00 01         [ 2]  420 	ldw	x, #_display+0
      0082A3 1F 05            [ 2]  421 	ldw	(0x05, sp), x
      0082A5 16 05            [ 2]  422 	ldw	y, (0x05, sp)
      0082A7 90 E6 09         [ 1]  423 	ld	a, (0x9, y)
      0082AA EE 02            [ 2]  424 	ldw	x, (0x2, x)
      0082AC 88               [ 1]  425 	push	a
      0082AD 89               [ 2]  426 	pushw	x
      0082AE CD 8E CC         [ 4]  427 	call	_GPIO_WriteHigh
      0082B1 5B 03            [ 2]  428 	addw	sp, #3
                                    429 ;	user/display.c: 87: break;
      0082B3 20 27            [ 2]  430 	jra	00107$
                                    431 ;	user/display.c: 89: case 3:{
      0082B5                        432 00103$:
                                    433 ;	user/display.c: 90: GPIO_WriteHigh(display.portScan, display.led[2]);
      0082B5 AE 00 01         [ 2]  434 	ldw	x, #_display+0
      0082B8 1F 03            [ 2]  435 	ldw	(0x03, sp), x
      0082BA 16 03            [ 2]  436 	ldw	y, (0x03, sp)
      0082BC 90 E6 0A         [ 1]  437 	ld	a, (0xa, y)
      0082BF EE 02            [ 2]  438 	ldw	x, (0x2, x)
      0082C1 88               [ 1]  439 	push	a
      0082C2 89               [ 2]  440 	pushw	x
      0082C3 CD 8E CC         [ 4]  441 	call	_GPIO_WriteHigh
      0082C6 5B 03            [ 2]  442 	addw	sp, #3
                                    443 ;	user/display.c: 91: break;
      0082C8 20 12            [ 2]  444 	jra	00107$
                                    445 ;	user/display.c: 93: case 4:{
      0082CA                        446 00104$:
                                    447 ;	user/display.c: 94: GPIO_WriteHigh(display.portData, display.led[3]);
      0082CA AE 00 01         [ 2]  448 	ldw	x, #_display+0
      0082CD 1F 01            [ 2]  449 	ldw	(0x01, sp), x
      0082CF 16 01            [ 2]  450 	ldw	y, (0x01, sp)
      0082D1 90 E6 0B         [ 1]  451 	ld	a, (0xb, y)
      0082D4 FE               [ 2]  452 	ldw	x, (x)
      0082D5 88               [ 1]  453 	push	a
      0082D6 89               [ 2]  454 	pushw	x
      0082D7 CD 8E CC         [ 4]  455 	call	_GPIO_WriteHigh
      0082DA 5B 03            [ 2]  456 	addw	sp, #3
                                    457 ;	user/display.c: 98: }
      0082DC                        458 00107$:
      0082DC 5B 08            [ 2]  459 	addw	sp, #8
      0082DE 81               [ 4]  460 	ret
                                    461 ;	user/display.c: 101: void offLed(uint8_t led)
                                    462 ;	-----------------------------------------
                                    463 ;	 function offLed
                                    464 ;	-----------------------------------------
      0082DF                        465 _offLed:
      0082DF 52 08            [ 2]  466 	sub	sp, #8
                                    467 ;	user/display.c: 103: switch(led)
      0082E1 7B 0B            [ 1]  468 	ld	a, (0x0b, sp)
      0082E3 A1 01            [ 1]  469 	cp	a, #0x01
      0082E5 27 14            [ 1]  470 	jreq	00101$
      0082E7 7B 0B            [ 1]  471 	ld	a, (0x0b, sp)
      0082E9 A1 02            [ 1]  472 	cp	a, #0x02
      0082EB 27 23            [ 1]  473 	jreq	00102$
      0082ED 7B 0B            [ 1]  474 	ld	a, (0x0b, sp)
      0082EF A1 03            [ 1]  475 	cp	a, #0x03
      0082F1 27 32            [ 1]  476 	jreq	00103$
      0082F3 7B 0B            [ 1]  477 	ld	a, (0x0b, sp)
      0082F5 A1 04            [ 1]  478 	cp	a, #0x04
      0082F7 27 41            [ 1]  479 	jreq	00104$
      0082F9 20 51            [ 2]  480 	jra	00107$
                                    481 ;	user/display.c: 105: case 1: {
      0082FB                        482 00101$:
                                    483 ;	user/display.c: 106: GPIO_WriteLow(display.portScan, display.led[0]);
      0082FB AE 00 01         [ 2]  484 	ldw	x, #_display+0
      0082FE 1F 07            [ 2]  485 	ldw	(0x07, sp), x
      008300 16 07            [ 2]  486 	ldw	y, (0x07, sp)
      008302 90 E6 08         [ 1]  487 	ld	a, (0x8, y)
      008305 EE 02            [ 2]  488 	ldw	x, (0x2, x)
      008307 88               [ 1]  489 	push	a
      008308 89               [ 2]  490 	pushw	x
      008309 CD 8E D3         [ 4]  491 	call	_GPIO_WriteLow
      00830C 5B 03            [ 2]  492 	addw	sp, #3
                                    493 ;	user/display.c: 107: break;
      00830E 20 3C            [ 2]  494 	jra	00107$
                                    495 ;	user/display.c: 109: case 2:{
      008310                        496 00102$:
                                    497 ;	user/display.c: 110: GPIO_WriteLow(display.portScan, display.led[1]);
      008310 AE 00 01         [ 2]  498 	ldw	x, #_display+0
      008313 1F 05            [ 2]  499 	ldw	(0x05, sp), x
      008315 16 05            [ 2]  500 	ldw	y, (0x05, sp)
      008317 90 E6 09         [ 1]  501 	ld	a, (0x9, y)
      00831A EE 02            [ 2]  502 	ldw	x, (0x2, x)
      00831C 88               [ 1]  503 	push	a
      00831D 89               [ 2]  504 	pushw	x
      00831E CD 8E D3         [ 4]  505 	call	_GPIO_WriteLow
      008321 5B 03            [ 2]  506 	addw	sp, #3
                                    507 ;	user/display.c: 111: break;
      008323 20 27            [ 2]  508 	jra	00107$
                                    509 ;	user/display.c: 113: case 3:{
      008325                        510 00103$:
                                    511 ;	user/display.c: 114: GPIO_WriteLow(display.portScan, display.led[2]);
      008325 AE 00 01         [ 2]  512 	ldw	x, #_display+0
      008328 1F 03            [ 2]  513 	ldw	(0x03, sp), x
      00832A 16 03            [ 2]  514 	ldw	y, (0x03, sp)
      00832C 90 E6 0A         [ 1]  515 	ld	a, (0xa, y)
      00832F EE 02            [ 2]  516 	ldw	x, (0x2, x)
      008331 88               [ 1]  517 	push	a
      008332 89               [ 2]  518 	pushw	x
      008333 CD 8E D3         [ 4]  519 	call	_GPIO_WriteLow
      008336 5B 03            [ 2]  520 	addw	sp, #3
                                    521 ;	user/display.c: 115: break;
      008338 20 12            [ 2]  522 	jra	00107$
                                    523 ;	user/display.c: 117: case 4:{
      00833A                        524 00104$:
                                    525 ;	user/display.c: 118: GPIO_WriteLow(display.portData, display.led[3]);
      00833A AE 00 01         [ 2]  526 	ldw	x, #_display+0
      00833D 1F 01            [ 2]  527 	ldw	(0x01, sp), x
      00833F 16 01            [ 2]  528 	ldw	y, (0x01, sp)
      008341 90 E6 0B         [ 1]  529 	ld	a, (0xb, y)
      008344 FE               [ 2]  530 	ldw	x, (x)
      008345 88               [ 1]  531 	push	a
      008346 89               [ 2]  532 	pushw	x
      008347 CD 8E D3         [ 4]  533 	call	_GPIO_WriteLow
      00834A 5B 03            [ 2]  534 	addw	sp, #3
                                    535 ;	user/display.c: 122: }
      00834C                        536 00107$:
      00834C 5B 08            [ 2]  537 	addw	sp, #8
      00834E 81               [ 4]  538 	ret
                                    539 ;	user/display.c: 125: void screen(uint8_t intensy)
                                    540 ;	-----------------------------------------
                                    541 ;	 function screen
                                    542 ;	-----------------------------------------
      00834F                        543 _screen:
      00834F 52 03            [ 2]  544 	sub	sp, #3
                                    545 ;	user/display.c: 128: for(i = 0; i < 4; i++)
      008351 4F               [ 1]  546 	clr	a
      008352                        547 00102$:
                                    548 ;	user/display.c: 130: writeBuffer(i);
      008352 88               [ 1]  549 	push	a
      008353 88               [ 1]  550 	push	a
      008354 CD 82 57         [ 4]  551 	call	_writeBuffer
      008357 84               [ 1]  552 	pop	a
      008358 84               [ 1]  553 	pop	a
                                    554 ;	user/display.c: 131: onLed(i+1);
      008359 4C               [ 1]  555 	inc	a
      00835A 6B 01            [ 1]  556 	ld	(0x01, sp), a
      00835C 7B 01            [ 1]  557 	ld	a, (0x01, sp)
      00835E 88               [ 1]  558 	push	a
      00835F CD 82 6F         [ 4]  559 	call	_onLed
      008362 84               [ 1]  560 	pop	a
                                    561 ;	user/display.c: 132: delay_us(intensy);
      008363 5F               [ 1]  562 	clrw	x
      008364 7B 06            [ 1]  563 	ld	a, (0x06, sp)
      008366 97               [ 1]  564 	ld	xl, a
      008367 89               [ 2]  565 	pushw	x
      008368 CD 80 A0         [ 4]  566 	call	_delay_us
      00836B 85               [ 2]  567 	popw	x
                                    568 ;	user/display.c: 133: offLed(i+1);
      00836C 7B 01            [ 1]  569 	ld	a, (0x01, sp)
      00836E 88               [ 1]  570 	push	a
      00836F CD 82 DF         [ 4]  571 	call	_offLed
      008372 84               [ 1]  572 	pop	a
                                    573 ;	user/display.c: 134: delay_us(255-intensy);
      008373 7B 06            [ 1]  574 	ld	a, (0x06, sp)
      008375 6B 03            [ 1]  575 	ld	(0x03, sp), a
      008377 0F 02            [ 1]  576 	clr	(0x02, sp)
      008379 AE 00 FF         [ 2]  577 	ldw	x, #0x00ff
      00837C 72 F0 02         [ 2]  578 	subw	x, (0x02, sp)
      00837F 89               [ 2]  579 	pushw	x
      008380 CD 80 A0         [ 4]  580 	call	_delay_us
      008383 85               [ 2]  581 	popw	x
                                    582 ;	user/display.c: 128: for(i = 0; i < 4; i++)
      008384 7B 01            [ 1]  583 	ld	a, (0x01, sp)
      008386 A1 04            [ 1]  584 	cp	a, #0x04
      008388 25 C8            [ 1]  585 	jrc	00102$
      00838A 5B 03            [ 2]  586 	addw	sp, #3
      00838C 81               [ 4]  587 	ret
                                    588 ;	user/display.c: 138: void setDigit(uint8_t led, uint8_t bcd)
                                    589 ;	-----------------------------------------
                                    590 ;	 function setDigit
                                    591 ;	-----------------------------------------
      00838D                        592 _setDigit:
      00838D 89               [ 2]  593 	pushw	x
                                    594 ;	user/display.c: 140: display.buffer[led-1] = code7Seg[bcd];
      00838E AE 00 0D         [ 2]  595 	ldw	x, #_display+12
      008391 1F 01            [ 2]  596 	ldw	(0x01, sp), x
      008393 7B 05            [ 1]  597 	ld	a, (0x05, sp)
      008395 4A               [ 1]  598 	dec	a
      008396 90 5F            [ 1]  599 	clrw	y
      008398 90 97            [ 1]  600 	ld	yl, a
      00839A 72 F9 01         [ 2]  601 	addw	y, (0x01, sp)
      00839D AE 84 C0         [ 2]  602 	ldw	x, #_code7Seg+0
      0083A0 9F               [ 1]  603 	ld	a, xl
      0083A1 1B 06            [ 1]  604 	add	a, (0x06, sp)
      0083A3 02               [ 1]  605 	rlwa	x
      0083A4 A9 00            [ 1]  606 	adc	a, #0x00
      0083A6 95               [ 1]  607 	ld	xh, a
      0083A7 F6               [ 1]  608 	ld	a, (x)
      0083A8 90 F7            [ 1]  609 	ld	(y), a
      0083AA 85               [ 2]  610 	popw	x
      0083AB 81               [ 4]  611 	ret
                                    612 ;	user/display.c: 143: void display_test(uint8_t intensy)
                                    613 ;	-----------------------------------------
                                    614 ;	 function display_test
                                    615 ;	-----------------------------------------
      0083AC                        616 _display_test:
      0083AC 52 13            [ 2]  617 	sub	sp, #19
                                    618 ;	user/display.c: 146: for(i = 0; i < 20; i++)
      0083AE AE 00 01         [ 2]  619 	ldw	x, #_display+0
      0083B1 1F 02            [ 2]  620 	ldw	(0x02, sp), x
      0083B3 1E 02            [ 2]  621 	ldw	x, (0x02, sp)
      0083B5 1C 00 08         [ 2]  622 	addw	x, #0x0008
      0083B8 1F 12            [ 2]  623 	ldw	(0x12, sp), x
      0083BA 1E 02            [ 2]  624 	ldw	x, (0x02, sp)
      0083BC 5C               [ 2]  625 	incw	x
      0083BD 5C               [ 2]  626 	incw	x
      0083BE 1F 10            [ 2]  627 	ldw	(0x10, sp), x
      0083C0 1E 02            [ 2]  628 	ldw	x, (0x02, sp)
      0083C2 1C 00 09         [ 2]  629 	addw	x, #0x0009
      0083C5 1F 0E            [ 2]  630 	ldw	(0x0e, sp), x
      0083C7 1E 02            [ 2]  631 	ldw	x, (0x02, sp)
      0083C9 1C 00 0A         [ 2]  632 	addw	x, #0x000a
      0083CC 1F 0C            [ 2]  633 	ldw	(0x0c, sp), x
      0083CE 1E 02            [ 2]  634 	ldw	x, (0x02, sp)
      0083D0 1C 00 0B         [ 2]  635 	addw	x, #0x000b
      0083D3 1F 0A            [ 2]  636 	ldw	(0x0a, sp), x
      0083D5 0F 01            [ 1]  637 	clr	(0x01, sp)
      0083D7                        638 00102$:
                                    639 ;	user/display.c: 148: shiftOut595(0x3F);
      0083D7 4B 3F            [ 1]  640 	push	#0x3f
      0083D9 CD 81 9A         [ 4]  641 	call	_shiftOut595
      0083DC 84               [ 1]  642 	pop	a
                                    643 ;	user/display.c: 149: latch595();
      0083DD CD 81 F9         [ 4]  644 	call	_latch595
                                    645 ;	user/display.c: 150: GPIO_WriteHigh(display.portScan, display.led[0]);
      0083E0 1E 12            [ 2]  646 	ldw	x, (0x12, sp)
      0083E2 F6               [ 1]  647 	ld	a, (x)
      0083E3 1E 10            [ 2]  648 	ldw	x, (0x10, sp)
      0083E5 FE               [ 2]  649 	ldw	x, (x)
      0083E6 88               [ 1]  650 	push	a
      0083E7 89               [ 2]  651 	pushw	x
      0083E8 CD 8E CC         [ 4]  652 	call	_GPIO_WriteHigh
      0083EB 5B 03            [ 2]  653 	addw	sp, #3
                                    654 ;	user/display.c: 151: delay_us(intensy);
      0083ED 7B 16            [ 1]  655 	ld	a, (0x16, sp)
      0083EF 6B 09            [ 1]  656 	ld	(0x09, sp), a
      0083F1 0F 08            [ 1]  657 	clr	(0x08, sp)
      0083F3 1E 08            [ 2]  658 	ldw	x, (0x08, sp)
      0083F5 89               [ 2]  659 	pushw	x
      0083F6 CD 80 A0         [ 4]  660 	call	_delay_us
      0083F9 85               [ 2]  661 	popw	x
                                    662 ;	user/display.c: 152: GPIO_WriteLow(display.portScan, display.led[0]);
      0083FA 1E 12            [ 2]  663 	ldw	x, (0x12, sp)
      0083FC F6               [ 1]  664 	ld	a, (x)
      0083FD 1E 10            [ 2]  665 	ldw	x, (0x10, sp)
      0083FF FE               [ 2]  666 	ldw	x, (x)
      008400 88               [ 1]  667 	push	a
      008401 89               [ 2]  668 	pushw	x
      008402 CD 8E D3         [ 4]  669 	call	_GPIO_WriteLow
      008405 5B 03            [ 2]  670 	addw	sp, #3
                                    671 ;	user/display.c: 153: delay_us(255-intensy);
      008407 7B 16            [ 1]  672 	ld	a, (0x16, sp)
      008409 6B 07            [ 1]  673 	ld	(0x07, sp), a
      00840B 0F 06            [ 1]  674 	clr	(0x06, sp)
      00840D A6 FF            [ 1]  675 	ld	a, #0xff
      00840F 10 07            [ 1]  676 	sub	a, (0x07, sp)
      008411 6B 05            [ 1]  677 	ld	(0x05, sp), a
      008413 4F               [ 1]  678 	clr	a
      008414 12 06            [ 1]  679 	sbc	a, (0x06, sp)
      008416 6B 04            [ 1]  680 	ld	(0x04, sp), a
      008418 1E 04            [ 2]  681 	ldw	x, (0x04, sp)
      00841A 89               [ 2]  682 	pushw	x
      00841B CD 80 A0         [ 4]  683 	call	_delay_us
      00841E 85               [ 2]  684 	popw	x
                                    685 ;	user/display.c: 154: shiftOut595(0x06);
      00841F 4B 06            [ 1]  686 	push	#0x06
      008421 CD 81 9A         [ 4]  687 	call	_shiftOut595
      008424 84               [ 1]  688 	pop	a
                                    689 ;	user/display.c: 155: latch595();
      008425 CD 81 F9         [ 4]  690 	call	_latch595
                                    691 ;	user/display.c: 156: GPIO_WriteHigh(display.portScan, display.led[1]);
      008428 1E 0E            [ 2]  692 	ldw	x, (0x0e, sp)
      00842A F6               [ 1]  693 	ld	a, (x)
      00842B 1E 10            [ 2]  694 	ldw	x, (0x10, sp)
      00842D FE               [ 2]  695 	ldw	x, (x)
      00842E 88               [ 1]  696 	push	a
      00842F 89               [ 2]  697 	pushw	x
      008430 CD 8E CC         [ 4]  698 	call	_GPIO_WriteHigh
      008433 5B 03            [ 2]  699 	addw	sp, #3
                                    700 ;	user/display.c: 157: delay_us(intensy);
      008435 1E 08            [ 2]  701 	ldw	x, (0x08, sp)
      008437 89               [ 2]  702 	pushw	x
      008438 CD 80 A0         [ 4]  703 	call	_delay_us
      00843B 85               [ 2]  704 	popw	x
                                    705 ;	user/display.c: 158: GPIO_WriteLow(display.portScan, display.led[1]);
      00843C 1E 0E            [ 2]  706 	ldw	x, (0x0e, sp)
      00843E F6               [ 1]  707 	ld	a, (x)
      00843F 1E 10            [ 2]  708 	ldw	x, (0x10, sp)
      008441 FE               [ 2]  709 	ldw	x, (x)
      008442 88               [ 1]  710 	push	a
      008443 89               [ 2]  711 	pushw	x
      008444 CD 8E D3         [ 4]  712 	call	_GPIO_WriteLow
      008447 5B 03            [ 2]  713 	addw	sp, #3
                                    714 ;	user/display.c: 159: delay_us(255-intensy);
      008449 1E 04            [ 2]  715 	ldw	x, (0x04, sp)
      00844B 89               [ 2]  716 	pushw	x
      00844C CD 80 A0         [ 4]  717 	call	_delay_us
      00844F 85               [ 2]  718 	popw	x
                                    719 ;	user/display.c: 160: shiftOut595(0x5B);
      008450 4B 5B            [ 1]  720 	push	#0x5b
      008452 CD 81 9A         [ 4]  721 	call	_shiftOut595
      008455 84               [ 1]  722 	pop	a
                                    723 ;	user/display.c: 161: latch595();
      008456 CD 81 F9         [ 4]  724 	call	_latch595
                                    725 ;	user/display.c: 162: GPIO_WriteHigh(display.portScan, display.led[2]);
      008459 1E 0C            [ 2]  726 	ldw	x, (0x0c, sp)
      00845B F6               [ 1]  727 	ld	a, (x)
      00845C 1E 10            [ 2]  728 	ldw	x, (0x10, sp)
      00845E FE               [ 2]  729 	ldw	x, (x)
      00845F 88               [ 1]  730 	push	a
      008460 89               [ 2]  731 	pushw	x
      008461 CD 8E CC         [ 4]  732 	call	_GPIO_WriteHigh
      008464 5B 03            [ 2]  733 	addw	sp, #3
                                    734 ;	user/display.c: 163: delay_us(intensy);
      008466 1E 08            [ 2]  735 	ldw	x, (0x08, sp)
      008468 89               [ 2]  736 	pushw	x
      008469 CD 80 A0         [ 4]  737 	call	_delay_us
      00846C 85               [ 2]  738 	popw	x
                                    739 ;	user/display.c: 164: GPIO_WriteLow(display.portScan, display.led[2]);
      00846D 1E 0C            [ 2]  740 	ldw	x, (0x0c, sp)
      00846F F6               [ 1]  741 	ld	a, (x)
      008470 1E 10            [ 2]  742 	ldw	x, (0x10, sp)
      008472 FE               [ 2]  743 	ldw	x, (x)
      008473 88               [ 1]  744 	push	a
      008474 89               [ 2]  745 	pushw	x
      008475 CD 8E D3         [ 4]  746 	call	_GPIO_WriteLow
      008478 5B 03            [ 2]  747 	addw	sp, #3
                                    748 ;	user/display.c: 165: delay_us(255-intensy);
      00847A 1E 04            [ 2]  749 	ldw	x, (0x04, sp)
      00847C 89               [ 2]  750 	pushw	x
      00847D CD 80 A0         [ 4]  751 	call	_delay_us
      008480 85               [ 2]  752 	popw	x
                                    753 ;	user/display.c: 166: shiftOut595(0x4F);
      008481 4B 4F            [ 1]  754 	push	#0x4f
      008483 CD 81 9A         [ 4]  755 	call	_shiftOut595
      008486 84               [ 1]  756 	pop	a
                                    757 ;	user/display.c: 167: latch595();
      008487 CD 81 F9         [ 4]  758 	call	_latch595
                                    759 ;	user/display.c: 168: GPIO_WriteHigh(display.portData, display.led[3]);
      00848A 1E 0A            [ 2]  760 	ldw	x, (0x0a, sp)
      00848C F6               [ 1]  761 	ld	a, (x)
      00848D 1E 02            [ 2]  762 	ldw	x, (0x02, sp)
      00848F FE               [ 2]  763 	ldw	x, (x)
      008490 88               [ 1]  764 	push	a
      008491 89               [ 2]  765 	pushw	x
      008492 CD 8E CC         [ 4]  766 	call	_GPIO_WriteHigh
      008495 5B 03            [ 2]  767 	addw	sp, #3
                                    768 ;	user/display.c: 169: delay_us(intensy);
      008497 1E 08            [ 2]  769 	ldw	x, (0x08, sp)
      008499 89               [ 2]  770 	pushw	x
      00849A CD 80 A0         [ 4]  771 	call	_delay_us
      00849D 85               [ 2]  772 	popw	x
                                    773 ;	user/display.c: 170: GPIO_WriteLow(display.portData, display.led[3]);
      00849E 1E 0A            [ 2]  774 	ldw	x, (0x0a, sp)
      0084A0 F6               [ 1]  775 	ld	a, (x)
      0084A1 1E 02            [ 2]  776 	ldw	x, (0x02, sp)
      0084A3 FE               [ 2]  777 	ldw	x, (x)
      0084A4 88               [ 1]  778 	push	a
      0084A5 89               [ 2]  779 	pushw	x
      0084A6 CD 8E D3         [ 4]  780 	call	_GPIO_WriteLow
      0084A9 5B 03            [ 2]  781 	addw	sp, #3
                                    782 ;	user/display.c: 171: delay_us(255-intensy);
      0084AB 1E 04            [ 2]  783 	ldw	x, (0x04, sp)
      0084AD 89               [ 2]  784 	pushw	x
      0084AE CD 80 A0         [ 4]  785 	call	_delay_us
      0084B1 85               [ 2]  786 	popw	x
                                    787 ;	user/display.c: 146: for(i = 0; i < 20; i++)
      0084B2 0C 01            [ 1]  788 	inc	(0x01, sp)
      0084B4 7B 01            [ 1]  789 	ld	a, (0x01, sp)
      0084B6 A1 14            [ 1]  790 	cp	a, #0x14
      0084B8 24 03            [ 1]  791 	jrnc	00111$
      0084BA CC 83 D7         [ 2]  792 	jp	00102$
      0084BD                        793 00111$:
      0084BD 5B 13            [ 2]  794 	addw	sp, #19
      0084BF 81               [ 4]  795 	ret
                                    796 	.area CODE
      0084C0                        797 _code7Seg:
      0084C0 3F                     798 	.db #0x3f	; 63
      0084C1 06                     799 	.db #0x06	; 6
      0084C2 5B                     800 	.db #0x5b	; 91
      0084C3 4F                     801 	.db #0x4f	; 79	'O'
      0084C4 66                     802 	.db #0x66	; 102	'f'
      0084C5 6D                     803 	.db #0x6d	; 109	'm'
      0084C6 7D                     804 	.db #0x7d	; 125
      0084C7 07                     805 	.db #0x07	; 7
      0084C8 7F                     806 	.db #0x7f	; 127
      0084C9 6F                     807 	.db #0x6f	; 111	'o'
                                    808 	.area INITIALIZER
                                    809 	.area CABS (ABS)
