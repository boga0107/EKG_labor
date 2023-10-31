#include "display.h"

display::display(SSD1306Wire &pDisplay, readEKG &pEKG) : mDisplay(pDisplay), mEKG(pEKG), mValue(0), mXpos(0), mXposFloat(0.0)
{
}

/* Function to draw the most recent measured values */
void display::draw()
{
    /* drawing the graph, while readIndex didn't catch up to writeIndex */
    localWriteIndex = mEKG.getWriteIndex();

    while (mEKG.getReadIndex() != localWriteIndex)
    {
        mEKG.getValue(mValue);                  /* returns last not read value */
        mYpos[1] = map(mValue, 0, 4095, 4, 58); /* value gets remapped to the size of the display */

        /* draw the graph an connect last two values with a line */
        if (mXpos == 0)
        {
            /* don't draw a line if the current position is on the left boarder */
            mDisplay.setPixel(mXpos, mYpos[1]);
        }
        else
        {
            mDisplay.drawLine(mXpos - 1, mYpos[0], mXpos, mYpos[1]);
        }
        mYpos[0] = mYpos[1]; /* current value is the past value for the next iteration */
        mXposFloat = mXposFloat + float(MAX_X_VALUE) * float(EKG_SAMPLING_TIME_MS) / float(GRAPH_TIME_MS);
        mXpos = int(mXposFloat);
    }
    mDisplay.display(); /* display last drawings */
    
    /* reached right edge of the display */
    if (mXpos >= MAX_X_VALUE)
    {
        mXpos = 0;
        mXposFloat = 0.0;
        mDisplay.clear();
    }
}
