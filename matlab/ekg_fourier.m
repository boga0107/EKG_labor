clear
close all

T_A = 4e-3;
f_A = 1/T_A;
T_MAX = 30;
BUFFERSIZE = T_MAX/T_A;

data = transpose(load("gabriel_ekg.mat").data);
t = linspace(0, T_MAX, T_MAX/T_A);

F_data = abs(fft(data));

x_f = linspace(0, f_A, BUFFERSIZE);

subplot(2,1,1)
plot(t, data)
subplot(2,1,2)
plot(x_f, F_data)


element_f_A = 50/BUFFERSIZE