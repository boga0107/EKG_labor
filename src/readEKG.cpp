#include <Arduino.h>
#include "readEKG.h"

readEKG::readEKG(uint32_t &counter) : mWriteIndex(0), mReadIndex(0), mFilterIndex(0), mem0(0.0), mem1(0.0), mem2(0.0), peakDetected(false), lastTiming(0), counter4ms(counter)
{
    for (uint8_t i = 0; i < 2; i++)
    {
        heartTiming[i] = 0;
    }
    /*for (uint8_t i = 0; i < BUFFERSIZE; i++)
    {
        analogBuffer[i] = 0;
    }*/
    analogReadResolution(12);
    pinMode(EN_EKG, OUTPUT);
    digitalWrite(EN_EKG, HIGH);
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

void readEKG::filter()
{
    double y = 0.0;

    mem0 = analogBuffer[mFilterIndex] - D1 * mem1 - D2 * mem2;
    y = gain * (N0 * mem0 + N1 * mem1 + N2 * mem2);

    mem2 = mem1;
    mem1 = mem0;

    if (y < 0)
    {
        y = 0.0;
    }
    filteredBuffer[mFilterIndex] = uint16_t(y);

    if (filteredBuffer[mFilterIndex] < 800)
    {
        switch (mFilterIndex)
        {
        case 0:
            if (filteredBuffer[mFilterIndex] < filteredBuffer[BUFFERSIZE])
            {
                calculateHeartRate();
                Serial.println("Boarder");
                peakDetected = true;
            }
            else
            {
                peakDetected = false;
            }
            break;

        default:
            if (filteredBuffer[mFilterIndex] < filteredBuffer[mFilterIndex - 1])
            {
                calculateHeartRate();
                peakDetected = true;
            }
            else
            {
                peakDetected = false;
            }
            break;
        }
    }

    mFilterIndex++;
    mFilterIndex %= BUFFERSIZE;
}

void readEKG::calculateHeartRate()
{
    if (!peakDetected)
    {
        if ((counter4ms - heartTiming[0]) > 50)
        {
            heartTiming[1] = counter4ms;
            heartRate = (heartTiming[1] - heartTiming[0]) * EKG_SAMPLING_TIME_MS;
            //lastTiming = counter4ms;
            heartTiming[0] = heartTiming[1];
            Serial.printf("HR: %d\n", heartRate);
        }
    }
}

/* getter for the value at the current read index */
void readEKG::getValue(uint16_t &pValue)
{
    pValue = filteredBuffer[mReadIndex];
    mReadIndex++;
    mReadIndex %= BUFFERSIZE;
}

/* readIndex getter*/
uint16_t readEKG::getReadIndex()
{
    return mReadIndex;
}

uint16_t readEKG::getFilterIndex()
{
    return mFilterIndex;
}

/* writeIndex getter*/
uint16_t readEKG::getWriteIndex()
{
    return mWriteIndex;
}

uint16_t readEKG::getHeartRate()
{
    return heartRate;
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

void readEKG::transmitFirstFiltered()
{
    openTransmitFiltered();
    uint8_t *writePointer = (uint8_t *)filteredBuffer;
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
    for (uint16_t i = BUFFERSIZE / 2 * 2; i < BUFFERSIZE * 2; i++)
    {
        sendData(writePointer[i]);
    }
    closeTransmit();
}

void readEKG::transmitSecondFiltered()
{
    openTransmitFiltered();
    uint8_t *writePointer = (uint8_t *)filteredBuffer;
    for (uint16_t i = BUFFERSIZE / 2 * 2; i < BUFFERSIZE * 2; i++)
    {
        sendData(writePointer[i]);
    }
    closeTransmit();
}
