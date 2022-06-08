

% Accuracy Assesment

% converstion of vector form of training and validation dataset
% TrainingImages,validationImages
TrainImVector=TrainingImages.labels;
ValidImVector=validationImages.labels;

TrainImPredicted=classify(net,TrainingImages);
ValidImPredicted=classify(net,validationImages);


plotconfusion(TrainImVector, TrainImPredicted);
plotconfusion(ValidImVector, ValidImPredicted);


% Accuracy
Training_Accuracy = sum(TrainImVector == TrainImPredicted)/numel(TrainImVector)
Validatation_Accuracy = sum(ValidImVector == ValidImPredicted)/numel(ValidImVector)