                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.6.0 #9615 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8s_clk
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _HSIDivFactor
                                     12 	.globl _CLK_Config
                                     13 	.globl _CLK_PeripheralClockConfig
                                     14 	.globl _CLK_SYSCLKConfig
                                     15 	.globl _CLK_GetClockFreq
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
                                     24 ;--------------------------------------------------------
                                     25 ; absolute external ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area DABS (ABS)
                                     28 ;--------------------------------------------------------
                                     29 ; global & static initialisations
                                     30 ;--------------------------------------------------------
                                     31 	.area HOME
                                     32 	.area GSINIT
                                     33 	.area GSFINAL
                                     34 	.area GSINIT
                                     35 ;--------------------------------------------------------
                                     36 ; Home
                                     37 ;--------------------------------------------------------
                                     38 	.area HOME
                                     39 	.area HOME
                                     40 ;--------------------------------------------------------
                                     41 ; code
                                     42 ;--------------------------------------------------------
                                     43 	.area CODE
                                     44 ;	lib/stm8s_clk.c: 15: void CLK_Config(void)
                                     45 ;	-----------------------------------------
                                     46 ;	 function CLK_Config
                                     47 ;	-----------------------------------------
      008CF8                         48 _CLK_Config:
                                     49 ;	lib/stm8s_clk.c: 18: CLK->ICKR = CLK_ICKR_RESET_VALUE;
      008CF8 35 01 50 C0      [ 1]   50 	mov	0x50c0+0, #0x01
                                     51 ;	lib/stm8s_clk.c: 19: CLK->ECKR = CLK_ECKR_RESET_VALUE;
      008CFC 35 00 50 C1      [ 1]   52 	mov	0x50c1+0, #0x00
                                     53 ;	lib/stm8s_clk.c: 20: CLK->SWR  = CLK_SWR_RESET_VALUE;
      008D00 35 E1 50 C4      [ 1]   54 	mov	0x50c4+0, #0xe1
                                     55 ;	lib/stm8s_clk.c: 21: CLK->SWCR = CLK_SWCR_RESET_VALUE;
      008D04 35 00 50 C5      [ 1]   56 	mov	0x50c5+0, #0x00
                                     57 ;	lib/stm8s_clk.c: 22: CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
      008D08 35 18 50 C6      [ 1]   58 	mov	0x50c6+0, #0x18
                                     59 ;	lib/stm8s_clk.c: 23: CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
      008D0C 35 FF 50 C7      [ 1]   60 	mov	0x50c7+0, #0xff
                                     61 ;	lib/stm8s_clk.c: 24: CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
      008D10 35 FF 50 CA      [ 1]   62 	mov	0x50ca+0, #0xff
                                     63 ;	lib/stm8s_clk.c: 25: CLK->CSSR = CLK_CSSR_RESET_VALUE;
      008D14 35 00 50 C8      [ 1]   64 	mov	0x50c8+0, #0x00
                                     65 ;	lib/stm8s_clk.c: 26: CLK->CCOR = CLK_CCOR_RESET_VALUE;
      008D18 35 00 50 C9      [ 1]   66 	mov	0x50c9+0, #0x00
                                     67 ;	lib/stm8s_clk.c: 27: while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
      008D1C                         68 00101$:
      008D1C AE 50 C9         [ 2]   69 	ldw	x, #0x50c9
      008D1F F6               [ 1]   70 	ld	a, (x)
      008D20 44               [ 1]   71 	srl	a
      008D21 25 F9            [ 1]   72 	jrc	00101$
                                     73 ;	lib/stm8s_clk.c: 29: CLK->CCOR = CLK_CCOR_RESET_VALUE;
      008D23 35 00 50 C9      [ 1]   74 	mov	0x50c9+0, #0x00
                                     75 ;	lib/stm8s_clk.c: 30: CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
      008D27 35 00 50 CC      [ 1]   76 	mov	0x50cc+0, #0x00
                                     77 ;	lib/stm8s_clk.c: 31: CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
      008D2B 35 00 50 CD      [ 1]   78 	mov	0x50cd+0, #0x00
                                     79 ;	lib/stm8s_clk.c: 35: CLK->ICKR |= CLK_ICKR_HSIEN; /* Set HSIEN bit */
      008D2F 72 10 50 C0      [ 1]   80 	bset	0x50c0, #0
                                     81 ;	lib/stm8s_clk.c: 42: CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV); /* Clear High speed internal clock prescaler */
      008D33 AE 50 C6         [ 2]   82 	ldw	x, #0x50c6
      008D36 F6               [ 1]   83 	ld	a, (x)
      008D37 A4 E7            [ 1]   84 	and	a, #0xe7
      008D39 F7               [ 1]   85 	ld	(x), a
                                     86 ;	lib/stm8s_clk.c: 43: CLK->CKDIVR |= (uint8_t)CLK_PRESCALER_HSIDIV1; /* Set High speed internal clock prescaler */
      008D3A AE 50 C6         [ 2]   87 	ldw	x, #0x50c6
      008D3D F6               [ 1]   88 	ld	a, (x)
      008D3E AE 50 C6         [ 2]   89 	ldw	x, #0x50c6
      008D41 F7               [ 1]   90 	ld	(x), a
                                     91 ;	lib/stm8s_clk.c: 45: CLK_SYSCLKConfig(CLK_PRESCALER_HSIDIV1);
      008D42 4B 00            [ 1]   92 	push	#0x00
      008D44 CD 8D 9F         [ 4]   93 	call	_CLK_SYSCLKConfig
      008D47 84               [ 1]   94 	pop	a
      008D48 81               [ 4]   95 	ret
                                     96 ;	lib/stm8s_clk.c: 48: void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
                                     97 ;	-----------------------------------------
                                     98 ;	 function CLK_PeripheralClockConfig
                                     99 ;	-----------------------------------------
      008D49                        100 _CLK_PeripheralClockConfig:
      008D49 89               [ 2]  101 	pushw	x
                                    102 ;	lib/stm8s_clk.c: 55: CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
      008D4A 7B 05            [ 1]  103 	ld	a, (0x05, sp)
      008D4C A4 0F            [ 1]  104 	and	a, #0x0f
      008D4E 88               [ 1]  105 	push	a
      008D4F A6 01            [ 1]  106 	ld	a, #0x01
      008D51 6B 02            [ 1]  107 	ld	(0x02, sp), a
      008D53 84               [ 1]  108 	pop	a
      008D54 4D               [ 1]  109 	tnz	a
      008D55 27 05            [ 1]  110 	jreq	00125$
      008D57                        111 00124$:
      008D57 08 01            [ 1]  112 	sll	(0x01, sp)
      008D59 4A               [ 1]  113 	dec	a
      008D5A 26 FB            [ 1]  114 	jrne	00124$
      008D5C                        115 00125$:
                                    116 ;	lib/stm8s_clk.c: 60: CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
      008D5C 7B 01            [ 1]  117 	ld	a, (0x01, sp)
      008D5E 43               [ 1]  118 	cpl	a
      008D5F 6B 02            [ 1]  119 	ld	(0x02, sp), a
                                    120 ;	lib/stm8s_clk.c: 50: if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
      008D61 7B 05            [ 1]  121 	ld	a, (0x05, sp)
      008D63 A5 10            [ 1]  122 	bcp	a, #0x10
      008D65 26 1C            [ 1]  123 	jrne	00108$
                                    124 ;	lib/stm8s_clk.c: 52: if (NewState != DISABLE)
      008D67 0D 06            [ 1]  125 	tnz	(0x06, sp)
      008D69 27 0C            [ 1]  126 	jreq	00102$
                                    127 ;	lib/stm8s_clk.c: 55: CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
      008D6B AE 50 C7         [ 2]  128 	ldw	x, #0x50c7
      008D6E F6               [ 1]  129 	ld	a, (x)
      008D6F 1A 01            [ 1]  130 	or	a, (0x01, sp)
      008D71 AE 50 C7         [ 2]  131 	ldw	x, #0x50c7
      008D74 F7               [ 1]  132 	ld	(x), a
      008D75 20 26            [ 2]  133 	jra	00110$
      008D77                        134 00102$:
                                    135 ;	lib/stm8s_clk.c: 60: CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
      008D77 AE 50 C7         [ 2]  136 	ldw	x, #0x50c7
      008D7A F6               [ 1]  137 	ld	a, (x)
      008D7B 14 02            [ 1]  138 	and	a, (0x02, sp)
      008D7D AE 50 C7         [ 2]  139 	ldw	x, #0x50c7
      008D80 F7               [ 1]  140 	ld	(x), a
      008D81 20 1A            [ 2]  141 	jra	00110$
      008D83                        142 00108$:
                                    143 ;	lib/stm8s_clk.c: 65: if (NewState != DISABLE)
      008D83 0D 06            [ 1]  144 	tnz	(0x06, sp)
      008D85 27 0C            [ 1]  145 	jreq	00105$
                                    146 ;	lib/stm8s_clk.c: 68: CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
      008D87 AE 50 CA         [ 2]  147 	ldw	x, #0x50ca
      008D8A F6               [ 1]  148 	ld	a, (x)
      008D8B 1A 01            [ 1]  149 	or	a, (0x01, sp)
      008D8D AE 50 CA         [ 2]  150 	ldw	x, #0x50ca
      008D90 F7               [ 1]  151 	ld	(x), a
      008D91 20 0A            [ 2]  152 	jra	00110$
      008D93                        153 00105$:
                                    154 ;	lib/stm8s_clk.c: 73: CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
      008D93 AE 50 CA         [ 2]  155 	ldw	x, #0x50ca
      008D96 F6               [ 1]  156 	ld	a, (x)
      008D97 14 02            [ 1]  157 	and	a, (0x02, sp)
      008D99 AE 50 CA         [ 2]  158 	ldw	x, #0x50ca
      008D9C F7               [ 1]  159 	ld	(x), a
      008D9D                        160 00110$:
      008D9D 85               [ 2]  161 	popw	x
      008D9E 81               [ 4]  162 	ret
                                    163 ;	lib/stm8s_clk.c: 78: void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
                                    164 ;	-----------------------------------------
                                    165 ;	 function CLK_SYSCLKConfig
                                    166 ;	-----------------------------------------
      008D9F                        167 _CLK_SYSCLKConfig:
      008D9F 89               [ 2]  168 	pushw	x
                                    169 ;	lib/stm8s_clk.c: 80: if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
      008DA0 0D 05            [ 1]  170 	tnz	(0x05, sp)
      008DA2 2B 19            [ 1]  171 	jrmi	00102$
                                    172 ;	lib/stm8s_clk.c: 82: CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
      008DA4 AE 50 C6         [ 2]  173 	ldw	x, #0x50c6
      008DA7 F6               [ 1]  174 	ld	a, (x)
      008DA8 A4 E7            [ 1]  175 	and	a, #0xe7
      008DAA F7               [ 1]  176 	ld	(x), a
                                    177 ;	lib/stm8s_clk.c: 83: CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
      008DAB AE 50 C6         [ 2]  178 	ldw	x, #0x50c6
      008DAE F6               [ 1]  179 	ld	a, (x)
      008DAF 6B 02            [ 1]  180 	ld	(0x02, sp), a
      008DB1 7B 05            [ 1]  181 	ld	a, (0x05, sp)
      008DB3 A4 18            [ 1]  182 	and	a, #0x18
      008DB5 1A 02            [ 1]  183 	or	a, (0x02, sp)
      008DB7 AE 50 C6         [ 2]  184 	ldw	x, #0x50c6
      008DBA F7               [ 1]  185 	ld	(x), a
      008DBB 20 17            [ 2]  186 	jra	00104$
      008DBD                        187 00102$:
                                    188 ;	lib/stm8s_clk.c: 87: CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
      008DBD AE 50 C6         [ 2]  189 	ldw	x, #0x50c6
      008DC0 F6               [ 1]  190 	ld	a, (x)
      008DC1 A4 F8            [ 1]  191 	and	a, #0xf8
      008DC3 F7               [ 1]  192 	ld	(x), a
                                    193 ;	lib/stm8s_clk.c: 88: CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
      008DC4 AE 50 C6         [ 2]  194 	ldw	x, #0x50c6
      008DC7 F6               [ 1]  195 	ld	a, (x)
      008DC8 6B 01            [ 1]  196 	ld	(0x01, sp), a
      008DCA 7B 05            [ 1]  197 	ld	a, (0x05, sp)
      008DCC A4 07            [ 1]  198 	and	a, #0x07
      008DCE 1A 01            [ 1]  199 	or	a, (0x01, sp)
      008DD0 AE 50 C6         [ 2]  200 	ldw	x, #0x50c6
      008DD3 F7               [ 1]  201 	ld	(x), a
      008DD4                        202 00104$:
      008DD4 85               [ 2]  203 	popw	x
      008DD5 81               [ 4]  204 	ret
                                    205 ;	lib/stm8s_clk.c: 92: uint32_t CLK_GetClockFreq(void)
                                    206 ;	-----------------------------------------
                                    207 ;	 function CLK_GetClockFreq
                                    208 ;	-----------------------------------------
      008DD6                        209 _CLK_GetClockFreq:
      008DD6 52 07            [ 2]  210 	sub	sp, #7
                                    211 ;	lib/stm8s_clk.c: 99: clocksource = (CLK_Source_TypeDef)CLK->CMSR;
      008DD8 AE 50 C3         [ 2]  212 	ldw	x, #0x50c3
      008DDB F6               [ 1]  213 	ld	a, (x)
      008DDC 6B 01            [ 1]  214 	ld	(0x01, sp), a
                                    215 ;	lib/stm8s_clk.c: 100: if (clocksource == CLK_SOURCE_HSI)
      008DDE 7B 01            [ 1]  216 	ld	a, (0x01, sp)
      008DE0 A1 E1            [ 1]  217 	cp	a, #0xe1
      008DE2 26 2C            [ 1]  218 	jrne	00105$
                                    219 ;	lib/stm8s_clk.c: 102: tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
      008DE4 AE 50 C6         [ 2]  220 	ldw	x, #0x50c6
      008DE7 F6               [ 1]  221 	ld	a, (x)
      008DE8 A4 18            [ 1]  222 	and	a, #0x18
                                    223 ;	lib/stm8s_clk.c: 103: tmp = (uint8_t)(tmp >> 3);
      008DEA 44               [ 1]  224 	srl	a
      008DEB 44               [ 1]  225 	srl	a
      008DEC 44               [ 1]  226 	srl	a
                                    227 ;	lib/stm8s_clk.c: 104: presc = HSIDivFactor[tmp];
      008DED AE 8E 2F         [ 2]  228 	ldw	x, #_HSIDivFactor+0
      008DF0 1F 06            [ 2]  229 	ldw	(0x06, sp), x
      008DF2 5F               [ 1]  230 	clrw	x
      008DF3 97               [ 1]  231 	ld	xl, a
      008DF4 72 FB 06         [ 2]  232 	addw	x, (0x06, sp)
      008DF7 F6               [ 1]  233 	ld	a, (x)
                                    234 ;	lib/stm8s_clk.c: 105: clockfrequency = HSI_VALUE / presc;
      008DF8 5F               [ 1]  235 	clrw	x
      008DF9 97               [ 1]  236 	ld	xl, a
      008DFA 90 5F            [ 1]  237 	clrw	y
      008DFC 89               [ 2]  238 	pushw	x
      008DFD 90 89            [ 2]  239 	pushw	y
      008DFF 4B 00            [ 1]  240 	push	#0x00
      008E01 4B 24            [ 1]  241 	push	#0x24
      008E03 4B F4            [ 1]  242 	push	#0xf4
      008E05 4B 00            [ 1]  243 	push	#0x00
      008E07 CD 95 A9         [ 4]  244 	call	__divulong
      008E0A 5B 08            [ 2]  245 	addw	sp, #8
      008E0C 1F 04            [ 2]  246 	ldw	(0x04, sp), x
      008E0E 20 1A            [ 2]  247 	jra	00106$
      008E10                        248 00105$:
                                    249 ;	lib/stm8s_clk.c: 107: else if ( clocksource == CLK_SOURCE_LSI)
      008E10 7B 01            [ 1]  250 	ld	a, (0x01, sp)
      008E12 A1 D2            [ 1]  251 	cp	a, #0xd2
      008E14 26 0B            [ 1]  252 	jrne	00102$
                                    253 ;	lib/stm8s_clk.c: 109: clockfrequency = LSI_VALUE;
      008E16 AE F4 00         [ 2]  254 	ldw	x, #0xf400
      008E19 1F 04            [ 2]  255 	ldw	(0x04, sp), x
      008E1B 90 AE 00 01      [ 2]  256 	ldw	y, #0x0001
      008E1F 20 09            [ 2]  257 	jra	00106$
      008E21                        258 00102$:
                                    259 ;	lib/stm8s_clk.c: 113: clockfrequency = HSE_VALUE;
      008E21 AE 24 00         [ 2]  260 	ldw	x, #0x2400
      008E24 1F 04            [ 2]  261 	ldw	(0x04, sp), x
      008E26 90 AE 00 F4      [ 2]  262 	ldw	y, #0x00f4
      008E2A                        263 00106$:
                                    264 ;	lib/stm8s_clk.c: 115: return((uint32_t)clockfrequency);
      008E2A 1E 04            [ 2]  265 	ldw	x, (0x04, sp)
      008E2C 5B 07            [ 2]  266 	addw	sp, #7
      008E2E 81               [ 4]  267 	ret
                                    268 	.area CODE
      008E2F                        269 _HSIDivFactor:
      008E2F 01                     270 	.db #0x01	; 1
      008E30 02                     271 	.db #0x02	; 2
      008E31 04                     272 	.db #0x04	; 4
      008E32 08                     273 	.db #0x08	; 8
                                    274 	.area INITIALIZER
                                    275 	.area CABS (ABS)
