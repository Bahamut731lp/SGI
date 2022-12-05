clear all;
close all;
T = 1;
Fs = 1000;

% Vytvoření signálu x o složkách 100, 200, 300 a 400 Hz
fs = [100, 200, 300, 400];
t = 0:1/Fs:T-1/Fs;

% generování x
x = 0;

for i = 1:numel(fs)
    x = x + cos(2*pi*fs(i)*t);
end

N = 1000;
F = 0:Fs/N:Fs-Fs/N;

X = fft(x,N);

subplot(2, 1 ,1)
stem(F,abs(X)/(N));
title('Spektrum signálu x');
xlabel('f [Hz]');
ylabel('|A|');

% Koeficienty nulovacího filtru pro frekvenci 300 Hz
B = [1 -2*cos(2*pi*300/Fs) 1];
A = [1];

y = filter(B,A,x);
Y = fft(y,N);
subplot(2, 1 ,2)
stem(F,abs(Y)/(N));
title('Spektrum signálu y');
xlabel('f [Hz]');
ylabel('|A|');


figure;
zplane(B,A);
figure;
freqz(B,A);





