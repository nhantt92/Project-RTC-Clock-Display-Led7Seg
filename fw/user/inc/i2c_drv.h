#ifndef _I2C_DRV_H
#define _I2C_DRV_H

#include "stm8s.h"
#include "stm8s_gpio.h"

#define  SOFT_I2C_SDA_OUT        GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_HIZ_FAST)
#define  SOFT_I2C_SCL_OUT        GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_HIZ_FAST)
#define  SOFT_I2C_SDA_IN         GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT)
#define  SOFT_I2C_SCL_IN         GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_IN_FL_NO_IT)

#define  SOFT_I2C_SDA_PIN        GPIO_ReadInputPin(GPIOB, GPIO_PIN_5) 
#define  SOFT_I2C_SCL_PIN        GPIO_ReadInputPin(GPIOB, GPIO_PIN_4)

#define  SOFT_I2C_SDA_HIGH       GPIO_WriteHigh(GPIOB, GPIO_PIN_5)
#define  SOFT_I2C_SDA_LOW        GPIO_WriteLow(GPIOB, GPIO_PIN_5)
#define  SOFT_I2C_SCL_HIGH       GPIO_WriteHigh(GPIOB, GPIO_PIN_4)
#define  SOFT_I2C_SCL_LOW        GPIO_WriteLow(GPIOB, GPIO_PIN_4)

#define  SOFT_SDA                2
#define  SOFT_SCL                1

void SoftI2CInit();
void SoftI2CStart();
void SoftI2CStop();
uint8_t SoftI2CWriteByte(uint8_t data);
uint8_t SoftI2CReadByte(uint8_t ack);
#endif