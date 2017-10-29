T = readtable('C:\Users\baseb_000\Desktop\scale.csv');
model = fitcnb(T,T.Var1);

WinLoseIndex = strcmp(model.ClassNames,'Var1');
estimates = model.DistributionParameters;

e = estimates(1,5);
e{1}

crossvalidation = crossval(model);
defaultLoss = kfoldLoss(crossvalidation)
crossvalLoss = crossval(model);
Loss = kfoldLoss(crossvalLoss)