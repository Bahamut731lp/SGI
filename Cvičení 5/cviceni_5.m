clc; clear; close all;

f = 2;
Fs = 1000;
N = 1000;

t = -1:1/Fs:1;

figure;
tiledlayout(2, 2, TileIndexing="rowmajor");

ctverecSlozky = 1:2:N;
pilaSlozky = 1:1:N;

ctverec = arrayfun(@(index) 1/index * cos(2*pi*t*f*index - pi/2), ctverecSlozky, UniformOutput=false);
ctverec = sum(cell2mat(ctverec'));

pila = arrayfun(@(index) 1/index * cos(2*pi*t*f*index - pi/2), pilaSlozky, UniformOutput=false); 
pila = sum(cell2mat(pila'));

nexttile;
plot(t, ctverec);

nexttile
[x, y] = getMagnitudeGraph(ctverec, N, Fs);
stem(x, y, '.');

nexttile;
plot(t, pila);

nexttile;
[x, y] = getMagnitudeGraph(pila, N, Fs);
stem(x, y, '.');


nexttile