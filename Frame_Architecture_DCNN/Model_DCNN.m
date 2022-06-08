%% DCNN model at 3-convolutional layer, 2-max-pooling, 1-fully connected layer

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