#include "stm8s_delay.h"


void delay_cycles(register unsigned short value)
{
	//_asm("nop\n $N:\n decw X\n jrne $L\n nop\n ", value);
  asm("nop\n nop\n");
        do {
              --value;
        }while (value);
        asm("nop\n");
}


void delay_us(uint16_t value)
{
    delay_cycles(value);
//  while(value--)
//  {
//     nop();
//     nop();
//     nop();
//     nop();
//     nop();
//     nop();
//     nop();
//     nop();
//     nop();
//  }
}


void delay_ms(uint16_t  value)
{
	while(value--)
	{
		delay_us(1000);
	}
}