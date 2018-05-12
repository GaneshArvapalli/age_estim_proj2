% Evaluation code of Project 2 Version 1.0
% 03-26-2018

clc
clearvars
close all

% You can add path of other toolboxes that you are using
addpath NIFTI_20130306     % toolbox path1
%% TESTING

% Load data
scanDir = 'scans_testing/'; % testing subjects 
scanList = xlsread('ScanList_testing.xls');  % Testing list
subjName = scanList(:,1);      % 1st column: name
subjNum = length(subjName);    % # of subjects for testing
labelNum = 6;                  % 6 subcortical structures

model = linear_trainer();   %(E)
% If you have a pretrained model that can be used for testing, you can load
% your model here. If not, you can simply delete this line.

maskImg_tst = cell(subjNum,1); % segmentation results
age_tst = zeros(subjNum,1);    % predicted ages
boundBox_tst = zeros(subjNum,labelNum,6); % bounding boxes. 
runTime = zeros(subjNum,1);    % run time


% Testing: segmentation, bounding boxes, and age.
for subjID = 1:subjNum         
    scanStruc = load_untouch_nii([scanDir,num2str(subjName(subjID)),'_ANAT_N4_MNI_BRAIN_HISTMATCH.nii.gz']);
    scanImg = scanStruc.img;   % This is the MR scan
    
    tic                        
    [maskImg_temp,boundBox_temp,age_temp] = FUN_runProj2(scanImg,model); %(E)
    % If your algorithm doesn't need pretrained models, you can remove the
    % "trained_model" here. On the other hand, if your algorithm needs
    % multiple inputs, you can add more inputs. 
    % i.e. [maskImg_temp,boundBox_temp,age_temp] = FUN_runProj2(scanImg,trained_model1, trained_model2);
    runTime_temp = toc;      % save runtime of each subject
    
    maskImg_tst{subjID} = maskImg_temp;
    age_tst(subjID) = age_temp;
    boundBox_tst(subjID,:,:) = reshape(boundBox_temp,[6,6]);
    runTime(subjID) = runTime_temp;
    
    clear maskImg_temp boundBox_temp age_temp runTime_temp
end


%% EVALUATION

% Load truth data
maskDir = 'masks_testing/';   % manual delineation
ageList = xlsread('AgeList_testing.xls');  % Testing list
age_truth = ageList(:,1);        % true age

dice = zeros(subjNum,labelNum);  % Dice coefficient
boxError = zeros(subjNum,6);     % bounding box error
ageError = zeros(subjNum,1);     % age prediction error

for subjID = 1:subjNum
    % Evaluate segmentation
    maskImg_temp = maskImg_tst{subjID};   % segmentation result
    maskStruc = load_untouch_nii([maskDir,num2str(subjName(subjID)),'_MNI_label_convert.nii']);
    maskImg_truth = maskStruc.img;
    for labelID = 1:labelNum
        labelVal = labelID;
        labelImg_temp = maskImg_temp == labelVal;
        labelImg_truth = maskImg_truth == labelVal;
        dice(subjID,labelID) = FUN_Dice(labelImg_temp,labelImg_truth);
    end
    
    % Evaluate bounding boxes
    boundBox_truth = zeros(labelNum,6);
    for labelID = 1:labelNum
        labelVal = labelID;
        labelImg_truth = maskImg_truth == labelVal;
        [cen_row,cen_col,cen_slic,h,w,t] = FUN_BoundingBox(labelImg_truth);
        boundBox_truth(labelID,:) = [cen_row,cen_col,cen_slic,h,w,t];
    end
    boundBox_temp = boundBox_tst(subjID,:,:);
    boxError(subjID,:) = FUN_BoxError(boundBox_temp,boundBox_truth);
    
    % Evaluate age
    ageError(subjID) = FUN_AgeError(age_tst(subjID),age_truth(subjID));
end

%% EVALUATION SCORES
meanDice = mean(dice,1); % mean Dice of 6 labels
varDice = var(dice,1);   % variance of Dice of 6 labels

meanBoxError = mean(boxError,1); 
varBoxError = var(boxError,1);   

meanAgeError = mean(ageError);
varAgeError = var(ageError);

disp('***Evaluation Scores***');
fprintf('Mean Dice coefficient: %1.4f \n',mean(meanDice));
fprintf('Mean bounding box error: %4.4f \n',mean(meanBoxError));
fprintf('Mean age error: %4.4f \n',meanAgeError);
fprintf('Total runtime: %4.4f s\n',sum(runTime));

