T = readtable('iris.csv');
T.Properties.VariableNames = {'sepal_length' 'sepal_width' 'petal_length' 'petal_width' 'class'};
model = fitcnb(T,T.class);

crossvalLoss = crossval(model);
BayesLoss = kfoldLoss(crossvalLoss)

irisraw = table2array(T(:,1:4));

irisLabels = zeros(3,150);
irisLabels(1,1:50) = 1; %%Equal to 1 column
irisLabels(2,51:100) = 2;
irisLabels(3,101:150) = 3;
KnnLabels = ones(50,1);
KnnLabels = [KnnLabels; 2*ones(50,1)];
KnnLabels =  [KnnLabels; 3*(ones(50,1))];
KNN = fitcknn(irisraw(:,1:4),KnnLabels);

crossvalLoss = crossval(KNN);
KNNLoss = kfoldLoss(crossvalLoss)

net = feedforwardnet(10);
net.trainParam.showWindow = 1;
net = train(net, irisraw',irisLabels);
pre = net(irisraw');
plotconfusion(irisLabels, pre, 'Classifications and Missclassifications');

