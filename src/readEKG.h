#ifndef READEKG_H
#define READEKG_H

#include <Arduino.h>
#include "defines.h"

#define BUFFERSIZE 100
#define PIN 33


class readEKG
{
private:
    uint16_t analogBuffer[BUFFERSIZE];
    uint8_t mWriteIndex;
    uint8_t mReadIndex;
public:
    readEKG();
    void measure();
    void getValue(uint16_t &pValue);
    uint8_t getReadIndex();
    uint8_t getWriteIndex();

};

#endif