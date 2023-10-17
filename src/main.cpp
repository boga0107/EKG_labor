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
#include "wifiConfig.h"

#define EKG_SAMPLING_TIME 100

/* Variablen - Timer */
hw_timer_s *timer = NULL;
uint32_t counterms = 0;

/* Variablen - Display*/
uint8_t posX = 0;
SSD1306Wire myDisplay(0x3c, SDA, SCL);

/* Sonstige Variablen */
bool flagRead = false; // Scheduling - Timer-Interrupt
float sinusValue = 0;
uint8_t freque = 1; // Frequenz vom Sinus, aktuell 1Hz
uint8_t dacValue = 0;
uint16_t adcValue = 0;

/* Klassen */
TaskHandle_t TaskWriteSinus; // Task
// readEKG myEKG;

/* Funktionen */
void setup();
void loop();
void timerInit();
void IRAM_ATTR onTimer();

void setup()
{

  timerInit();

  Serial.begin(115200);
  analogReadResolution(12);
  myDisplay.init();
  myDisplay.flipScreenVertically();

  wifiInit(myDisplay);
}

/* Hauptprogramm - Loop */
void loop()
{
  /* Alle 20ms wird ein Pixel erstellt. */
  if (flagRead)
  {
    // myEKG.getValue(adcValue);
    // adcValue = map(adcValue, 0, 4095, 55, 10);
    // myDisplay.setPixel(posX, adcValue);
    // myDisplay.display();
    // posX++;
    // flagRead = false;
  }
  /* Nach 2,5sek wird der Display zurück gesetzt */
  // if (posX == 128)
  // {
  //   posX = 0;
  //   myDisplay.clear();
  // }
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
  if (counterms % EKG_SAMPLING_TIME == 0)
  {
    // myEKG.measure();
  }
}
