%% Ganesh Arvapalli
% Basic method to segment MRI image using region growing

function full_mask=segment_MRI(inputImage)
    % First find average locations of existing brain labels/parts
    if ~exist('training_labeled_imgs')
        load('labeled_images_training.mat');
    end
    if ~exist('train_imgs')
        load('training_images.mat');
    end
    avLabel = uint8(zeros(size(training_labeled_imgs{1})));
    for i=1:length(training_labeled_imgs)
        avLabel = avLabel + uint8(training_labeled_imgs{i});
    end
    avLabel = avLabel/length(training_labeled_imgs);
    % disp(size(av));
    % labeled_image = training_labeled_imgs{1};
    % labeled_image = avLabel;
    
        
    avImage = single(zeros(size(train_imgs{1})));
    for i=1:length(train_imgs)
        avImage = avImage + single(train_imgs{i});
    end
    avImage = avImage/length(train_imgs);
    
    
    labeled_image = uint8(avLabel);
    labeled_image = uint8(imresize3(labeled_image, 0.5));
    seeds = zeros(6,3);
    for label=1:6
        BW = labeled_image == label;
        CC = bwconncomp(BW);
        S = regionprops(CC, 'Centroid');
%         stats = regionprops(labeled_image == label);
%         seeds(label,:) = stats.Centroid;
        seeds(label, :) = S.Centroid;
    end
    seeds = uint8(seeds);
    disp('Found seeds');
    % Register every slice of current MRI scan to training image
    
    % TRY DONWSAMPLING A
    a = double(imresize3(inputImage, 0.5));
    % registerTo = double(imresize3(train_imgs{1}, 0.5));
    registerTo = double(imresize3(avImage, 0.5));
    [optimizer, metric] = imregconfig('multimodal');
    movingReg = imregister(a,registerTo,'affine',optimizer,metric);
    
    % determine proper format, one image at a time?
    % mriVolumeOriginal = squeeze(a.D);
    % sizeO = size(mriVolumeOriginal);

    % mriVolumeResized = imresize3(mriVolumeOriginal, 0.5);
    % sizeR = size(mriVolumeResized);

    
    % AFFINE REGISTRATION SEEMS INCORRECT
    
    disp('Completed registration');
    % [~,movingReg] = imregdemons(a,training_image);
    
    % TRY COMPARING CONTRAST BETWEEN REGION AROUND PIXEL AND CURRENT PIXEL
    % CHECK WHETHER PIXEL IS HIGHER THAN BACKGROUND (Use image gradient?)
    
    
    %tform = imregcorr(a, training_image);
    %Rfixed = imref3d(size(training_image));
    %movingReg = imwarp(a,tform,'OutputView',Rfixed);
        %for slice=1:size(training_image,3)
        %    a(:,:,slice) = 
        %end
    % Conduct region growing using the previously found centroids
    full_mask = zeros(size(movingReg));
    disp('Starting labeling');
    for l=1:6
        full_mask = full_mask + region_grow(movingReg, seeds(l,:), l);
        disp(['Completed labeling for ', num2str(l)]);
    end
    % Output labeled image
end