#include "display.h"
#include <string.h>

const uint8_t code7Seg[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

DisplayLed_Struct display;

static void delay_us(uint16_t x)
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
	// display.buffer[0] = code7Seg[1];
	// display.buffer[1] = code7Seg[2];
	// display.buffer[2] = code7Seg[3];
	// display.buffer[3] = code7Seg[4];
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
	delay_us(100);
}

void writeBuffer(uint8_t pos)
{
	shiftOut595(display.buffer[pos]);
	latch595();
}

void onLed(uint8_t led)
{
	switch(led)
	{
		case 1: {
			GPIO_WriteHigh(display.portScan, display.led[0]);
			break;
		}
		case 2:{
			GPIO_WriteHigh(display.portScan, display.led[1]);
			break;
		}
		case 3:{
			GPIO_WriteHigh(display.portScan, display.led[2]);
			break;
		}
		case 4:{
			GPIO_WriteHigh(display.portData, display.led[3]);
			break;
		}
		default: break;
	}
}

void offLed(uint8_t led)
{
	switch(led)
	{
		case 1: {
			GPIO_WriteLow(display.portScan, display.led[0]);
			break;
		}
		case 2:{
			GPIO_WriteLow(display.portScan, display.led[1]);
			break;
		}
		case 3:{
			GPIO_WriteLow(display.portScan, display.led[2]);
			break;
		}
		case 4:{
			GPIO_WriteLow(display.portData, display.led[3]);
			break;
		}
		default: break;
	}
}

void screen(uint8_t intensy)
{
	uint8_t i;
	for(i = 0; i < 4; i++)
	{
		writeBuffer(i);
		onLed(i+1);
		delay_us(intensy);
		offLed(i+1);
		delay_us(255-intensy);
	}
}

void setDigit(uint8_t led, uint8_t bcd)
{
	display.buffer[led-1] = code7Seg[bcd];
}

void display_test(uint8_t intensy)
{
	uint8_t i;
	for(i = 0; i < 20; i++)
	{
		shiftOut595(0x3F);
		latch595();
		GPIO_WriteHigh(display.portScan, display.led[0]);
		delay_us(intensy);
		GPIO_WriteLow(display.portScan, display.led[0]);
		delay_us(255-intensy);
		shiftOut595(0x06);
		latch595();
		GPIO_WriteHigh(display.portScan, display.led[1]);
		delay_us(intensy);
		GPIO_WriteLow(display.portScan, display.led[1]);
		delay_us(255-intensy);
		shiftOut595(0x5B);
		latch595();
		GPIO_WriteHigh(display.portScan, display.led[2]);
		delay_us(intensy);
		GPIO_WriteLow(display.portScan, display.led[2]);
		delay_us(255-intensy);
		shiftOut595(0x4F);
		latch595();
		GPIO_WriteHigh(display.portData, display.led[3]);
		delay_us(intensy);
		GPIO_WriteLow(display.portData, display.led[3]);
		delay_us(255-intensy);
	}
}
