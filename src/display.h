#ifndef DISPLAY_H
#define DISPLAY_H

#include <Arduino.h>
#include "Wire.h"
#include "SSD1306Wire.h"
#include "readEKG.h"
#include "defines.h"

#define MAX_X_VALUE 128
#define MAX_Y_VALUE 64



class display
{
public:
    display(SSD1306Wire &pDisplay, readEKG &pEKG);
    void draw();

private:
    SSD1306Wire &mDisplay;
    readEKG &mEKG;
    uint16_t mValue;
    uint8_t mXpos;
    float mXposFloat;
    uint8_t mYpos[2];
    uint16_t localWriteIndex;
};



#endif