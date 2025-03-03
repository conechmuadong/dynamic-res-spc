function resized_masks = resize_mask(masks, sz, new_size)
%RESIZE_MASK Resizes the used masks from lower resolution to higher
%resolution for running recovering algorithm
%   Details about the resizing scheme, please read in our publications.
%   @params:
%       masks: list of matrixs - represents used masks in lower resolution
%       acquisitions.
%       size: int - current image size is being used for the single-pixel imaging
%       scheme.
%       new_size: int - new resolution to resize the masks to.
    block_size = round(new_size/sz);
    number_of_masks = size(masks, 1);
    resized_masks = zeros(number_of_masks,new_size*new_size);
    for i=1:number_of_masks
        mask = reshape(masks(i,:),sz,sz);
        new_mask = zeros(new_size, new_size);
        for j=1:sz
            for k=1:sz
                new_mask((j-1)*block_size+1:j*block_size,(k-1)*block_size+1:k*block_size) = mask(j,k);
            end
        end
        resized_masks(i,:) = reshape(new_mask,1,new_size*new_size);
    end
end

