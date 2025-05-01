function [out, recovered_img, evaluate] = simulator(image, start_size, desired_size, noise_level)
%SIMULATOR Function to simulate the single pixel camera scheme
%   This function loads image, takes measurement and start the
%   reconstruction process
%   @param
%       image: str - Path to the original image (or phantom)
%       start_size: int - Initial resolution
%       desired_size: int - Desired resolution of the system
%       noise_level: int - The SNR level for noisy simulation
%
%   @return
%       out: double - Time (s) needed to perform the reconstruction
%       recovered_img: matrix - Numeric representation of reconstructed
%       image
%       evalute: array - The SSIM value recorded in the process

    fullscreen = get(0,'ScreenSize');
    figure('Name','TVAL3','Position',...
    [fullscreen(1) fullscreen(2) fullscreen(3) fullscreen(4)]);
    results = java.util.LinkedList;
    if image == "phantom"
        img = phantom(512);
        filename = image;
    else
        img = imread(image);
        img = rgb2gray(img);
        filename = split(image, ["/","."]);
        filename = filename(2);
    end
    subplot(121); imshow(img,[]);
    title('Original','fontsize',18); drawnow;
    sz = start_size;
    no_of_meas = 1;
    masks = zeros(1, sz*sz);
    img_resized = resize_img(img, sz);
    measurements = zeros(1, 1);
    rcv_at = 0;
    img_eva = resize_img(img, 256);
    k = 1;
    evaluate = 0;
    while sz <= desired_size
        mask = random_masks(sz, 0.3);
        if no_of_meas == 1
            masks(no_of_meas, :) = transpose(mask(:));
            measurements(no_of_meas) = transpose(mask(:))*img_resized(:);
        else
            masks = [masks; transpose(mask(:))];
            measurements = [measurements; transpose(mask(:))*img_resized(:)];
        end

        if (no_of_meas > round(sz*sz*0.1))&&(rem(no_of_meas, round(sz*sz*0.05))==0)
            [recovered_img, t] = recover_image(masks, awgn(measurements, noise_level, 'measured'), sz);
            results.add(recovered_img);
%             display(m);
            rcv_at = [rcv_at; no_of_meas];
            subplot(122); 
            imshow(rescale(recovered_img),[]);
            title('Recovered by TVAL3','fontsize',18); drawnow;
        end
        
        if no_of_meas > round(sz*sz*0.7)
            masks = resize_mask(masks, sz, sz*2);
%             imshow(rescale(recovered_img));
            imwrite(rescale(recovered_img),"result/phantom/"+filename+string(sz)+"x"+string(sz)+".png")
            sz = sz*2;
            img_resized = resize_img(img, sz);
            for i = k:results.size()
                rcv_img = results.get(i-1);
                evaluate = [evaluate; evaluate_results(img, rcv_img, size(rcv_img,1))];
            end
            k = results.size()+1;
        end
        no_of_meas = no_of_meas + 1;
    end
    out = t;
end

