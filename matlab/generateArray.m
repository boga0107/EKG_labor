% Skript um Messdaten als C-Array zu extrahieren


data = transpose(load("uC_data.mat").dataOut(:,2));


fid = fopen('ekg_sim_data.txt', 'wt');
fprintf(fid, 'uint16_t EKGSim16[] = {\n');
for i=151:4301
    fprintf(fid, string(data(i)));
    if i ~= 4301
        fprintf(fid, ', ');
    end
    if mod(i, 25) == 0
        fprintf(fid, '\n');
    end
end
fprintf(fid, '\n};');
fclose(fid);