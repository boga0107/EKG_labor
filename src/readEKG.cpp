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

/* measure method
 * read the current value and add it to the buffer
 */
void readEKG::measure()
{
    analogBuffer[mWriteIndex] = analogRead(PIN);

    mWriteIndex++;
    mWriteIndex %= BUFFERSIZE;
}

/* getter for the value at the current read index */
void readEKG::getValue(uint16_t &pValue)
{
    pValue = analogBuffer[mReadIndex];
    mReadIndex++;
    mReadIndex %= BUFFERSIZE;
}

/* readIndex getter*/
uint16_t readEKG::getReadIndex()
{
    return mReadIndex;
}

/* writeIndex getter*/
uint16_t readEKG::getWriteIndex()
{
    return mWriteIndex;
}

/* prepare data of the first half of the buffer for transmit */
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

/* prepare data of the second half of the buffer for transmit */
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
