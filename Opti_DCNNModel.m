close all;
clear;
clc;

% LoadLISS_IV_Dataset

Director= 'Select the link to the folder where the store of the dataset';
Class= 'Define the folder name of all separate classes where the collected samples'

Land_Use_Dataset = imageDatastore(fullfile(Director, {Class}),...
'LabelSource', 'foldernames', 'FileExtensions', {'.jpg', '.png', '.tif'});

Land_Use_Dataset.Labels


%Prepare Dataset for Training and validation dataset
 
 [TrainingImages,validationImages] = splitEachLabel(Land_Use_Dataset,0.7,'randomized');
 
 
 % DCNN model at 3-convolutional layer, 2-max-pooling, 1-fully connected layer

layers = [
    imageInputLayer([6 6 3])   %% Input image size: 6x6 and depth =3 (Red, Green, Blue)

    convolution2dLayer(3,16,'Padding',1)  %% Frist convoultional layer with 3x3 kernal of 16 feature maps, also include 1 padding, 1 stride
    batchNormalizationLayer    %%% After the 16- convolved feature map, the batch normalized _1 is used.
    reluLayer              % rule_1 prevents the wanted growth

    maxPooling2dLayer(2,'Stride',2)   %Frist max-pooling layer with 2x2 kenel of 2 stride

    convolution2dLayer(3,32,'Padding',1) %% Second convoultional layer with 3x3 kernal of 32 feature maps, also include 1 padding, 1 stride
    batchNormalizationLayer        %%% After the 32- convolved feature map, the batch normalized _2 is used.
    reluLayer                           % rule_1 prevents the wanted growth

    maxPooling2dLayer(2,'Stride',2)     %Second max-pooling layer with 2x2 kenel of 2 stride

    convolution2dLayer(3,64,'Padding',1)%% Thrid convoultional layer with 3x3 kernal of 64 feature maps, also include 1 padding, 1 stride
    batchNormalizationLayer            %%% After the 64- convolved feature map, the batch normalized _3 is used.
    reluLayer                            % rule_1 prevents the wanted growth

    fullyConnectedLayer(5)              %% 1-Fully connected layer of 5 neurons
    softmaxLayer                         %%the output layer of neural network models that predict a multinomial probability distribution.
    classificationLayer];               % desired output predicted classes barren land , builtup area, coal mining region, vegetation, and waterbody
 
 
 
% Optimized model using tuning the optimizer checking the model performance

%Step-1 to check ADM optimiser model training accruacy
% Step-2 to check rmspro opmtiser model training accruacy
%Step-3 to check sgm opmtiser model training accruacy
% Step-4 Select the optimum performance of model training accuracy and further implement DCNN+optimized optimizer



options = trainingOptions('sgdm',...   %% selection of optimiser: sgdm, adm,rmspro
    'Momentum',0.95,...                 %% Optimiser of sgdm : use of momentum range 0 to 1, where 0.8 to 0.99  are be achieved a strong result
      'InitialLearnRate',0.001, ...     %% sensitivity of model accaurcy variation of learning rate 
    'MaxEpochs',300, ...                %%  sensitivity of model accaurcy variation of epoches
    'MiniBatchSize',128, ...            %%   sensitivity of model accaurcy variation of minibatchsize  
    'ValidationData',{TrainingImages,validationImages},... %% used training and validation dataset
    'ValidationFrequency',30,... 
    'Verbose',false,...
    'Plots','training-progress');

% progressive graph of training model
net = trainNetwork(TrainingImages,layers,options);  % Generation of progressive training plot
%net = trainNetwork(validationImages,layers,options);