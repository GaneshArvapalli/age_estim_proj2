%% Ganesh Arvapalli
% Consolidated method to help visualize nii image slice
function blank=show_nii(nii, slice)
    if ~exist('slice','var')
        slice = size(nii, 3)./2;
    end
    temp = nii*255/max(max(nii(:,:,uint8(slice))));
    imshow(uint8(temp));
end