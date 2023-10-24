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

    vTaskDelay(1000 / portTICK_PERIOD_MS); /* Delay von 1000ms */

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

    vTaskDelay(1000 / portTICK_PERIOD_MS); /* Delay von 1000ms */

    myWifiSettings.ESP_IP = WiFi.localIP();
    myWifiSettings.ESP_IP_String = WiFi.localIP().toString();
    Serial.println(myWifiSettings.ESP_IP);

    if (myWifiSettings.Udp.begin(myWifiSettings.ESP_IP, myWifiSettings.ESP_Port) == 1)
    {
    }
    else
    {
      myWifiSettings.ESP_Port = 00000;
    }

    myDisplay.clear();
    myDisplay.drawString(64, 10, "Lokale IP-Adresse:\n" + myWifiSettings.ESP_IP_String + "\nUDP-Port:\n" + myWifiSettings.ESP_Port);
    Serial.print("Lokale IP-Adresse: " + String(myWifiSettings.ESP_IP));
    Serial.print("UDP-Port: " + myWifiSettings.ESP_Port);
    myDisplay.display();

    vTaskDelay(3000 / portTICK_PERIOD_MS); /* Delay von 1000ms */

    myDisplay.clear();
  }
  else
  {
    myDisplay.clear();
    myDisplay.drawString(64, 32, "No connection :(\n WiFi Err-" + String(WiFi.status()));
    myDisplay.display();

    vTaskDelay(1000 / portTICK_PERIOD_MS); /* Delay von 1000ms */

    myDisplay.clear();
  }
}

bool connectToMatLab(SSD1306Wire &myDisplay)
{
  uint8_t buffer[2];
  myWifiSettings.Udp.parsePacket();
  if (myWifiSettings.Udp.available())
  {
    myWifiSettings.Udp.readBytes(buffer, 2);

    uint16_t receivedValue;
    uint8_t *pointer = (uint8_t *)&receivedValue;
    for (uint8_t i = 0; i < sizeof(buffer); i++)
    {
      pointer[i] = buffer[i];
    }
    myDisplay.clear();
    myDisplay.drawString(64, 32, String(receivedValue));
    myDisplay.display();

    delay(1000);
    myWifiSettings.REMOTE_IP = myWifiSettings.Udp.remoteIP();
    myWifiSettings.REMOTE_PORT = myWifiSettings.Udp.remotePort();

    myDisplay.clear();
    myDisplay.drawString(64, 10, "Remote IP-Adresse:\n" + myWifiSettings.REMOTE_IP.toString() + "\nUDP-Port:\n" + myWifiSettings.REMOTE_PORT);
    Serial.print("Lokale IP-Adresse: " + String(myWifiSettings.ESP_IP));
    Serial.print("UDP-Port: " + myWifiSettings.ESP_Port);
    myDisplay.display();

    myWifiSettings.Udp.beginPacket(myWifiSettings.REMOTE_IP, myWifiSettings.REMOTE_PORT);
    uint16_t writeVal = 12345;
    uint8_t *writePointer = (uint8_t *)&writeVal;
    for (uint8_t i = 0; i < sizeof(writeVal); i++)
    {
      myWifiSettings.Udp.write(writePointer[i]);
    }
    return myWifiSettings.Udp.endPacket();
  }
  else
  {
    return false;
  }
}