function model=trainNet(net)
    % dataSetDir = fullfile(toolboxdir('vision'),'visiondata','triangleImages');
    imageDir = fullfile('Project2_TrainingData\training_images');
    labelDir = fullfile('Project2_TrainingData\labeled_training_images');
    % Files = dir(labelDir);
    % disp(Files(3).name);
    imds = imageDatastore(imageDir,'ReadFcn',@load_nii,'FileExtensions','.gz');
    classNames = ['left_caudate','right_caudate','left_putamen','right_putamen','left_thalamus','right_thalamus','background'];
    labelIDs   = [1 2 3 4 5 6 0];
    % pxds = pixelLabelDatastore(labelDir,classNames,labelIDs,'ReadFcn',@load_nii,'FileExtensions','.nii');
    pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);
    load('labeled_images_training.mat');
%     readerFcn = @(~,idx)load_nii(imageDatastore(imageDir,'ReadFcn',@load_nii,'FileExtensions','.nii'), seconds(idx));
%     gtSource = groundTruthDataSource('Project2_TrainingData\labeled_training_images',readerFcn);
    % images_to_use = {'Project2_TrainingData\labeled_training_images\1000_MNI_label_convert.nii', 'Project2_TrainingData\labeled_training_images\1002_MNI_label_convert.nii', 'Project2_TrainingData\labeled_training_images\1004_MNI_label_convert.nii', 'Project2_TrainingData\labeled_training_images\1006_MNI_label_convert.nii', 'Project2_TrainingData\labeled_training_images\1007_MNI_label_convert.nii'};
    % gtSource = groundTruthDataSource(images_to_use, 'FileExtensions','.nii');
    % pxds = pixelLabelDatastore(training_labeled_imgs, 'ReadFcn', @load_nii);
    C = read(pxds);
end