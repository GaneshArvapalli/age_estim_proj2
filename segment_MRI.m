%% Ganesh Arvapalli
% Basic method to segment MRI image using region growing

function full_mask=segment_MRI(a)
    % First find average locations of existing brain labels/parts
    if ~exist('train_imgs')
        load('training_images.mat');
    end
    training_image = train_imgs{1};
    seeds = zeros(6,3);
    for label=1:6
        stats = regionprops(training_image == label);
        seeds(label,:) = stats.Centroid;
    end
    seeds = uint8(seeds);
    disp('Found seeds');
    % Register every slice of current MRI scan to training image
    
    % TRY DONWSAMPLING A
    [optimizer, metric] = imregconfig('multimodal');
    movingReg = imregister(a,training_image,'affine',optimizer,metric);
    
     % determine proper format, one image at a time?
    mriVolumeOriginal = squeeze(a.D);
    sizeO = size(mriVolumeOriginal);

    mriVolumeResized = imresize3(mriVolumeOriginal, 0.5);
    sizeR = size(mriVolumeResized);

    
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