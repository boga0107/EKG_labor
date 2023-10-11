#include "readEKG.h"

readEKG::readEKG(): mBufferIndex(0)
{
    for (uint8_t i = 0; i < BUFFERSIZE; i++)
    {
        analogBuffer[i] = 0;
    }
    analogReadResolution(12);
    
}