#include "display.h"

display::display(SSD1306Wire &pDisplay, readEKG &pEKG) : 
mDisplay(pDisplay), mEKG(pEKG), mValue(0)
{

}

void display::draw()
{
    mEKG.getValue(mValue);
    mYpos = map(mValue, 0, 4095, 64, 0);
    if(mXpos == 0){
        mDisplay.setPixel(mXpos, mValue);
    } else {
        mDisplay.drawLine(mXpos - 1, mYposOld, mXpos, mYpos);
    }
    mYposOld = mYpos;
    if(mXpos >= MAX_X_VALUE){
        mXpos = 0;
        mDisplay.clear();
    }
    mDisplay.display();
}
