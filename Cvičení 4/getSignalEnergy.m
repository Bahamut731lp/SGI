function [energy] = getSignalEnergy(data, totalSamples, resolution)
    %Funkce pro výpočet energie signálu

    % Vytvoření indexů vzorků, které jsou pro nás zajímavé
    % Rozložení se řídí hlavně jemností dělení (resolution) a celkovým
    % počtem vzorků (totalSamples)
    samplesOfInterest = 1:resolution:totalSamples;
    dataLength = numel(data);

    energy = arrayfun(@(index) sum(data(index:(min([dataLength index+resolution-1]))).^2 ), samplesOfInterest);
    %energy = normalize(energy, "norm");
end