#ifndef WIFICONFIG_H
#define WIFICONFIG_H

#include "Wire.h"
#include "SSD1306Wire.h"
#include "Wifi.h"
#include "WiFiUdp.h"
#include "ESPAsyncWebServer.h"

void wifiInit(SSD1306Wire &myDisplay);

struct wifiSettings
{
    const char *wifiSSID = "FRITZ!Box 7590 VL";
    const char *wifiPAS = "56616967766283031728";
    /* const char *wifiSSID = "Vodafone-A1BC";
    const char *wifiPAS = "FNRaMbEtnTZGsn9C"; */
    String wifiCon = "Connecting to WiFi";
    IPAddress localIP;
    WiFiUDP Udp;
    int remotePort = 0;
} myWifiSettings;

#endif