#ifndef DISPLAY_H
#define DISPLAY_H

#include <Arduino.h>
#include "Wire.h"
#include "SSD1306Wire.h"
#include "readEKG.h"


#define MAX_X_VALUE 128
#define MAX_Y_VALUE 64
#define GRAPH_TIME 2000  // Dauer der 


class display
{
public:
    display(SSD1306Wire &pDisplay, readEKG &pEKG);
    void draw();

private:
    SSD1306Wire &mDisplay;
    readEKG &mEKG;
    uint16_t mValue;
    uint16_t mYpos;
    uint16_t mYposOld;
    uint8_t mXpos;
};

#endif