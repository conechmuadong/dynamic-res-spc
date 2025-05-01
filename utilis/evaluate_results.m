function eval = evaluate_results(image, recovered_img, sz)
%     recovered_img = rescale_image(recovered_img, sz, round(512/sz));
    recovered_img = upsize_img(recovered_img, sz, size(image, 1));
    eval = ssim(rescale(image),rescale(recovered_img));
end

