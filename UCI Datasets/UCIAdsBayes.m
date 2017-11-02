T = readtable('ad.csv');

net = feedforwardnet(150);
net.trainParam.showWindow = 1;
t = zeros(2,length(T));
T= T';
net = train(net, T,t);
pre = net(T);
plotconfusion(t, pre, 'Classifications and Missclassifications');


crossvalidation = crossval(model);
defaultLoss = kfoldLoss(crossvalidation)
crossvalLoss = crossval(model);
Loss = kfoldLoss(crossvalLoss)