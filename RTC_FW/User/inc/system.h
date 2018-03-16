#ifndef __KEY_H
#define __KEY_H

#include "stm8s.h"
#include "timerTick.h"

#define RING_PORT GPIOD
#define RING_PIN GPIO_PIN_4

typedef enum {
  MODE_NORMAL = 0,
  MODE_SET_TIME = 1
}FLAG_MODE;

typedef struct {
  FLAG_MODE mode;
  TIME tick;
  uint32_t setTimeOut;
  uint8_t modePressTime;
  uint8_t modeReleaseTime;
  uint8_t modeflag;
  uint8_t upPressTime;
  uint8_t downPressTime;
  uint8_t brightness;
  uint8_t ring;
  bool flag_pm;
}SYS_STRUCT;

void System_Init(void);
void System_Manager(void);

#endif
