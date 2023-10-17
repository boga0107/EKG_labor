/*
Projekt: EKG-Labor
Aufagenstellung:
Ziel des Labors ist der Entwurf einer Signalverarbeitungskette in einem Mikrocontroller anhand eines EKG-Rekorders.
Hierzu sollen EKG-Daten aufgenommen und über WLAN an einen PC übertragen werden. Die Verarbeitung der Daten findet teilweise
im Controller und teilweise auf dem PC in MATLAB statt.

Autoren: Gabriel Boehm & Walter Orlov
Erstellt am 09.10.2023
*/

/* Bibliotheken */
#include <Arduino.h>
#include <math.h>
#include "Wire.h"
#include "SSD1306Wire.h"
#include "readEKG.h"
#include "display.h"
#include "defines.h"
#include "wifiConfig.h"

#define FREQUENCY 1 // Frequenz vom Sinus, aktuell 1Hz

/* Variablen - Timer */
hw_timer_s *timer = NULL;
uint32_t counterms = 0;

/* Variablen - Display*/
SSD1306Wire myDisplay(0x3c, SDA, SCL);

/* Sonstige Variablen */
bool flagDisplay = false; // Scheduling - Timer-Interrupt
float sinusValue = 0;

uint8_t dacValue = 0;
uint16_t adcValue = 0;

/* Klassen */
TaskHandle_t TaskWriteSinus; // Task
readEKG myEKG;
display myDisp(myDisplay, myEKG);

/* Funktionen */
void setup();
void loop();
void timerInit();
void IRAM_ATTR onTimer();
void writeSinus(void *parameter);

void setup()
{

  timerInit();

  Serial.begin(115200);
  myDisplay.init();
  myDisplay.flipScreenVertically();

  wifiInit(myDisplay);
  xTaskCreate(writeSinus, "Write Sinus", 1000, NULL, 1, &TaskWriteSinus);
}

/* Hauptprogramm - Loop */
void loop()
{
  if (flagDisplay)
  {
    myDisp.draw();
    flagDisplay = false;
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
  if (counterms % EKG_SAMPLING_TIME_MS == 0)
  {
    myEKG.measure();
  }

  /* delay by 5ms to prevent two tasks at the same time */
  if (counterms % DISPLAY_PERIOD_MS == 5)
  {
    flagDisplay = true;
  }
}

void writeSinus(void *parameter)
{
  TickType_t xLastWakeTime;
  const TickType_t xFrequency = 10 / portTICK_PERIOD_MS;
  for (;;)
  {

    xTaskDelayUntil(&xLastWakeTime, xFrequency);
    /* Sinus, 1Hz */
    sinusValue = sin(2.0 * PI * FREQUENCY * millis() / 1000.0);
    dacValue = int(sinusValue * 127.0 + 127.0);
    dacWrite(25, dacValue);
  }
}
