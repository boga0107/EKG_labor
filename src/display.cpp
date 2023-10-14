#include "display.h"

display::display(SSD1306Wire &pDisplay, readEKG &pEKG) : mDisplay(pDisplay), mEKG(pEKG), mValue(0), mXpos(0)
{
}

void display::draw()
{
    /* drawing the graph, while readIndex didn't catch up to writeIndex */
    while (mEKG.getReadIndex() != mEKG.getWriteIndex())
    {

        mEKG.getValue(mValue);  /*  */
        mYpos[1] = map(mValue, 0, 4095, 64, 0);

        if (mXpos == 0)
        {
            mDisplay.setPixel(mXpos, mYpos[1]);
        }
        else
        {
            mDisplay.drawLine(mXpos - 1, mYpos[0], mXpos, mYpos[1]);
        }

        mYpos[0] = mYpos[1];
        mXpos++;
    }
    
    mDisplay.display();

    if(mXpos >= 128)
    {
        mXpos = 0;
        mDisplay.clear();
    }
}
