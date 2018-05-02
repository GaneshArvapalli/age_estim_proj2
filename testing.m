%% Ganesh Arvapalli

websave('\networks\imagenet-caffe-alex.mat',...
    'http://www.vlfeat.org/matconvnet/models/beta16/imagenet-caffe-alex.mat');

% Load MatConvNet network into a SeriesNetwork
convnet = helperImportMatConvNet(cnnFullMatFile);


% View the CNN architecture
convnet.Layers

function full_mask=segment_MRI(a)


end