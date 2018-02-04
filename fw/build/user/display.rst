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
                                     25 	.globl _display_test
                                     26 ;--------------------------------------------------------
                                     27 ; ram data
                                     28 ;--------------------------------------------------------
                                     29 	.area DATA
      000001                         30 _display::
      000001                         31 	.ds 16
                                     32 ;--------------------------------------------------------
                                     33 ; ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area INITIALIZED
                                     36 ;--------------------------------------------------------
                                     37 ; absolute external ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area DABS (ABS)
                                     40 ;--------------------------------------------------------
                                     41 ; global & static initialisations
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
                                     44 	.area GSINIT
                                     45 	.area GSFINAL
                                     46 	.area GSINIT
                                     47 ;--------------------------------------------------------
                                     48 ; Home
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area HOME
                                     52 ;--------------------------------------------------------
                                     53 ; code
                                     54 ;--------------------------------------------------------
                                     55 	.area CODE
                                     56 ;	user/display.c: 8: static void delay_us(uint16_t x)
                                     57 ;	-----------------------------------------
                                     58 ;	 function delay_us
                                     59 ;	-----------------------------------------
      0080A0                         60 _delay_us:
      0080A0 89               [ 2]   61 	pushw	x
                                     62 ;	user/display.c: 10: while(x--);
      0080A1 1E 05            [ 2]   63 	ldw	x, (0x05, sp)
      0080A3                         64 00101$:
      0080A3 1F 01            [ 2]   65 	ldw	(0x01, sp), x
      0080A5 5A               [ 2]   66 	decw	x
      0080A6 16 01            [ 2]   67 	ldw	y, (0x01, sp)
      0080A8 26 F9            [ 1]   68 	jrne	00101$
      0080AA 85               [ 2]   69 	popw	x
      0080AB 81               [ 4]   70 	ret
                                     71 ;	user/display.c: 13: void displayInit(GPIO_TypeDef* portData, GPIO_TypeDef* portScan, uint8_t data, uint8_t clk, uint8_t lat, uint8_t clr, uint8_t led1, uint8_t led2, uint8_t led3, uint8_t led4)
                                     72 ;	-----------------------------------------
                                     73 ;	 function displayInit
                                     74 ;	-----------------------------------------
      0080AC                         75 _displayInit:
      0080AC 52 12            [ 2]   76 	sub	sp, #18
                                     77 ;	user/display.c: 15: display.portData = portData;
      0080AE AE 00 01         [ 2]   78 	ldw	x, #_display+0
      0080B1 16 15            [ 2]   79 	ldw	y, (0x15, sp)
      0080B3 FF               [ 2]   80 	ldw	(x), y
                                     81 ;	user/display.c: 16: display.portScan = portScan;
      0080B4 AE 00 01         [ 2]   82 	ldw	x, #_display+0
      0080B7 1F 11            [ 2]   83 	ldw	(0x11, sp), x
      0080B9 1E 11            [ 2]   84 	ldw	x, (0x11, sp)
      0080BB 5C               [ 2]   85 	incw	x
      0080BC 5C               [ 2]   86 	incw	x
      0080BD 1F 0F            [ 2]   87 	ldw	(0x0f, sp), x
      0080BF 1E 0F            [ 2]   88 	ldw	x, (0x0f, sp)
      0080C1 16 17            [ 2]   89 	ldw	y, (0x17, sp)
      0080C3 FF               [ 2]   90 	ldw	(x), y
                                     91 ;	user/display.c: 17: display.data = data;
      0080C4 1E 11            [ 2]   92 	ldw	x, (0x11, sp)
      0080C6 7B 19            [ 1]   93 	ld	a, (0x19, sp)
      0080C8 E7 04            [ 1]   94 	ld	(0x0004, x), a
                                     95 ;	user/display.c: 18: display.clk = clk;
      0080CA 1E 11            [ 2]   96 	ldw	x, (0x11, sp)
      0080CC 7B 1A            [ 1]   97 	ld	a, (0x1a, sp)
      0080CE E7 05            [ 1]   98 	ld	(0x0005, x), a
                                     99 ;	user/display.c: 19: display.lat = lat;
      0080D0 1E 11            [ 2]  100 	ldw	x, (0x11, sp)
      0080D2 7B 1B            [ 1]  101 	ld	a, (0x1b, sp)
      0080D4 E7 06            [ 1]  102 	ld	(0x0006, x), a
                                    103 ;	user/display.c: 20: display.clr = clr;
      0080D6 1E 11            [ 2]  104 	ldw	x, (0x11, sp)
      0080D8 1C 00 07         [ 2]  105 	addw	x, #0x0007
      0080DB 1F 0D            [ 2]  106 	ldw	(0x0d, sp), x
      0080DD 1E 0D            [ 2]  107 	ldw	x, (0x0d, sp)
      0080DF 7B 1C            [ 1]  108 	ld	a, (0x1c, sp)
      0080E1 F7               [ 1]  109 	ld	(x), a
                                    110 ;	user/display.c: 21: display.led[0] = led1;
      0080E2 1E 11            [ 2]  111 	ldw	x, (0x11, sp)
      0080E4 1C 00 08         [ 2]  112 	addw	x, #0x0008
      0080E7 1F 0B            [ 2]  113 	ldw	(0x0b, sp), x
      0080E9 1E 0B            [ 2]  114 	ldw	x, (0x0b, sp)
      0080EB 7B 1D            [ 1]  115 	ld	a, (0x1d, sp)
      0080ED F7               [ 1]  116 	ld	(x), a
                                    117 ;	user/display.c: 22: display.led[1] = led2;
      0080EE 1E 11            [ 2]  118 	ldw	x, (0x11, sp)
      0080F0 1C 00 09         [ 2]  119 	addw	x, #0x0009
      0080F3 1F 09            [ 2]  120 	ldw	(0x09, sp), x
      0080F5 1E 09            [ 2]  121 	ldw	x, (0x09, sp)
      0080F7 7B 1E            [ 1]  122 	ld	a, (0x1e, sp)
      0080F9 F7               [ 1]  123 	ld	(x), a
                                    124 ;	user/display.c: 23: display.led[2] = led3;
      0080FA 1E 11            [ 2]  125 	ldw	x, (0x11, sp)
      0080FC 1C 00 0A         [ 2]  126 	addw	x, #0x000a
      0080FF 1F 07            [ 2]  127 	ldw	(0x07, sp), x
      008101 1E 07            [ 2]  128 	ldw	x, (0x07, sp)
      008103 7B 1F            [ 1]  129 	ld	a, (0x1f, sp)
      008105 F7               [ 1]  130 	ld	(x), a
                                    131 ;	user/display.c: 24: display.led[3] = led4;
      008106 1E 11            [ 2]  132 	ldw	x, (0x11, sp)
      008108 1C 00 0B         [ 2]  133 	addw	x, #0x000b
      00810B 1F 05            [ 2]  134 	ldw	(0x05, sp), x
      00810D 1E 05            [ 2]  135 	ldw	x, (0x05, sp)
      00810F 7B 20            [ 1]  136 	ld	a, (0x20, sp)
      008111 F7               [ 1]  137 	ld	(x), a
                                    138 ;	user/display.c: 25: GPIO_Init(display.portData, display.data|display.clk|display.lat|display.clr|display.led[3], GPIO_MODE_OUT_PP_HIGH_FAST);
      008112 7B 19            [ 1]  139 	ld	a, (0x19, sp)
      008114 1A 1A            [ 1]  140 	or	a, (0x1a, sp)
      008116 1A 1B            [ 1]  141 	or	a, (0x1b, sp)
      008118 1A 1C            [ 1]  142 	or	a, (0x1c, sp)
      00811A 1A 20            [ 1]  143 	or	a, (0x20, sp)
      00811C 1E 11            [ 2]  144 	ldw	x, (0x11, sp)
      00811E FE               [ 2]  145 	ldw	x, (x)
      00811F 4B F0            [ 1]  146 	push	#0xf0
      008121 88               [ 1]  147 	push	a
      008122 89               [ 2]  148 	pushw	x
      008123 CD 87 7C         [ 4]  149 	call	_GPIO_Init
      008126 5B 04            [ 2]  150 	addw	sp, #4
                                    151 ;	user/display.c: 26: GPIO_Init(display.portScan, display.led[0]|display.led[1]|display.led[2], GPIO_MODE_OUT_PP_HIGH_FAST);
      008128 1E 0B            [ 2]  152 	ldw	x, (0x0b, sp)
      00812A F6               [ 1]  153 	ld	a, (x)
      00812B 6B 04            [ 1]  154 	ld	(0x04, sp), a
      00812D 1E 09            [ 2]  155 	ldw	x, (0x09, sp)
      00812F F6               [ 1]  156 	ld	a, (x)
      008130 1A 04            [ 1]  157 	or	a, (0x04, sp)
      008132 6B 03            [ 1]  158 	ld	(0x03, sp), a
      008134 1E 07            [ 2]  159 	ldw	x, (0x07, sp)
      008136 F6               [ 1]  160 	ld	a, (x)
      008137 1A 03            [ 1]  161 	or	a, (0x03, sp)
      008139 1E 0F            [ 2]  162 	ldw	x, (0x0f, sp)
      00813B FE               [ 2]  163 	ldw	x, (x)
      00813C 4B F0            [ 1]  164 	push	#0xf0
      00813E 88               [ 1]  165 	push	a
      00813F 89               [ 2]  166 	pushw	x
      008140 CD 87 7C         [ 4]  167 	call	_GPIO_Init
      008143 5B 04            [ 2]  168 	addw	sp, #4
                                    169 ;	user/display.c: 29: GPIO_WriteHigh(display.portData, display.clr);
      008145 1E 0D            [ 2]  170 	ldw	x, (0x0d, sp)
      008147 F6               [ 1]  171 	ld	a, (x)
      008148 1E 11            [ 2]  172 	ldw	x, (0x11, sp)
      00814A FE               [ 2]  173 	ldw	x, (x)
      00814B 88               [ 1]  174 	push	a
      00814C 89               [ 2]  175 	pushw	x
      00814D CD 88 10         [ 4]  176 	call	_GPIO_WriteHigh
      008150 5B 03            [ 2]  177 	addw	sp, #3
                                    178 ;	user/display.c: 30: GPIO_WriteLow(display.portScan, display.led[0]);
      008152 1E 0B            [ 2]  179 	ldw	x, (0x0b, sp)
      008154 F6               [ 1]  180 	ld	a, (x)
      008155 1E 0F            [ 2]  181 	ldw	x, (0x0f, sp)
      008157 FE               [ 2]  182 	ldw	x, (x)
      008158 88               [ 1]  183 	push	a
      008159 89               [ 2]  184 	pushw	x
      00815A CD 88 17         [ 4]  185 	call	_GPIO_WriteLow
      00815D 5B 03            [ 2]  186 	addw	sp, #3
                                    187 ;	user/display.c: 31: GPIO_WriteLow(display.portScan, display.led[1]);
      00815F 1E 09            [ 2]  188 	ldw	x, (0x09, sp)
      008161 F6               [ 1]  189 	ld	a, (x)
      008162 1E 0F            [ 2]  190 	ldw	x, (0x0f, sp)
      008164 FE               [ 2]  191 	ldw	x, (x)
      008165 88               [ 1]  192 	push	a
      008166 89               [ 2]  193 	pushw	x
      008167 CD 88 17         [ 4]  194 	call	_GPIO_WriteLow
      00816A 5B 03            [ 2]  195 	addw	sp, #3
                                    196 ;	user/display.c: 32: GPIO_WriteLow(display.portScan, display.led[2]);
      00816C 1E 07            [ 2]  197 	ldw	x, (0x07, sp)
      00816E F6               [ 1]  198 	ld	a, (x)
      00816F 1E 0F            [ 2]  199 	ldw	x, (0x0f, sp)
      008171 FE               [ 2]  200 	ldw	x, (x)
      008172 88               [ 1]  201 	push	a
      008173 89               [ 2]  202 	pushw	x
      008174 CD 88 17         [ 4]  203 	call	_GPIO_WriteLow
      008177 5B 03            [ 2]  204 	addw	sp, #3
                                    205 ;	user/display.c: 33: GPIO_WriteLow(display.portData, display.led[3]);
      008179 1E 05            [ 2]  206 	ldw	x, (0x05, sp)
      00817B F6               [ 1]  207 	ld	a, (x)
      00817C 1E 11            [ 2]  208 	ldw	x, (0x11, sp)
      00817E FE               [ 2]  209 	ldw	x, (x)
      00817F 88               [ 1]  210 	push	a
      008180 89               [ 2]  211 	pushw	x
      008181 CD 88 17         [ 4]  212 	call	_GPIO_WriteLow
      008184 5B 03            [ 2]  213 	addw	sp, #3
                                    214 ;	user/display.c: 34: memset(display.buffer, 0x00, sizeof(display.buffer));
      008186 1E 11            [ 2]  215 	ldw	x, (0x11, sp)
      008188 1C 00 0C         [ 2]  216 	addw	x, #0x000c
      00818B 1F 01            [ 2]  217 	ldw	(0x01, sp), x
      00818D 16 01            [ 2]  218 	ldw	y, (0x01, sp)
      00818F 4B 04            [ 1]  219 	push	#0x04
      008191 4B 00            [ 1]  220 	push	#0x00
      008193 5F               [ 1]  221 	clrw	x
      008194 89               [ 2]  222 	pushw	x
      008195 90 89            [ 2]  223 	pushw	y
      008197 CD 8A A5         [ 4]  224 	call	_memset
      00819A 5B 06            [ 2]  225 	addw	sp, #6
                                    226 ;	user/display.c: 39: memset(display.buffer, 0xff, sizeof(display.buffer));
      00819C 1E 01            [ 2]  227 	ldw	x, (0x01, sp)
      00819E 4B 04            [ 1]  228 	push	#0x04
      0081A0 4B 00            [ 1]  229 	push	#0x00
      0081A2 4B FF            [ 1]  230 	push	#0xff
      0081A4 4B 00            [ 1]  231 	push	#0x00
      0081A6 89               [ 2]  232 	pushw	x
      0081A7 CD 8A A5         [ 4]  233 	call	_memset
      0081AA 5B 18            [ 2]  234 	addw	sp, #24
      0081AC 81               [ 4]  235 	ret
                                    236 ;	user/display.c: 42: void shiftOut595(uint8_t data)
                                    237 ;	-----------------------------------------
                                    238 ;	 function shiftOut595
                                    239 ;	-----------------------------------------
      0081AD                        240 _shiftOut595:
      0081AD 52 06            [ 2]  241 	sub	sp, #6
                                    242 ;	user/display.c: 45: temp = data;
      0081AF 7B 09            [ 1]  243 	ld	a, (0x09, sp)
      0081B1 6B 02            [ 1]  244 	ld	(0x02, sp), a
                                    245 ;	user/display.c: 47: for(i = 0; i< 8; i++)
      0081B3 AE 00 01         [ 2]  246 	ldw	x, #_display+0
      0081B6 1F 03            [ 2]  247 	ldw	(0x03, sp), x
      0081B8 1E 03            [ 2]  248 	ldw	x, (0x03, sp)
      0081BA 1C 00 05         [ 2]  249 	addw	x, #0x0005
      0081BD 1F 05            [ 2]  250 	ldw	(0x05, sp), x
      0081BF 0F 01            [ 1]  251 	clr	(0x01, sp)
      0081C1                        252 00105$:
                                    253 ;	user/display.c: 49: GPIO_WriteLow(display.portData, display.clk);
      0081C1 1E 05            [ 2]  254 	ldw	x, (0x05, sp)
      0081C3 F6               [ 1]  255 	ld	a, (x)
      0081C4 1E 03            [ 2]  256 	ldw	x, (0x03, sp)
      0081C6 FE               [ 2]  257 	ldw	x, (x)
      0081C7 88               [ 1]  258 	push	a
      0081C8 89               [ 2]  259 	pushw	x
      0081C9 CD 88 17         [ 4]  260 	call	_GPIO_WriteLow
      0081CC 5B 03            [ 2]  261 	addw	sp, #3
      0081CE 1E 03            [ 2]  262 	ldw	x, (0x03, sp)
      0081D0 FE               [ 2]  263 	ldw	x, (x)
                                    264 ;	user/display.c: 50: if(temp&0x80) GPIO_WriteHigh(display.portData, display.data);
      0081D1 16 03            [ 2]  265 	ldw	y, (0x03, sp)
      0081D3 90 E6 04         [ 1]  266 	ld	a, (0x4, y)
      0081D6 0D 02            [ 1]  267 	tnz	(0x02, sp)
      0081D8 2A 09            [ 1]  268 	jrpl	00102$
      0081DA 88               [ 1]  269 	push	a
      0081DB 89               [ 2]  270 	pushw	x
      0081DC CD 88 10         [ 4]  271 	call	_GPIO_WriteHigh
      0081DF 5B 03            [ 2]  272 	addw	sp, #3
      0081E1 20 07            [ 2]  273 	jra	00103$
      0081E3                        274 00102$:
                                    275 ;	user/display.c: 51: else GPIO_WriteLow(display.portData, display.data);
      0081E3 88               [ 1]  276 	push	a
      0081E4 89               [ 2]  277 	pushw	x
      0081E5 CD 88 17         [ 4]  278 	call	_GPIO_WriteLow
      0081E8 5B 03            [ 2]  279 	addw	sp, #3
      0081EA                        280 00103$:
                                    281 ;	user/display.c: 52: delay_us(5);
      0081EA 4B 05            [ 1]  282 	push	#0x05
      0081EC 4B 00            [ 1]  283 	push	#0x00
      0081EE CD 80 A0         [ 4]  284 	call	_delay_us
      0081F1 85               [ 2]  285 	popw	x
                                    286 ;	user/display.c: 53: GPIO_WriteHigh(display.portData, display.clk);
      0081F2 1E 05            [ 2]  287 	ldw	x, (0x05, sp)
      0081F4 F6               [ 1]  288 	ld	a, (x)
      0081F5 1E 03            [ 2]  289 	ldw	x, (0x03, sp)
      0081F7 FE               [ 2]  290 	ldw	x, (x)
      0081F8 88               [ 1]  291 	push	a
      0081F9 89               [ 2]  292 	pushw	x
      0081FA CD 88 10         [ 4]  293 	call	_GPIO_WriteHigh
      0081FD 5B 03            [ 2]  294 	addw	sp, #3
                                    295 ;	user/display.c: 54: temp <<= 1;
      0081FF 08 02            [ 1]  296 	sll	(0x02, sp)
                                    297 ;	user/display.c: 47: for(i = 0; i< 8; i++)
      008201 0C 01            [ 1]  298 	inc	(0x01, sp)
      008203 7B 01            [ 1]  299 	ld	a, (0x01, sp)
      008205 A1 08            [ 1]  300 	cp	a, #0x08
      008207 25 B8            [ 1]  301 	jrc	00105$
      008209 5B 06            [ 2]  302 	addw	sp, #6
      00820B 81               [ 4]  303 	ret
                                    304 ;	user/display.c: 58: void latch595(void)
                                    305 ;	-----------------------------------------
                                    306 ;	 function latch595
                                    307 ;	-----------------------------------------
      00820C                        308 _latch595:
      00820C 89               [ 2]  309 	pushw	x
                                    310 ;	user/display.c: 60: GPIO_WriteHigh(display.portData, display.lat);
      00820D AE 00 01         [ 2]  311 	ldw	x, #_display+0
      008210 1F 01            [ 2]  312 	ldw	(0x01, sp), x
      008212 1E 01            [ 2]  313 	ldw	x, (0x01, sp)
      008214 1C 00 06         [ 2]  314 	addw	x, #0x0006
      008217 F6               [ 1]  315 	ld	a, (x)
      008218 16 01            [ 2]  316 	ldw	y, (0x01, sp)
      00821A 90 FE            [ 2]  317 	ldw	y, (y)
      00821C 89               [ 2]  318 	pushw	x
      00821D 88               [ 1]  319 	push	a
      00821E 90 89            [ 2]  320 	pushw	y
      008220 CD 88 10         [ 4]  321 	call	_GPIO_WriteHigh
      008223 5B 03            [ 2]  322 	addw	sp, #3
      008225 85               [ 2]  323 	popw	x
                                    324 ;	user/display.c: 61: GPIO_WriteLow(display.portData, display.lat);
      008226 F6               [ 1]  325 	ld	a, (x)
      008227 1E 01            [ 2]  326 	ldw	x, (0x01, sp)
      008229 FE               [ 2]  327 	ldw	x, (x)
      00822A 88               [ 1]  328 	push	a
      00822B 89               [ 2]  329 	pushw	x
      00822C CD 88 17         [ 4]  330 	call	_GPIO_WriteLow
      00822F 5B 03            [ 2]  331 	addw	sp, #3
                                    332 ;	user/display.c: 62: delay_us(5);
      008231 4B 05            [ 1]  333 	push	#0x05
      008233 4B 00            [ 1]  334 	push	#0x00
      008235 CD 80 A0         [ 4]  335 	call	_delay_us
      008238 5B 04            [ 2]  336 	addw	sp, #4
      00823A 81               [ 4]  337 	ret
                                    338 ;	user/display.c: 65: void clear595(void)
                                    339 ;	-----------------------------------------
                                    340 ;	 function clear595
                                    341 ;	-----------------------------------------
      00823B                        342 _clear595:
      00823B 89               [ 2]  343 	pushw	x
                                    344 ;	user/display.c: 67: GPIO_WriteHigh(display.portData, display.clr);
      00823C AE 00 01         [ 2]  345 	ldw	x, #_display+0
      00823F 1F 01            [ 2]  346 	ldw	(0x01, sp), x
      008241 1E 01            [ 2]  347 	ldw	x, (0x01, sp)
      008243 1C 00 07         [ 2]  348 	addw	x, #0x0007
      008246 F6               [ 1]  349 	ld	a, (x)
      008247 16 01            [ 2]  350 	ldw	y, (0x01, sp)
      008249 90 FE            [ 2]  351 	ldw	y, (y)
      00824B 89               [ 2]  352 	pushw	x
      00824C 88               [ 1]  353 	push	a
      00824D 90 89            [ 2]  354 	pushw	y
      00824F CD 88 10         [ 4]  355 	call	_GPIO_WriteHigh
      008252 5B 03            [ 2]  356 	addw	sp, #3
      008254 85               [ 2]  357 	popw	x
                                    358 ;	user/display.c: 68: GPIO_WriteLow(display.portData, display.clr);
      008255 F6               [ 1]  359 	ld	a, (x)
      008256 1E 01            [ 2]  360 	ldw	x, (0x01, sp)
      008258 FE               [ 2]  361 	ldw	x, (x)
      008259 88               [ 1]  362 	push	a
      00825A 89               [ 2]  363 	pushw	x
      00825B CD 88 17         [ 4]  364 	call	_GPIO_WriteLow
      00825E 5B 03            [ 2]  365 	addw	sp, #3
                                    366 ;	user/display.c: 69: delay_us(100);
      008260 4B 64            [ 1]  367 	push	#0x64
      008262 4B 00            [ 1]  368 	push	#0x00
      008264 CD 80 A0         [ 4]  369 	call	_delay_us
      008267 5B 04            [ 2]  370 	addw	sp, #4
      008269 81               [ 4]  371 	ret
                                    372 ;	user/display.c: 72: void writeBuffer(uint8_t pos)
                                    373 ;	-----------------------------------------
                                    374 ;	 function writeBuffer
                                    375 ;	-----------------------------------------
      00826A                        376 _writeBuffer:
      00826A 89               [ 2]  377 	pushw	x
                                    378 ;	user/display.c: 74: shiftOut595(display.buffer[pos]);
      00826B AE 00 0D         [ 2]  379 	ldw	x, #_display+12
      00826E 1F 01            [ 2]  380 	ldw	(0x01, sp), x
      008270 7B 05            [ 1]  381 	ld	a, (0x05, sp)
      008272 5F               [ 1]  382 	clrw	x
      008273 97               [ 1]  383 	ld	xl, a
      008274 72 FB 01         [ 2]  384 	addw	x, (0x01, sp)
      008277 F6               [ 1]  385 	ld	a, (x)
      008278 88               [ 1]  386 	push	a
      008279 CD 81 AD         [ 4]  387 	call	_shiftOut595
      00827C 84               [ 1]  388 	pop	a
                                    389 ;	user/display.c: 75: latch595();
      00827D CD 82 0C         [ 4]  390 	call	_latch595
      008280 85               [ 2]  391 	popw	x
      008281 81               [ 4]  392 	ret
                                    393 ;	user/display.c: 78: void onLed(uint8_t led)
                                    394 ;	-----------------------------------------
                                    395 ;	 function onLed
                                    396 ;	-----------------------------------------
      008282                        397 _onLed:
      008282 52 08            [ 2]  398 	sub	sp, #8
                                    399 ;	user/display.c: 80: switch(led)
      008284 7B 0B            [ 1]  400 	ld	a, (0x0b, sp)
      008286 A1 01            [ 1]  401 	cp	a, #0x01
      008288 27 14            [ 1]  402 	jreq	00101$
      00828A 7B 0B            [ 1]  403 	ld	a, (0x0b, sp)
      00828C A1 02            [ 1]  404 	cp	a, #0x02
      00828E 27 23            [ 1]  405 	jreq	00102$
      008290 7B 0B            [ 1]  406 	ld	a, (0x0b, sp)
      008292 A1 03            [ 1]  407 	cp	a, #0x03
      008294 27 32            [ 1]  408 	jreq	00103$
      008296 7B 0B            [ 1]  409 	ld	a, (0x0b, sp)
      008298 A1 04            [ 1]  410 	cp	a, #0x04
      00829A 27 41            [ 1]  411 	jreq	00104$
      00829C 20 51            [ 2]  412 	jra	00107$
                                    413 ;	user/display.c: 82: case 1: {
      00829E                        414 00101$:
                                    415 ;	user/display.c: 83: GPIO_WriteHigh(display.portScan, display.led[0]);
      00829E AE 00 01         [ 2]  416 	ldw	x, #_display+0
      0082A1 1F 07            [ 2]  417 	ldw	(0x07, sp), x
      0082A3 16 07            [ 2]  418 	ldw	y, (0x07, sp)
      0082A5 90 E6 08         [ 1]  419 	ld	a, (0x8, y)
      0082A8 EE 02            [ 2]  420 	ldw	x, (0x2, x)
      0082AA 88               [ 1]  421 	push	a
      0082AB 89               [ 2]  422 	pushw	x
      0082AC CD 88 10         [ 4]  423 	call	_GPIO_WriteHigh
      0082AF 5B 03            [ 2]  424 	addw	sp, #3
                                    425 ;	user/display.c: 84: break;
      0082B1 20 3C            [ 2]  426 	jra	00107$
                                    427 ;	user/display.c: 86: case 2:{
      0082B3                        428 00102$:
                                    429 ;	user/display.c: 87: GPIO_WriteHigh(display.portScan, display.led[1]);
      0082B3 AE 00 01         [ 2]  430 	ldw	x, #_display+0
      0082B6 1F 05            [ 2]  431 	ldw	(0x05, sp), x
      0082B8 16 05            [ 2]  432 	ldw	y, (0x05, sp)
      0082BA 90 E6 09         [ 1]  433 	ld	a, (0x9, y)
      0082BD EE 02            [ 2]  434 	ldw	x, (0x2, x)
      0082BF 88               [ 1]  435 	push	a
      0082C0 89               [ 2]  436 	pushw	x
      0082C1 CD 88 10         [ 4]  437 	call	_GPIO_WriteHigh
      0082C4 5B 03            [ 2]  438 	addw	sp, #3
                                    439 ;	user/display.c: 88: break;
      0082C6 20 27            [ 2]  440 	jra	00107$
                                    441 ;	user/display.c: 90: case 3:{
      0082C8                        442 00103$:
                                    443 ;	user/display.c: 91: GPIO_WriteHigh(display.portScan, display.led[2]);
      0082C8 AE 00 01         [ 2]  444 	ldw	x, #_display+0
      0082CB 1F 03            [ 2]  445 	ldw	(0x03, sp), x
      0082CD 16 03            [ 2]  446 	ldw	y, (0x03, sp)
      0082CF 90 E6 0A         [ 1]  447 	ld	a, (0xa, y)
      0082D2 EE 02            [ 2]  448 	ldw	x, (0x2, x)
      0082D4 88               [ 1]  449 	push	a
      0082D5 89               [ 2]  450 	pushw	x
      0082D6 CD 88 10         [ 4]  451 	call	_GPIO_WriteHigh
      0082D9 5B 03            [ 2]  452 	addw	sp, #3
                                    453 ;	user/display.c: 92: break;
      0082DB 20 12            [ 2]  454 	jra	00107$
                                    455 ;	user/display.c: 94: case 4:{
      0082DD                        456 00104$:
                                    457 ;	user/display.c: 95: GPIO_WriteHigh(display.portData, display.led[3]);
      0082DD AE 00 01         [ 2]  458 	ldw	x, #_display+0
      0082E0 1F 01            [ 2]  459 	ldw	(0x01, sp), x
      0082E2 16 01            [ 2]  460 	ldw	y, (0x01, sp)
      0082E4 90 E6 0B         [ 1]  461 	ld	a, (0xb, y)
      0082E7 FE               [ 2]  462 	ldw	x, (x)
      0082E8 88               [ 1]  463 	push	a
      0082E9 89               [ 2]  464 	pushw	x
      0082EA CD 88 10         [ 4]  465 	call	_GPIO_WriteHigh
      0082ED 5B 03            [ 2]  466 	addw	sp, #3
                                    467 ;	user/display.c: 99: }
      0082EF                        468 00107$:
      0082EF 5B 08            [ 2]  469 	addw	sp, #8
      0082F1 81               [ 4]  470 	ret
                                    471 ;	user/display.c: 102: void offLed(uint8_t led)
                                    472 ;	-----------------------------------------
                                    473 ;	 function offLed
                                    474 ;	-----------------------------------------
      0082F2                        475 _offLed:
      0082F2 52 08            [ 2]  476 	sub	sp, #8
                                    477 ;	user/display.c: 104: switch(led)
      0082F4 7B 0B            [ 1]  478 	ld	a, (0x0b, sp)
      0082F6 A1 01            [ 1]  479 	cp	a, #0x01
      0082F8 27 14            [ 1]  480 	jreq	00101$
      0082FA 7B 0B            [ 1]  481 	ld	a, (0x0b, sp)
      0082FC A1 02            [ 1]  482 	cp	a, #0x02
      0082FE 27 23            [ 1]  483 	jreq	00102$
      008300 7B 0B            [ 1]  484 	ld	a, (0x0b, sp)
      008302 A1 03            [ 1]  485 	cp	a, #0x03
      008304 27 32            [ 1]  486 	jreq	00103$
      008306 7B 0B            [ 1]  487 	ld	a, (0x0b, sp)
      008308 A1 04            [ 1]  488 	cp	a, #0x04
      00830A 27 41            [ 1]  489 	jreq	00104$
      00830C 20 51            [ 2]  490 	jra	00107$
                                    491 ;	user/display.c: 106: case 1: {
      00830E                        492 00101$:
                                    493 ;	user/display.c: 107: GPIO_WriteLow(display.portScan, display.led[0]);
      00830E AE 00 01         [ 2]  494 	ldw	x, #_display+0
      008311 1F 07            [ 2]  495 	ldw	(0x07, sp), x
      008313 16 07            [ 2]  496 	ldw	y, (0x07, sp)
      008315 90 E6 08         [ 1]  497 	ld	a, (0x8, y)
      008318 EE 02            [ 2]  498 	ldw	x, (0x2, x)
      00831A 88               [ 1]  499 	push	a
      00831B 89               [ 2]  500 	pushw	x
      00831C CD 88 17         [ 4]  501 	call	_GPIO_WriteLow
      00831F 5B 03            [ 2]  502 	addw	sp, #3
                                    503 ;	user/display.c: 108: break;
      008321 20 3C            [ 2]  504 	jra	00107$
                                    505 ;	user/display.c: 110: case 2:{
      008323                        506 00102$:
                                    507 ;	user/display.c: 111: GPIO_WriteLow(display.portScan, display.led[1]);
      008323 AE 00 01         [ 2]  508 	ldw	x, #_display+0
      008326 1F 05            [ 2]  509 	ldw	(0x05, sp), x
      008328 16 05            [ 2]  510 	ldw	y, (0x05, sp)
      00832A 90 E6 09         [ 1]  511 	ld	a, (0x9, y)
      00832D EE 02            [ 2]  512 	ldw	x, (0x2, x)
      00832F 88               [ 1]  513 	push	a
      008330 89               [ 2]  514 	pushw	x
      008331 CD 88 17         [ 4]  515 	call	_GPIO_WriteLow
      008334 5B 03            [ 2]  516 	addw	sp, #3
                                    517 ;	user/display.c: 112: break;
      008336 20 27            [ 2]  518 	jra	00107$
                                    519 ;	user/display.c: 114: case 3:{
      008338                        520 00103$:
                                    521 ;	user/display.c: 115: GPIO_WriteLow(display.portScan, display.led[2]);
      008338 AE 00 01         [ 2]  522 	ldw	x, #_display+0
      00833B 1F 03            [ 2]  523 	ldw	(0x03, sp), x
      00833D 16 03            [ 2]  524 	ldw	y, (0x03, sp)
      00833F 90 E6 0A         [ 1]  525 	ld	a, (0xa, y)
      008342 EE 02            [ 2]  526 	ldw	x, (0x2, x)
      008344 88               [ 1]  527 	push	a
      008345 89               [ 2]  528 	pushw	x
      008346 CD 88 17         [ 4]  529 	call	_GPIO_WriteLow
      008349 5B 03            [ 2]  530 	addw	sp, #3
                                    531 ;	user/display.c: 116: break;
      00834B 20 12            [ 2]  532 	jra	00107$
                                    533 ;	user/display.c: 118: case 4:{
      00834D                        534 00104$:
                                    535 ;	user/display.c: 119: GPIO_WriteLow(display.portData, display.led[3]);
      00834D AE 00 01         [ 2]  536 	ldw	x, #_display+0
      008350 1F 01            [ 2]  537 	ldw	(0x01, sp), x
      008352 16 01            [ 2]  538 	ldw	y, (0x01, sp)
      008354 90 E6 0B         [ 1]  539 	ld	a, (0xb, y)
      008357 FE               [ 2]  540 	ldw	x, (x)
      008358 88               [ 1]  541 	push	a
      008359 89               [ 2]  542 	pushw	x
      00835A CD 88 17         [ 4]  543 	call	_GPIO_WriteLow
      00835D 5B 03            [ 2]  544 	addw	sp, #3
                                    545 ;	user/display.c: 123: }
      00835F                        546 00107$:
      00835F 5B 08            [ 2]  547 	addw	sp, #8
      008361 81               [ 4]  548 	ret
                                    549 ;	user/display.c: 126: void screen(void)
                                    550 ;	-----------------------------------------
                                    551 ;	 function screen
                                    552 ;	-----------------------------------------
      008362                        553 _screen:
                                    554 ;	user/display.c: 129: for(i = 0; i < 4; i++)
      008362 4F               [ 1]  555 	clr	a
      008363                        556 00102$:
                                    557 ;	user/display.c: 131: writeBuffer(i);
      008363 88               [ 1]  558 	push	a
      008364 88               [ 1]  559 	push	a
      008365 CD 82 6A         [ 4]  560 	call	_writeBuffer
      008368 84               [ 1]  561 	pop	a
      008369 84               [ 1]  562 	pop	a
                                    563 ;	user/display.c: 132: onLed(i+1);
      00836A 4C               [ 1]  564 	inc	a
      00836B 88               [ 1]  565 	push	a
      00836C 88               [ 1]  566 	push	a
      00836D CD 82 82         [ 4]  567 	call	_onLed
      008370 84               [ 1]  568 	pop	a
      008371 4B C8            [ 1]  569 	push	#0xc8
      008373 4B 00            [ 1]  570 	push	#0x00
      008375 CD 80 A0         [ 4]  571 	call	_delay_us
      008378 85               [ 2]  572 	popw	x
      008379 84               [ 1]  573 	pop	a
                                    574 ;	user/display.c: 134: offLed(i+1);
      00837A 88               [ 1]  575 	push	a
      00837B 88               [ 1]  576 	push	a
      00837C CD 82 F2         [ 4]  577 	call	_offLed
      00837F 84               [ 1]  578 	pop	a
      008380 4B 0A            [ 1]  579 	push	#0x0a
      008382 4B 00            [ 1]  580 	push	#0x00
      008384 CD 80 A0         [ 4]  581 	call	_delay_us
      008387 85               [ 2]  582 	popw	x
      008388 84               [ 1]  583 	pop	a
                                    584 ;	user/display.c: 129: for(i = 0; i < 4; i++)
      008389 A1 04            [ 1]  585 	cp	a, #0x04
      00838B 25 D6            [ 1]  586 	jrc	00102$
      00838D 81               [ 4]  587 	ret
                                    588 ;	user/display.c: 139: void display_test(void)
                                    589 ;	-----------------------------------------
                                    590 ;	 function display_test
                                    591 ;	-----------------------------------------
      00838E                        592 _display_test:
      00838E 52 0D            [ 2]  593 	sub	sp, #13
                                    594 ;	user/display.c: 142: for(i = 0; i < 20; i++)
      008390 AE 00 01         [ 2]  595 	ldw	x, #_display+0
      008393 1F 0C            [ 2]  596 	ldw	(0x0c, sp), x
      008395 1E 0C            [ 2]  597 	ldw	x, (0x0c, sp)
      008397 1C 00 08         [ 2]  598 	addw	x, #0x0008
      00839A 1F 0A            [ 2]  599 	ldw	(0x0a, sp), x
      00839C 1E 0C            [ 2]  600 	ldw	x, (0x0c, sp)
      00839E 5C               [ 2]  601 	incw	x
      00839F 5C               [ 2]  602 	incw	x
      0083A0 1F 08            [ 2]  603 	ldw	(0x08, sp), x
      0083A2 1E 0C            [ 2]  604 	ldw	x, (0x0c, sp)
      0083A4 1C 00 09         [ 2]  605 	addw	x, #0x0009
      0083A7 1F 06            [ 2]  606 	ldw	(0x06, sp), x
      0083A9 1E 0C            [ 2]  607 	ldw	x, (0x0c, sp)
      0083AB 1C 00 0A         [ 2]  608 	addw	x, #0x000a
      0083AE 1F 04            [ 2]  609 	ldw	(0x04, sp), x
      0083B0 1E 0C            [ 2]  610 	ldw	x, (0x0c, sp)
      0083B2 1C 00 0B         [ 2]  611 	addw	x, #0x000b
      0083B5 1F 02            [ 2]  612 	ldw	(0x02, sp), x
      0083B7 0F 01            [ 1]  613 	clr	(0x01, sp)
      0083B9                        614 00102$:
                                    615 ;	user/display.c: 144: shiftOut595(0x3F);
      0083B9 4B 3F            [ 1]  616 	push	#0x3f
      0083BB CD 81 AD         [ 4]  617 	call	_shiftOut595
      0083BE 84               [ 1]  618 	pop	a
                                    619 ;	user/display.c: 145: latch595();
      0083BF CD 82 0C         [ 4]  620 	call	_latch595
                                    621 ;	user/display.c: 146: GPIO_WriteHigh(display.portScan, display.led[0]);
      0083C2 1E 0A            [ 2]  622 	ldw	x, (0x0a, sp)
      0083C4 F6               [ 1]  623 	ld	a, (x)
      0083C5 1E 08            [ 2]  624 	ldw	x, (0x08, sp)
      0083C7 FE               [ 2]  625 	ldw	x, (x)
      0083C8 88               [ 1]  626 	push	a
      0083C9 89               [ 2]  627 	pushw	x
      0083CA CD 88 10         [ 4]  628 	call	_GPIO_WriteHigh
      0083CD 5B 03            [ 2]  629 	addw	sp, #3
                                    630 ;	user/display.c: 147: delay_us(50);
      0083CF 4B 32            [ 1]  631 	push	#0x32
      0083D1 4B 00            [ 1]  632 	push	#0x00
      0083D3 CD 80 A0         [ 4]  633 	call	_delay_us
      0083D6 85               [ 2]  634 	popw	x
                                    635 ;	user/display.c: 148: GPIO_WriteLow(display.portScan, display.led[0]);
      0083D7 1E 0A            [ 2]  636 	ldw	x, (0x0a, sp)
      0083D9 F6               [ 1]  637 	ld	a, (x)
      0083DA 1E 08            [ 2]  638 	ldw	x, (0x08, sp)
      0083DC FE               [ 2]  639 	ldw	x, (x)
      0083DD 88               [ 1]  640 	push	a
      0083DE 89               [ 2]  641 	pushw	x
      0083DF CD 88 17         [ 4]  642 	call	_GPIO_WriteLow
      0083E2 5B 03            [ 2]  643 	addw	sp, #3
                                    644 ;	user/display.c: 149: delay_us(10);
      0083E4 4B 0A            [ 1]  645 	push	#0x0a
      0083E6 4B 00            [ 1]  646 	push	#0x00
      0083E8 CD 80 A0         [ 4]  647 	call	_delay_us
      0083EB 85               [ 2]  648 	popw	x
                                    649 ;	user/display.c: 150: shiftOut595(0x06);
      0083EC 4B 06            [ 1]  650 	push	#0x06
      0083EE CD 81 AD         [ 4]  651 	call	_shiftOut595
      0083F1 84               [ 1]  652 	pop	a
                                    653 ;	user/display.c: 151: latch595();
      0083F2 CD 82 0C         [ 4]  654 	call	_latch595
                                    655 ;	user/display.c: 152: GPIO_WriteHigh(display.portScan, display.led[1]);
      0083F5 1E 06            [ 2]  656 	ldw	x, (0x06, sp)
      0083F7 F6               [ 1]  657 	ld	a, (x)
      0083F8 1E 08            [ 2]  658 	ldw	x, (0x08, sp)
      0083FA FE               [ 2]  659 	ldw	x, (x)
      0083FB 88               [ 1]  660 	push	a
      0083FC 89               [ 2]  661 	pushw	x
      0083FD CD 88 10         [ 4]  662 	call	_GPIO_WriteHigh
      008400 5B 03            [ 2]  663 	addw	sp, #3
                                    664 ;	user/display.c: 153: delay_us(50);
      008402 4B 32            [ 1]  665 	push	#0x32
      008404 4B 00            [ 1]  666 	push	#0x00
      008406 CD 80 A0         [ 4]  667 	call	_delay_us
      008409 85               [ 2]  668 	popw	x
                                    669 ;	user/display.c: 154: GPIO_WriteLow(display.portScan, display.led[1]);
      00840A 1E 06            [ 2]  670 	ldw	x, (0x06, sp)
      00840C F6               [ 1]  671 	ld	a, (x)
      00840D 1E 08            [ 2]  672 	ldw	x, (0x08, sp)
      00840F FE               [ 2]  673 	ldw	x, (x)
      008410 88               [ 1]  674 	push	a
      008411 89               [ 2]  675 	pushw	x
      008412 CD 88 17         [ 4]  676 	call	_GPIO_WriteLow
      008415 5B 03            [ 2]  677 	addw	sp, #3
                                    678 ;	user/display.c: 155: delay_us(10);
      008417 4B 0A            [ 1]  679 	push	#0x0a
      008419 4B 00            [ 1]  680 	push	#0x00
      00841B CD 80 A0         [ 4]  681 	call	_delay_us
      00841E 85               [ 2]  682 	popw	x
                                    683 ;	user/display.c: 156: shiftOut595(0x5B);
      00841F 4B 5B            [ 1]  684 	push	#0x5b
      008421 CD 81 AD         [ 4]  685 	call	_shiftOut595
      008424 84               [ 1]  686 	pop	a
                                    687 ;	user/display.c: 157: latch595();
      008425 CD 82 0C         [ 4]  688 	call	_latch595
                                    689 ;	user/display.c: 158: GPIO_WriteHigh(display.portScan, display.led[2]);
      008428 1E 04            [ 2]  690 	ldw	x, (0x04, sp)
      00842A F6               [ 1]  691 	ld	a, (x)
      00842B 1E 08            [ 2]  692 	ldw	x, (0x08, sp)
      00842D FE               [ 2]  693 	ldw	x, (x)
      00842E 88               [ 1]  694 	push	a
      00842F 89               [ 2]  695 	pushw	x
      008430 CD 88 10         [ 4]  696 	call	_GPIO_WriteHigh
      008433 5B 03            [ 2]  697 	addw	sp, #3
                                    698 ;	user/display.c: 159: delay_us(50);
      008435 4B 32            [ 1]  699 	push	#0x32
      008437 4B 00            [ 1]  700 	push	#0x00
      008439 CD 80 A0         [ 4]  701 	call	_delay_us
      00843C 85               [ 2]  702 	popw	x
                                    703 ;	user/display.c: 160: GPIO_WriteLow(display.portScan, display.led[2]);
      00843D 1E 04            [ 2]  704 	ldw	x, (0x04, sp)
      00843F F6               [ 1]  705 	ld	a, (x)
      008440 1E 08            [ 2]  706 	ldw	x, (0x08, sp)
      008442 FE               [ 2]  707 	ldw	x, (x)
      008443 88               [ 1]  708 	push	a
      008444 89               [ 2]  709 	pushw	x
      008445 CD 88 17         [ 4]  710 	call	_GPIO_WriteLow
      008448 5B 03            [ 2]  711 	addw	sp, #3
                                    712 ;	user/display.c: 161: delay_us(10);
      00844A 4B 0A            [ 1]  713 	push	#0x0a
      00844C 4B 00            [ 1]  714 	push	#0x00
      00844E CD 80 A0         [ 4]  715 	call	_delay_us
      008451 85               [ 2]  716 	popw	x
                                    717 ;	user/display.c: 162: shiftOut595(0x4F);
      008452 4B 4F            [ 1]  718 	push	#0x4f
      008454 CD 81 AD         [ 4]  719 	call	_shiftOut595
      008457 84               [ 1]  720 	pop	a
                                    721 ;	user/display.c: 163: latch595();
      008458 CD 82 0C         [ 4]  722 	call	_latch595
                                    723 ;	user/display.c: 164: GPIO_WriteHigh(display.portData, display.led[3]);
      00845B 1E 02            [ 2]  724 	ldw	x, (0x02, sp)
      00845D F6               [ 1]  725 	ld	a, (x)
      00845E 1E 0C            [ 2]  726 	ldw	x, (0x0c, sp)
      008460 FE               [ 2]  727 	ldw	x, (x)
      008461 88               [ 1]  728 	push	a
      008462 89               [ 2]  729 	pushw	x
      008463 CD 88 10         [ 4]  730 	call	_GPIO_WriteHigh
      008466 5B 03            [ 2]  731 	addw	sp, #3
                                    732 ;	user/display.c: 165: delay_us(50);
      008468 4B 32            [ 1]  733 	push	#0x32
      00846A 4B 00            [ 1]  734 	push	#0x00
      00846C CD 80 A0         [ 4]  735 	call	_delay_us
      00846F 85               [ 2]  736 	popw	x
                                    737 ;	user/display.c: 166: GPIO_WriteLow(display.portData, display.led[3]);
      008470 1E 02            [ 2]  738 	ldw	x, (0x02, sp)
      008472 F6               [ 1]  739 	ld	a, (x)
      008473 1E 0C            [ 2]  740 	ldw	x, (0x0c, sp)
      008475 FE               [ 2]  741 	ldw	x, (x)
      008476 88               [ 1]  742 	push	a
      008477 89               [ 2]  743 	pushw	x
      008478 CD 88 17         [ 4]  744 	call	_GPIO_WriteLow
      00847B 5B 03            [ 2]  745 	addw	sp, #3
                                    746 ;	user/display.c: 167: delay_us(10);
      00847D 4B 0A            [ 1]  747 	push	#0x0a
      00847F 4B 00            [ 1]  748 	push	#0x00
      008481 CD 80 A0         [ 4]  749 	call	_delay_us
      008484 85               [ 2]  750 	popw	x
                                    751 ;	user/display.c: 142: for(i = 0; i < 20; i++)
      008485 0C 01            [ 1]  752 	inc	(0x01, sp)
      008487 7B 01            [ 1]  753 	ld	a, (0x01, sp)
      008489 A1 14            [ 1]  754 	cp	a, #0x14
      00848B 24 03            [ 1]  755 	jrnc	00111$
      00848D CC 83 B9         [ 2]  756 	jp	00102$
      008490                        757 00111$:
      008490 5B 0D            [ 2]  758 	addw	sp, #13
      008492 81               [ 4]  759 	ret
                                    760 	.area CODE
      008493                        761 _code7Seg:
      008493 3F                     762 	.db #0x3f	; 63
      008494 06                     763 	.db #0x06	; 6
      008495 5B                     764 	.db #0x5b	; 91
      008496 4F                     765 	.db #0x4f	; 79	'O'
      008497 66                     766 	.db #0x66	; 102	'f'
      008498 6D                     767 	.db #0x6d	; 109	'm'
      008499 7D                     768 	.db #0x7d	; 125
      00849A 07                     769 	.db #0x07	; 7
      00849B 7F                     770 	.db #0x7f	; 127
      00849C 6F                     771 	.db #0x6f	; 111	'o'
                                    772 	.area INITIALIZER
                                    773 	.area CABS (ABS)
