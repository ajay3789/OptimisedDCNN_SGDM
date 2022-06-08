

 %% Prepare Dataset for Training and validation dataset
 
 [TrainingImages,validationImages] = splitEachLabel(Land_Use_Dataset,0.7,'randomized');