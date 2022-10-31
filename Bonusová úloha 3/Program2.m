clc; clear; close all;

%% Konstanty a nastavení

% Nastavení rozložení okna s grafy
tiledlayout(10, 3,'TileSpacing','tight','Padding','tight', "TileIndexing","columnmajor");

%% Tělo programu

% Přečtení souboru FilesList a získání cest k audio souborům
paths = getFileList("FilesList.txt");
setFigureToSecondMonitor(gcf);

verdikty = zeros(1, numel(paths));

for i= 1:numel(paths)
    verdikty(i) = analyzeAudioFile(paths(i));
end

spravneVerdikty = sum(arrayfun(@(x) x == 1, verdikty));
procenta = spravneVerdikty / numel(paths) * 100;

fprintf("========================================\n");
fprintf("Celková úspěšnost: %3.0f%%\n", procenta);
fprintf("========================================\n");


%% Analyzující funkce
function [verdict] = analyzeAudioFile(path)
    nexttile;

    % Přečtení dat
    data = audioread(path)';
    metadata = audioinfo(path);
    sampleRate = metadata.SampleRate;
    
    % Výpočty důležitých hodnot nahrávky
    sampleCount = getSamplesPerTime(path); % Získání počtu vzorků na 10 ms;
    label = getSampleResultFromPath(path); % Přečtení správného výsledku pro porovnání s rozpoznáváním
    energy = getSignalEnergy(data, metadata.TotalSamples, sampleCount); % Výpočet energie

   
    time = (0:sampleCount:metadata.TotalSamples - 1) / sampleRate; % Vytvoření časové osy pro grafy
    
    practicallyZeros = abs(energy) < 2e-2;
    energy(practicallyZeros) = 0;

    % Výpočet kauzální derivace energie signálu
    causalDiff = getCausalDifference(energy);
    plot(time, causalDiff);

    % Vykreslení grafů
    hold on;
    grid on;
    
    plot(time, energy, "DisplayName","Energie");

    title(path, 'Interpreter','none');
    xlabel("Čas [s]");
    ylabel("Energie");
    %legend;

    hold off;
    
    % Log do konzole
    verdict = 0;

    %if (label == options(maxima_loc))
     %   verdict = 1;
    %end%
    
    % Print výsledků do konzole
    fprintf("%s:\t%d\t(%s)\n", path, 0, verdict);
end