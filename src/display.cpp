#include "display.h"

display::display(SSD1306Wire &pDisplay, readEKG &pEKG) : mDisplay(pDisplay), mEKG(pEKG), mValue(0), mXpos(0)
{
}

void display::draw()
{
    /* drawing the graph, while readIndex didn't catch up to writeIndex */
    while (mEKG.getReadIndex() != mEKG.getWriteIndex())
    {

        mEKG.getValue(mValue);  /* returns last not read value */
        mYpos[1] = map(mValue, 0, 4095, 64, 0); /* value gets remapped to the size of the display */

        /* draw the graph an connect last two values with a line */
        if (mXpos == 0)
        {
            mDisplay.setPixel(mXpos, mYpos[1]);
        }
        else
        {
            mDisplay.drawLine(mXpos - 1, mYpos[0], mXpos, mYpos[1]);
        }

        mYpos[0] = mYpos[1]; /* current value is the past value for the next iteration */
        mXpos++;
    }
    
    mDisplay.display(); /* display last drawings */

    /* reached right edge of the display */
    if(mXpos >= 128)
    {
        mXpos = 0;
        mDisplay.clear();
    }
}
