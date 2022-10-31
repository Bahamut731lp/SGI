function [num] = getSampleResultFromPath(path)
    % Funkce pro získání čísla, který je v názvu vzorku

    charArray = convertStringsToChars(path);
    num = str2double(charArray(end-14));
end

