
close all;
clear;
clc;

Director= 'Select the link to the folder where the store of the dataset';
Class= 'Define the folder name of all separate classes where the collected samples'

Land_Use_Dataset = imageDatastore(fullfile(Director, {Class}),...
'LabelSource', 'foldernames', 'FileExtensions', {'.jpg', '.png', '.tif'});

Land_Use_Dataset.Labels

