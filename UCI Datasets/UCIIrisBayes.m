T = readtable('C:\Users\baseb_000\Desktop\iris.csv');
T.Properties.VariableNames = {'sepal_length' 'sepal_width' 'petal_length' 'petal_width' 'class'};
model = fitcnb(T,T.class);

WinLoseIndex = strcmp(model.ClassNames,'class');
estimates = model.DistributionParameters;



crossvalidation = crossval(model);
defaultLoss = kfoldLoss(crossvalidation)
crossvalLoss = crossval(model);
Loss = kfoldLoss(crossvalLoss)

irisraw = table2array(T(:,1:4));

irisLabels = zeros(3,150);
irisLabels(1,1:50) = 1; %%Equal to 1 column
irisLabels(2,51:100) = 2;
irisLabels(3,101:150) = 3;

net = feedforwardnet(10);
net.trainParam.showWindow = 1;
net = train(net, irisraw',irisLabels);
pre = net(irisraw');
plotconfusion(irisLabels, pre, 'Classifications and Missclassifications');
