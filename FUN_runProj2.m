% runProj2 version 1.0
% 03-31-2018
function [maskImg,boundBox,age] = FUN_runProj2(scanImg,trained_model)
% Inputs:  scanImg       - 3D MR image of testing subject 
%          trained_model - pretrained model for testing  %(E)
%                          If you don't need a trained model, you can
%                          remove this input.
% 
% Outputs: maskImg  - 3D mask image of 6 segmented structures with value
%                     1: left caudate,  2: right caudate; 
%                     3: left putamen,  4: right putamen;
%                     5: left thalamus, 6: right thalamus.
%
%          boundBox - bounding boxes of 6 segmented stuctures.
%                     6 * 6 matrix, stacked as
%                     row1: left caudate  [1*6 vector]
%                     row2: right caudate [1*6 vector]
%                     row3: left putamen  [1*6 vector]
%                     row4: right putamen [1*6 vector]
%                     row5: left thalamus [1*6 vector]
%                     row6: right thalamus[1*6 vector]
%
%          age      - predicted age of testing subject.


% MAKE UP SOME STUPID RESULTS TO MAKE THE CODE RUNNABLE. YOU SHOULD REPLACE
% THIS WITH YOUR BELOVED SEGMENTATION ALGORITHM :)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maskImg = trained_model; %(E)
% boundBox = zeros(6,6);   %(E)
% for i = 1:6              %(E)
%     labelImg = maskImg == i; %(E)
%     [cen_row,cen_col,cen_slic,h,w,t] = FUN_BoundingBox(labelImg); %(E)
%     boundBox(i,:) = [cen_row,cen_col,cen_slic,h,w,t];             %(E)
% end                      %(E)
% age = floor(100 * rand); %(E)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('linear_predictor.mat');

maskImg = segment_MRI(scanImg);
maskImg = uint8(imresize3(maskImg, 2));

% save('maskImg.mat','maskImg');

boundBox = zeros(6, 6);
for label=1:6
    [r,c,s,h,w,t] = FUN_BoundingBox(maskImg==label);
    if isempty(r)
        r = 0;
        c = 0;
        s = 0;
        h = 0;
        w = 0;
        t = 0;
    end
    boundBox(label, :) = [r,c,s,h,w,t];
end
input = reshape(boundBox, 1,36);
input_pca = principal_comp(input, 20);
age = predict(trained_model, input_pca);
disp(num2str(age));
end