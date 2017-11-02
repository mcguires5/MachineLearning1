T = readtable('ad.csv');
model = fitcnb(T(1:1558),T(1559));

crossvalidation = crossval(model);
defaultLoss = kfoldLoss(crossvalidation)
