close all
clear

ESPipAdresse = "192.168.177.89";
ESPudpPort = 123;
BUFFERSIZE = 7500;

testVar = 777;

% Initialisierung
uBroadcaster = udpport("datagram")
uBroadcaster.EnableBroadcast = true;

uReceiver = udpport("byte", "LocalPort",2020, "EnablePortSharing",true)

write(uBroadcaster, testVar, "uint16", ESPipAdresse, ESPudpPort);
data = 0;
n=1;
figure
hold on
while true
    uReceiverCount = uReceiver.NumBytesAvailable;
    if  uReceiverCount > 1 
         data(n,:) = read(uReceiver, 1, "uint16");
         n = n+1;
         plot(data)
    end
    
 
    %pause(0.05)
end


