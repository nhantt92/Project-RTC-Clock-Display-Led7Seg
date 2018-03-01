#include "rtc.h"
#include "i2c_drv.h"
#include <time.h>

RTC_TIME dayTime;

void RTC_Init(void)
{ 
  SoftI2CInit(); 
   dayTime.sec = 1;
   dayTime.min = 8;
   dayTime.hour = 11;
   dayTime.day = 1;
   dayTime.date = 16;
   dayTime.month = 8;
   dayTime.year = 15;
   RTC_SetDateTime(&dayTime);
}

/***************************************************
Function To Read Internal Registers of DS1307
---------------------------------------------
address : Address of the register
data: value of register is copied to this.

Returns:
0= Failure
1= Success
***************************************************/
uint8_t DS1307Read(uint8_t address,uint8_t *data)
{
    uint8_t res;    //result  
    disableInterrupts();
    //Start
    SoftI2CStart();   
    //SLA+W (for dummy write to set register pointer)
    res=SoftI2CWriteByte(DS1307_SLA_W); //DS1307 address + W   
    //Error
    if(!res)    return FALSE;   
    //Now send the address of required register
    res=SoftI2CWriteByte(address);
    //Error
    if(!res)    return FALSE;
    //Repeat Start
    SoftI2CStart();
    //SLA + R
    res=SoftI2CWriteByte(DS1307_SLA_R); //DS1307 Address + R
    //Error
    if(!res)    return FALSE;
    //Now read the value with NACK
    *data=SoftI2CReadByte(0);  
    //Error
    if(!res)    return FALSE;   
    //STOP
    SoftI2CStop();
    enableInterrupts();
    return TRUE;
}

/***************************************************
Function To Write Internal Registers of DS1307
---------------------------------------------
address : Address of the register
data: value to write.


Returns:
0= Failure
1= Success
***************************************************/
uint8_t DS1307Write(uint8_t address,uint8_t data)
{
    uint8_t res;    //result    
    disableInterrupts();
    //Start
    SoftI2CStart();    
    //SLA+W
    res=SoftI2CWriteByte(DS1307_SLA_W); //DS1307 address + W    
    //Error
    if(!res)    return FALSE;
    //Now send the address of required register
    res=SoftI2CWriteByte(address);
    //Error
    if(!res)    return FALSE;
    //Now write the value
    res=SoftI2CWriteByte(data);   
    //Error
    if(!res)    return FALSE;
    //STOP
    SoftI2CStop();
    enableInterrupts();
    return TRUE;
}

void RTC_GetDateTime(RTC_TIME* time) 
{
   unsigned char i,data[8];
   uint8_t status;
   for(i=0;i<8;i++)
   {
      status = DS1307Read(i, &data[i]);
      if(status != TRUE)
        status = 0;
   }
   time->sec = BCD2BIN(data[0]&=0x7F);
   time->min = BCD2BIN(data[1]&=0x7F);
   if((data[2]&0x40)!=0)time->hour=BCD2BIN(data[2]&=0x1F);
   else time->hour=BCD2BIN(data[2]&=0x3F);
   time->day = BCD2BIN(data[3]&=0x07);
   time->date = BCD2BIN(data[4]&=0x3F);
   time->month = BCD2BIN(data[5]&=0x1F);
   time->year = BCD2BIN(data[6]&=0xFF);
}

void RTC_SetDateTime(RTC_TIME* time)
{
  uint8_t i,data[8];
  uint8_t status;
  data[0]=BIN2BCD(time->sec);
  data[1]=BIN2BCD(time->min);
  data[2]=BIN2BCD(time->hour);
  data[3]=BIN2BCD(time->day);
  data[4]=BIN2BCD(time->date);
  data[5]=BIN2BCD(time->month);
  data[6]=BIN2BCD(time->year);
  data[7]=0;
  for(i=0;i<8;i++)
  {
    status = DS1307Write(i, data[i]);
    if(status != TRUE)
        status = 0;
  }
}

uint8_t BCD2BIN(uint8_t data)
{
  uint8_t high,low;
  high=(data>>4)&0x0F;
  low=data&0x0F;
  return ((high*10)+low);
}

uint8_t BIN2BCD(uint8_t data)
{
  unsigned char high,low;
  high=data/10; high =(high<<4)&0xF0;
  low=data%10;  low&=0x0F;
  return ((high)|low);
}


void RTC_CalcTime(DATE_TIME *dt, uint32_t unixTime)
{
  struct tm *gt;
  time_t epoch;
  epoch = unixTime;
  gt = localtime(&epoch);			
  dt->sec = gt->tm_sec;
  dt->min = gt->tm_min;
  dt->hour = gt->tm_hour;
  dt->mday = gt->tm_mday;
  dt->wday = gt->tm_wday + 1;				// tm_wday 0 - 6 (0 = sunday)
  dt->month = gt->tm_mon + 1;				// tm_mon 0 - 11 (0 = Jan)
  dt->year = gt->tm_year + 1900;		// tm_year = current year - 1900
}

uint32_t RTC_GetUnixTimestamp(DATE_TIME *dt)
{
  struct tm t;
  time_t t_of_day;
  t.tm_year = dt->year - 1900;
  t.tm_mon = dt->month - 1; 				// Month, 0 - jan
  t.tm_mday = dt->mday; 						// Day of the month
  t.tm_hour = dt->hour;
  t.tm_min = dt->min;
  t.tm_sec = dt->sec;
  t.tm_isdst = -1; 									// Is DST on? 1 = yes, 0 = no, -1 = unknown
  t_of_day = mktime(&t);
  return (uint32_t)t_of_day; 
}



