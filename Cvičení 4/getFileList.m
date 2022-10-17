function [files] = getFileList(path)
    % Funkce pro čtení seznamu souborů
    fileID = fopen(path);
    data = textscan(fileID,'%s');
    fclose(fileID);

    files = string(data{:});
end