tic
length = 60000;
TestLength = 10000;
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
images = images(:,1:length);
labels = labels(1:length,:);
RealLabels = zeros(length,10);
for i = 1:length
    if(labels(i,1) == 0)
        RealLabels(i,1) = 1;
    elseif(labels(i,1) == 1)
        RealLabels(i,2) = 1;
    elseif(labels(i,1) == 2)
        RealLabels(i,3) = 1;
    elseif(labels(i,1) == 3)
        RealLabels(i,4) = 1;
    elseif(labels(i,1) == 4)
        RealLabels(i,5) = 1;
    elseif(labels(i,1) == 5)
        RealLabels(i,6) = 1;
    elseif(labels(i,1) == 6)
        RealLabels(i,7) = 1;
    elseif(labels(i,1) == 7)
        RealLabels(i,8) = 1;
    elseif(labels(i,1) == 8)
        RealLabels(i,9) = 1;
    elseif(labels(i,1) == 9)
        RealLabels(i,10) = 1;
    end
end
labels = RealLabels';
%net1 = feedforwardnet(100);
%net1.trainParam.max_fail = 10;
%net1.performparam.regularization = (0-1);
%net1.trainParam.showWindow = 1;
for i = 1:784
    if(images(i,1) == 0)
        images(i,1) = 0.0000001;
    end
end
%net1 = train(net1,images,labels,'useGPU','yes','showResources','yes');
% 
% xg = nndata2gpu(images);
% tg = nndata2gpu(labels);
% net2 = configure(net1,images,labels);  % Configure with MATLAB arrays
% net2 = train(net2,xg,tg);    % Execute on GPU with NNET formatted gpuArrays 
% yg = net2(xg);               % Execute on GPU
% y = gpu2nndata(yg); 

Testimages = loadMNISTImages('t10k-images.idx3-ubyte');
Testlabels = loadMNISTLabels('t10k-labels.idx1-ubyte');
Testimages = Testimages(:,1:TestLength);

RealTest = zeros(TestLength,10);
for i = 1:TestLength
    if(Testlabels(i,1) == 0)
        RealTest(i,1) = 1;
    elseif(Testlabels(i,1) == 1)
        RealTest(i,2) = 1;
    elseif(Testlabels(i,1) == 2)
        RealTest(i,3) = 1;
    elseif(Testlabels(i,1) == 3)
        RealTest(i,4) = 1;
    elseif(Testlabels(i,1) == 4)
        RealTest(i,5) = 1;
    elseif(Testlabels(i,1) == 5)
        RealTest(i,6) = 1;
    elseif(Testlabels(i,1) == 6)
        RealTest(i,7) = 1;
    elseif(Testlabels(i,1) == 7)
        RealTest(i,8) = 1;
    elseif(Testlabels(i,1) == 8)
        RealTest(i,9) = 1;
    elseif(Testlabels(i,1) == 9)
        RealTest(i,10) = 1;
    end
end

Testlabels = RealTest';
pre = net1(Testimages);
plotconfusion(Testlabels, pre, 'Classifications and Missclassifications');
toc
