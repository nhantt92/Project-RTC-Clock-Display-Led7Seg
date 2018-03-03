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
        uint16_t intensy;
        led_blink_type blink;
}DisplayLed_Struct;

void displayInit(GPIO_TypeDef* portData, GPIO_TypeDef* portScan, uint8_t data, uint8_t clk, uint8_t lat, uint8_t clr, uint8_t led1, uint8_t led2, uint8_t led3, uint8_t led4);
void shiftOut595(uint8_t data);
void latch595(void);
void clear595(void);
void led_setIntensy(uint16_t duty);
void led_set_blink(led_blink_type blink);
void led_set_digit(uint8_t digit, uint8_t value);
void enableLed(uint8_t led);
void writeBuffer(uint8_t pos);
void led_on(void);
void led_off(void);
void LED_TIM1_UPDATE_ISR(void);
void LED_TIM1_CC1_ISR(void);

#endif