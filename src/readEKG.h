#ifndef READEKG_H
#define READEKG_H

#include <Arduino.h>
#include "defines.h"
#include "wifiConfig.h"

#define PIN 33

/* Filter Numerator */
const double N0 = 1.0;
const double N1 = -0.622946104851632709298314694024156779051;
const double N2 = 1.0;

/* FIlter Denominator */
const double D0 = 1.0;
const double D1 = -0.553076317436604014687873132061213254929;
const double D2 = 0.775679511049613079620712596806697547436;

/* Filter gain */
const double gain = 0.887839755524806539810356298403348773718;

/* class to manage the EKG measuring and the
 * data processing and  distribution
 * */
class readEKG
{
private:
    uint16_t readValue;
    uint16_t analogBuffer[BUFFERSIZE];
    uint16_t filteredBuffer[BUFFERSIZE];
    uint16_t mWriteIndex;
    uint16_t mFilterIndex;
    uint16_t mReadIndex;

    double mem0;
    double mem1;
    double mem2;

    void calculateHeartRate();
    bool peakDetected;
    uint16_t heartTiming[2];
    uint16_t heartRate;
    uint32_t lastTiming;
    uint32_t &counter4ms;

public:
    readEKG(uint32_t &counter);
    void measure();
    void filter();
    void getValue(uint16_t &pValue);
    uint16_t getReadIndex();
    uint16_t getFilterIndex();
    uint16_t getWriteIndex();
    uint16_t getHeartRate();
    void transmitFirst();
    void transmitFirstFiltered();
    void transmitSecond();
    void transmitSecondFiltered();
};

#endif