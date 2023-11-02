clear
close all

T_A = 4e-3;
f_A = 1/T_A;
T_MAX = 30;
BUFFERSIZE = T_MAX/T_A;
df = f_A / BUFFERSIZE;

t = linspace(0, T_MAX, BUFFERSIZE);

noise_freq = 50;
noise_amplitude = 250;
noise = noise_amplitude* sin(2 * pi * noise_freq * t);



data = transpose(load("gabriel_ekg.mat").data) + noise;

F_data = (fft(data));
F_dataFiltered = F_data;
F_data = abs(F_data);

x_f = linspace(0, f_A, BUFFERSIZE);


element_f1 = 49.5/df + 1;
element_f2 = 50.5/df + 1;
for element=element_f1:element_f2
    F_dataFiltered(element) = 0;
end

element_f1 = BUFFERSIZE - 50.5/df;
element_f2 = BUFFERSIZE - 49.5/df;
for element=element_f1:element_f2
    F_dataFiltered(element) = 0;
end

dataFiltered = ifft(F_dataFiltered);

%Numerator
N0 = 1.0;
N1 = -0.622946104851632709298314694024156779051;
N2 = 1;

% Denominator
D0 = 1.0;
D1 = -0.553076317436604014687873132061213254929;
D2 =   0.775679511049613079620712596806697547436 ;

% Gain
gain = 0.887839755524806539810356298403348773718   ;

MEM0 = 0.0;
MEM1 = 0.0;
MEM2 = 0.0;

dataNumFilter = 0;

for i=1:BUFFERSIZE
    y = 0.0;
    
    MEM0 = data(i) - D1*MEM1 - D2 * MEM2;
    y = gain * (N0 * MEM0 + N1 * MEM1 + N2 * MEM2);

    MEM2 = MEM1;
    MEM1 = MEM0;
    
    dataNumFilter(i,:) = y;
end

F_dataNumFilter = transpose(abs(fft(dataNumFilter)));

dataNumFilter = transpose(dataNumFilter);

%createfigureIIR(t, [data dataNumFilter], x_f, [F_data F_dataNumFilter])

subplot(2,1,1)
plot(t, data)
title("IIR-Filter")
grid
hold
%plot(t, dataFiltered)
plot(t, dataNumFilter)
xlim([0 2])
ylim([0 2750])
xlabel("t[s]")
ylabel("u")
subtitle("Signal")
legend("Eingangssignal", "Ausgangssignal", "Location","southeast")
subplot(2,1,2)
plot(x_f, F_data)
grid
hold
%xlim([0 60])
ylim([0 1e6])
%plot(x_f, abs(F_dataFiltered))
plot(x_f, F_dataNumFilter)
xlabel("f[Hz]")
ylabel("|FFT(u)|")
subtitle("Spektrum")
legend("Eingangsspektrum", "Ausgangsspektrum")


