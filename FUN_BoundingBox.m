% MATLAB function for creating bounding box based on mask images
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
[IDrow,IDcol,IDslic] = ind2sub([Nrow,Ncol,Nslic],idx);

row_up = min(max(IDrow),Nrow);
row_low = max(min(IDrow),1);

col_up = min(max(IDcol),Ncol);
col_low = max(min(IDcol),1);

slic_up = min(max(IDslic,Nslic));
slic_low = max(min(IDslic),1);

h = row_up - row_low;   % height: # rows
w = col_up - col_low;   % width: # columns
t = slic_up - slic_low; % thickness: # slices

cen_col = (row_up + row_low) / 2;
cen_row = (col_up + col_low) / 2;
cen_slic = (slic_up + slic_low) / 2;
end
