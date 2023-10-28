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

/* globale Variablen */
TaskHandle_t TaskWriteSinus; // Task
TaskHandle_t TaskUDPTransmit;

/* Variablen - Timer */
hw_timer_s *timer = NULL;
uint32_t counter4ms = 0;

/* Variablen - Display*/
SSD1306Wire myDisplay(0x3c, SDA, SCL);
bool flagDisplay = false; // Scheduling des Displays
bool flagRead = false;
bool flagUDPSend = true; // Scheduling des Verschickens per UDP

/* Klassen */
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

  Serial.begin(115200);
  myDisplay.init();
  myDisplay.flipScreenVertically();
  wifiInit(myDisplay);

  while (!connectToMatLab(myDisplay))
  {
  }

  vTaskDelay(3000 / portTICK_PERIOD_MS);

  xTaskCreatePinnedToCore(
      writeSinus,
      "Write Sinus",
      1000,
      NULL,
      1,
      &TaskWriteSinus,
      xPortGetCoreID());


  pinMode(TEST_OUT, OUTPUT);
  myDisplay.clear();
  timerInit();
}

/* Hauptprogramm - Loop */
void loop()
{
  if (flagDisplay)
  {
    myDisp.draw();
    flagDisplay = false;
  }

  if (myEKG.getWriteIndex() >= BUFFERSIZE / 2 && flagUDPSend)
  {
    Serial.printf("Send first!\t- %d\n", counter4ms * 4);
    myEKG.transmitFirst();
    flagUDPSend = false;
  }

  /* UDP send second half of buffer */
  if (myEKG.getWriteIndex() < BUFFERSIZE / 2 && !flagUDPSend)
  {
    Serial.printf("Send second!\t- %d\n", counter4ms * 4);
    myEKG.transmitSecond();
    flagUDPSend = true;
  }
}

void timerInit()
{
  timer = timerBegin(0, 80, true);
  timerAttachInterrupt(timer, onTimer, true);
  timerAlarmWrite(timer, 4000, true);
  timerAlarmEnable(timer);
}

void IRAM_ATTR onTimer()
{
  myEKG.measure();
  counter4ms++;

  /* delay by 2ms to prevent two tasks at the same time */
  if (counter4ms % DISPLAY_PERIOD_MS == 2)
  {
    flagDisplay = true;
  }
}

void writeSinus(void *parameter)
{
  TickType_t xLastWakeTime;
  const TickType_t xFrequency = 20 / portTICK_PERIOD_MS;

  float sinusValue = 0;
  uint8_t dacValue = 0;

  for (;;)
  {

    xTaskDelayUntil(&xLastWakeTime, xFrequency);
    /* Sinus, 1Hz */
    // sinusValue = sin(2.0 * PI * FREQUENCY * millis() / 1000.0);
    // dacValue = int(sinusValue * 127.0 + 127.0);
    dacWrite(25, dacValue);
    dacValue++;
    // dacValue %= 256;
  }
}

