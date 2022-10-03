clear;
clc;
close all;

[t1, sig1] = evaluateSignal(20, 2, 2, 4, pi/3, 0);
[t2, sig2] = evaluateSignal(20, 2, 4, 2, pi/4, 0);

subplot(2, 2 , 1);
draw(t1, sig1, "STEM SIG 1");

subplot(2, 2, 2);
draw(t2, sig2, "STEM SIG 1");

subplot(2, 2, [3 4]);
draw(t1, sig1 + sig2, "STEM SIG 1");


function [t, x] = evaluateSignal(Samplerate, Time, Amplitude, Frequency, Phase, M) 
    Period = 1/Samplerate;
    
    t = 0:Period:(Time-Period);
    x = Amplitude * cos(2 * pi * Frequency * t + Phase) + M;
end

function draw(x, y, label)
    stem(x, y);
    title(label);
    xlabel("t [s]");
    ylabel("cos(t)");
end