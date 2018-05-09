function net=createNet()
inputSize = [50, 50, 50];
imgLayer = imageInputLayer(inputSize);
filterSize = 3;
numFilters = 32;
conv = convolution2dLayer(filterSize,numFilters,'Padding',1);
relu = reluLayer();
poolSize = 2;
maxPoolDownsample2x = maxPooling2dLayer(poolSize,'Stride',2);
downsamplingLayers = [
    conv
    relu
    maxPoolDownsample2x
    conv
    relu
    maxPoolDownsample2x
    ];
filterSize = 4;
transposedConvUpsample2x = transposedConv2dLayer(4,numFilters,'Stride',2,'Cropping',1);
upsamplingLayers = [
    transposedConvUpsample2x
    relu
    transposedConvUpsample2x
    relu
    ];
numClasses = 6;
conv1x1 = convolution2dLayer(1,numClasses);
finalLayers = [
    conv1x1
    softmaxLayer()
    pixelClassificationLayer()
    ];
net = [
    imgLayer    
    downsamplingLayers
    upsamplingLayers
    finalLayers
    ];
save('neural_net.mat', 'net');
end