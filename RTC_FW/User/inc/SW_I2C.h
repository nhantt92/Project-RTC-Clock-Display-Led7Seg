#include "stm8s.h"

#define SW_I2C_port		GPIOB

#define SDA_pin                 GPIO_PIN_5
#define SCL_pin         	GPIO_PIN_4

#define SW_I2C_OUT()    	do{GPIO_DeInit(SW_I2C_port); GPIO_Init(SW_I2C_port, SDA_pin, GPIO_MODE_OUT_PP_LOW_FAST); GPIO_Init(SW_I2C_port, SCL_pin, GPIO_MODE_OUT_PP_LOW_FAST);}while(0)

#define SW_I2C_IN()     	do{GPIO_DeInit(SW_I2C_port); GPIO_Init(SW_I2C_port, SDA_pin, GPIO_MODE_IN_FL_NO_IT); GPIO_Init(SW_I2C_port, SCL_pin, GPIO_MODE_OUT_PP_LOW_FAST);}while(0)

#define SDA_HIGH()      			GPIO_WriteHigh(SW_I2C_port, SDA_pin)
#define SDA_LOW()       			GPIO_WriteLow(SW_I2C_port, SDA_pin)
#define SCL_HIGH()      			GPIO_WriteHigh(SW_I2C_port, SCL_pin)
#define SCL_LOW()      		    GPIO_WriteLow(SW_I2C_port, SCL_pin)

#define SDA_IN()        				GPIO_ReadInputPin(SW_I2C_port, SDA_pin)

#define I2C_ACK         				0xFF
#define I2C_NACK        			0x00

#define I2C_timeout     			1000


void SW_I2C_init(void);
void SW_I2C_start(void);
void SW_I2C_stop(void);
uint8_t SW_I2C_read(uint8_t ack);
void SW_I2C_write(uint8_t value);
void SW_I2C_ACK_NACK(uint8_t mode);
uint8_t SW_I2C_wait_ACK(void);