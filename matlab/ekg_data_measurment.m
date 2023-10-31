close all
clear


T_A = 4e-3;
f_A = 1/T_A;
ESPipAdresse = "192.168.188.146";
ESPudpPort = 123;
BUFFERSIZE = 7500;
data_sum = 0;
t = linspace(0,30,BUFFERSIZE);


testVar = 777;

% Initialisierung
uBroadcaster = udpport("datagram")
uBroadcaster.EnableBroadcast = true;

uReceiver = udpport("byte", "LocalPort",2020, "EnablePortSharing",true)

write(uBroadcaster, testVar, "uint16", ESPipAdresse, ESPudpPort);
pause(5)
data = 0;
n=1;
Mem = 0;

 while n <= 7500
     uReceiverCount = uReceiver.NumBytesAvailable;
     if  uReceiverCount > 1 
        data(n,:) = read(uReceiver, 1, "uint16");
        data_sum = data_sum + data(n);
    
        n = n+1;  
     end
 end



F_data = abs(fft(data));
F_data = F_data/length(F_data);

%Frequenzachse
x_f = linspace(0, f_A, length(F_data)+1);
x_f = x_f(1:end-1);



plot(t, data)


figure

plot(x_f, F_data)





