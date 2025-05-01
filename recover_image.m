function [recovered_img, t] = recover_image(M, y, sz)
%RECOVER_IMAGE Perform TVAL3 to reconstruct the image
%   This function set up TVAL3 configuration and perform the algorithm to
%   reconstruct the image.
%   
%   @param:
%       M: matrix - The measurement matrix.
%       y: matrix - The measurement results
%       sz: int - Image will be reconstructed at resolution sz x sz
% 
%   @return:
%       recovered_img: matrix - The numeric representation of the
%       reconstructed image
%       t: double - Time (s) needed to perform the algoritm
    clear opts
    opts.mu = 2^13;
    opts.beta = 2^9;
    opts.mu0 = 2^4;      % trigger continuation shceme
    opts.beta0 = 2^-1;    % trigger continuation scheme
    opts.tol_inn = 1e-4;
    opts.tol = 1e-5;
    opts.maxit = 10000;
    opts.TVnorm = 1;
    opts.nonneg = true;
    t = cputime();
    [recovered_img, out] = TVAL3(M, y, sz, sz, opts);
    t = t - cputime();
end

