#include "readEKG.h"

readEKG::readEKG() : mWriteIndex(0), mReadIndex(0)
{
    for (uint8_t i = 0; i < BUFFERSIZE; i++)
    {
        analogBuffer[i] = 0;
    }
    analogReadResolution(12);
}

void readEKG::measure()
{
    analogBuffer[mWriteIndex] = analogRead(PIN);
    mWriteIndex++;
    mWriteIndex %= BUFFERSIZE;
}

void readEKG::getValue(uint16_t &pValue)
{
    pValue = analogBuffer[mReadIndex];
    mReadIndex++;
    mReadIndex %= BUFFERSIZE;
}

