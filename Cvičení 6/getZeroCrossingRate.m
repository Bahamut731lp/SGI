function [zcr] = getZeroCrossingRate(data, resolution, overlap)
    TotalSamples = numel(data);
    
    starts = 1:resolution-overlap:numel(data);
    starts = starts(1:end - 1);

    ranges = arrayfun(@(start) start:min([TotalSamples (start + resolution - 1)]), starts, UniformOutput=false);
    
    signs = cellfun( ...
        @(cell) sum( ...
                arrayfun( ...
                    @(index) abs( sign(data(cell(index))) - sign(data(cell(index - 1))) ) ...
                , 2:numel(cell)) ...
        ) / 2*(resolution-1), ...
        ranges);
    
    zcr = signs;
end

