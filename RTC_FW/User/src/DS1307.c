#include "DS1307.h"

#define BinToBCD(bin) ((((bin) / 10) << 4) + ((bin) % 10))
#define BCDToBin(bcd) ((((bcd) >> 4))*10 + ((bcd)&0x0F))

void DS1307_Init(void)
{
    SW_I2C_init();
    DS1307_Write(DS1306_CTR, 0x90);
}


uint8_t DS1307_Read(uint8_t address, uint8_t *data)
{
    disableInterrupts();
    SW_I2C_start();
    SW_I2C_write(DS1307_WR);
    SW_I2C_write(address);

    SW_I2C_start();
    SW_I2C_write(DS1307_RD);
    *data = SW_I2C_read(I2C_NACK);
    SW_I2C_stop();
    enableInterrupts();
    return TRUE;
}


uint8_t DS1307_Write(uint8_t address, uint8_t value)
{
    disableInterrupts();
    SW_I2C_start();
    SW_I2C_write(DS1307_WR);
    SW_I2C_write(address);
    SW_I2C_write(value);
    SW_I2C_stop();
    enableInterrupts();
    return TRUE;
}

void DS1307_GetTime(DATATIME *getTime)
{
  uint8_t i, buffer[7];
  for(i = 0; i < 7; i++)
  {
    DS1307_Read(i, &buffer[i]);
  }
  getTime->ss = BCDToBin(buffer[0]&0x7F);
  getTime->mn = BCDToBin(buffer[1]&0x7F);
  if((buffer[2]&0x40)!=0)
    getTime->hh = BCDToBin(buffer[2]&0x1F);
  else
    getTime->hh = BCDToBin(buffer[2]&0x3F);
  getTime->wd = BCDToBin(buffer[3]&0x07);
  getTime->md = BCDToBin(buffer[4]&0x3F);
  getTime->mo = BCDToBin(buffer[5]&0x1F);
  getTime->yy = BCDToBin(buffer[6]&0xFF);
}

void DS1307_SetTime(DATATIME *setTime)
{
  uint8_t i, buffer[7];
  buffer[0] = BinToBCD(setTime->ss);
  buffer[1] = BinToBCD(setTime->mn);
  buffer[2] = BinToBCD(setTime->hh);
  buffer[3] = BinToBCD(setTime->wd);
  buffer[4] = BinToBCD(setTime->md);
  buffer[5] = BinToBCD(setTime->mo);
  buffer[6] = BinToBCD(setTime->yy);
  for(i = 0; i < 7; i++)
  {
    DS1307_Write(i, buffer[i]);
  }
}
