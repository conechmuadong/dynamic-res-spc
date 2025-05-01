function img = resize_img(image, sz)
%RESIZE_IMG Summary of this function goes here
%   Detailed explanation goes here
%     image = image/255;
    img = zeros(sz, sz);
    block_size = round(size(image,1)/sz);
    for i = 1:sz
        for j = 1:sz
            img(i,j) = sum(image((i-1)*block_size+1:i*block_size,(j-1)*block_size+1:j*block_size),"all");   
        end
    end
end

