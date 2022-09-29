%% Preambule
echo off;
clear;
clc;
close all;

%% Konstanty
segmentation = 100;

%% Tělo programu

analyzeAudioSample("data\c0_p0458_s03.wav", segmentation);
analyzeAudioSample("data\c2_p0044_s02.wav", segmentation);
analyzeAudioSample("data\c3_p0018_s03.wav", segmentation);
analyzeAudioSample("data\c4_p0063_s04.wav", segmentation);
analyzeAudioSample("data\c5_p0026_s02.wav", segmentation);
analyzeAudioSample("data\c6_p0076_s04.wav", segmentation);
analyzeAudioSample("data\c9_p0635_s04.wav", segmentation);

%% Funkce pro zjištění optimální meze oddělující šum od informace
% @param {Vector<number>} volumes - Vektor segmentů
% @returns [startIndex, endIndex] - Dvousložkový vektor s indexy segmentů, ve kterém začíná slovo a resp. končí
function [startIndex, endIndex] = getGateThresholds(volumes)
    % Počet segmentů
    segmentation = size(volumes);
    % První mez pro oddělení šumu a informace
    firstThreshold = rms(volumes);
    % Pokud je vzorek nad první mezí, označí se jedničkou

    findSequenceAboveThreshold = @(threshold) strfind(arrayfun(@(index) abs(volumes(index)) > threshold, (1:segmentation)), ones(1,4));
    
    % Následně se hledá sekvence čtyř jedniček
    % tj. čtyř hodnot, které zasebou jsou nad první mezí
    volumesAboveThresh = findSequenceAboveThreshold(firstThreshold);
    firstVolumeAboveThresh = volumesAboveThresh(1);

    % Oblast od začátku nahrávky až po první mez vymezíme oblast jako
    % "profil šumu"
    noise = volumes(1:firstVolumeAboveThresh);
    % Profil šumu zprůměrujeme
    noiseThreshold = mean(noise);
    % Najdeme další sekvenci růstu hlasitosti
    volumeAboveNoise = findSequenceAboveThreshold(noiseThreshold);

    firstAboveNoise = volumeAboveNoise(1) - 1;
    lastAboveNoise = volumeAboveNoise(end) + 4;

    startIndex = firstAboveNoise;
    endIndex = lastAboveNoise;
end
%% Funkce pro analýzu zvukových dat ze souboru
% @param {string} path - Cesta k souboru
% @param {integer} segmentation - Jemnost dělení vzorků
function analyzeAudioSample(path, segmentation)
    if (~isfile(path)) 
        error(append("The file ", path, " does not exist.")) 
    end
    
    % Přečtení vzorků a metadat
    samples = audioread(path);
    metadata = audioinfo(path);
    
    % Počet vzorků na segment podle jemnosti dělení
    noOfSegments = length(samples) / segmentation;
    % Předělání vektoru vzorků na vektoru segmentů
    segments = reshape(samples, [noOfSegments, segmentation]);
    % Nalezení nejvyšší amplitudy v každém segmentu
    volume = arrayfun(@(index) abs(max(segments(:, index))), (1:segmentation)');
    
    % Hranice slova
    [first, last] = getGateThresholds(volume);

    figure('Name', path);
    legend(Location='bestoutside')
    hold on;

    % Vykreslení signálu
    plot(samples, DisplayName="Původní signál")
    % Vykreslení segmentů
    plot(repelem(volume, noOfSegments), DisplayName="Segmenty signálu");
    % Vykreslení hranic
    xline(first .* noOfSegments, "LineStyle", "--", Color="g", LineWidth=2, DisplayName="Začátek slova");
    xline(last .* noOfSegments, "LineStyle", "--", Color="r", LineWidth=2, DisplayName="Konec slova");
    
    % Vypočtení času
    startTime = (first * noOfSegments) / metadata.SampleRate;
    endTime = (last * noOfSegments) / metadata.SampleRate;
    
    % Výpis do konzole
    fprintf('Zacatek: %-3.2f s \t\t Konec: %-3.2f s\n', startTime, endTime);

    hold off;
end