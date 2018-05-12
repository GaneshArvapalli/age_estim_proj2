%% Ganesh Arvapalli
% Basic linear classifier training

function [trained_model, avLabel, avImage]=linear_trainer()
    % First find average locations of existing brain labels/parts
    data_loader('Project2_TrainingData\manual_label', 'label_train');
    data_loader('Project2_TrainingData\scans', 'train');
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
    avImage = single(zeros(size(train_imgs{1})));
    for i=1:length(train_imgs)
        avImage = avImage + single(train_imgs{i});
    end
    avImage = avImage/length(train_imgs);
    % disp(size(av));
    % labeled_image = training_labeled_imgs{1};
    % labeled_image = avLabel;
    if ~exist('training_labeled_imgs')
        load('labeled_images_training.mat');
        trainX = [];
        for i=1:length(training_labeled_imgs)
            vec_s = zeros(1, 36);
            for label=1:6
                [r,c,s,h,w,t] = FUN_BoundingBox(training_labeled_imgs{i}==label);
                vec_s(label:label+5) = [r,c,s,h,w,t];
            end
            trainX = [trainX; vec_s];
        end
        % trainX = reshape(trainX,[36,length(imgs)]);
        % trainX = trainX';
        save('training_data.mat','trainX');
    else
        load('training_data.mat');
    end
%     n = size(trainX,1)/6;
    Y = xlsread('Project2_TrainingData/SubjectList_training.xls');
    Y = abs(Y(:,2));
    Y = Y(1:length(training_labeled_imgs));
    % rng(1); % For reproducibility
    % cvp = cvpartition(n,'Holdout',2);
    % idxTrain = training(cvp); % Extract training set indices
    % trainX = trainX';
    % Mdl = fitclinear(trainX(:,idxTrain),Y(idxTrain),'ObservationsIn','columns');
    % [Mdl, FitInfo] = fitrlinear(trainX, Y);
    % disp(FitInfo);
    % PCA STEP (M=10 arbitrarily chosen for now, will be optimized later)
    trainX = principal_comp(trainX, 3);
    trained_model = fitlm(trainX, Y);
    save('linear_predictor.mat','trained_model');
end