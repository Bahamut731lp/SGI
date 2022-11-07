clear all;
close all;
clc;

Fs = 10;
t = (0:1/Fs:2);

prvni = cos(2*pi*4*t);
druhy = cos(2*pi*2.5*t);
treti = cos(2*pi*12*t);
ctvrty = cos(2*pi*7.25*t);

tiledlayout(4,2,TileIndexing="columnmajor");

signals = {prvni, druhy, treti, ctvrty};
generateGraphs(signals, 20);
generateGraphs(signals, 30);

function generateGraphs(signals, N)
    for i=1:numel(signals)
         nexttile;
         stem(1:N, abs(DFT(signals{i}, N)), 'o');
         xlabel("f [Hz]");
         ylabel("|A|");
         
         if (i == 1)
            title(join(["N = ", num2str(N)]));
         end
    end
end