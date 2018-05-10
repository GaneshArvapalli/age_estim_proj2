function model=trainNet(net)
    if nargin < 1
        net = createNet();
    end
    % dataSetDir = fullfile(toolboxdir('vision'),'visiondata','triangleImages');
    % imageDir = fullfile('Project2_TrainingData\training_images');
    % labelDir = fullfile('Project2_TrainingData\labeled_training_images');
    % % Files = dir(labelDir);
    % % disp(Files(3).name);
    % imds = imageDatastore(imageDir,'ReadFcn',@load_nii,'FileExtensions','.gz');
    % classNames = ['left_caudate','right_caudate','left_putamen','right_putamen','left_thalamus','right_thalamus','background'];
    % labelIDs   = [1 2 3 4 5 6 0];
    % pxds = pixelLabelDatastore(labelDir,classNames,labelIDs,'ReadFcn',@load_nii,'FileExtensions','.nii');
    % pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);
    % load('labeled_images_training.mat');
    % readerFcn = @(~,idx)load_nii(imageDatastore(imageDir,'ReadFcn',@load_nii,'FileExtensions','.nii'), seconds(idx));
    % gtSource = groundTruthDataSource('Project2_TrainingData\labeled_training_images',readerFcn);
    % images_to_use = {'Project2_TrainingData\labeled_training_images\1000_MNI_label_convert.nii', 'Project2_TrainingData\labeled_training_images\1002_MNI_label_convert.nii', 'Project2_TrainingData\labeled_training_images\1004_MNI_label_convert.nii', 'Project2_TrainingData\labeled_training_images\1006_MNI_label_convert.nii', 'Project2_TrainingData\labeled_training_images\1007_MNI_label_convert.nii'};
    % gtSource = groundTruthDataSource(images_to_use, 'FileExtensions','.nii');
    % pxds = pixelLabelDatastore(training_labeled_imgs, 'ReadFcn', @load_nii);
    % C = read(pxds);
    
    % readerFcn = @load_nii;
    % ds = groundTruthDataSource(labelDir,@load_nii,1:5);
    % pxds = imageDatastore(labelDir,'ReadFcn',@load_nii,'FileExtensions','.nii');
    % labelds = pixelLabelDatastore(labelDir,classNames, labelIDs);
    %
    % opts = trainingOptions('sgdm', 'InitialLearnRate',1e-3,'MaxEpochs',100,'MiniBatchSize',1);

%     for k = 1:length(train_imgs)
%         i = train_imgs{k};
%         l = training_labeled_imgs{k};
%     end
    clc;
    load('training_images.mat');
    load('labeled_images_training.mat');
    X = zeros(241, 286, 241);
    Y = zeros(241, 286, 241);
    % Maybe flatten images into 2D first then concatenate?
    for k = 1:length(train_imgs)
        i = cat(4, train_imgs{k});
        l = cat(4, uint8(training_labeled_imgs{k}));
        % X = [X; i];
        % Y = [Y; l];
        X(:, :, :, k) = i;
        Y(:, :, :, k) = l;
    end
    % X = cat(4, train_imgs{:});
    % Y = cat(4, training_labeled_imgs{:});
    sizeX = size(X);
    % X = reshape(X, sizeX(1), sizeX(2), 1, sizeX(3));
    % Y = reshape(Y, sizeX(1), sizeX(2), 1, sizeX(3));
    options = trainingOptions('sgdm','InitialLearnRate',0.001, 'Verbose',false,'Plots','training-progress');
    trained_net = trainNetwork(X, Y, net, options);
    save('neural_net.mat', 'trained_net');
end