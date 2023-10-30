#include <Arduino.h>
#include "readEKG.h"

readEKG::readEKG() : mWriteIndex(0), mReadIndex(0)
{
    /*for (uint8_t i = 0; i < BUFFERSIZE; i++)
    {
        analogBuffer[i] = 0;
    }*/
    analogReadResolution(12);
}

void readEKG::measure()
{
    analogBuffer[mWriteIndex] = analogRead(PIN);

    mWriteIndex++;
    mWriteIndex %= BUFFERSIZE;
}

void readEKG::writeValue()
{
}

void readEKG::getValue(uint16_t &pValue)
{
    pValue = analogBuffer[mReadIndex];
    mReadIndex++;
    mReadIndex %= BUFFERSIZE;
}

uint16_t readEKG::getReadIndex()
{
    return mReadIndex;
}

uint16_t readEKG::getWriteIndex()
{
    return mWriteIndex;
}

void readEKG::transmitFirst()
{
    openTransmit();
    uint8_t *writePointer = (uint8_t *)analogBuffer;
    for (uint16_t i = 0; i < BUFFERSIZE / 2 * 2; i++)
    {
        sendData(writePointer[i]);
    }
    closeTransmit();
}

void readEKG::transmitSecond()
{
    openTransmit();
    uint8_t *writePointer = (uint8_t *)analogBuffer;
    for (uint16_t i = BUFFERSIZE / 2 * 2 ; i < BUFFERSIZE * 2; i++)
    {
        sendData(writePointer[i]);
    }
    closeTransmit();
}
