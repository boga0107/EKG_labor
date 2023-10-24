#ifndef READEKG_H
#define READEKG_H

#include <Arduino.h>
#include "defines.h"

#define PIN 33

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
    void writeValue();
    void getValue(uint16_t &pValue);
    uint16_t getReadIndex();
    uint16_t getWriteIndex();
};

#endif