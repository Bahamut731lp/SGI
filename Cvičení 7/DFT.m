function X = DFT(x, N)
   
    X = arrayfun( ...
        @(k) 1/N * sum(getCoeffs(x, k, N)), ...
    1:N);

    function [ops] = getCoeffs(x, k, N)
        ops = arrayfun(@(index) x(index + 1) * getExponential(k, index, N), 0:(N-1));
    end

    function e = getExponential(k, n, N)
        e = exp(-1i*2*pi*k*n*1/N);
    end
end

