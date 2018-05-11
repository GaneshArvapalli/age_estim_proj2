# Project 2 - Medical Image Analysis

## Authors:
Ganesh Arvapalli - garvapa1@jhu.edu
Shayan Roychoudhury - sroycho1@jhu.edu

## Instructions:
To run this program, first place the whole set of directories in the same folder with all of the training data located in "Project2_TrainingData" with the subfolders "manual_label" and "scans". We will also need all of the NIFTI files to read in images.

Start by data_loader(filepath, 'train') and data_loader(filepath, 'label_train') to store necessary images in .mat files for easy access. The filepaths will correspond to the paths to the folders "scans" and "manual_label" respectively.

Next, run linear_trainer.m to train the linear model. This will have PCA built in (implemented in principal_comp.m). This will also generate a .mat file containing the linear model used for regression.

Finally, once you have all of these .mat files made, run FUN_runProj2 with the image you are trying to segment and regress using the following command:

[m, bb, age] = FUN_runProj2(inputImage);