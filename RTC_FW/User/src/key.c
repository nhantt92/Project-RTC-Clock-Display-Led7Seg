#include "key.h"

KEY_STRUCT key;

void Key_Init(void)
{
  GPIO_Init(KEY_PORT, KEY1|KEY2|KEY3, GPIO_MODE_IN_PU_NO_IT);
  for(key.name = 0; key.name < NUM_KEY; key.name++)
  {
      key.ext[key.name].press = KEY_RELEASE;
      key.ext[key.name].waitRelease = 0;
      key.ext[key.name].cnt = 0;
      key.pressFlag[key.name] = 0;
  }
}

void Key_Get(uint8_t port_id)
{
  uint8_t keyGet;
  switch(port_id)
  {
  case 0: 
    keyGet = KEY1_In();
    if(keyGet == 0)
      key.ext[port_id].press = KEY_PRESS;
    else
      key.ext[port_id].press = KEY_RELEASE;
    break;
  case 1:
    keyGet = KEY2_In();
    if(keyGet == 0)
      key.ext[port_id].press = KEY_PRESS;
    else
      key.ext[port_id].press = KEY_RELEASE;
    break;
  case 2:
    keyGet = KEY3_In();
    if(keyGet == 0)
      key.ext[port_id].press = KEY_PRESS;
    else
      key.ext[port_id].press = KEY_RELEASE;
    break;
  }
  if(key.ext[port_id].press != key.ext[port_id].pressed)
  {
      ++(key.ext[port_id].cnt);
      if(key.ext[port_id].cnt == NUM_OF_SAMPLE_KEY)
      {
        key.ext[port_id].pressed = key.ext[port_id].press;
        key.ext[port_id].cnt = 0;
      }
  }
  else
  {
    key.ext[port_id].cnt = 0;
  }
}

uint8_t keyget(uint8_t id)
{
  return key.ext[id].pressed;
}

void Key_Process(void)
{
  for(key.name = 0; key.name < NUM_KEY; key.name++)
  {
    Key_Get(key.name);
    if(key.ext[key.name].pressed == KEY_PRESS)
    {
      key.ext[key.name].waitRelease = 1;
    }
    if(key.ext[key.name].pressed == KEY_RELEASE)
    {
      key.ext[key.name].waitRelease = 0;
    }
  }
}
