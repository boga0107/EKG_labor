% Skript um Messdaten als C-Array zu extrahieren
clear
close all
clc

data = load("gabriel_ekg.mat").data;


fid = fopen('ekg_sim_data.txt', 'wt');
fprintf(fid, 'uint16_t EKGSim16[] = {\n');
dataExport = 0;
for i=79:6739
    dataExport(:,i-78) = data(i);
    fprintf(fid, string(data(i)));
    if i ~= 6739
        fprintf(fid, ', ');
    end
    if mod(i, 25) == 0
        fprintf(fid, '\n');
    end
end
dataExport = [dataExport dataExport];
plot(dataExport)
fprintf(fid, '\n};');
fclose(fid);