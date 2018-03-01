/**
*******************************************
* @file     main.c
* @author   nhantt
* @version  V1.0.0
* @date     25-March-2017
* @brief    This file brief for save memory used build with SDCC
*********************************************
*/

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "main.h"
#include "stm8s_gpio.h"
#include "stm8s_clk.h"
#include "stm8s_conf.h"
#include "stm8s_spi.h"
#include <string.h>
#include "timerTick.h"
#include "stm8s_tim4.h"
#include "display.h"
#include "rtc.h"
TIME tick;
extern DisplayLed_Struct display;

void delay(uint16_t x)
{
    while(x--);
}

INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
{
  TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
  TIMER_Inc();
  IWDG_ReloadCounter();
}

// void IWDG_Config(void)
// {
//   /* IWDG timeout equal to 500 ms (the timeout may varies due to LSI frequency dispersion) */
//   /* Enable write access to IWDG_PR and IWDG_RLR registers */
//   IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
//   /* IWDG counter clock: LSI 128KHz/256 */
//   IWDG_SetPrescaler(IWDG_Prescaler_256);
//   //Set counter reload value to obtain 0.5s IWDG TimeOut.
//   //Counter Reload Value = 0.5s/IWDG counter clock period
//   //                       = 0.5s*LsiFreq/(256) 
//   IWDG_SetReload(250);
//   /* Reload IWDG counter */
//   IWDG_ReloadCounter();
//   /* Enable IWDG (the LSI oscillator will be enabled by hardware) */
//   IWDG_Enable();
// }


void main() 
{
  RTC_TIME time;
  uint8_t sec;
  CLK_Config();
  RTC_Init();
  displayInit(GPIOC, GPIOA, GPIO_PIN_6, GPIO_PIN_5, GPIO_PIN_7, GPIO_PIN_4, GPIO_PIN_3, GPIO_PIN_2, GPIO_PIN_1, GPIO_PIN_3);
  TIMER_Init();
  TIMER_InitTime(&tick);
   
  //IWDG_Config();
  enableInterrupts();
  while(TRUE) 
  {
      if(TIMER_CheckTimeMS(&tick, 50) == 0)
      {
        RTC_GetDateTime(&time);
        setDigit(1, time.sec/10);
        setDigit(2, time.sec%10);
      }
      screen(250);
  }
}


// void GPIO_setup(void) 
// {
//   GPIO_Init(GPIOD, ((GPIO_Pin_TypeDef)GPIO_PIN_5), GPIO_MODE_OUT_PP_HIGH_FAST);
// }
// void SPI_setup(void) 
// {
//   SPI_DeInit(); SPI_Init(SPI_FIRSTBIT_MSB, SPI_BAUDRATEPRESCALER_2, SPI_MODE_MASTER, SPI_CLOCKPOLARITY_HIGH, SPI_CLOCKPHASE_1EDGE, SPI_DATADIRECTION_1LINE_TX, SPI_NSS_SOFT ,0x00); 
//   SPI_Cmd(ENABLE);
// }
