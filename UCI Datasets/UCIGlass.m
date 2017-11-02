T = readtable('Glass.csv');

raw = table2array(T(:,1:10));
labels = table2array(T(:,11));
model = fitcnb(raw,labels);

crossvalLoss = crossval(model);
BayesLoss = kfoldLoss(crossvalLoss)

KNN = fitcknn(raw,labels);

crossvalLoss = crossval(KNN);
KNNLoss = kfoldLoss(crossvalLoss)

