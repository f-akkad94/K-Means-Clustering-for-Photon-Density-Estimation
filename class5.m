function x = class5(N)

    a = 5 * [randn(N,1) + 5, randn(N,1) + 5];
    b = 5 * [randn(N,1) + 5, randn(N,1) - 5];
    c = 5 * [randn(N,1) - 5, randn(N,1) + 5];
    d = 5 * [randn(N,1) - 5, randn(N,1) - 5];
    e = 5 * [randn(N,1), randn(N,1)];
    
    x = [a;b;c;d;e];
end