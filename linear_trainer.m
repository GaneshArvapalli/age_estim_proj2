%% Ganesh Arvapalli
% Basic linear classifier training

function Mdl=linear_trainer()
    if ~exist('training_data.mat')
        load('training_images.mat');
        trainX = [];
        for i=1:length(imgs)
            vec_s = zeros(6, 6);
            for label=1:6
                [r,c,s,h,w,t] = FUN_BoundingBox(imgs{i}==label);
                vec_s(label, :) = [r,c,s,h,w,t];
            end
            trainX = [trainX; vec_s];
        end
        trainX = reshape(trainX,[36,length(imgs)]);
        trainX = trainX';
        %%%% CHECK THIS RESHAPE PROBABLY WRONG
        save('training_data.mat','trainX');
    else
        load('training_data.mat');
    end
    n = size(trainX,1)/6;
    Y = xlsread('Project2_TrainingData/SubjectList_training.xls');
    Y = Y(:,2);
%     rng(1); % For reproducibility
%     cvp = cvpartition(n,'Holdout',double(3.0/size(trainX, 1)));
%     idxTrain = training(cvp); % Extract training set indices
%     trainX = trainX';
%     Mdl = fitclinear(trainX(:,idxTrain),Y(idxTrain),'ObservationsIn','columns');
    [Mdl, FitInfo] = fitrlinear(trainX, Y);
    disp(FitInfo);
end