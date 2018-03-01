                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.6.0 #9615 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8s_tim4
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _TIM4_DeInit
                                     12 	.globl _TIM4_TimeBaseInit
                                     13 	.globl _TIM4_Cmd
                                     14 	.globl _TIM4_ITConfig
                                     15 	.globl _TIM4_GetCounter
                                     16 	.globl _TIM4_GetFlagStatus
                                     17 	.globl _TIM4_ClearFlag
                                     18 	.globl _TIM4_ClearITPendingBit
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area DATA
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area INITIALIZED
                                     27 ;--------------------------------------------------------
                                     28 ; absolute external ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DABS (ABS)
                                     31 ;--------------------------------------------------------
                                     32 ; global & static initialisations
                                     33 ;--------------------------------------------------------
                                     34 	.area HOME
                                     35 	.area GSINIT
                                     36 	.area GSFINAL
                                     37 	.area GSINIT
                                     38 ;--------------------------------------------------------
                                     39 ; Home
                                     40 ;--------------------------------------------------------
                                     41 	.area HOME
                                     42 	.area HOME
                                     43 ;--------------------------------------------------------
                                     44 ; code
                                     45 ;--------------------------------------------------------
                                     46 	.area CODE
                                     47 ;	lib/stm8s_tim4.c: 13: void TIM4_DeInit(void)
                                     48 ;	-----------------------------------------
                                     49 ;	 function TIM4_DeInit
                                     50 ;	-----------------------------------------
      008F32                         51 _TIM4_DeInit:
                                     52 ;	lib/stm8s_tim4.c: 15: TIM4->CR1 = TIM4_CR1_RESET_VALUE;
      008F32 35 00 53 40      [ 1]   53 	mov	0x5340+0, #0x00
                                     54 ;	lib/stm8s_tim4.c: 16: TIM4->IER = TIM4_IER_RESET_VALUE;
      008F36 35 00 53 43      [ 1]   55 	mov	0x5343+0, #0x00
                                     56 ;	lib/stm8s_tim4.c: 17: TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
      008F3A 35 00 53 46      [ 1]   57 	mov	0x5346+0, #0x00
                                     58 ;	lib/stm8s_tim4.c: 18: TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
      008F3E 35 00 53 47      [ 1]   59 	mov	0x5347+0, #0x00
                                     60 ;	lib/stm8s_tim4.c: 19: TIM4->ARR = TIM4_ARR_RESET_VALUE;
      008F42 35 FF 53 48      [ 1]   61 	mov	0x5348+0, #0xff
                                     62 ;	lib/stm8s_tim4.c: 20: TIM4->SR1 = TIM4_SR1_RESET_VALUE;
      008F46 35 00 53 44      [ 1]   63 	mov	0x5344+0, #0x00
      008F4A 81               [ 4]   64 	ret
                                     65 ;	lib/stm8s_tim4.c: 23: void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
                                     66 ;	-----------------------------------------
                                     67 ;	 function TIM4_TimeBaseInit
                                     68 ;	-----------------------------------------
      008F4B                         69 _TIM4_TimeBaseInit:
                                     70 ;	lib/stm8s_tim4.c: 26: TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
      008F4B AE 53 47         [ 2]   71 	ldw	x, #0x5347
      008F4E 7B 03            [ 1]   72 	ld	a, (0x03, sp)
      008F50 F7               [ 1]   73 	ld	(x), a
                                     74 ;	lib/stm8s_tim4.c: 28: TIM4->ARR = (uint8_t)(TIM4_Period);
      008F51 AE 53 48         [ 2]   75 	ldw	x, #0x5348
      008F54 7B 04            [ 1]   76 	ld	a, (0x04, sp)
      008F56 F7               [ 1]   77 	ld	(x), a
      008F57 81               [ 4]   78 	ret
                                     79 ;	lib/stm8s_tim4.c: 31: void TIM4_Cmd(FunctionalState NewState)
                                     80 ;	-----------------------------------------
                                     81 ;	 function TIM4_Cmd
                                     82 ;	-----------------------------------------
      008F58                         83 _TIM4_Cmd:
                                     84 ;	lib/stm8s_tim4.c: 34: TIM4->CR1 |= TIM4_CR1_CEN;
      008F58 72 10 53 40      [ 1]   85 	bset	0x5340, #0
      008F5C 81               [ 4]   86 	ret
                                     87 ;	lib/stm8s_tim4.c: 37: void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
                                     88 ;	-----------------------------------------
                                     89 ;	 function TIM4_ITConfig
                                     90 ;	-----------------------------------------
      008F5D                         91 _TIM4_ITConfig:
                                     92 ;	lib/stm8s_tim4.c: 41: TIM4->IER |= (uint8_t)TIM4_IT;
      008F5D AE 53 43         [ 2]   93 	ldw	x, #0x5343
      008F60 F6               [ 1]   94 	ld	a, (x)
      008F61 1A 03            [ 1]   95 	or	a, (0x03, sp)
      008F63 AE 53 43         [ 2]   96 	ldw	x, #0x5343
      008F66 F7               [ 1]   97 	ld	(x), a
      008F67 81               [ 4]   98 	ret
                                     99 ;	lib/stm8s_tim4.c: 44: uint8_t TIM4_GetCounter(void)
                                    100 ;	-----------------------------------------
                                    101 ;	 function TIM4_GetCounter
                                    102 ;	-----------------------------------------
      008F68                        103 _TIM4_GetCounter:
                                    104 ;	lib/stm8s_tim4.c: 47: return (uint8_t)(TIM4->CNTR);
      008F68 AE 53 46         [ 2]  105 	ldw	x, #0x5346
      008F6B F6               [ 1]  106 	ld	a, (x)
      008F6C 81               [ 4]  107 	ret
                                    108 ;	lib/stm8s_tim4.c: 50: FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
                                    109 ;	-----------------------------------------
                                    110 ;	 function TIM4_GetFlagStatus
                                    111 ;	-----------------------------------------
      008F6D                        112 _TIM4_GetFlagStatus:
                                    113 ;	lib/stm8s_tim4.c: 53: if ((TIM4->SR1 & (uint8_t)TIM4_FLAG)  != 0)
      008F6D AE 53 44         [ 2]  114 	ldw	x, #0x5344
      008F70 F6               [ 1]  115 	ld	a, (x)
      008F71 14 03            [ 1]  116 	and	a, (0x03, sp)
      008F73 4D               [ 1]  117 	tnz	a
      008F74 27 03            [ 1]  118 	jreq	00102$
                                    119 ;	lib/stm8s_tim4.c: 55: bitstatus = SET;
      008F76 A6 01            [ 1]  120 	ld	a, #0x01
      008F78 81               [ 4]  121 	ret
      008F79                        122 00102$:
                                    123 ;	lib/stm8s_tim4.c: 59: bitstatus = RESET;
      008F79 4F               [ 1]  124 	clr	a
                                    125 ;	lib/stm8s_tim4.c: 61: return ((FlagStatus)bitstatus);
      008F7A 81               [ 4]  126 	ret
                                    127 ;	lib/stm8s_tim4.c: 64: void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
                                    128 ;	-----------------------------------------
                                    129 ;	 function TIM4_ClearFlag
                                    130 ;	-----------------------------------------
      008F7B                        131 _TIM4_ClearFlag:
                                    132 ;	lib/stm8s_tim4.c: 67: TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
      008F7B 7B 03            [ 1]  133 	ld	a, (0x03, sp)
      008F7D 43               [ 1]  134 	cpl	a
      008F7E AE 53 44         [ 2]  135 	ldw	x, #0x5344
      008F81 F7               [ 1]  136 	ld	(x), a
      008F82 81               [ 4]  137 	ret
                                    138 ;	lib/stm8s_tim4.c: 70: void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
                                    139 ;	-----------------------------------------
                                    140 ;	 function TIM4_ClearITPendingBit
                                    141 ;	-----------------------------------------
      008F83                        142 _TIM4_ClearITPendingBit:
                                    143 ;	lib/stm8s_tim4.c: 73: TIM4->SR1 = (uint8_t)(~TIM4_IT);
      008F83 7B 03            [ 1]  144 	ld	a, (0x03, sp)
      008F85 43               [ 1]  145 	cpl	a
      008F86 AE 53 44         [ 2]  146 	ldw	x, #0x5344
      008F89 F7               [ 1]  147 	ld	(x), a
      008F8A 81               [ 4]  148 	ret
                                    149 	.area CODE
                                    150 	.area INITIALIZER
                                    151 	.area CABS (ABS)
