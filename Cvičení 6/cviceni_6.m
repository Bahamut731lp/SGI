clear all;
close all;
clc;

data = audioread("ovcaci-housle.wav");
metadata = audioinfo("ovcaci-housle.wav");

sampleCount = 256;
overlap = 128;
overlapCoefficient = sampleCount / overlap;

zcr = getZeroCrossingRate(data, sampleCount, overlap);

figure;
tiledlayout(3, 1);

nexttile;

dataTime = (0:metadata.TotalSamples - 1) / metadata.SampleRate;
plot(dataTime, data);

nexttile;
time = (0:overlap:metadata.TotalSamples - 1);
time = time(1:end - 1);
time = time / metadata.SampleRate;

plot(time, zcr);

nexttile;
spectrogram(data, hamming(sampleCount), overlap, sampleCount, metadata.SampleRate, 'yaxis');