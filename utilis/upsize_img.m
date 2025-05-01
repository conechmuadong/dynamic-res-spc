function img = upsize_img(image, sz, new_sz)
%UPSIZE_IMG Summary of this function goes here
%   Detailed explanation goes here
    img = zeros(new_sz, new_sz);
    block_size = round(new_sz/sz);
    for j=1:sz
        for k=1:sz
            img((j-1)*block_size+1:j*block_size,(k-1)*block_size+1:k*block_size) = image(j,k);
        end
    end
end

