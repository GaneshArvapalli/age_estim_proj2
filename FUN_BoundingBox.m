% MATLAB function for creating bounding box based on mask images
% Version 2.0: 
%   * Some bug fixes. 
%   * When input image does not have a segmentation, the output will be
%   [0 0 0 0 0 0].
% Input:  mask image (1 for segmented region, 0 elsewhere)
% Output: 
% 	* cen_row, cen_col, cen_slic: geometeric center of the box
% 	* h: height, w: width, t: thickness
% Note: Since you have 6 segmented structures per subject, you have to 
%	run FUN_BoundingBox(); six times. At each time, your input image should 
% 	only contain 1 segmented structure. 
function [cen_row,cen_col,cen_slic,h,w,t] = FUN_BoundingBox(maskImg)
[Nrow,Ncol,Nslic] = size(maskImg); % [#rows,#columns,#slices]
idx = find(maskImg(:) ~= 0);       % IDs of voxels with nonzero value
if ~isempty(idx)
    [IDrow,IDcol,IDslic] = ind2sub([Nrow,Ncol,Nslic],idx);

    row_up = min(max(IDrow),Nrow);
    row_low = max(min(IDrow),1);

    col_up = min(max(IDcol),Ncol);
    col_low = max(min(IDcol),1);

    slic_up = min(max(IDslic),Nslic);
    slic_low = max(min(IDslic),1);

    h = row_up - row_low;   % height: # rows
    w = col_up - col_low;   % width: # columns
    t = slic_up - slic_low; % thickness: # slices

    cen_row = (row_up + row_low) / 2;
    cen_col = (col_up + col_low) / 2;
    cen_slic = (slic_up + slic_low) / 2;
else
    cen_col = 0;
    cen_row = 0;
    cen_slic = 0;
    h = 0;
    w = 0;
    t = 0;
end
end
