#ifndef WIFICONFIG_H
#define WIFICONFIG_H

#include "Wire.h"
#include "SSD1306Wire.h"
#include "Wifi.h"
#include "WiFiUdp.h"
#include "ESPAsyncWebServer.h"

void wifiInit(SSD1306Wire &myDisplay);
bool connectToMatLab(SSD1306Wire &myDisplay);
void openTransmit();
void openTransmitFiltered();
void closeTransmit();
void sendData(uint8_t &pData);

typedef struct
{
#define GABRIEL_HOME
#ifdef LABOR
    const char *wifiSSID = "FRITZ!Box 7590 VL";
    const char *wifiPAS = "56616967766283031728";
#endif
#ifdef WALTER_HOME
    const char *wifiSSID = "Vodafone-A1BC";
    const char *wifiPAS = "FNRaMbEtnTZGsn9C";
#endif
#ifdef GABRIEL_PHONE
    const char *wifiSSID = "Pixel7";
    const char *wifiPAS = "11223GB0107";
#endif
#ifdef GABRIEL_HOME
    const char *wifiSSID = "WLAN-7EZLYG";
    const char *wifiPAS = "0169360086146884";
#endif
    String wifiCon = "Connecting to WiFi";
    IPAddress ESP_IP;
    String ESP_IP_String;
    WiFiUDP Udp;
    int ESP_Port = 123;
    IPAddress REMOTE_IP;
    uint16_t REMOTE_PORT = 2020;
    uint16_t REMOTE_PORT_FILTERED = 202;
} wifiSettings;

static wifiSettings myWifiSettings;

#endif