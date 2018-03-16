//#ifndef __KEY_H
//#define __KEY_H

#include "stm8s.h"
#include "timerTick.h"

#define KEY_PORT GPIOD

#define KEY1 GPIO_PIN_6
#define KEY2 GPIO_PIN_2
#define KEY3 GPIO_PIN_3

#define KEY1_In() GPIO_ReadInputPin(KEY_PORT, KEY1)
#define KEY2_In() GPIO_ReadInputPin(KEY_PORT, KEY2)
#define KEY3_In() GPIO_ReadInputPin(KEY_PORT, KEY3)

#define NUM_OF_SAMPLE_KEY 10
#define NUM_KEY 3

typedef enum{
  MODE = 0,
  UP = 1,
  DOWN = 2
}KEY_NAME;

typedef enum{
  KEY_RELEASE = 0,
  KEY_PRESS
}KEY_EVENT;

typedef struct{
  uint8_t pressed;
  uint8_t press;
  uint8_t waitRelease;
  uint8_t cnt;
}KEY_EXT;

typedef struct{
  KEY_NAME name;
  KEY_EXT ext[NUM_KEY];
  TIME tick;
  uint8_t pressFlag[NUM_KEY];
}KEY_STRUCT;

void Key_Init(void);
void Key_Get(uint8_t port_id);
uint8_t keyget(uint8_t id);
void Key_Process(void);
void Key_Manager(void);

//#endif