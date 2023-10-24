#ifndef WIFICONFIG_H
#define WIFICONFIG_H

#include "Wire.h"
#include "SSD1306Wire.h"
#include "Wifi.h"
#include "WiFiUdp.h"
#include "ESPAsyncWebServer.h"

void wifiInit(SSD1306Wire &myDisplay);
bool connectToMatLab(SSD1306Wire &myDisplay);

typedef struct
{
    const char *wifiSSID = "FRITZ!Box 7590 VL";
    const char *wifiPAS = "56616967766283031728";
    /* const char *wifiSSID = "Vodafone-A1BC";
    const char *wifiPAS = "FNRaMbEtnTZGsn9C"; */
    /*const char *wifiSSID = "Pixel7";
    const char *wifiPAS = "11223GB0107";*/
    String wifiCon = "Connecting to WiFi";
    IPAddress ESP_IP;
    String ESP_IP_String;
    WiFiUDP Udp;
    int ESP_Port = 123;
} wifiSettings;

static wifiSettings myWifiSettings;



#endif