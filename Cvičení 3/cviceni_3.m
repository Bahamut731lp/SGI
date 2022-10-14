clc; clear; close all;

BPM = 174;

TPul = 120 / BPM;
Tctvrt = 60 / BPM;
TOsm = 30 / BPM;

pauza = 0 * 0:1/BPM:Tctvrt;

skakal_doggo = [
    generujTon(-2, Tctvrt) generujTon(-2, Tctvrt) generujTon(-5, Tctvrt) pauza...
    generujTon(-2, Tctvrt) generujTon(-2, Tctvrt) generujTon(-5, Tctvrt) pauza...
    generujTon(-2, Tctvrt) generujTon(-2, Tctvrt) generujTon(0, Tctvrt) generujTon(-2, Tctvrt)...
    generujTon(-2, TPul) generujTon(-4, TPul)...
    ...
    generujTon(-4, Tctvrt) generujTon(-4, Tctvrt) generujTon(-7, Tctvrt) pauza...
    generujTon(-4, Tctvrt) generujTon(-4, Tctvrt) generujTon(-7, Tctvrt) pauza...
    generujTon(-4, Tctvrt) generujTon(-4, Tctvrt) generujTon(-2, Tctvrt) generujTon(-4, Tctvrt)...
    generujTon(-4, TPul) generujTon(-5, TPul)
];

sound(skakal_doggo, 8000)
%dvanáctá odmocnina ze 2


function [ton] = generujTon(vyska, delka)
    A4 = 440;
    Fs = 8000;
    t = 0:1/Fs:delka-1/Fs;

    freq = A4 * nthroot(2, 12)^(vyska);
    ton = [ cos(2*pi*freq*t) 0 * 0:1/Fs:0.1 ];
end