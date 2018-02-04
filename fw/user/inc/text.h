#ifndef _TEXT_H
#define _TEXT_H

#include "stm8s.h"

typedef struct TEXT_Struct
{
	uint16_t scrollCnt;
	uint32_t tick;
	uint8_t data[20];
	uint8_t change;
}TEXT;

void Text_Init(void);
void Text_GetStringToBuff(uint8_t *str);

#endif