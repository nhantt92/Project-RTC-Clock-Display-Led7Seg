#include "system.h"
#include "display.h"
#include "key.h"
#include "DS1307.h"

SYS_STRUCT sys;
extern DisplayLed_Struct display;
extern DATATIME timenow;
DATATIME timeset;
void System_Init(void)
{
  GPIO_Init(RING_PORT, RING_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
  GPIO_WriteLow(RING_PORT, RING_PIN);
  sys.mode = MODE_NORMAL;
  sys.flag_pm = FALSE;
  DS1307_SetPM(sys.flag_pm);
  TIMER_InitTime(&sys.tick);
}

uint8_t check24h()
{
  if(timenow.hh == 23 || timenow.hh == 0 || timenow.hh == 1 || timenow.hh == 2 || timenow.hh == 3 || timenow.hh == 4 || timenow.hh ==5)
    return 0;
  else
    return 1;
}

uint8_t check12h()
{
  if(timenow.hh == 11 || timenow.hh == 12 || timenow.hh == 1 || timenow.hh == 2 || timenow.hh == 3 || timenow.hh == 4 || timenow.hh ==5)
    return 0;
  else
    return 1;
}

void system_ring()
{
  if((sys.flag_pm == 0) && check24h() == 1)
  {
    if(timenow.mn == 0)
    {
    if(timenow.ss < 4)
    {
      if(timenow.ss % 2 == 0)
      {
        GPIO_WriteHigh(RING_PORT, RING_PIN);
      }
      else
        GPIO_WriteLow(RING_PORT, RING_PIN);
    }
    else
      GPIO_WriteLow(RING_PORT, RING_PIN);
    }
  }
  else if((sys.flag_pm == 1) && check12h() == 1)
  {
          if(timenow.mn == 0)
    {
    if(timenow.ss < 4)
    {
      if(timenow.ss % 2 == 0)
      {
        GPIO_WriteHigh(RING_PORT, RING_PIN);
      }
      else
        GPIO_WriteLow(RING_PORT, RING_PIN);
    }
    else
      GPIO_WriteLow(RING_PORT, RING_PIN);
    }
  }
  else
    GPIO_WriteLow(RING_PORT, RING_PIN);
}

void System_Manager(void)
{
   static uint8_t mode = 0;
   if(TIMER_CheckTimeMS(&sys.tick, 20)==0)
   {
     switch(sys.mode)
     {
     case MODE_NORMAL:
       //modeget = keyget(MODE);
       led_set_blink(LED_BLINK_OFF);
       if(timenow.hh / 10 == 0)
       {
         led_clear_digit(1);
         led_set_digit(2, timenow.hh%10);
         led_set_digit(3, timenow.mn/10);
         led_set_digit(4, timenow.mn%10);
       }
       else
       {
         led_set_digit(1, timenow.hh/10);
         led_set_digit(2, timenow.hh%10);
         led_set_digit(3, timenow.mn/10);
         led_set_digit(4, timenow.mn%10);
       }
       system_ring();
       if(keyget(MODE) == KEY_PRESS)
       {
         ++sys.modePressTime;
         if(sys.modePressTime > 10 && sys.modePressTime < 15)
         {
           sys.modeflag = 1;
           sys.modeReleaseTime = 50;
         }
         if(sys.modePressTime > 50)
         {
           sys.mode = MODE_SET_TIME;
           sys.setTimeOut = 800;
           sys.modePressTime = 0;
         }
       }
       else
       {
         if((sys.modeflag == 1) && (sys.modeReleaseTime != 0))
         {
           sys.flag_pm = !sys.flag_pm;
           DS1307_SetPM(sys.flag_pm);
           sys.modeflag = 0;
           sys.modePressTime = 0;
           
         }
         else
         {
            sys.modeReleaseTime--;
         }
       }
      // UpGet = keyget(UP);
       if(keyget(UP) == KEY_PRESS)
       {
         ++sys.upPressTime;
         if(sys.upPressTime > 10)
         {
            if(++display.intensy>30) display.intensy = 30;
            led_setIntensy(display.intensy);
            sys.upPressTime = 0;
         }
       }
       //DownGet = keyget(DOWN);
       if(keyget(DOWN) == KEY_PRESS)
       {
          ++sys.downPressTime;
         if(sys.downPressTime > 10)
         {
            if(--display.intensy < 1) display.intensy = 1;
            led_setIntensy(display.intensy);
            sys.downPressTime = 0;
         }
       }
       break;
     case MODE_SET_TIME:
        if(keyget(MODE) == KEY_PRESS)
        {
            ++sys.modePressTime;
            if(sys.modePressTime > 50)
            {
              mode++;
              if(mode > 3) mode = 0; 
              sys.setTimeOut = 800;
              sys.modePressTime = 0;
            }
        }
        else
        {
            if(--sys.setTimeOut == 0)
            {
                sys.mode = MODE_NORMAL;
                mode = 0;
            }
        }
        switch(mode)
        {
         case 1: 
            led_set_blink(LED_BLINK_2HZ);
            led_digit_blink(LED_12_BLINK);
            led_set_digit(1, timeset.hh/10);
            led_set_digit(2, timeset.hh%10);
            led_set_digit(3, timeset.mn/10);
            led_set_digit(4, timeset.mn%10);
             if(keyget(UP) == KEY_PRESS)
             {
               ++sys.upPressTime;
               if(sys.upPressTime > 10)
               {
                  if(++timeset.hh > 23) timeset.hh = 0;
                  sys.setTimeOut = 800;
                  sys.upPressTime = 0;
               }
             }
             if(keyget(DOWN) == KEY_PRESS)
             {
               ++sys.downPressTime;
               if(sys.downPressTime > 10)
               {
                  if(--timeset.hh == 255) timeset.hh = 23;
                  sys.setTimeOut = 800;
                  sys.downPressTime = 0;
               }
             }
            break;
          case 2:
            led_set_blink(LED_BLINK_2HZ);
            led_digit_blink(LED_34_BLINK);
            led_set_digit(1, timeset.hh/10);
            led_set_digit(2, timeset.hh%10);
            led_set_digit(3, timeset.mn/10);
            led_set_digit(4, timeset.mn%10);
             if(keyget(UP) == KEY_PRESS)
             {
               ++sys.upPressTime;
               if(sys.upPressTime > 15)
               {
                  if(++timeset.mn > 59) timeset.mn = 0;
                  sys.setTimeOut = 800;
                  sys.upPressTime = 0;
               }
             }
             if(keyget(DOWN) == KEY_PRESS)
             {
                ++sys.downPressTime;
               if(sys.downPressTime > 15)
               {
                  if(--timeset.mn == 255) timeset.mn = 59;
                  sys.setTimeOut = 800;
                  sys.downPressTime = 0;
               }
             }
            break;
          case 3:
            DS1307_SetTime(&timeset);
            mode = 0;
            sys.mode = MODE_NORMAL;
            break;
          default:
            led_set_blink(LED_BLINK_2HZ);
            led_digit_blink(LED_ALL_BLINK);
            DS1307_GetTime(&timeset);
            break;
          }
        }
     }
}
