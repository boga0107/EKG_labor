close all
clear
clc


T_A = 4e-3;
f_A = 1/T_A;
ESPipAdresse = "192.168.2.124";
ESPudpPort = 123;
BUFFERSIZE = 7500;
data_sum = 0;
t = linspace(0,30,BUFFERSIZE);
UnFilteredPort = 2020;
FilteredPort = 0202;

testVar = 777;

% Initialisierung
uBroadcaster = udpport("datagram")
uBroadcaster.EnableBroadcast = true;

uReceiver1 = udpport("byte", "LocalPort",UnFilteredPort, "EnablePortSharing",true)
uReceiver2 = udpport("byte", "LocalPort",FilteredPort, "EnablePortSharing",true)


write(uBroadcaster, testVar, "uint16", ESPipAdresse, ESPudpPort);
pause(5)
data = 0;
dataFiltered = 0;
n=1;
m =1;

unfiltered = false;
filtered = false;

while true
     uReceiver1Count = uReceiver1.NumBytesAvailable;
     uReceiver2Count = uReceiver2.NumBytesAvailable;
     if  uReceiver1Count > 1 && unfiltered == false
        data(n,:) = read(uReceiver1, 1, "uint16");
        %data_sum = data_sum + data(n);
        n = n+1
        if n == BUFFERSIZE + 1
            unfiltered = true;
        end
     end
     if uReceiver2Count > 1 && filtered == false
         dataFiltered(m,:) = read(uReceiver2, 1, "uint16");
         %data_sum = data_sum + data(m);
         m = m+1
         if m == BUFFERSIZE + 1
             filtered = true;
         end
     end
     if filtered && unfiltered
         break
     end
end



F_data = abs(fft(data));
F_data = F_data/length(F_data);

F_dataFiltered = abs(fft(dataFiltered));
F_dataFiltered = F_dataFiltered/length(F_dataFiltered);

%Frequenzachse
x_f = linspace(0, f_A, length(F_data)+1);
x_f = x_f(1:end-1);


subplot(2,1,1)
plot(t, data)
hold
plot(t, dataFiltered)
grid
xlim([0 5])
xlabel("t[s]")
title("Signal")
legend("Eingangssignal", "Ausgangssignal")


subplot(2,1,2)
plot(x_f, F_data)
hold
plot(x_f, F_dataFiltered)
ylim([0 100])
xlabel("t[s]")
title("Signal")
legend("Eingangsspektrum", "Ausgangsspektrum")

figure
subplot(3,1,1)
plot(t, data)
grid

subplot(3,1,2)
plot(t, dataFiltered)
grid

subplot(3,1,3)
plot(t, data - dataFiltered)
grid

dataOut = [data dataFiltered data-dataFiltered];

save("uC_data.mat", "dataOut")

%run("heart_rate.mlx")