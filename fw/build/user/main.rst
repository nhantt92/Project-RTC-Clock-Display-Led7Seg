                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.6.0 #9615 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _TIM4_UPD_OVF_IRQHandler
                                     13 	.globl _delay
                                     14 	.globl _screen
                                     15 	.globl _displayInit
                                     16 	.globl _TIMER_InitTime
                                     17 	.globl _TIMER_Inc
                                     18 	.globl _TIMER_Init
                                     19 	.globl _TIM4_ClearITPendingBit
                                     20 	.globl _IWDG_Enable
                                     21 	.globl _IWDG_ReloadCounter
                                     22 	.globl _IWDG_SetReload
                                     23 	.globl _IWDG_SetPrescaler
                                     24 	.globl _IWDG_WriteAccessCmd
                                     25 	.globl _GPIO_Init
                                     26 	.globl _CLK_Config
                                     27 	.globl _tick
                                     28 	.globl _IWDG_Config
                                     29 	.globl _GPIO_setup
                                     30 ;--------------------------------------------------------
                                     31 ; ram data
                                     32 ;--------------------------------------------------------
                                     33 	.area DATA
      000011                         34 _tick::
      000011                         35 	.ds 6
                                     36 ;--------------------------------------------------------
                                     37 ; ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area INITIALIZED
                                     40 ;--------------------------------------------------------
                                     41 ; Stack segment in internal ram 
                                     42 ;--------------------------------------------------------
                                     43 	.area	SSEG
      008AC6                         44 __start__stack:
      008AC6                         45 	.ds	1
                                     46 
                                     47 ;--------------------------------------------------------
                                     48 ; absolute external ram data
                                     49 ;--------------------------------------------------------
                                     50 	.area DABS (ABS)
                                     51 ;--------------------------------------------------------
                                     52 ; interrupt vector 
                                     53 ;--------------------------------------------------------
                                     54 	.area HOME
      008000                         55 __interrupt_vect:
      008000 82 00 80 83             56 	int s_GSINIT ;reset
      008004 82 00 00 00             57 	int 0x0000 ;trap
      008008 82 00 00 00             58 	int 0x0000 ;int0
      00800C 82 00 00 00             59 	int 0x0000 ;int1
      008010 82 00 00 00             60 	int 0x0000 ;int2
      008014 82 00 00 00             61 	int 0x0000 ;int3
      008018 82 00 00 00             62 	int 0x0000 ;int4
      00801C 82 00 00 00             63 	int 0x0000 ;int5
      008020 82 00 00 00             64 	int 0x0000 ;int6
      008024 82 00 00 00             65 	int 0x0000 ;int7
      008028 82 00 00 00             66 	int 0x0000 ;int8
      00802C 82 00 00 00             67 	int 0x0000 ;int9
      008030 82 00 00 00             68 	int 0x0000 ;int10
      008034 82 00 00 00             69 	int 0x0000 ;int11
      008038 82 00 00 00             70 	int 0x0000 ;int12
      00803C 82 00 00 00             71 	int 0x0000 ;int13
      008040 82 00 00 00             72 	int 0x0000 ;int14
      008044 82 00 00 00             73 	int 0x0000 ;int15
      008048 82 00 00 00             74 	int 0x0000 ;int16
      00804C 82 00 00 00             75 	int 0x0000 ;int17
      008050 82 00 00 00             76 	int 0x0000 ;int18
      008054 82 00 00 00             77 	int 0x0000 ;int19
      008058 82 00 00 00             78 	int 0x0000 ;int20
      00805C 82 00 00 00             79 	int 0x0000 ;int21
      008060 82 00 00 00             80 	int 0x0000 ;int22
      008064 82 00 84 A9             81 	int _TIM4_UPD_OVF_IRQHandler ;int23
      008068 82 00 00 00             82 	int 0x0000 ;int24
      00806C 82 00 00 00             83 	int 0x0000 ;int25
      008070 82 00 00 00             84 	int 0x0000 ;int26
      008074 82 00 00 00             85 	int 0x0000 ;int27
      008078 82 00 00 00             86 	int 0x0000 ;int28
      00807C 82 00 00 00             87 	int 0x0000 ;int29
                                     88 ;--------------------------------------------------------
                                     89 ; global & static initialisations
                                     90 ;--------------------------------------------------------
                                     91 	.area HOME
                                     92 	.area GSINIT
                                     93 	.area GSFINAL
                                     94 	.area GSINIT
      008083                         95 __sdcc_gs_init_startup:
      008083                         96 __sdcc_init_data:
                                     97 ; stm8_genXINIT() start
      008083 AE 00 1F         [ 2]   98 	ldw x, #l_DATA
      008086 27 07            [ 1]   99 	jreq	00002$
      008088                        100 00001$:
      008088 72 4F 00 00      [ 1]  101 	clr (s_DATA - 1, x)
      00808C 5A               [ 2]  102 	decw x
      00808D 26 F9            [ 1]  103 	jrne	00001$
      00808F                        104 00002$:
      00808F AE 00 00         [ 2]  105 	ldw	x, #l_INITIALIZER
      008092 27 09            [ 1]  106 	jreq	00004$
      008094                        107 00003$:
      008094 D6 8A C5         [ 1]  108 	ld	a, (s_INITIALIZER - 1, x)
      008097 D7 00 1F         [ 1]  109 	ld	(s_INITIALIZED - 1, x), a
      00809A 5A               [ 2]  110 	decw	x
      00809B 26 F7            [ 1]  111 	jrne	00003$
      00809D                        112 00004$:
                                    113 ; stm8_genXINIT() end
                                    114 	.area GSFINAL
      00809D CC 80 80         [ 2]  115 	jp	__sdcc_program_startup
                                    116 ;--------------------------------------------------------
                                    117 ; Home
                                    118 ;--------------------------------------------------------
                                    119 	.area HOME
                                    120 	.area HOME
      008080                        121 __sdcc_program_startup:
      008080 CC 84 CF         [ 2]  122 	jp	_main
                                    123 ;	return from main will return to caller
                                    124 ;--------------------------------------------------------
                                    125 ; code
                                    126 ;--------------------------------------------------------
                                    127 	.area CODE
                                    128 ;	user/main.c: 28: void delay(uint16_t x)
                                    129 ;	-----------------------------------------
                                    130 ;	 function delay
                                    131 ;	-----------------------------------------
      00849D                        132 _delay:
      00849D 89               [ 2]  133 	pushw	x
                                    134 ;	user/main.c: 30: while(x--);
      00849E 1E 05            [ 2]  135 	ldw	x, (0x05, sp)
      0084A0                        136 00101$:
      0084A0 1F 01            [ 2]  137 	ldw	(0x01, sp), x
      0084A2 5A               [ 2]  138 	decw	x
      0084A3 16 01            [ 2]  139 	ldw	y, (0x01, sp)
      0084A5 26 F9            [ 1]  140 	jrne	00101$
      0084A7 85               [ 2]  141 	popw	x
      0084A8 81               [ 4]  142 	ret
                                    143 ;	user/main.c: 33: INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
                                    144 ;	-----------------------------------------
                                    145 ;	 function TIM4_UPD_OVF_IRQHandler
                                    146 ;	-----------------------------------------
      0084A9                        147 _TIM4_UPD_OVF_IRQHandler:
      0084A9 62               [ 2]  148 	div	x, a
                                    149 ;	user/main.c: 35: TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
      0084AA 4B 01            [ 1]  150 	push	#0x01
      0084AC CD 8A 43         [ 4]  151 	call	_TIM4_ClearITPendingBit
      0084AF 84               [ 1]  152 	pop	a
                                    153 ;	user/main.c: 36: TIMER_Inc();
      0084B0 CD 85 48         [ 4]  154 	call	_TIMER_Inc
                                    155 ;	user/main.c: 37: IWDG_ReloadCounter();
      0084B3 CD 88 6C         [ 4]  156 	call	_IWDG_ReloadCounter
      0084B6 80               [11]  157 	iret
                                    158 ;	user/main.c: 40: void IWDG_Config(void)
                                    159 ;	-----------------------------------------
                                    160 ;	 function IWDG_Config
                                    161 ;	-----------------------------------------
      0084B7                        162 _IWDG_Config:
                                    163 ;	user/main.c: 44: IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
      0084B7 4B 55            [ 1]  164 	push	#0x55
      0084B9 CD 88 57         [ 4]  165 	call	_IWDG_WriteAccessCmd
      0084BC 84               [ 1]  166 	pop	a
                                    167 ;	user/main.c: 46: IWDG_SetPrescaler(IWDG_Prescaler_256);
      0084BD 4B 06            [ 1]  168 	push	#0x06
      0084BF CD 88 5E         [ 4]  169 	call	_IWDG_SetPrescaler
      0084C2 84               [ 1]  170 	pop	a
                                    171 ;	user/main.c: 50: IWDG_SetReload(250);
      0084C3 4B FA            [ 1]  172 	push	#0xfa
      0084C5 CD 88 65         [ 4]  173 	call	_IWDG_SetReload
      0084C8 84               [ 1]  174 	pop	a
                                    175 ;	user/main.c: 52: IWDG_ReloadCounter();
      0084C9 CD 88 6C         [ 4]  176 	call	_IWDG_ReloadCounter
                                    177 ;	user/main.c: 54: IWDG_Enable();
      0084CC CC 88 71         [ 2]  178 	jp	_IWDG_Enable
                                    179 ;	user/main.c: 58: void main() 
                                    180 ;	-----------------------------------------
                                    181 ;	 function main
                                    182 ;	-----------------------------------------
      0084CF                        183 _main:
                                    184 ;	user/main.c: 60: CLK_Config();
      0084CF CD 86 41         [ 4]  185 	call	_CLK_Config
                                    186 ;	user/main.c: 61: GPIO_setup(); 
      0084D2 CD 85 07         [ 4]  187 	call	_GPIO_setup
                                    188 ;	user/main.c: 63: TIMER_Init();
      0084D5 CD 85 15         [ 4]  189 	call	_TIMER_Init
                                    190 ;	user/main.c: 64: displayInit(GPIOC, GPIOA, GPIO_PIN_6, GPIO_PIN_5, GPIO_PIN_7, GPIO_PIN_4, GPIO_PIN_3, GPIO_PIN_2, GPIO_PIN_1, GPIO_PIN_3);
      0084D8 4B 08            [ 1]  191 	push	#0x08
      0084DA 4B 02            [ 1]  192 	push	#0x02
      0084DC 4B 04            [ 1]  193 	push	#0x04
      0084DE 4B 08            [ 1]  194 	push	#0x08
      0084E0 4B 10            [ 1]  195 	push	#0x10
      0084E2 4B 80            [ 1]  196 	push	#0x80
      0084E4 4B 20            [ 1]  197 	push	#0x20
      0084E6 4B 40            [ 1]  198 	push	#0x40
      0084E8 4B 00            [ 1]  199 	push	#0x00
      0084EA 4B 50            [ 1]  200 	push	#0x50
      0084EC 4B 0A            [ 1]  201 	push	#0x0a
      0084EE 4B 50            [ 1]  202 	push	#0x50
      0084F0 CD 80 AC         [ 4]  203 	call	_displayInit
      0084F3 5B 0C            [ 2]  204 	addw	sp, #12
                                    205 ;	user/main.c: 65: TIMER_InitTime(&tick);
      0084F5 AE 00 11         [ 2]  206 	ldw	x, #_tick+0
      0084F8 89               [ 2]  207 	pushw	x
      0084F9 CD 85 74         [ 4]  208 	call	_TIMER_InitTime
      0084FC 85               [ 2]  209 	popw	x
                                    210 ;	user/main.c: 66: IWDG_Config();
      0084FD CD 84 B7         [ 4]  211 	call	_IWDG_Config
                                    212 ;	user/main.c: 67: enableInterrupts();
      008500 9A               [ 1]  213 	rim
                                    214 ;	user/main.c: 70: while(TRUE) 
      008501                        215 00102$:
                                    216 ;	user/main.c: 80: screen();
      008501 CD 83 62         [ 4]  217 	call	_screen
      008504 20 FB            [ 2]  218 	jra	00102$
      008506 81               [ 4]  219 	ret
                                    220 ;	user/main.c: 84: void GPIO_setup(void) 
                                    221 ;	-----------------------------------------
                                    222 ;	 function GPIO_setup
                                    223 ;	-----------------------------------------
      008507                        224 _GPIO_setup:
                                    225 ;	user/main.c: 86: GPIO_Init(GPIOD, ((GPIO_Pin_TypeDef)GPIO_PIN_5), GPIO_MODE_OUT_PP_HIGH_FAST);
      008507 4B F0            [ 1]  226 	push	#0xf0
      008509 4B 20            [ 1]  227 	push	#0x20
      00850B 4B 0F            [ 1]  228 	push	#0x0f
      00850D 4B 50            [ 1]  229 	push	#0x50
      00850F CD 87 7C         [ 4]  230 	call	_GPIO_Init
      008512 5B 04            [ 2]  231 	addw	sp, #4
      008514 81               [ 4]  232 	ret
                                    233 	.area CODE
                                    234 	.area INITIALIZER
                                    235 	.area CABS (ABS)
