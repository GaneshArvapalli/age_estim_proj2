%% Ganesh Arvapalli
clc;
clearvars;

classNames = ['Left Caudate', 'Right Caudate', 'Left Putamen', 'Right Putamen',...
    'Left Thalamus', 'Right Thalamus'];
cmap = jet(numel(classNames));
N = numel(classNames);
ticks = 1/(N*2):1/N:1;
colorbar('TickLabels',cellstr(classNames),'Ticks',ticks,'TickLength',0,'TickLabelInterpreter','none');
colormap(cmap)

imds = imageDatastore('training_images.mat','FileExtensions','.mat','ReadFcn',@matReader);

%%
function full_mask=segment_MRI(a)


end

% 
% % nii = load_nii('Project2_TrainingData/NIFTI_20130306/1000_MNI_label_convert.nii', [], 1);
% filename = fullfile('Project2_TrainingData', 'manual_label', '1000_MNI_label_convert.nii');
% Img = load_nii(filename);
% filename = fullfile('Project2_TrainingData','scans','1000_ANAT_N4_MNI_BRAIN_HISTMATCH.nii.gz');
% original = load_nii(filename);
% slicenum = 130;
% temp = double(Img.img(:,:,slicenum));
% imshow(double(Img.img(:,:,slicenum)));
% % ding = labeloverlay(uint8(Img.img(:,:,slicenum)),uint8(original.img(:,:,slicenum)));
% % imshowpair(ding, double(original.img(:,:,slicenum)), 'montage');