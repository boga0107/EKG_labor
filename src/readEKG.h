#ifndef READEKG_H
#define READEKG_H

#include <Arduino.h>
#include "defines.h"
#include "wifiConfig.h"

#define PIN 33

/* class to manage the EKG measuring and the 
 * data processing and  distribution
 * */
class readEKG
{
private:
    uint16_t readValue;
    uint16_t analogBuffer[BUFFERSIZE];
    uint16_t mWriteIndex;
    uint16_t mReadIndex;

public:
    readEKG();
    void measure();
    void getValue(uint16_t &pValue);
    uint16_t getReadIndex();
    uint16_t getWriteIndex();
    void transmitFirst();
    void transmitSecond();
};

#endif