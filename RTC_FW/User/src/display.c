#include "display.h"
#include <string.h>

#define DEFAULT_LED_DUTY 15

const uint8_t code7Seg[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

DisplayLed_Struct display;

static void delay_us(uint32_t x)
{
  while(x--);
}

void displayInit(GPIO_TypeDef* portData, GPIO_TypeDef* portScan, uint8_t data, uint8_t clk, uint8_t lat, uint8_t clr, uint8_t led1, uint8_t led2, uint8_t led3, uint8_t led4)
{
	display.portData = portData;
	display.portScan = portScan;
	display.data = data;
	display.clk = clk;
	display.lat = lat;
	display.clr = clr;
	display.led[0] = led1;
	display.led[1] = led2;
	display.led[2] = led3;
	display.led[3] = led4;
	GPIO_Init(display.portData, display.data|display.clk|display.lat|display.clr|display.led[3], GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_Init(display.portScan, display.led[0]|display.led[1]|display.led[2], GPIO_MODE_OUT_PP_HIGH_FAST);
	// GPIO_Init(GPIOC, GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7, GPIO_MODE_OUT_PP_HIGH_FAST);
	// GPIO_Init(GPIOA, GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_WriteHigh(display.portData, display.clr);
	GPIO_WriteLow(display.portScan, display.led[0]);
	GPIO_WriteLow(display.portScan, display.led[1]);
	GPIO_WriteLow(display.portScan, display.led[2]);
	GPIO_WriteLow(display.portData, display.led[3]);
	memset(display.buffer, 0x00, sizeof(display.buffer));
        display.blink = LED_BLINK_OFF;
        display.intensy = DEFAULT_LED_DUTY;
        led_off();
}

void shiftOut595(uint8_t data)
{
	uint8_t temp, i;
	temp = data;
	//GPIO_WriteHigh(display.portData, display.clr);
	for(i = 0; i< 8; i++)
	{
		GPIO_WriteLow(display.portData, display.clk);
		if(temp&0x80) GPIO_WriteHigh(display.portData, display.data);
		else GPIO_WriteLow(display.portData, display.data);
		delay_us(5);
		GPIO_WriteHigh(display.portData, display.clk);
		temp <<= 1;
	}
}

void latch595(void)
{
	GPIO_WriteHigh(display.portData, display.lat);
	GPIO_WriteLow(display.portData, display.lat);
	delay_us(5);
}

void clear595(void)
{
	GPIO_WriteHigh(display.portData, display.clr);
	GPIO_WriteLow(display.portData, display.clr);
	delay_us(10);
}

void writeBuffer(uint8_t pos)
{
	shiftOut595(display.buffer[pos]);
	latch595();
}

void setDigit(uint8_t led, uint8_t bcd)
{       
	display.buffer[led-1] = code7Seg[bcd];
}

void enableLed(uint8_t led)
{
	switch(led)
	{
		case 1: {
			GPIO_WriteHigh(display.portScan, display.led[0]);
                        GPIO_WriteLow(display.portScan, display.led[1]);
                        GPIO_WriteLow(display.portScan, display.led[2]);
                        GPIO_WriteLow(display.portData, display.led[3]);
			break;
		}
		case 2:{
                        GPIO_WriteLow(display.portScan, display.led[0]);
			GPIO_WriteHigh(display.portScan, display.led[1]);
                        GPIO_WriteLow(display.portScan, display.led[2]);
                        GPIO_WriteLow(display.portData, display.led[3]);
			break;
		}
		case 3:{
                        GPIO_WriteLow(display.portScan, display.led[0]);
                        GPIO_WriteLow(display.portScan, display.led[1]);
			GPIO_WriteHigh(display.portScan, display.led[2]);
                        GPIO_WriteLow(display.portData, display.led[3]);
			break;
		}
		case 4:{
                        GPIO_WriteLow(display.portScan, display.led[0]);
                        GPIO_WriteLow(display.portScan, display.led[1]);
                        GPIO_WriteLow(display.portScan, display.led[2]);
			GPIO_WriteHigh(display.portData, display.led[3]);
			break;
		}
                default: {
                        GPIO_WriteLow(display.portScan, display.led[0]);
                        GPIO_WriteLow(display.portScan, display.led[1]);
                        GPIO_WriteLow(display.portScan, display.led[2]);
                        GPIO_WriteLow(display.portData, display.led[3]);
                        break;
                }
                  
	}
}

void led_on(void)
{
  TIM1_DeInit();
   /* TIM1 configuration:
   * TIM1 in PWM mode without output disabled. We only interest in the interrupts.
   * Period of PWM is 1024us; Duty cycle adjustable from 1/16 - 15/16.
   * With 16Mhz clock, we use:
   * TIM1_Period = 16 - 1
   * TIM1_Prescaler = 1024 - 1 
   * TIM1_Pulse = [0..15]
   */  
   TIM1_TimeBaseInit(1023, TIM1_COUNTERMODE_UP, 31, 0);
  /*
  TIM1_OCMode = TIM1_OCMODE_PWM1
  TIM1_OutputState = TIM1_OUTPUTSTATE_DISABLED
  TIM1_OutputNState = TIM1_OUTPUTNSTATE_DISABLED
  TIM1_Pulse = [1..16], change using TIM1_SetCompare1
  TIM1_OCPolarity = TIM1_OCPOLARITY_LOW; Doesn't matter as output is disabled
  TIM1_OCNPolarity = TIM1_OCNPOLARITY_HIGH; Doesn't matter as output is disabled
  TIM1_OCIdleState = TIM1_OCIDLESTATE_SET; Doesn't matter as output is disabled
  TIM1_OCNIdleState = TIM1_OCIDLESTATE_RESET; Doesn't matter as output is disabled
  */
  TIM1_OC1Init
  (
    TIM1_OCMODE_PWM1,
    TIM1_OUTPUTSTATE_DISABLE, TIM1_OUTPUTNSTATE_DISABLE,
    display.intensy,
    TIM1_OCPOLARITY_LOW, TIM1_OCNPOLARITY_HIGH,
    TIM1_OCIDLESTATE_SET, TIM1_OCNIDLESTATE_RESET
  ); 
  TIM1_ITConfig((TIM1_IT_TypeDef)(TIM1_IT_UPDATE | TIM1_IT_CC1), ENABLE);
  /* TIM1 Main Output disabled */
  TIM1_CtrlPWMOutputs(DISABLE);  
  /* TIM1 counter enable */
  TIM1_Cmd(ENABLE);
}

void led_off(void)
{
  TIM1_ITConfig((TIM1_IT_TypeDef)(TIM1_IT_UPDATE | TIM1_IT_CC1), DISABLE);
  TIM1_ClearITPendingBit((TIM1_IT_TypeDef)(TIM1_IT_UPDATE | TIM1_IT_CC1));
  TIM1_Cmd(DISABLE);
  //Display Off
  enableLed(0);
  shiftOut595(0x00);
  latch595();
}

void led_setIntensy(uint16_t duty)
{
  if(duty > 15) display.intensy = 15;
  TIM1_SetCompare1((uint16_t)duty);
}

void led_set_blink(led_blink_type blink)
{
   display.blink = blink;
}

void led_set_digit(uint8_t digit, uint8_t value)
{
  if(digit == 0 || digit > 4)
    return;
  display.buffer[digit-1] = code7Seg[value];
}

void LED_TIM1_UPDATE_ISR(void)
{
  static uint8_t digit = 1;
  static uint8_t turn_on = 1;
  static uint16_t blink_count =0;
  ++blink_count;
  switch(display.blink)
  {
  case LED_BLINK_OFF:
    {
      turn_on = 1;
      blink_count = 0;
      break;
    }
  case LED_BLINK_2HZ:
    {
      if(blink_count > 244)
      {
        turn_on = !turn_on;
        blink_count = 0;
      }
      break;
    }
  case LED_BLINK_1HZ:
    {
      if(blink_count > 488)
      {
        turn_on = !turn_on;
        blink_count = 0;
      }
      break;
    }
  case LED_BLINK_HALFHZ:
    {
      if(blink_count > 977)
      {
        turn_on = !turn_on;
        blink_count = 0;
      }
      break;
    }
  }
  if(turn_on)
  {
    writeBuffer(digit-1);
    enableLed(digit);
  }
  if(++digit > 4) digit = 1;
}

void LED_TIM1_CC1_ISR(void)
{
    //Display Off
  enableLed(0);
  shiftOut595(0x00);
  latch595();
}
