function setFigureToSecondMonitor(figureHandle)
    % Funkce pro nastavení okna s grafy na druhý monitor
    % Okno je také maximalizováno na fullscreen
    
    MonitorPositions = get(0, "MonitorPositions");
    NoOfMonitors = size(MonitorPositions, 1);
    FigurePosition = MonitorPositions(1,:);

    if (NoOfMonitors > 1)
        FigurePosition(1) = FigurePosition(1) + MonitorPositions(2, 1);
    end
    
    figureHandle.set('Position', FigurePosition, 'units', 'normalized');
    figureHandle.WindowState = 'maximized';
end

