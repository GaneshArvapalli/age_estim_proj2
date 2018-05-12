*****************
*** IMPORTANT *** 
*****************

You are reading the "README.txt" file of Evaluation code Version 1.0. This folder contains files and subfolders that will be used to evaluate your algorithm. There are several things you should do: 

1. You should edit the evaluation code to make it work well with your own algorithm.
Note: There are two MATLAB files you can edit: "script_EvaluationProj2.m" and "FUN_runProj2.m". However, for each MATLAB file, not all lines are allowed to be edited. Every editable line is labeled "%(E)" at the end of the line.
e.g. 
output = FUN_runProj2(input1,input2,input3); %(E)
% You may add or remove some inputs of FUN_run_Proj2();

2. Since you don't have "real" testing data, you may use your training data as "fake" testing data to run the evaluation code. To do this, you should: 
* copy the .nii files of TRAINING masks to "masks_testing" folder.
* copy the nii.gz files of TRAINING scans to "scans_testing" folder.

3. After editing the evaluation code, you should send a compressed *ROOT FOLDER* (.zip file) to TAs. The due date of submitting your code will be posted shortly. The compressed *ROOT FOLDER* should contain: 
* script_EvaluationProj2.m (may be edited)
* FUN_runProj2.m (may be edited)
* Your_algorithm.m (If you use other languages, your code should be callable for MATLAB.)
* Others (e.g. pretrained model)

4. What will TAs do when evaluating your code?
* TAs will copy real testing data to corresponding folders (e.g. MR images for testing),
* replace the "fake" testing lists (i.e. ScanList_testing.xls, and AgeList_testing.xls) with "real" testing lists,
* and run "script_EvaluationProj2.m". Then your code will be assessed based on the displayed metrics. 
* So, please double check that your code is fully automatic, and works well with the evaluation code.

5. Changes might be made on the evaluation code if we found errors or bugs. So, make sure that you are working on the latest version of evaluation code.



****************
*** CONTENTS ***
**************** 

1. script_EvaluationProj2.m: script for evaluating Project2.

2. FUN_runProj2.m: MATLAB function to call your algorithm.

3. ScanList_testing.xls: table of scan names of testing subjects. 
Note: To make evaluation code runnable on your machine, the content of "ScanList_testing.xls" has already been made to be the name list of TRAINING subjects. However, after you send us the final code, TAs will replace the content with the name of TESTING subjects. 

4. AgeList_testing.xls: table of true ages of testing subjects. 
Note: To make evaluation code runnable in your machine, the content of "AgeList_testing.xls" is made to be the age list of TRAINING subjects. However, after you send us the final code, TAs will replace the content with the true age of TESTING subjects. 

5. (Empty folder) masks_testing: to make the evaluation code runnable on your machine, you  may copy the nii files of TRAINING masks to this folder.

6. (Empty folder) scans_testing: to make the evaluation code runnable on your machine, you  may copy the nii.gz files of TRAINING scans to this folder.

7. NIFTI_20130306: toolbox folder of loading and writing .nii files.

8. README.txt

9. Several MATLAB functions: FUN_AgeError.m, FUN_BoundingBox.m, FUN_BoxError.m, and FUN_Dice.m.

10. trained_model.mat: trained model of my "stupid" segmentation algorithm. You should remove it when using your method. 