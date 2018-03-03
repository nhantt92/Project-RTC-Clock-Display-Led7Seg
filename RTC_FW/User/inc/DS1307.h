

#include "SW_I2C.h"

#define DS1307_SECOND    0x00
#define DS1307_MINUTE    0x01
#define DS1307_HOUR      0x02
#define DS1307_WEEK      0x03
#define DS1307_DAY       0x04
#define DS1307_MONTH     0x05
#define DS1307_YEAR      0x06
#define DS1306_CTR       0x07

#define DS1307_ADDR                       0xD0
#define DS1307_WR                         DS1307_ADDR
#define DS1307_RD                         0xD1

typedef struct
{
  uint8_t ss; //seconds
  uint8_t mn; //minutes
  uint8_t hh; //hours
  uint8_t wd; //day in weeks
  uint8_t md; //day in month
  uint8_t mo; //month
  uint8_t yy;
} DATATIME;

void DS1307_Init(void);
uint8_t DS1307_Read(uint8_t address, uint8_t *data);
uint8_t DS1307_Write(uint8_t address, uint8_t value);
unsigned char bcd_to_decimal(unsigned char value);
unsigned char decimal_to_bcd(unsigned char value);
void DS1307_GetTime(DATATIME *getTime);
void DS1307_SetTime(DATATIME *setTime);
void PM_Set(uint8_t pm);
