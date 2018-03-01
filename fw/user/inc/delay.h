#ifndef _DELAY_H_
#define _DELAY_H_

#define F_CPU 200000

#ifndef F_CPU
#warning F_CPU is not defined!
#endif
/*
	* Func delayed N cycles, where N = 3 + (ticks*3)
	* ticks = (N-3)/3, minimum delay is 6 CLK
	* when tick = 1, because 0 equels 65535
*/

static inline void _delay_cycl(uint8_t ticks)
{
	  #define T_COUNT(x) (( F_CPU * x / 1000000UL )-5)/5
	__asm__("nop\n nop\n"); 
	do { 		// ASM: ldw X, #tick; lab$: decw X; tnzw X; jrne lab$
                ticks--;//      2c;                 1c;     2c    ; 1/2c   
        } while (ticks);
	__asm__("nop\n");
}

static inline void delay_us(uint16_t us)
{
	_delay_cycl((uint8_t)(T_COUNT(us)));
}

static inline void delay_ms(uint16_t ms)
{
	while(ms--)
	{
		delay_us(1000);
	}
}

#endif