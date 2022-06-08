%% Setting of hyperparameters values  and improving model performance
options = trainingOptions('sgdm',...   %% selection of optimiser: sgdm, adm,rmspro
    'Momentum',0.95,...                 %% Optimiser of sgdm : use of momentum range 0 to 1, where 0.8 to 0.99  are be achieved a strong result
      'InitialLearnRate',0.001, ...     %% Most of study learning rate at 0.001 get robust performance
    'MaxEpochs',300, ...                %% 300 at maximum epoch used increases the epochs variation of performance but at particular time epoch variation goes constant
    'MiniBatchSize',128, ...            %%  128 at minibatch size used, an efficient memory for model execution, increases the value more memory space required
    'ValidationData',{TrainingImages,validationImages},... %% used training and validation dataset
    'ValidationFrequency',30,... 
    'Verbose',false,...
    'Plots','training-progress');

% progressive graph of training model
net = trainNetwork(TrainingImages,layers,options);  % Generation of progressive training plot

