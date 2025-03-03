function [recovered_img, t] = recover_image(M, y, sz)
%RECOVER_IMAGE Summary of this function goes here
%   Detailed explanation goes here
    clear opts
    opts.mu = 2^12;
    opts.beta = 2^6;
    opts.mu0 = 2^4;       % trigger continuation shceme
    opts.beta0 = 2^-2;    % trigger continuation shceme
    opts.maxcnt = 10;
    opts.tol_inn = 1e-3;
    opts.tol = 1E-6;
    opts.maxit = 1000;
    t = cputime();
    [recovered_img, out] = TVAL3(M, y, sz, sz, opts);
    t = t - cputime();
end

