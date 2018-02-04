#ifndef __DISPLAY_H
#define __DISPLAY_H
#include "stm8s.h"
#include "stm8s_gpio.h"

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
}DisplayLed_Struct;

void displayInit(GPIO_TypeDef* portData, GPIO_TypeDef* portScan, uint8_t data, uint8_t clk, uint8_t lat, uint8_t clr, uint8_t led1, uint8_t led2, uint8_t led3, uint8_t led4);
void shiftOut595(uint8_t data);
void latch595(void);
void clear595(void);
void display_test(void);
void screen(void);

#endif