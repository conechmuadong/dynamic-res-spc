function [out, recovered_img] = simulator(image, start_size, desired_size)
%SIMULATOR Summary of this function goes here
%   Detailed explanation goes here
    img = imread(image);
    img = rgb2gray(img);
    sz = start_size;
    no_of_meas = 1;
    masks = zeros(1, sz*sz);
    img_resized = resize_img(img, sz);
    measurements = zeros(1, 1);
    while sz <= desired_size
        mask = random_masks(sz, 0.6);
        if no_of_meas == 1
            masks(no_of_meas, :) = transpose(mask(:));
            measurements(no_of_meas) = transpose(mask(:))*img_resized(:);
        else
            masks = [masks; transpose(mask(:))];
            measurements = [measurements; transpose(mask(:))*img_resized(:)];
        end

        if (no_of_meas > round(sz*sz*0.2))&&(rem(no_of_meas, round(sz*sz*0.05))==0)
            [recovered_img, t] = recover_image(masks, measurements, sz);
        end
        
        if no_of_meas > round(sz*sz*0.7)
            masks = resize_mask(masks, sz, sz*2);
            sz = sz*2;
            imshow(rescale(recovered_img));
            img_resized = resize_img(img, sz);
        end
        no_of_meas = no_of_meas + 1;
    end
end

