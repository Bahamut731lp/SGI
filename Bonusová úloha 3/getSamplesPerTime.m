function [sampleCount] = getSamplesPerTime(path)
    % Funkce pro výpočet počtu vzorků na 10ms
    % Čas 10 milisekund
    timeInMs = 10;
    metadata = audioinfo(path);

    sampleCount = (timeInMs *  metadata.TotalSamples)/ (metadata.Duration * 1000);
end