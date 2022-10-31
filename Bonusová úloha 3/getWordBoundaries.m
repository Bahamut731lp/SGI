function [lowerBound, upperBound] = getWordBoundaries(energy)
    thresh = mean(energy);
    gatedEnergy = find(energy > thresh);

    lowerBound = gatedEnergy(1);
    upperBound = gatedEnergy(end);
end

