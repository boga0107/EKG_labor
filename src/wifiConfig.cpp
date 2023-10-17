#include <Arduino.h>
#include "WifiConfig.h"

void wifiInit(SSD1306Wire &myDisplay)
{
  myDisplay.setTextAlignment(TEXT_ALIGN_CENTER);

  uint8_t indexWait = 0;
  uint8_t indexDot = 0;

  /* WiFi-Mode:  */
  WiFi.mode(WIFI_STA);
  WiFi.begin(myWifiSettings.wifiSSID, myWifiSettings.wifiPAS);

  /* DoWhile-Schleife um 30sec versuchen die WiFi Verbindung aufzubauen */
  do
  {
    myDisplay.clear();

    if (indexDot == 4)
    {
      myWifiSettings.wifiCon = "Connecting to WiFi";
      indexDot = 0;
    }

    myDisplay.drawString(64, 32, myWifiSettings.wifiCon);
    myWifiSettings.wifiCon += ".";
    myDisplay.display();

    delay(1000);

    indexWait++;
    indexDot++;

    if (WiFi.status() == WL_CONNECTED)
    {
      break;
    }

  } while (indexWait < 30);

  indexWait = 0;

  if (WiFi.status() == WL_CONNECTED)
  {
    myDisplay.clear();
    myDisplay.drawString(64, 32, "WOW, you are connected!");
    myDisplay.display();

    delay(1000);

    myWifiSettings.ESP_IP = WiFi.localIP();
    myWifiSettings.ESP_Port = myWifiSettings.Udp.remotePort();

    myDisplay.clear();
    myDisplay.drawString(64, 10, "Lokale IP-Adresse:\n" + String(myWifiSettings.ESP_IP) + "\nUDP-Port:\n" + myWifiSettings.ESP_Port);
    Serial.print("Lokale IP-Adresse: " + String(myWifiSettings.ESP_IP));
    Serial.print("UDP-Port: " + myWifiSettings.ESP_Port);
    myDisplay.display();

    delay(3000);

    myDisplay.clear();
  }
  else
  {
    myDisplay.clear();
    myDisplay.drawString(64, 32, "No connection :(\n WiFi Err-" + String(WiFi.status()));
    myDisplay.display();

    delay(3000);

    myDisplay.clear();
  }
}