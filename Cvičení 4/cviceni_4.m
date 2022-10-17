clc; clear; close all;

paths = dir("data/*.wav");

fig = figure;
fig.WindowState = 'maximized';

t = tiledlayout(numel(paths), 3);
disp(t)

for i= 1:numel(paths)
    analyze(strjoin([paths(i).folder, "\", paths(i).name], ""));
end

function analyze(path)
    data = audioread(path);
    metadata = audioinfo(path);
    sampleCount = 100;
    
    dataTime = (0:metadata.TotalSamples - 1) / metadata.SampleRate;
    time = (0:sampleCount:metadata.TotalSamples - 1) / metadata.SampleRate;
    
    energy = getSignalEnergy(data, metadata.TotalSamples, sampleCount);
    diff = getCausalDifference(energy);
    
    
    % Vykreslení grafů
      
    nexttile;
    plot(dataTime, data);
    xlim([0 metadata.Duration]);
    title(path, "Interpreter","none");
    
    nexttile;
    plot(time, energy);
    xlim([0 metadata.Duration]);
    title("Energie");
    
    nexttile;
    plot(time, diff);
    xlim([0 metadata.Duration]);
    title("Zpětná diference");
end
