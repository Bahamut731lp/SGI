function x = getConvolution(f,g)   
    m = numel(f);
    n = numel(g);
    w = zeros(1, (m + n - 1));
    
    for k = 1:numel(w)
        acc = 0;

        for j = max(1,k+1-n):1:min(k,m)
            acc = acc + (f(j) * g(k - j + 1));
        end

        w(k) = acc;
    end
    
    x = w;
end

