                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.6.0 #9615 (Mac OS X x86_64)
                                      4 ;--------------------------------------------------------
                                      5 	.module stm8s_gpio
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _GPIO_DeInit
                                     12 	.globl _GPIO_Init
                                     13 	.globl _GPIO_Write
                                     14 	.globl _GPIO_WriteHigh
                                     15 	.globl _GPIO_WriteLow
                                     16 	.globl _GPIO_WriteReverse
                                     17 	.globl _GPIO_ReadOutputData
                                     18 	.globl _GPIO_ReadInputData
                                     19 	.globl _GPIO_ReadInputPin
                                     20 	.globl _GPIO_ExternalPullUpConfig
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DATA
                                     25 ;--------------------------------------------------------
                                     26 ; ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area INITIALIZED
                                     29 ;--------------------------------------------------------
                                     30 ; absolute external ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area DABS (ABS)
                                     33 ;--------------------------------------------------------
                                     34 ; global & static initialisations
                                     35 ;--------------------------------------------------------
                                     36 	.area HOME
                                     37 	.area GSINIT
                                     38 	.area GSFINAL
                                     39 	.area GSINIT
                                     40 ;--------------------------------------------------------
                                     41 ; Home
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
                                     44 	.area HOME
                                     45 ;--------------------------------------------------------
                                     46 ; code
                                     47 ;--------------------------------------------------------
                                     48 	.area CODE
                                     49 ;	lib/stm8s_gpio.c: 14: void GPIO_DeInit(GPIO_TypeDef* GPIOx)
                                     50 ;	-----------------------------------------
                                     51 ;	 function GPIO_DeInit
                                     52 ;	-----------------------------------------
      008E33                         53 _GPIO_DeInit:
      008E33 89               [ 2]   54 	pushw	x
                                     55 ;	lib/stm8s_gpio.c: 16: GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
      008E34 16 05            [ 2]   56 	ldw	y, (0x05, sp)
      008E36 17 01            [ 2]   57 	ldw	(0x01, sp), y
      008E38 1E 01            [ 2]   58 	ldw	x, (0x01, sp)
      008E3A 7F               [ 1]   59 	clr	(x)
                                     60 ;	lib/stm8s_gpio.c: 17: GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
      008E3B 1E 01            [ 2]   61 	ldw	x, (0x01, sp)
      008E3D 5C               [ 2]   62 	incw	x
      008E3E 5C               [ 2]   63 	incw	x
      008E3F 7F               [ 1]   64 	clr	(x)
                                     65 ;	lib/stm8s_gpio.c: 18: GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
      008E40 1E 01            [ 2]   66 	ldw	x, (0x01, sp)
      008E42 1C 00 03         [ 2]   67 	addw	x, #0x0003
      008E45 7F               [ 1]   68 	clr	(x)
                                     69 ;	lib/stm8s_gpio.c: 19: GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
      008E46 1E 01            [ 2]   70 	ldw	x, (0x01, sp)
      008E48 1C 00 04         [ 2]   71 	addw	x, #0x0004
      008E4B 7F               [ 1]   72 	clr	(x)
      008E4C 85               [ 2]   73 	popw	x
      008E4D 81               [ 4]   74 	ret
                                     75 ;	lib/stm8s_gpio.c: 22: void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
                                     76 ;	-----------------------------------------
                                     77 ;	 function GPIO_Init
                                     78 ;	-----------------------------------------
      008E4E                         79 _GPIO_Init:
      008E4E 52 05            [ 2]   80 	sub	sp, #5
                                     81 ;	lib/stm8s_gpio.c: 31: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin)); /* Reset corresponding bit to GPIO_Pin in CR2 register */
      008E50 16 08            [ 2]   82 	ldw	y, (0x08, sp)
      008E52 17 04            [ 2]   83 	ldw	(0x04, sp), y
      008E54 1E 04            [ 2]   84 	ldw	x, (0x04, sp)
      008E56 1C 00 04         [ 2]   85 	addw	x, #0x0004
      008E59 1F 02            [ 2]   86 	ldw	(0x02, sp), x
      008E5B 1E 02            [ 2]   87 	ldw	x, (0x02, sp)
      008E5D F6               [ 1]   88 	ld	a, (x)
      008E5E 88               [ 1]   89 	push	a
      008E5F 7B 0B            [ 1]   90 	ld	a, (0x0b, sp)
      008E61 43               [ 1]   91 	cpl	a
      008E62 6B 02            [ 1]   92 	ld	(0x02, sp), a
      008E64 84               [ 1]   93 	pop	a
      008E65 14 01            [ 1]   94 	and	a, (0x01, sp)
      008E67 1E 02            [ 2]   95 	ldw	x, (0x02, sp)
      008E69 F7               [ 1]   96 	ld	(x), a
                                     97 ;	lib/stm8s_gpio.c: 47: GPIOx->DDR |= (uint8_t)GPIO_Pin;
      008E6A 1E 04            [ 2]   98 	ldw	x, (0x04, sp)
      008E6C 5C               [ 2]   99 	incw	x
      008E6D 5C               [ 2]  100 	incw	x
                                    101 ;	lib/stm8s_gpio.c: 36: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
      008E6E 0D 0B            [ 1]  102 	tnz	(0x0b, sp)
      008E70 2A 20            [ 1]  103 	jrpl	00105$
                                    104 ;	lib/stm8s_gpio.c: 40: GPIOx->ODR |= (uint8_t)GPIO_Pin;
      008E72 16 04            [ 2]  105 	ldw	y, (0x04, sp)
      008E74 90 F6            [ 1]  106 	ld	a, (y)
                                    107 ;	lib/stm8s_gpio.c: 38: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
      008E76 88               [ 1]  108 	push	a
      008E77 7B 0C            [ 1]  109 	ld	a, (0x0c, sp)
      008E79 A5 10            [ 1]  110 	bcp	a, #0x10
      008E7B 84               [ 1]  111 	pop	a
      008E7C 27 08            [ 1]  112 	jreq	00102$
                                    113 ;	lib/stm8s_gpio.c: 40: GPIOx->ODR |= (uint8_t)GPIO_Pin;
      008E7E 1A 0A            [ 1]  114 	or	a, (0x0a, sp)
      008E80 16 04            [ 2]  115 	ldw	y, (0x04, sp)
      008E82 90 F7            [ 1]  116 	ld	(y), a
      008E84 20 06            [ 2]  117 	jra	00103$
      008E86                        118 00102$:
                                    119 ;	lib/stm8s_gpio.c: 44: GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
      008E86 14 01            [ 1]  120 	and	a, (0x01, sp)
      008E88 16 04            [ 2]  121 	ldw	y, (0x04, sp)
      008E8A 90 F7            [ 1]  122 	ld	(y), a
      008E8C                        123 00103$:
                                    124 ;	lib/stm8s_gpio.c: 47: GPIOx->DDR |= (uint8_t)GPIO_Pin;
      008E8C F6               [ 1]  125 	ld	a, (x)
      008E8D 1A 0A            [ 1]  126 	or	a, (0x0a, sp)
      008E8F F7               [ 1]  127 	ld	(x), a
      008E90 20 04            [ 2]  128 	jra	00106$
      008E92                        129 00105$:
                                    130 ;	lib/stm8s_gpio.c: 52: GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
      008E92 F6               [ 1]  131 	ld	a, (x)
      008E93 14 01            [ 1]  132 	and	a, (0x01, sp)
      008E95 F7               [ 1]  133 	ld	(x), a
      008E96                        134 00106$:
                                    135 ;	lib/stm8s_gpio.c: 59: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      008E96 1E 04            [ 2]  136 	ldw	x, (0x04, sp)
      008E98 1C 00 03         [ 2]  137 	addw	x, #0x0003
                                    138 ;	lib/stm8s_gpio.c: 57: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
      008E9B 7B 0B            [ 1]  139 	ld	a, (0x0b, sp)
      008E9D A5 40            [ 1]  140 	bcp	a, #0x40
      008E9F 27 06            [ 1]  141 	jreq	00108$
                                    142 ;	lib/stm8s_gpio.c: 59: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      008EA1 F6               [ 1]  143 	ld	a, (x)
      008EA2 1A 0A            [ 1]  144 	or	a, (0x0a, sp)
      008EA4 F7               [ 1]  145 	ld	(x), a
      008EA5 20 04            [ 2]  146 	jra	00109$
      008EA7                        147 00108$:
                                    148 ;	lib/stm8s_gpio.c: 63: GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
      008EA7 F6               [ 1]  149 	ld	a, (x)
      008EA8 14 01            [ 1]  150 	and	a, (0x01, sp)
      008EAA F7               [ 1]  151 	ld	(x), a
      008EAB                        152 00109$:
                                    153 ;	lib/stm8s_gpio.c: 68: if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
      008EAB 7B 0B            [ 1]  154 	ld	a, (0x0b, sp)
      008EAD A5 20            [ 1]  155 	bcp	a, #0x20
      008EAF 27 0A            [ 1]  156 	jreq	00111$
                                    157 ;	lib/stm8s_gpio.c: 70: GPIOx->CR2 |= (uint8_t)GPIO_Pin;
      008EB1 1E 02            [ 2]  158 	ldw	x, (0x02, sp)
      008EB3 F6               [ 1]  159 	ld	a, (x)
      008EB4 1A 0A            [ 1]  160 	or	a, (0x0a, sp)
      008EB6 1E 02            [ 2]  161 	ldw	x, (0x02, sp)
      008EB8 F7               [ 1]  162 	ld	(x), a
      008EB9 20 08            [ 2]  163 	jra	00113$
      008EBB                        164 00111$:
                                    165 ;	lib/stm8s_gpio.c: 74: GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
      008EBB 1E 02            [ 2]  166 	ldw	x, (0x02, sp)
      008EBD F6               [ 1]  167 	ld	a, (x)
      008EBE 14 01            [ 1]  168 	and	a, (0x01, sp)
      008EC0 1E 02            [ 2]  169 	ldw	x, (0x02, sp)
      008EC2 F7               [ 1]  170 	ld	(x), a
      008EC3                        171 00113$:
      008EC3 5B 05            [ 2]  172 	addw	sp, #5
      008EC5 81               [ 4]  173 	ret
                                    174 ;	lib/stm8s_gpio.c: 78: void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
                                    175 ;	-----------------------------------------
                                    176 ;	 function GPIO_Write
                                    177 ;	-----------------------------------------
      008EC6                        178 _GPIO_Write:
                                    179 ;	lib/stm8s_gpio.c: 80: GPIOx->ODR = PortVal;
      008EC6 1E 03            [ 2]  180 	ldw	x, (0x03, sp)
      008EC8 7B 05            [ 1]  181 	ld	a, (0x05, sp)
      008ECA F7               [ 1]  182 	ld	(x), a
      008ECB 81               [ 4]  183 	ret
                                    184 ;	lib/stm8s_gpio.c: 83: void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
                                    185 ;	-----------------------------------------
                                    186 ;	 function GPIO_WriteHigh
                                    187 ;	-----------------------------------------
      008ECC                        188 _GPIO_WriteHigh:
                                    189 ;	lib/stm8s_gpio.c: 85: GPIOx->ODR |= (uint8_t)PortPins;
      008ECC 1E 03            [ 2]  190 	ldw	x, (0x03, sp)
      008ECE F6               [ 1]  191 	ld	a, (x)
      008ECF 1A 05            [ 1]  192 	or	a, (0x05, sp)
      008ED1 F7               [ 1]  193 	ld	(x), a
      008ED2 81               [ 4]  194 	ret
                                    195 ;	lib/stm8s_gpio.c: 88: void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
                                    196 ;	-----------------------------------------
                                    197 ;	 function GPIO_WriteLow
                                    198 ;	-----------------------------------------
      008ED3                        199 _GPIO_WriteLow:
      008ED3 88               [ 1]  200 	push	a
                                    201 ;	lib/stm8s_gpio.c: 90: GPIOx->ODR &= (uint8_t)(~PortPins);
      008ED4 1E 04            [ 2]  202 	ldw	x, (0x04, sp)
      008ED6 F6               [ 1]  203 	ld	a, (x)
      008ED7 6B 01            [ 1]  204 	ld	(0x01, sp), a
      008ED9 7B 06            [ 1]  205 	ld	a, (0x06, sp)
      008EDB 43               [ 1]  206 	cpl	a
      008EDC 14 01            [ 1]  207 	and	a, (0x01, sp)
      008EDE F7               [ 1]  208 	ld	(x), a
      008EDF 84               [ 1]  209 	pop	a
      008EE0 81               [ 4]  210 	ret
                                    211 ;	lib/stm8s_gpio.c: 93: void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
                                    212 ;	-----------------------------------------
                                    213 ;	 function GPIO_WriteReverse
                                    214 ;	-----------------------------------------
      008EE1                        215 _GPIO_WriteReverse:
                                    216 ;	lib/stm8s_gpio.c: 95: GPIOx->ODR ^= (uint8_t)PortPins;
      008EE1 1E 03            [ 2]  217 	ldw	x, (0x03, sp)
      008EE3 F6               [ 1]  218 	ld	a, (x)
      008EE4 18 05            [ 1]  219 	xor	a, (0x05, sp)
      008EE6 F7               [ 1]  220 	ld	(x), a
      008EE7 81               [ 4]  221 	ret
                                    222 ;	lib/stm8s_gpio.c: 98: uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
                                    223 ;	-----------------------------------------
                                    224 ;	 function GPIO_ReadOutputData
                                    225 ;	-----------------------------------------
      008EE8                        226 _GPIO_ReadOutputData:
                                    227 ;	lib/stm8s_gpio.c: 100: return ((uint8_t)GPIOx->ODR);
      008EE8 1E 03            [ 2]  228 	ldw	x, (0x03, sp)
      008EEA F6               [ 1]  229 	ld	a, (x)
      008EEB 81               [ 4]  230 	ret
                                    231 ;	lib/stm8s_gpio.c: 103: uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
                                    232 ;	-----------------------------------------
                                    233 ;	 function GPIO_ReadInputData
                                    234 ;	-----------------------------------------
      008EEC                        235 _GPIO_ReadInputData:
                                    236 ;	lib/stm8s_gpio.c: 105: return ((uint8_t)GPIOx->IDR);
      008EEC 1E 03            [ 2]  237 	ldw	x, (0x03, sp)
      008EEE E6 01            [ 1]  238 	ld	a, (0x1, x)
      008EF0 81               [ 4]  239 	ret
                                    240 ;	lib/stm8s_gpio.c: 108: BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
                                    241 ;	-----------------------------------------
                                    242 ;	 function GPIO_ReadInputPin
                                    243 ;	-----------------------------------------
      008EF1                        244 _GPIO_ReadInputPin:
                                    245 ;	lib/stm8s_gpio.c: 110: return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
      008EF1 1E 03            [ 2]  246 	ldw	x, (0x03, sp)
      008EF3 E6 01            [ 1]  247 	ld	a, (0x1, x)
      008EF5 14 05            [ 1]  248 	and	a, (0x05, sp)
      008EF7 81               [ 4]  249 	ret
                                    250 ;	lib/stm8s_gpio.c: 113: void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
                                    251 ;	-----------------------------------------
                                    252 ;	 function GPIO_ExternalPullUpConfig
                                    253 ;	-----------------------------------------
      008EF8                        254 _GPIO_ExternalPullUpConfig:
      008EF8 88               [ 1]  255 	push	a
                                    256 ;	lib/stm8s_gpio.c: 117: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      008EF9 1E 04            [ 2]  257 	ldw	x, (0x04, sp)
      008EFB 1C 00 03         [ 2]  258 	addw	x, #0x0003
                                    259 ;	lib/stm8s_gpio.c: 115: if (NewState != DISABLE) /* External Pull-Up Set*/
      008EFE 0D 07            [ 1]  260 	tnz	(0x07, sp)
      008F00 27 06            [ 1]  261 	jreq	00102$
                                    262 ;	lib/stm8s_gpio.c: 117: GPIOx->CR1 |= (uint8_t)GPIO_Pin;
      008F02 F6               [ 1]  263 	ld	a, (x)
      008F03 1A 06            [ 1]  264 	or	a, (0x06, sp)
      008F05 F7               [ 1]  265 	ld	(x), a
      008F06 20 09            [ 2]  266 	jra	00104$
      008F08                        267 00102$:
                                    268 ;	lib/stm8s_gpio.c: 120: GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
      008F08 F6               [ 1]  269 	ld	a, (x)
      008F09 6B 01            [ 1]  270 	ld	(0x01, sp), a
      008F0B 7B 06            [ 1]  271 	ld	a, (0x06, sp)
      008F0D 43               [ 1]  272 	cpl	a
      008F0E 14 01            [ 1]  273 	and	a, (0x01, sp)
      008F10 F7               [ 1]  274 	ld	(x), a
      008F11                        275 00104$:
      008F11 84               [ 1]  276 	pop	a
      008F12 81               [ 4]  277 	ret
                                    278 	.area CODE
                                    279 	.area INITIALIZER
                                    280 	.area CABS (ABS)
