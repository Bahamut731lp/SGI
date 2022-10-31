clc; clear; close all;

%% Konstanty a nastavení

% Nastavení rozložení okna s grafy
tiledlayout(5, 3,'TileSpacing','tight','Padding','tight', "TileIndexing","columnmajor");

%% Tělo programu

% Přečtení souboru FilesList a získání cest k audio souborům
paths = getFileList("reference.txt");

for i= 1:numel(paths)
    analyzeAudioFile(paths(i));
end

%% Analyzující funkce
function analyzeAudioFile(path)
    nexttile;

    % Přečtení dat a počtu vzorků na 10 ms
    data = audioread(path)';
    metadata = audioinfo(path);
    sampleRate = metadata.SampleRate;
    [sampleCount] = getSamplesPerTime(path);
    
    %TODO: Udělat kauzální derivaci signálu
    %Možná mi to něco napoví, popř. zkusit další parametry
    %causalDiff = [0 arrayfun(@(index) energy(index) - energy(index - 1), 2:numel(energy))]


    % Výpočet energie
    energy = getSignalEnergy(data, metadata.TotalSamples, sampleCount);
    time = (0:sampleCount:metadata.TotalSamples - 1) / sampleRate;

    % Vykreslení grafů
    hold on;
    grid on;

    plot(time, energy, "DisplayName","Energie");

    title(path);
    xlabel("Čas [s]");
    ylabel("Energie");
    legend;

    hold off;
end