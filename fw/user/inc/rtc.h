#ifndef __RTC_H
#define __RTC_H

#include "stm8s.h"
#include "stm8s_i2c.h"
#include "stm8s_clk.h"

#define DS1307_I2C_CLOCK                400000
#define DS1307_I2C_ADDR                 0xD0

#define DS1307_SLA_W                    0xD0
#define DS1307_SLA_R                    0xD1

#define DS1307_SECONDS                  0x00
#define DS1307_MINUTES                  0x01
#define DS1307_HOURS                    0x02
#define DS1307_DAY                      0x03
#define DS1307_DATE                     0x04
#define DS1307_MONTH                    0x05
#define DS1307_YEAR                     0x06
#define DS1307_CONTROL                  0x07

#define TM_DS1307_CONTROL_OUT           7
#define TM_DS1307_CONTROL_SQWE          4
#define TM_DS1307_CONTROL_RS1           1
#define TM_DS1307_CONTROL_RS0           0

typedef struct
{
  int16_t year;				// year with all 4-digit (2011)
  int8_t month;				// month 1 - 12 (1 = Jan)
  int8_t mday;				// day of month 1 - 31
  int8_t wday;				// day of week 1 - 7 (1 = Sunday)
  int8_t hour;				// hour 0 - 23
  int8_t min;			        // min 0 - 59
  int8_t sec;				// sec 0 - 59
}DATE_TIME;

typedef struct
{
  uint8_t sec;
  uint8_t min;
  uint8_t hour;
  uint8_t day;
  uint8_t date;
  uint8_t month;
  uint8_t year;
}RTC_TIME;

extern RTC_TIME dayTime;

uint8_t BIN2BCD(uint8_t data);
uint8_t BCD2BIN(uint8_t data);
uint8_t RTC_ReadDs1307(uint8_t regadd);

void RTC_Init(void);
void RTC_GetDateTime(RTC_TIME* time);
void RTC_SetDateTime(RTC_TIME* time);
uint32_t RTC_GetUnixTimestamp(DATE_TIME *dt);
void RTC_CalcTime(DATE_TIME *dt, uint32_t unixTime);
#endif


