function mask = random_masks(size, p)
%RANDOM_MASKS Generates random (0 - 1) mask with Bernoulli distributions.
%   This function generates a mask in the form of a matrix that contains 0
%   and 1 elements. They represent the state of the equivalent pixels on the
%   DMD (0 = off, 1 = on)
%   @params:
%       size: int - size of the generated mask
%       p: double - the probability p in the Bernoulli distribution using
%       to generate the mask.
    mask = binornd(1,p*ones(size));
end

