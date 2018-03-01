#include "i2c_drv.h"
#include "timerTick.h"

TIME softI2cTime;
#define Q_DEL   while(TIMER_CheckTimeUS(&softI2cTime, 20)); //IWDG_ReloadCounter();
#define H_DEL   while(TIMER_CheckTimeUS(&softI2cTime, 50)); //IWDG_ReloadCounter();

void SoftI2CInit()
{
  SOFT_I2C_SDA_OUT;
  SOFT_I2C_SCL_OUT;
  
  SOFT_I2C_SDA_HIGH;
  SOFT_I2C_SCL_HIGH;      
  TIMER_InitTime(&softI2cTime);
}

void SoftI2CStart()
{
  SOFT_I2C_SCL_HIGH;
  H_DEL;
  
  SOFT_I2C_SDA_LOW;   
  H_DEL;      
}

void SoftI2CStop()
{
   SOFT_I2C_SDA_LOW;
   H_DEL;
   SOFT_I2C_SCL_HIGH;
   Q_DEL;
   SOFT_I2C_SDA_HIGH;
   H_DEL;
}

uint8_t SoftI2CWriteByte(uint8_t data)
{   
   uint8_t i;   
   uint8_t ack;   
   for(i=0;i<8;i++)
   {
      SOFT_I2C_SCL_LOW;
      Q_DEL;
      
      if(data & 0x80)
          SOFT_I2C_SDA_HIGH;
      else
          SOFT_I2C_SDA_LOW;        
      H_DEL;
      
      SOFT_I2C_SCL_HIGH;
      H_DEL;
      
//      SOFT_I2C_SCL_IN;
//      Q_DEL;
//      while((SOFT_I2C_SCL_PIN & (1<<SOFT_SCL))==0);
//      SOFT_I2C_SCL_OUT;        
      data=data<<1;
      Q_DEL;
  }
   
  //The 9th clock (ACK Phase)
  SOFT_I2C_SCL_LOW;
  Q_DEL;
      
  SOFT_I2C_SDA_HIGH;      
  H_DEL;
      
  SOFT_I2C_SCL_HIGH;
  H_DEL;  
  
  SOFT_I2C_SDA_IN;
  ack=!(SOFT_I2C_SDA_PIN & (1<<SOFT_SDA));
  SOFT_I2C_SDA_OUT;
  
  SOFT_I2C_SCL_LOW;
  H_DEL;
  
  return ack;   
}
  
uint8_t SoftI2CReadByte(uint8_t ack)
{
    uint8_t data=0x00;
    uint8_t i;    
    SOFT_I2C_SDA_IN;
    for(i=0;i<8;i++)
    {          
        SOFT_I2C_SCL_LOW;
        H_DEL;
        SOFT_I2C_SCL_HIGH;
        H_DEL;
           
//        SOFT_I2C_SCL_IN;
//        Q_DEL;
//        while((SOFT_I2C_SCL_PIN & (1<<SOFT_SCL))==0);      
        if(SOFT_I2C_SDA_PIN &(1<<SOFT_SDA))
            data|=(0x80>>i);    
        //SOFT_I2C_SCL_OUT;
        Q_DEL;
    }     
    SOFT_I2C_SDA_OUT;
    SOFT_I2C_SCL_LOW;
    Q_DEL;                      //Soft_I2C_Put_Ack  
    if(ack)
    {
        SOFT_I2C_SDA_LOW;   
    }
    else
    {
        SOFT_I2C_SDA_HIGH;
    }   
    H_DEL;   
    SOFT_I2C_SCL_HIGH;
    H_DEL;   
    SOFT_I2C_SCL_LOW;
    H_DEL;           
    return data;  
}













