function [xAxis, yAxis] = getMagnitudeGraph(x, N, Fs)
    F = 0:Fs/N:Fs/2-Fs/N;
    X = fft(x,N);

    xAxis = F(1:40);
    yAxis = 1/(N/2)*abs(X(1:40));
end

