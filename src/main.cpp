#include <Arduino.h>
#include <math.h>
#include "Wire.h"
#include "SSD1306Wire.h"

TaskHandle_t TaskWriteSinus;

hw_timer_s *timer = NULL;
uint32_t counterms = 0;

bool flagRead = false;
float sinusValue = 0;
uint8_t dacValue = 0;
uint16_t adcValue = 0;
uint8_t posX = 0;
SSD1306Wire myDisplay(0x3c, SDA, SCL);

void setup();
void loop();
void timerInit();
void IRAM_ATTR onTimer();
void writeSinus(void *parameter);

void setup()
{
  timerInit();
  Serial.begin(115200);
  analogReadResolution(12);

  xTaskCreate(
      writeSinus,
      "Write Sinus",
      1000,
      NULL,
      1,
      &TaskWriteSinus);

  myDisplay.init();
  myDisplay.flipScreenVertically();
}

void loop()
{
  if (flagRead)
  {
    adcValue = analogRead(33);
    adcValue = map(adcValue, 0, 4095, 55, 10);
    myDisplay.setPixel(posX, adcValue);
    myDisplay.display();
    posX++;
    flagRead = false;
  }
  if (posX == 128)
  {
    posX = 0;
    myDisplay.clear();
  }
}

void timerInit()
{
  timer = timerBegin(0, 80, true);
  timerAttachInterrupt(timer, onTimer, true);
  timerAlarmWrite(timer, 1000, true);
  timerAlarmEnable(timer);
}

void IRAM_ATTR onTimer()
{
  counterms++;
  if (counterms % 20 == 0)
  {
    flagRead = true;
  }
}

void writeSinus(void *parameter)
{
  bool plusMinus = true;
  uint16_t period = 1000;
  for (;;)
  {
    sinusValue = sin(2.0 * PI / float(period) * millis());
    dacValue = int(sinusValue * 127.0 + 127.0);
    dacWrite(25, dacValue);
    //vTaskDelay(10 / portTICK_PERIOD_MS);
  }
}
