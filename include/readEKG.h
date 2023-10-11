#include <Arduino.h>

#define BUFFERSIZE 100
#define PIN 25


class readEKG
{
private:
    uint16_t analogBuffer[BUFFERSIZE];
    uint8_t mBufferIndex;
public:
    readEKG();
    void measure();

};