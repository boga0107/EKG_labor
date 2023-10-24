ESPipAdresse = "192.168.188.146";
ESPudpPort = 123;

testVar = 777;

% Initialisierung
uBroadcaster = udpport("datagram")
uBroadcaster.EnableBroadcast = true;
while(true)
write(uBroadcaster, testVar, "uint16", ESPipAdresse, ESPudpPort);
end