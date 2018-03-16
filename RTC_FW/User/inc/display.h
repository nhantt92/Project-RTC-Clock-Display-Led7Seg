#ifndef __DISPLAY_H
#define __DISPLAY_H

#include "stm8s.h"
#include "stm8s_gpio.h"
#include "stm8s_tim1.h"

typedef enum
{
  LED_BLINK_OFF = (uint8_t)0,
  LED_BLINK_2HZ,
  LED_BLINK_1HZ,
  LED_BLINK_HALFHZ
}led_blink_type;

typedef enum
{       
  LED_ALL_BLINK = (uint8_t)0,
  LED_1_BLINK,
  LED_2_BLINK,
  LED_3_BLINK,
  LED_4_BLINK,
  LED_12_BLINK,
  LED_34_BLINK
}led_blink_digit;

typedef struct
{
	GPIO_TypeDef* portData;
	GPIO_TypeDef* portScan;
	uint8_t data;
	uint8_t clk;
	uint8_t lat;
	uint8_t clr;
	uint8_t led[4];
	uint8_t buffer[4];
        uint8_t intensy;
        led_blink_type blink_type;
        led_blink_digit blink_digit;
}DisplayLed_Struct;

void displayInit(GPIO_TypeDef* portData, GPIO_TypeDef* portScan, uint8_t data, uint8_t clk, uint8_t lat, uint8_t clr, uint8_t led1, uint8_t led2, uint8_t led3, uint8_t led4);
void shiftOut595(uint8_t data);
void latch595(void);
void clear595(void);
void led_setIntensy(uint8_t duty);
void led_set_blink(led_blink_type blink);
void led_digit_blink(led_blink_digit digit);
void led_set_digit(uint8_t digit, uint8_t value);
void led_clear_digit(uint8_t digit);
void enableLed(uint8_t led);
void disableLed(uint8_t led);
void writeBuffer(uint8_t pos);
void led_on(void);
void led_off(void);
void LED_TIM1_UPDATE_ISR(void);
void LED_TIM1_CC1_ISR(void);

#endif