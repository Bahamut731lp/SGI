function [causalDiff] = getCausalDifference(data)
    causalDiff = [data(1) arrayfun(@(index) data(index) - data(index - 1), 2:numel(data))];
end

