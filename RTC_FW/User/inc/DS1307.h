

#include "SW_I2C.h"

#define DS1307_SECOND    0x00
#define DS1307_HALT (1 << 7)

#define DS1307_MINUTE    0x01

#define DS1307_HOUR      0x02
#define DS1307_12H_MODE (1 << 6)
#define DS1307_12H_PM   (1 << 5)

#define DS1307_WEEK      0x03
#define DS1307_DAY       0x04
#define DS1307_MONTH     0x05
#define DS1307_YEAR      0x06

#define DS1307_ADDR                       0xD0
#define DS1307_WR                         DS1307_ADDR
#define DS1307_RD                         0xD1

#define DS1307_CTRL 0x07
#define DS1307_SQW_OUT  (1 << 7)
#define DS1307_SQW_EN   (1 << 4)
#define DS1307_SQW_RS1  (1 << 1)
#define DS1307_SQW_RS0  (1 << 0)

#define DS1307_OUT_1HZ 0x00
#define DS1307_OUT_4096KHZ 0x01
#define DS1307_OUT_8192KHZ 0x02
#define DS1307_OUT_32768KHZ 0x03

/* RAM */

#define DS1307_REG_RAM 0x08
#define DS1307_REG_END 0x40

/*
 * Square wave output
 * ----------------------
 * OUT EN RS1 RS0 Result
 *  X  1   0   0      1Hz
 *  X  1   0   1   4096Hz
 *  X  1   1   0   8192Hz
 *  X  1   1   1  32768Hz
 *  1  0   X   X     High
 *  0  0   X   X      Low
*/
typedef struct
{
  uint8_t ss; //seconds
  uint8_t mn; //minutes
  uint8_t hh; //hours
  uint8_t wd; //day in weeks
  uint8_t md; //day in month
  uint8_t mo; //month
  uint8_t yy;
}DATATIME;

void DS1307_Init(void);
uint8_t DS1307_Read(uint8_t address, uint8_t *data);
uint8_t DS1307_Write(uint8_t address, uint8_t value);
unsigned char bcd_to_decimal(unsigned char value);
unsigned char decimal_to_bcd(unsigned char value);
void DS1307_GetTime(DATATIME *getTime);
void DS1307_SetTime(DATATIME *setTime);
void DS1307_SetPM(bool flag);
void DS1307_SetOutSQW(uint8_t hz, uint8_t en);
uint8_t DS1307_WriteRAM(uint8_t addr, uint8_t byte);
uint8_t DS1307_ReadRAM(uint8_t addr, uint8_t byte);
