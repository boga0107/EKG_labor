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
uint16_t EKGSim16[] = {
    1910, 1841, 1871, 1936, 1943, 1861, 1819, 1840, 1907, 1936, 1883, 1823, 1837, 1891, 1904, 1855, 1813, 1839, 1899, 1927, 1869, 1808, 1847, 1927, 1937, 1871, 1800, 1844, 1922, 1937, 1891, 1831, 1856, 1931, 1941, 1882, 1809, 1823, 1889, 1904, 1869, 1810, 1833, 1901, 1911, 1829, 1760, 1791, 1856, 1872, 1789, 1725, 1766, 1839, 1886, 1879, 1840, 1856, 1930, 1958, 1917, 1903, 1911, 1936, 1936, 1889, 1872, 1894, 1932, 1954, 1939, 1983, 2135, 2277, 2270, 2128, 1808, 1399, 861, 368, 12, 0, 149, 876, 1460, 1984, 2352, 2501, 2473, 2448, 2397, 2255, 2195, 2233, 2254, 2218, 2149, 2142, 2151, 2151, 2115, 2075, 2059, 2063, 2064, 2031, 1985, 1972, 1992, 2013, 1990, 1939, 1910, 1943, 1979, 1954, 1887, 1883, 1931, 1945, 1904, 1856, 1865, 1886, 1893, 1882, 1831, 1814, 1858, 1891, 1855, 1789, 1791, 1853, 1860, 1823, 1776, 1761, 1838, 1872, 1825, 1769, 1813, 1890, 1935, 1904, 1866, 1883, 1963, 1985, 1952, 1891, 1903, 1955, 1966, 1924, 1884, 1903, 1962, 1967, 1917, 1859, 1879, 1924, 1947, 1905, 1859, 1879, 1919, 1936, 1894, 1838, 1861, 1927, 1947, 1904, 1845, 1862, 1915, 1931, 1885, 1840, 1853, 1906, 1920, 1882, 1845, 1858, 1915, 1926, 1879, 1831, 1869, 1927, 1923, 1869, 1818, 1851, 1905, 1921, 1874, 1818, 1851, 1919, 1941, 1877, 1812, 1839, 1904, 1918, 1872, 1813, 1846, 1904, 1909, 1847, 1798, 1808, 1869, 1882, 1792, 1727, 1767, 1842, 1885, 1837, 1789, 1842, 1934, 1957, 1887, 1843, 1875, 1943, 1947, 1905, 1853, 1866, 1925, 1958, 1927, 1905, 2006, 2215, 2304, 2192, 1999, 1747, 1357, 823, 300, 0, 0, 433, 1139, 1603, 2018, 2389, 2589, 2515, 2427, 2320, 2210, 2217, 2261, 2177, 2118, 2139, 2182, 2162, 2096, 2025, 2019, 2074, 2102, 2020, 1966, 1970, 2015, 2017, 1966, 1877, 1894, 1975, 1985, 1920, 1862, 1873, 1927, 1933, 1862, 1808, 1838, 1901, 1924, 1847, 1803, 1798, 1861, 1875, 1827, 1771, 1771, 1834, 1870, 1806, 1749, 1763, 1831, 1849, 1798, 1761, 1792, 1873, 1907, 1873, 1839, 1871, 1967, 1993, 1935, 1905, 1927, 1978, 1975, 1946, 1903, 1915, 1974, 1968, 1913, 1871, 1895, 1951, 1936, 1910, 1847, 1867, 1926, 1963, 1911, 1846, 1861, 1922, 1959, 1903, 1814, 1872, 1950, 1941, 1886, 1839, 1850, 1909, 1931, 1885, 1856, 1867, 1917, 1916, 1886, 1832, 1854, 1935, 1957, 1904, 1843, 1863, 1929, 1953, 1885, 1837, 1869, 1939, 1953};

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
