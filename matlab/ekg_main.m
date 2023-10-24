ESPipAdresse = "192.168.177.89";
ESPudpPort = 123;

testVar = 777;

% Initialisierung
uBroadcaster = udpport("datagram")
uBroadcaster.EnableBroadcast = true;
uReceiver = udpport("byte", "LocalPort",2020, "EnablePortSharing",true)

write(uBroadcaster, testVar, "uint16", ESPipAdresse, ESPudpPort);

while true
    uReceiverCount = uReceiver.NumBytesAvailable;
    if  uReceiverCount> 0
        data = read(uReceiver, uReceiverCount, "uint16")
    end
end


