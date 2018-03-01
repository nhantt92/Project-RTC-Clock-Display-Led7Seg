                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.6.0 #9615 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module rtc
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _DS1307Write
                                     12 	.globl _DS1307Read
                                     13 	.globl _mktime
                                     14 	.globl _localtime
                                     15 	.globl _SoftI2CReadByte
                                     16 	.globl _SoftI2CWriteByte
                                     17 	.globl _SoftI2CStop
                                     18 	.globl _SoftI2CStart
                                     19 	.globl _SoftI2CInit
                                     20 	.globl _dayTime
                                     21 	.globl _RTC_Init
                                     22 	.globl _RTC_GetDateTime
                                     23 	.globl _RTC_SetDateTime
                                     24 	.globl _BCD2BIN
                                     25 	.globl _BIN2BCD
                                     26 	.globl _RTC_CalcTime
                                     27 	.globl _RTC_GetUnixTimestamp
                                     28 ;--------------------------------------------------------
                                     29 ; ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DATA
      00001D                         32 _dayTime::
      00001D                         33 	.ds 7
                                     34 ;--------------------------------------------------------
                                     35 ; ram data
                                     36 ;--------------------------------------------------------
                                     37 	.area INITIALIZED
                                     38 ;--------------------------------------------------------
                                     39 ; absolute external ram data
                                     40 ;--------------------------------------------------------
                                     41 	.area DABS (ABS)
                                     42 ;--------------------------------------------------------
                                     43 ; global & static initialisations
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area GSINIT
                                     47 	.area GSFINAL
                                     48 	.area GSINIT
                                     49 ;--------------------------------------------------------
                                     50 ; Home
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area HOME
                                     54 ;--------------------------------------------------------
                                     55 ; code
                                     56 ;--------------------------------------------------------
                                     57 	.area CODE
                                     58 ;	user/rtc.c: 7: void RTC_Init(void)
                                     59 ;	-----------------------------------------
                                     60 ;	 function RTC_Init
                                     61 ;	-----------------------------------------
      00889E                         62 _RTC_Init:
      00889E 89               [ 2]   63 	pushw	x
                                     64 ;	user/rtc.c: 9: SoftI2CInit(); 
      00889F CD 84 CA         [ 4]   65 	call	_SoftI2CInit
                                     66 ;	user/rtc.c: 10: dayTime.sec = 1;
      0088A2 AE 00 1D         [ 2]   67 	ldw	x, #_dayTime+0
      0088A5 A6 01            [ 1]   68 	ld	a, #0x01
      0088A7 F7               [ 1]   69 	ld	(x), a
                                     70 ;	user/rtc.c: 11: dayTime.min = 8;
      0088A8 AE 00 1D         [ 2]   71 	ldw	x, #_dayTime+0
      0088AB 1F 01            [ 2]   72 	ldw	(0x01, sp), x
      0088AD 1E 01            [ 2]   73 	ldw	x, (0x01, sp)
      0088AF 5C               [ 2]   74 	incw	x
      0088B0 A6 08            [ 1]   75 	ld	a, #0x08
      0088B2 F7               [ 1]   76 	ld	(x), a
                                     77 ;	user/rtc.c: 12: dayTime.hour = 11;
      0088B3 1E 01            [ 2]   78 	ldw	x, (0x01, sp)
      0088B5 5C               [ 2]   79 	incw	x
      0088B6 5C               [ 2]   80 	incw	x
      0088B7 A6 0B            [ 1]   81 	ld	a, #0x0b
      0088B9 F7               [ 1]   82 	ld	(x), a
                                     83 ;	user/rtc.c: 13: dayTime.day = 1;
      0088BA 1E 01            [ 2]   84 	ldw	x, (0x01, sp)
      0088BC A6 01            [ 1]   85 	ld	a, #0x01
      0088BE E7 03            [ 1]   86 	ld	(0x0003, x), a
                                     87 ;	user/rtc.c: 14: dayTime.date = 16;
      0088C0 1E 01            [ 2]   88 	ldw	x, (0x01, sp)
      0088C2 A6 10            [ 1]   89 	ld	a, #0x10
      0088C4 E7 04            [ 1]   90 	ld	(0x0004, x), a
                                     91 ;	user/rtc.c: 15: dayTime.month = 8;
      0088C6 1E 01            [ 2]   92 	ldw	x, (0x01, sp)
      0088C8 A6 08            [ 1]   93 	ld	a, #0x08
      0088CA E7 05            [ 1]   94 	ld	(0x0005, x), a
                                     95 ;	user/rtc.c: 16: dayTime.year = 15;
      0088CC 1E 01            [ 2]   96 	ldw	x, (0x01, sp)
      0088CE A6 0F            [ 1]   97 	ld	a, #0x0f
      0088D0 E7 06            [ 1]   98 	ld	(0x0006, x), a
                                     99 ;	user/rtc.c: 17: RTC_SetDateTime(&dayTime);
      0088D2 1E 01            [ 2]  100 	ldw	x, (0x01, sp)
      0088D4 89               [ 2]  101 	pushw	x
      0088D5 CD 8A 2F         [ 4]  102 	call	_RTC_SetDateTime
      0088D8 5B 04            [ 2]  103 	addw	sp, #4
      0088DA 81               [ 4]  104 	ret
                                    105 ;	user/rtc.c: 30: uint8_t DS1307Read(uint8_t address,uint8_t *data)
                                    106 ;	-----------------------------------------
                                    107 ;	 function DS1307Read
                                    108 ;	-----------------------------------------
      0088DB                        109 _DS1307Read:
      0088DB 88               [ 1]  110 	push	a
                                    111 ;	user/rtc.c: 33: disableInterrupts();
      0088DC 9B               [ 1]  112 	sim
                                    113 ;	user/rtc.c: 35: SoftI2CStart();   
      0088DD CD 85 03         [ 4]  114 	call	_SoftI2CStart
                                    115 ;	user/rtc.c: 37: res=SoftI2CWriteByte(DS1307_SLA_W); //DS1307 address + W   
      0088E0 4B D0            [ 1]  116 	push	#0xd0
      0088E2 CD 85 A5         [ 4]  117 	call	_SoftI2CWriteByte
      0088E5 5B 01            [ 2]  118 	addw	sp, #1
                                    119 ;	user/rtc.c: 39: if(!res)    return FALSE;   
      0088E7 4D               [ 1]  120 	tnz	a
      0088E8 26 03            [ 1]  121 	jrne	00102$
      0088EA 4F               [ 1]  122 	clr	a
      0088EB 20 3A            [ 2]  123 	jra	00109$
      0088ED                        124 00102$:
                                    125 ;	user/rtc.c: 41: res=SoftI2CWriteByte(address);
      0088ED 7B 04            [ 1]  126 	ld	a, (0x04, sp)
      0088EF 88               [ 1]  127 	push	a
      0088F0 CD 85 A5         [ 4]  128 	call	_SoftI2CWriteByte
      0088F3 5B 01            [ 2]  129 	addw	sp, #1
                                    130 ;	user/rtc.c: 43: if(!res)    return FALSE;
      0088F5 4D               [ 1]  131 	tnz	a
      0088F6 26 03            [ 1]  132 	jrne	00104$
      0088F8 4F               [ 1]  133 	clr	a
      0088F9 20 2C            [ 2]  134 	jra	00109$
      0088FB                        135 00104$:
                                    136 ;	user/rtc.c: 45: SoftI2CStart();
      0088FB CD 85 03         [ 4]  137 	call	_SoftI2CStart
                                    138 ;	user/rtc.c: 47: res=SoftI2CWriteByte(DS1307_SLA_R); //DS1307 Address + R
      0088FE 4B D1            [ 1]  139 	push	#0xd1
      008900 CD 85 A5         [ 4]  140 	call	_SoftI2CWriteByte
      008903 5B 01            [ 2]  141 	addw	sp, #1
      008905 6B 01            [ 1]  142 	ld	(0x01, sp), a
                                    143 ;	user/rtc.c: 49: if(!res)    return FALSE;
      008907 0D 01            [ 1]  144 	tnz	(0x01, sp)
      008909 26 03            [ 1]  145 	jrne	00106$
      00890B 4F               [ 1]  146 	clr	a
      00890C 20 19            [ 2]  147 	jra	00109$
      00890E                        148 00106$:
                                    149 ;	user/rtc.c: 51: *data=SoftI2CReadByte(0);  
      00890E 1E 05            [ 2]  150 	ldw	x, (0x05, sp)
      008910 89               [ 2]  151 	pushw	x
      008911 4B 00            [ 1]  152 	push	#0x00
      008913 CD 86 E1         [ 4]  153 	call	_SoftI2CReadByte
      008916 5B 01            [ 2]  154 	addw	sp, #1
      008918 85               [ 2]  155 	popw	x
      008919 F7               [ 1]  156 	ld	(x), a
                                    157 ;	user/rtc.c: 53: if(!res)    return FALSE;   
      00891A 0D 01            [ 1]  158 	tnz	(0x01, sp)
      00891C 26 03            [ 1]  159 	jrne	00108$
      00891E 4F               [ 1]  160 	clr	a
      00891F 20 06            [ 2]  161 	jra	00109$
      008921                        162 00108$:
                                    163 ;	user/rtc.c: 55: SoftI2CStop();
      008921 CD 85 45         [ 4]  164 	call	_SoftI2CStop
                                    165 ;	user/rtc.c: 56: enableInterrupts();
      008924 9A               [ 1]  166 	rim
                                    167 ;	user/rtc.c: 57: return TRUE;
      008925 A6 01            [ 1]  168 	ld	a, #0x01
      008927                        169 00109$:
      008927 5B 01            [ 2]  170 	addw	sp, #1
      008929 81               [ 4]  171 	ret
                                    172 ;	user/rtc.c: 71: uint8_t DS1307Write(uint8_t address,uint8_t data)
                                    173 ;	-----------------------------------------
                                    174 ;	 function DS1307Write
                                    175 ;	-----------------------------------------
      00892A                        176 _DS1307Write:
                                    177 ;	user/rtc.c: 74: disableInterrupts();
      00892A 9B               [ 1]  178 	sim
                                    179 ;	user/rtc.c: 76: SoftI2CStart();    
      00892B CD 85 03         [ 4]  180 	call	_SoftI2CStart
                                    181 ;	user/rtc.c: 78: res=SoftI2CWriteByte(DS1307_SLA_W); //DS1307 address + W    
      00892E 4B D0            [ 1]  182 	push	#0xd0
      008930 CD 85 A5         [ 4]  183 	call	_SoftI2CWriteByte
      008933 5B 01            [ 2]  184 	addw	sp, #1
                                    185 ;	user/rtc.c: 80: if(!res)    return FALSE;
      008935 4D               [ 1]  186 	tnz	a
      008936 26 02            [ 1]  187 	jrne	00102$
      008938 4F               [ 1]  188 	clr	a
      008939 81               [ 4]  189 	ret
      00893A                        190 00102$:
                                    191 ;	user/rtc.c: 82: res=SoftI2CWriteByte(address);
      00893A 7B 03            [ 1]  192 	ld	a, (0x03, sp)
      00893C 88               [ 1]  193 	push	a
      00893D CD 85 A5         [ 4]  194 	call	_SoftI2CWriteByte
      008940 5B 01            [ 2]  195 	addw	sp, #1
                                    196 ;	user/rtc.c: 84: if(!res)    return FALSE;
      008942 4D               [ 1]  197 	tnz	a
      008943 26 02            [ 1]  198 	jrne	00104$
      008945 4F               [ 1]  199 	clr	a
      008946 81               [ 4]  200 	ret
      008947                        201 00104$:
                                    202 ;	user/rtc.c: 86: res=SoftI2CWriteByte(data);   
      008947 7B 04            [ 1]  203 	ld	a, (0x04, sp)
      008949 88               [ 1]  204 	push	a
      00894A CD 85 A5         [ 4]  205 	call	_SoftI2CWriteByte
      00894D 5B 01            [ 2]  206 	addw	sp, #1
                                    207 ;	user/rtc.c: 88: if(!res)    return FALSE;
      00894F 4D               [ 1]  208 	tnz	a
      008950 26 02            [ 1]  209 	jrne	00106$
      008952 4F               [ 1]  210 	clr	a
      008953 81               [ 4]  211 	ret
      008954                        212 00106$:
                                    213 ;	user/rtc.c: 90: SoftI2CStop();
      008954 CD 85 45         [ 4]  214 	call	_SoftI2CStop
                                    215 ;	user/rtc.c: 91: enableInterrupts();
      008957 9A               [ 1]  216 	rim
                                    217 ;	user/rtc.c: 92: return TRUE;
      008958 A6 01            [ 1]  218 	ld	a, #0x01
      00895A 81               [ 4]  219 	ret
                                    220 ;	user/rtc.c: 95: void RTC_GetDateTime(RTC_TIME* time) 
                                    221 ;	-----------------------------------------
                                    222 ;	 function RTC_GetDateTime
                                    223 ;	-----------------------------------------
      00895B                        224 _RTC_GetDateTime:
      00895B 52 18            [ 2]  225 	sub	sp, #24
                                    226 ;	user/rtc.c: 99: for(i=0;i<8;i++)
      00895D 96               [ 1]  227 	ldw	x, sp
      00895E 5C               [ 2]  228 	incw	x
      00895F 1F 17            [ 2]  229 	ldw	(0x17, sp), x
      008961 4F               [ 1]  230 	clr	a
      008962                        231 00107$:
                                    232 ;	user/rtc.c: 101: status = DS1307Read(i, &data[i]);
      008962 5F               [ 1]  233 	clrw	x
      008963 97               [ 1]  234 	ld	xl, a
      008964 72 FB 17         [ 2]  235 	addw	x, (0x17, sp)
      008967 88               [ 1]  236 	push	a
      008968 89               [ 2]  237 	pushw	x
      008969 88               [ 1]  238 	push	a
      00896A CD 88 DB         [ 4]  239 	call	_DS1307Read
      00896D 5B 03            [ 2]  240 	addw	sp, #3
      00896F 84               [ 1]  241 	pop	a
                                    242 ;	user/rtc.c: 99: for(i=0;i<8;i++)
      008970 4C               [ 1]  243 	inc	a
      008971 A1 08            [ 1]  244 	cp	a, #0x08
      008973 25 ED            [ 1]  245 	jrc	00107$
                                    246 ;	user/rtc.c: 105: time->sec = BCD2BIN(data[0]&=0x7F);
      008975 16 1B            [ 2]  247 	ldw	y, (0x1b, sp)
      008977 17 15            [ 2]  248 	ldw	(0x15, sp), y
      008979 1E 17            [ 2]  249 	ldw	x, (0x17, sp)
      00897B F6               [ 1]  250 	ld	a, (x)
      00897C A4 7F            [ 1]  251 	and	a, #0x7f
      00897E 1E 17            [ 2]  252 	ldw	x, (0x17, sp)
      008980 F7               [ 1]  253 	ld	(x), a
      008981 88               [ 1]  254 	push	a
      008982 CD 8A D6         [ 4]  255 	call	_BCD2BIN
      008985 5B 01            [ 2]  256 	addw	sp, #1
      008987 1E 15            [ 2]  257 	ldw	x, (0x15, sp)
      008989 F7               [ 1]  258 	ld	(x), a
                                    259 ;	user/rtc.c: 106: time->min = BCD2BIN(data[1]&=0x7F);
      00898A 1E 15            [ 2]  260 	ldw	x, (0x15, sp)
      00898C 5C               [ 2]  261 	incw	x
      00898D 1F 13            [ 2]  262 	ldw	(0x13, sp), x
      00898F 1E 17            [ 2]  263 	ldw	x, (0x17, sp)
      008991 5C               [ 2]  264 	incw	x
      008992 F6               [ 1]  265 	ld	a, (x)
      008993 A4 7F            [ 1]  266 	and	a, #0x7f
      008995 F7               [ 1]  267 	ld	(x), a
      008996 88               [ 1]  268 	push	a
      008997 CD 8A D6         [ 4]  269 	call	_BCD2BIN
      00899A 5B 01            [ 2]  270 	addw	sp, #1
      00899C 1E 13            [ 2]  271 	ldw	x, (0x13, sp)
      00899E F7               [ 1]  272 	ld	(x), a
                                    273 ;	user/rtc.c: 107: if((data[2]&0x40)!=0)time->hour=BCD2BIN(data[2]&=0x1F);
      00899F 1E 17            [ 2]  274 	ldw	x, (0x17, sp)
      0089A1 5C               [ 2]  275 	incw	x
      0089A2 5C               [ 2]  276 	incw	x
      0089A3 F6               [ 1]  277 	ld	a, (x)
      0089A4 16 15            [ 2]  278 	ldw	y, (0x15, sp)
      0089A6 90 5C            [ 2]  279 	incw	y
      0089A8 90 5C            [ 2]  280 	incw	y
      0089AA 17 09            [ 2]  281 	ldw	(0x09, sp), y
      0089AC A5 40            [ 1]  282 	bcp	a, #0x40
      0089AE 27 0E            [ 1]  283 	jreq	00105$
      0089B0 A4 1F            [ 1]  284 	and	a, #0x1f
      0089B2 F7               [ 1]  285 	ld	(x), a
      0089B3 88               [ 1]  286 	push	a
      0089B4 CD 8A D6         [ 4]  287 	call	_BCD2BIN
      0089B7 5B 01            [ 2]  288 	addw	sp, #1
      0089B9 1E 09            [ 2]  289 	ldw	x, (0x09, sp)
      0089BB F7               [ 1]  290 	ld	(x), a
      0089BC 20 0C            [ 2]  291 	jra	00106$
      0089BE                        292 00105$:
                                    293 ;	user/rtc.c: 108: else time->hour=BCD2BIN(data[2]&=0x3F);
      0089BE A4 3F            [ 1]  294 	and	a, #0x3f
      0089C0 F7               [ 1]  295 	ld	(x), a
      0089C1 88               [ 1]  296 	push	a
      0089C2 CD 8A D6         [ 4]  297 	call	_BCD2BIN
      0089C5 5B 01            [ 2]  298 	addw	sp, #1
      0089C7 1E 09            [ 2]  299 	ldw	x, (0x09, sp)
      0089C9 F7               [ 1]  300 	ld	(x), a
      0089CA                        301 00106$:
                                    302 ;	user/rtc.c: 109: time->day = BCD2BIN(data[3]&=0x07);
      0089CA 1E 15            [ 2]  303 	ldw	x, (0x15, sp)
      0089CC 1C 00 03         [ 2]  304 	addw	x, #0x0003
      0089CF 1F 11            [ 2]  305 	ldw	(0x11, sp), x
      0089D1 1E 17            [ 2]  306 	ldw	x, (0x17, sp)
      0089D3 1C 00 03         [ 2]  307 	addw	x, #0x0003
      0089D6 F6               [ 1]  308 	ld	a, (x)
      0089D7 A4 07            [ 1]  309 	and	a, #0x07
      0089D9 F7               [ 1]  310 	ld	(x), a
      0089DA 88               [ 1]  311 	push	a
      0089DB CD 8A D6         [ 4]  312 	call	_BCD2BIN
      0089DE 5B 01            [ 2]  313 	addw	sp, #1
      0089E0 1E 11            [ 2]  314 	ldw	x, (0x11, sp)
      0089E2 F7               [ 1]  315 	ld	(x), a
                                    316 ;	user/rtc.c: 110: time->date = BCD2BIN(data[4]&=0x3F);
      0089E3 1E 15            [ 2]  317 	ldw	x, (0x15, sp)
      0089E5 1C 00 04         [ 2]  318 	addw	x, #0x0004
      0089E8 1F 0F            [ 2]  319 	ldw	(0x0f, sp), x
      0089EA 1E 17            [ 2]  320 	ldw	x, (0x17, sp)
      0089EC 1C 00 04         [ 2]  321 	addw	x, #0x0004
      0089EF F6               [ 1]  322 	ld	a, (x)
      0089F0 A4 3F            [ 1]  323 	and	a, #0x3f
      0089F2 F7               [ 1]  324 	ld	(x), a
      0089F3 88               [ 1]  325 	push	a
      0089F4 CD 8A D6         [ 4]  326 	call	_BCD2BIN
      0089F7 5B 01            [ 2]  327 	addw	sp, #1
      0089F9 1E 0F            [ 2]  328 	ldw	x, (0x0f, sp)
      0089FB F7               [ 1]  329 	ld	(x), a
                                    330 ;	user/rtc.c: 111: time->month = BCD2BIN(data[5]&=0x1F);
      0089FC 1E 15            [ 2]  331 	ldw	x, (0x15, sp)
      0089FE 1C 00 05         [ 2]  332 	addw	x, #0x0005
      008A01 1F 0D            [ 2]  333 	ldw	(0x0d, sp), x
      008A03 1E 17            [ 2]  334 	ldw	x, (0x17, sp)
      008A05 1C 00 05         [ 2]  335 	addw	x, #0x0005
      008A08 F6               [ 1]  336 	ld	a, (x)
      008A09 A4 1F            [ 1]  337 	and	a, #0x1f
      008A0B F7               [ 1]  338 	ld	(x), a
      008A0C 88               [ 1]  339 	push	a
      008A0D CD 8A D6         [ 4]  340 	call	_BCD2BIN
      008A10 5B 01            [ 2]  341 	addw	sp, #1
      008A12 1E 0D            [ 2]  342 	ldw	x, (0x0d, sp)
      008A14 F7               [ 1]  343 	ld	(x), a
                                    344 ;	user/rtc.c: 112: time->year = BCD2BIN(data[6]&=0xFF);
      008A15 1E 15            [ 2]  345 	ldw	x, (0x15, sp)
      008A17 1C 00 06         [ 2]  346 	addw	x, #0x0006
      008A1A 1F 0B            [ 2]  347 	ldw	(0x0b, sp), x
      008A1C 1E 17            [ 2]  348 	ldw	x, (0x17, sp)
      008A1E 1C 00 06         [ 2]  349 	addw	x, #0x0006
      008A21 F6               [ 1]  350 	ld	a, (x)
      008A22 F7               [ 1]  351 	ld	(x), a
      008A23 88               [ 1]  352 	push	a
      008A24 CD 8A D6         [ 4]  353 	call	_BCD2BIN
      008A27 5B 01            [ 2]  354 	addw	sp, #1
      008A29 1E 0B            [ 2]  355 	ldw	x, (0x0b, sp)
      008A2B F7               [ 1]  356 	ld	(x), a
      008A2C 5B 18            [ 2]  357 	addw	sp, #24
      008A2E 81               [ 4]  358 	ret
                                    359 ;	user/rtc.c: 115: void RTC_SetDateTime(RTC_TIME* time)
                                    360 ;	-----------------------------------------
                                    361 ;	 function RTC_SetDateTime
                                    362 ;	-----------------------------------------
      008A2F                        363 _RTC_SetDateTime:
      008A2F 52 0C            [ 2]  364 	sub	sp, #12
                                    365 ;	user/rtc.c: 119: data[0]=BIN2BCD(time->sec);
      008A31 96               [ 1]  366 	ldw	x, sp
      008A32 5C               [ 2]  367 	incw	x
      008A33 1F 0B            [ 2]  368 	ldw	(0x0b, sp), x
      008A35 16 0F            [ 2]  369 	ldw	y, (0x0f, sp)
      008A37 17 09            [ 2]  370 	ldw	(0x09, sp), y
      008A39 1E 09            [ 2]  371 	ldw	x, (0x09, sp)
      008A3B F6               [ 1]  372 	ld	a, (x)
      008A3C 88               [ 1]  373 	push	a
      008A3D CD 8A EE         [ 4]  374 	call	_BIN2BCD
      008A40 5B 01            [ 2]  375 	addw	sp, #1
      008A42 1E 0B            [ 2]  376 	ldw	x, (0x0b, sp)
      008A44 F7               [ 1]  377 	ld	(x), a
                                    378 ;	user/rtc.c: 120: data[1]=BIN2BCD(time->min);
      008A45 1E 0B            [ 2]  379 	ldw	x, (0x0b, sp)
      008A47 5C               [ 2]  380 	incw	x
      008A48 16 09            [ 2]  381 	ldw	y, (0x09, sp)
      008A4A 90 E6 01         [ 1]  382 	ld	a, (0x1, y)
      008A4D 89               [ 2]  383 	pushw	x
      008A4E 88               [ 1]  384 	push	a
      008A4F CD 8A EE         [ 4]  385 	call	_BIN2BCD
      008A52 5B 01            [ 2]  386 	addw	sp, #1
      008A54 85               [ 2]  387 	popw	x
      008A55 F7               [ 1]  388 	ld	(x), a
                                    389 ;	user/rtc.c: 121: data[2]=BIN2BCD(time->hour);
      008A56 1E 0B            [ 2]  390 	ldw	x, (0x0b, sp)
      008A58 5C               [ 2]  391 	incw	x
      008A59 5C               [ 2]  392 	incw	x
      008A5A 16 09            [ 2]  393 	ldw	y, (0x09, sp)
      008A5C 90 E6 02         [ 1]  394 	ld	a, (0x2, y)
      008A5F 89               [ 2]  395 	pushw	x
      008A60 88               [ 1]  396 	push	a
      008A61 CD 8A EE         [ 4]  397 	call	_BIN2BCD
      008A64 5B 01            [ 2]  398 	addw	sp, #1
      008A66 85               [ 2]  399 	popw	x
      008A67 F7               [ 1]  400 	ld	(x), a
                                    401 ;	user/rtc.c: 122: data[3]=BIN2BCD(time->day);
      008A68 1E 0B            [ 2]  402 	ldw	x, (0x0b, sp)
      008A6A 1C 00 03         [ 2]  403 	addw	x, #0x0003
      008A6D 16 09            [ 2]  404 	ldw	y, (0x09, sp)
      008A6F 90 E6 03         [ 1]  405 	ld	a, (0x3, y)
      008A72 89               [ 2]  406 	pushw	x
      008A73 88               [ 1]  407 	push	a
      008A74 CD 8A EE         [ 4]  408 	call	_BIN2BCD
      008A77 5B 01            [ 2]  409 	addw	sp, #1
      008A79 85               [ 2]  410 	popw	x
      008A7A F7               [ 1]  411 	ld	(x), a
                                    412 ;	user/rtc.c: 123: data[4]=BIN2BCD(time->date);
      008A7B 1E 0B            [ 2]  413 	ldw	x, (0x0b, sp)
      008A7D 1C 00 04         [ 2]  414 	addw	x, #0x0004
      008A80 16 09            [ 2]  415 	ldw	y, (0x09, sp)
      008A82 90 E6 04         [ 1]  416 	ld	a, (0x4, y)
      008A85 89               [ 2]  417 	pushw	x
      008A86 88               [ 1]  418 	push	a
      008A87 CD 8A EE         [ 4]  419 	call	_BIN2BCD
      008A8A 5B 01            [ 2]  420 	addw	sp, #1
      008A8C 85               [ 2]  421 	popw	x
      008A8D F7               [ 1]  422 	ld	(x), a
                                    423 ;	user/rtc.c: 124: data[5]=BIN2BCD(time->month);
      008A8E 1E 0B            [ 2]  424 	ldw	x, (0x0b, sp)
      008A90 1C 00 05         [ 2]  425 	addw	x, #0x0005
      008A93 16 09            [ 2]  426 	ldw	y, (0x09, sp)
      008A95 90 E6 05         [ 1]  427 	ld	a, (0x5, y)
      008A98 89               [ 2]  428 	pushw	x
      008A99 88               [ 1]  429 	push	a
      008A9A CD 8A EE         [ 4]  430 	call	_BIN2BCD
      008A9D 5B 01            [ 2]  431 	addw	sp, #1
      008A9F 85               [ 2]  432 	popw	x
      008AA0 F7               [ 1]  433 	ld	(x), a
                                    434 ;	user/rtc.c: 125: data[6]=BIN2BCD(time->year);
      008AA1 1E 0B            [ 2]  435 	ldw	x, (0x0b, sp)
      008AA3 1C 00 06         [ 2]  436 	addw	x, #0x0006
      008AA6 16 09            [ 2]  437 	ldw	y, (0x09, sp)
      008AA8 90 E6 06         [ 1]  438 	ld	a, (0x6, y)
      008AAB 89               [ 2]  439 	pushw	x
      008AAC 88               [ 1]  440 	push	a
      008AAD CD 8A EE         [ 4]  441 	call	_BIN2BCD
      008AB0 5B 01            [ 2]  442 	addw	sp, #1
      008AB2 85               [ 2]  443 	popw	x
      008AB3 F7               [ 1]  444 	ld	(x), a
                                    445 ;	user/rtc.c: 126: data[7]=0;
      008AB4 1E 0B            [ 2]  446 	ldw	x, (0x0b, sp)
      008AB6 1C 00 07         [ 2]  447 	addw	x, #0x0007
      008AB9 7F               [ 1]  448 	clr	(x)
                                    449 ;	user/rtc.c: 127: for(i=0;i<8;i++)
      008ABA 4F               [ 1]  450 	clr	a
      008ABB                        451 00104$:
                                    452 ;	user/rtc.c: 129: status = DS1307Write(i, data[i]);
      008ABB 5F               [ 1]  453 	clrw	x
      008ABC 97               [ 1]  454 	ld	xl, a
      008ABD 72 FB 0B         [ 2]  455 	addw	x, (0x0b, sp)
      008AC0 88               [ 1]  456 	push	a
      008AC1 F6               [ 1]  457 	ld	a, (x)
      008AC2 97               [ 1]  458 	ld	xl, a
      008AC3 84               [ 1]  459 	pop	a
      008AC4 88               [ 1]  460 	push	a
      008AC5 89               [ 2]  461 	pushw	x
      008AC6 5B 01            [ 2]  462 	addw	sp, #1
      008AC8 88               [ 1]  463 	push	a
      008AC9 CD 89 2A         [ 4]  464 	call	_DS1307Write
      008ACC 85               [ 2]  465 	popw	x
      008ACD 84               [ 1]  466 	pop	a
                                    467 ;	user/rtc.c: 127: for(i=0;i<8;i++)
      008ACE 4C               [ 1]  468 	inc	a
      008ACF A1 08            [ 1]  469 	cp	a, #0x08
      008AD1 25 E8            [ 1]  470 	jrc	00104$
      008AD3 5B 0C            [ 2]  471 	addw	sp, #12
      008AD5 81               [ 4]  472 	ret
                                    473 ;	user/rtc.c: 135: uint8_t BCD2BIN(uint8_t data)
                                    474 ;	-----------------------------------------
                                    475 ;	 function BCD2BIN
                                    476 ;	-----------------------------------------
      008AD6                        477 _BCD2BIN:
      008AD6 88               [ 1]  478 	push	a
                                    479 ;	user/rtc.c: 138: high=(data>>4)&0x0F;
      008AD7 7B 04            [ 1]  480 	ld	a, (0x04, sp)
      008AD9 4E               [ 1]  481 	swap	a
      008ADA A4 0F            [ 1]  482 	and	a, #0x0f
      008ADC A4 0F            [ 1]  483 	and	a, #0x0f
      008ADE 97               [ 1]  484 	ld	xl, a
                                    485 ;	user/rtc.c: 139: low=data&0x0F;
      008ADF 7B 04            [ 1]  486 	ld	a, (0x04, sp)
      008AE1 A4 0F            [ 1]  487 	and	a, #0x0f
      008AE3 6B 01            [ 1]  488 	ld	(0x01, sp), a
                                    489 ;	user/rtc.c: 140: return ((high*10)+low);
      008AE5 A6 0A            [ 1]  490 	ld	a, #0x0a
      008AE7 42               [ 4]  491 	mul	x, a
      008AE8 9F               [ 1]  492 	ld	a, xl
      008AE9 1B 01            [ 1]  493 	add	a, (0x01, sp)
      008AEB 5B 01            [ 2]  494 	addw	sp, #1
      008AED 81               [ 4]  495 	ret
                                    496 ;	user/rtc.c: 143: uint8_t BIN2BCD(uint8_t data)
                                    497 ;	-----------------------------------------
                                    498 ;	 function BIN2BCD
                                    499 ;	-----------------------------------------
      008AEE                        500 _BIN2BCD:
      008AEE 88               [ 1]  501 	push	a
                                    502 ;	user/rtc.c: 146: high=data/10; high =(high<<4)&0xF0;
      008AEF 5F               [ 1]  503 	clrw	x
      008AF0 7B 04            [ 1]  504 	ld	a, (0x04, sp)
      008AF2 97               [ 1]  505 	ld	xl, a
      008AF3 A6 0A            [ 1]  506 	ld	a, #0x0a
      008AF5 62               [ 2]  507 	div	x, a
      008AF6 9F               [ 1]  508 	ld	a, xl
      008AF7 4E               [ 1]  509 	swap	a
      008AF8 A4 F0            [ 1]  510 	and	a, #0xf0
      008AFA A4 F0            [ 1]  511 	and	a, #0xf0
      008AFC 6B 01            [ 1]  512 	ld	(0x01, sp), a
                                    513 ;	user/rtc.c: 147: low=data%10;  low&=0x0F;
      008AFE 5F               [ 1]  514 	clrw	x
      008AFF 7B 04            [ 1]  515 	ld	a, (0x04, sp)
      008B01 97               [ 1]  516 	ld	xl, a
      008B02 A6 0A            [ 1]  517 	ld	a, #0x0a
      008B04 62               [ 2]  518 	div	x, a
      008B05 A4 0F            [ 1]  519 	and	a, #0x0f
                                    520 ;	user/rtc.c: 148: return ((high)|low);
      008B07 1A 01            [ 1]  521 	or	a, (0x01, sp)
      008B09 5B 01            [ 2]  522 	addw	sp, #1
      008B0B 81               [ 4]  523 	ret
                                    524 ;	user/rtc.c: 152: void RTC_CalcTime(DATE_TIME *dt, uint32_t unixTime)
                                    525 ;	-----------------------------------------
                                    526 ;	 function RTC_CalcTime
                                    527 ;	-----------------------------------------
      008B0C                        528 _RTC_CalcTime:
      008B0C 52 08            [ 2]  529 	sub	sp, #8
                                    530 ;	user/rtc.c: 156: epoch = unixTime;
      008B0E 16 0F            [ 2]  531 	ldw	y, (0x0f, sp)
      008B10 17 03            [ 2]  532 	ldw	(0x03, sp), y
      008B12 16 0D            [ 2]  533 	ldw	y, (0x0d, sp)
      008B14 17 01            [ 2]  534 	ldw	(0x01, sp), y
                                    535 ;	user/rtc.c: 157: gt = localtime(&epoch);			
      008B16 96               [ 1]  536 	ldw	x, sp
      008B17 5C               [ 2]  537 	incw	x
      008B18 89               [ 2]  538 	pushw	x
      008B19 CD 90 D5         [ 4]  539 	call	_localtime
      008B1C 5B 02            [ 2]  540 	addw	sp, #2
      008B1E 1F 05            [ 2]  541 	ldw	(0x05, sp), x
                                    542 ;	user/rtc.c: 158: dt->sec = gt->tm_sec;
      008B20 16 0B            [ 2]  543 	ldw	y, (0x0b, sp)
      008B22 17 07            [ 2]  544 	ldw	(0x07, sp), y
      008B24 1E 07            [ 2]  545 	ldw	x, (0x07, sp)
      008B26 1C 00 07         [ 2]  546 	addw	x, #0x0007
      008B29 16 05            [ 2]  547 	ldw	y, (0x05, sp)
      008B2B 90 F6            [ 1]  548 	ld	a, (y)
      008B2D F7               [ 1]  549 	ld	(x), a
                                    550 ;	user/rtc.c: 159: dt->min = gt->tm_min;
      008B2E 1E 07            [ 2]  551 	ldw	x, (0x07, sp)
      008B30 1C 00 06         [ 2]  552 	addw	x, #0x0006
      008B33 16 05            [ 2]  553 	ldw	y, (0x05, sp)
      008B35 90 E6 01         [ 1]  554 	ld	a, (0x1, y)
      008B38 F7               [ 1]  555 	ld	(x), a
                                    556 ;	user/rtc.c: 160: dt->hour = gt->tm_hour;
      008B39 1E 07            [ 2]  557 	ldw	x, (0x07, sp)
      008B3B 1C 00 05         [ 2]  558 	addw	x, #0x0005
      008B3E 16 05            [ 2]  559 	ldw	y, (0x05, sp)
      008B40 90 E6 02         [ 1]  560 	ld	a, (0x2, y)
      008B43 F7               [ 1]  561 	ld	(x), a
                                    562 ;	user/rtc.c: 161: dt->mday = gt->tm_mday;
      008B44 1E 07            [ 2]  563 	ldw	x, (0x07, sp)
      008B46 1C 00 03         [ 2]  564 	addw	x, #0x0003
      008B49 16 05            [ 2]  565 	ldw	y, (0x05, sp)
      008B4B 90 E6 03         [ 1]  566 	ld	a, (0x3, y)
      008B4E F7               [ 1]  567 	ld	(x), a
                                    568 ;	user/rtc.c: 162: dt->wday = gt->tm_wday + 1;				// tm_wday 0 - 6 (0 = sunday)
      008B4F 1E 07            [ 2]  569 	ldw	x, (0x07, sp)
      008B51 1C 00 04         [ 2]  570 	addw	x, #0x0004
      008B54 16 05            [ 2]  571 	ldw	y, (0x05, sp)
      008B56 90 E6 07         [ 1]  572 	ld	a, (0x7, y)
      008B59 4C               [ 1]  573 	inc	a
      008B5A F7               [ 1]  574 	ld	(x), a
                                    575 ;	user/rtc.c: 163: dt->month = gt->tm_mon + 1;				// tm_mon 0 - 11 (0 = Jan)
      008B5B 1E 07            [ 2]  576 	ldw	x, (0x07, sp)
      008B5D 5C               [ 2]  577 	incw	x
      008B5E 5C               [ 2]  578 	incw	x
      008B5F 16 05            [ 2]  579 	ldw	y, (0x05, sp)
      008B61 90 E6 04         [ 1]  580 	ld	a, (0x4, y)
      008B64 4C               [ 1]  581 	inc	a
      008B65 F7               [ 1]  582 	ld	(x), a
                                    583 ;	user/rtc.c: 164: dt->year = gt->tm_year + 1900;		// tm_year = current year - 1900
      008B66 1E 05            [ 2]  584 	ldw	x, (0x05, sp)
      008B68 EE 05            [ 2]  585 	ldw	x, (0x5, x)
      008B6A 1C 07 6C         [ 2]  586 	addw	x, #0x076c
      008B6D 16 07            [ 2]  587 	ldw	y, (0x07, sp)
      008B6F 90 FF            [ 2]  588 	ldw	(y), x
      008B71 5B 08            [ 2]  589 	addw	sp, #8
      008B73 81               [ 4]  590 	ret
                                    591 ;	user/rtc.c: 167: uint32_t RTC_GetUnixTimestamp(DATE_TIME *dt)
                                    592 ;	-----------------------------------------
                                    593 ;	 function RTC_GetUnixTimestamp
                                    594 ;	-----------------------------------------
      008B74                        595 _RTC_GetUnixTimestamp:
      008B74 52 10            [ 2]  596 	sub	sp, #16
                                    597 ;	user/rtc.c: 171: t.tm_year = dt->year - 1900;
      008B76 96               [ 1]  598 	ldw	x, sp
      008B77 5C               [ 2]  599 	incw	x
      008B78 1F 0F            [ 2]  600 	ldw	(0x0f, sp), x
      008B7A 1E 0F            [ 2]  601 	ldw	x, (0x0f, sp)
      008B7C 1C 00 05         [ 2]  602 	addw	x, #0x0005
      008B7F 16 13            [ 2]  603 	ldw	y, (0x13, sp)
      008B81 17 0D            [ 2]  604 	ldw	(0x0d, sp), y
      008B83 16 0D            [ 2]  605 	ldw	y, (0x0d, sp)
      008B85 90 FE            [ 2]  606 	ldw	y, (y)
      008B87 72 A2 07 6C      [ 2]  607 	subw	y, #0x076c
      008B8B FF               [ 2]  608 	ldw	(x), y
                                    609 ;	user/rtc.c: 172: t.tm_mon = dt->month - 1; 				// Month, 0 - jan
      008B8C 1E 0F            [ 2]  610 	ldw	x, (0x0f, sp)
      008B8E 1C 00 04         [ 2]  611 	addw	x, #0x0004
      008B91 16 0D            [ 2]  612 	ldw	y, (0x0d, sp)
      008B93 90 E6 02         [ 1]  613 	ld	a, (0x2, y)
      008B96 4A               [ 1]  614 	dec	a
      008B97 F7               [ 1]  615 	ld	(x), a
                                    616 ;	user/rtc.c: 173: t.tm_mday = dt->mday; 						// Day of the month
      008B98 1E 0F            [ 2]  617 	ldw	x, (0x0f, sp)
      008B9A 1C 00 03         [ 2]  618 	addw	x, #0x0003
      008B9D 16 0D            [ 2]  619 	ldw	y, (0x0d, sp)
      008B9F 90 E6 03         [ 1]  620 	ld	a, (0x3, y)
      008BA2 F7               [ 1]  621 	ld	(x), a
                                    622 ;	user/rtc.c: 174: t.tm_hour = dt->hour;
      008BA3 1E 0F            [ 2]  623 	ldw	x, (0x0f, sp)
      008BA5 5C               [ 2]  624 	incw	x
      008BA6 5C               [ 2]  625 	incw	x
      008BA7 16 0D            [ 2]  626 	ldw	y, (0x0d, sp)
      008BA9 90 E6 05         [ 1]  627 	ld	a, (0x5, y)
      008BAC F7               [ 1]  628 	ld	(x), a
                                    629 ;	user/rtc.c: 175: t.tm_min = dt->min;
      008BAD 1E 0F            [ 2]  630 	ldw	x, (0x0f, sp)
      008BAF 5C               [ 2]  631 	incw	x
      008BB0 16 0D            [ 2]  632 	ldw	y, (0x0d, sp)
      008BB2 90 E6 06         [ 1]  633 	ld	a, (0x6, y)
      008BB5 F7               [ 1]  634 	ld	(x), a
                                    635 ;	user/rtc.c: 176: t.tm_sec = dt->sec;
      008BB6 1E 0D            [ 2]  636 	ldw	x, (0x0d, sp)
      008BB8 E6 07            [ 1]  637 	ld	a, (0x7, x)
      008BBA 1E 0F            [ 2]  638 	ldw	x, (0x0f, sp)
      008BBC F7               [ 1]  639 	ld	(x), a
                                    640 ;	user/rtc.c: 177: t.tm_isdst = -1; 									// Is DST on? 1 = yes, 0 = no, -1 = unknown
      008BBD 1E 0F            [ 2]  641 	ldw	x, (0x0f, sp)
      008BBF A6 FF            [ 1]  642 	ld	a, #0xff
      008BC1 E7 0A            [ 1]  643 	ld	(0x000a, x), a
                                    644 ;	user/rtc.c: 178: t_of_day = mktime(&t);
      008BC3 1E 0F            [ 2]  645 	ldw	x, (0x0f, sp)
      008BC5 89               [ 2]  646 	pushw	x
      008BC6 CD 92 F0         [ 4]  647 	call	_mktime
                                    648 ;	user/rtc.c: 179: return (uint32_t)t_of_day; 
      008BC9 5B 12            [ 2]  649 	addw	sp, #18
      008BCB 81               [ 4]  650 	ret
                                    651 	.area CODE
                                    652 	.area INITIALIZER
                                    653 	.area CABS (ABS)
