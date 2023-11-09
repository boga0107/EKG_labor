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
#define SIMULATION

/* globale Variablen */
TaskHandle_t TaskWriteSinus; // Task
TaskHandle_t TaskUDPTransmit;

/* Variablen - Timer */
hw_timer_s *timer = NULL;
uint32_t counter4ms = 0;

/* Variablen - Display*/
SSD1306Wire myDisplay(0x3c, SDA, SCL);
bool flagDisplay = false; // Scheduling des Displays
bool flagFilter = false;  // Scheduling des FIlters
#ifdef SIMULATION
bool flagSim = false;
#endif
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

#ifdef SIMULATION
#include "simData.h"
uint16_t simIndex;
const uint16_t SIM_MAX_VALUE = sizeof(EKGSim16) / sizeof(EKGSim16[0]);

uint8_t EKGSim[SIM_MAX_VALUE];
#endif

void setup()
{

  Serial.begin(115200);
  myDisplay.init();
  myDisplay.flipScreenVertically();
  wifiInit(myDisplay);

  while (!connectToMatLab(myDisplay))
  {
  }

  vTaskDelay(3000 / portTICK_PERIOD_MS); /* pause to display informations */

#ifdef SIMULATION
  for (uint16_t i = 0; i < SIM_MAX_VALUE; i++)
  {
    EKGSim[i] = map(EKGSim16[i], 0, 4095, 0, 256);
  }
#endif

  pinMode(TEST_OUT, OUTPUT);
  myDisplay.clear();
  timerInit();
}

/* Hauptprogramm - Loop */
void loop()
{
  /* filter analog value */
  if (flagFilter)
  {
    myEKG.filter();

    flagFilter = false;
  }
#ifdef SIMULATION
  if (flagSim)
  {
    dacWrite(25, EKGSim[simIndex]);
    simIndex++;
    simIndex %= SIM_MAX_VALUE;
    flagSim = false;
  }
#endif

  /* refresh display */
  if (flagDisplay)
  {
    myDisp.draw();
    flagDisplay = false;
  }

  /* Transmit Data */
  /* UDP send first half of buffer */
  if (myEKG.getFilterIndex() >= BUFFERSIZE / 2 && flagUDPSend)
  {
    Serial.printf("Send first!\t- %d\n", counter4ms * 4);
    myEKG.transmitFirst();
    myEKG.transmitFirstFiltered();
    flagUDPSend = false;
  }

  /* UDP send second half of buffer */
  if (myEKG.getFilterIndex() < BUFFERSIZE / 2 && !flagUDPSend)
  {
    Serial.printf("Send second!\t- %d\n", counter4ms * 4);
    myEKG.transmitSecond();
    myEKG.transmitSecondFiltered();
    flagUDPSend = true;
  }
}

/*** Funktionsimplementierungen ***/
/* timer Konfiguration */
void timerInit()
{
  timer = timerBegin(0, 80, true);
  timerAttachInterrupt(timer, onTimer, true);
  timerAlarmWrite(timer, 4000, true);
  timerAlarmEnable(timer);
}

/* Timer Interrupt */
/* Aufruf im 4ms-Takt */
void IRAM_ATTR onTimer()
{
  myEKG.measure();
  counter4ms++;
  flagFilter = true;
#ifdef SIMULATION
  flagSim = true;
#endif

  /* delay by 2ms to prevent two tasks at the same time */
  if (counter4ms % DISPLAY_PERIOD_MS == 2)
  {
    flagDisplay = true;
  }
}
