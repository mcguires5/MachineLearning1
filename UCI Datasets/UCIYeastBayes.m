T = readtable('C:\Users\baseb_000\Desktop\Yeast.csv');
T.Properties.VariableNames = {'Sequence_Name' 'mcg' 'gvh' 'alm' 'mit' 'vac' 'unkown' 'nuc'};
model = fitcnb(T,T.nuc);

%%WinLoseIndex = strcmp(model.ClassNames,'nuc');
%%estimates = model.DistributionParameters;

%%e = estimates(1,10);
%%e{1}

crossvalidation = crossval(model);
defaultLoss = kfoldLoss(crossvalidation)
crossvalLoss = crossval(model);
Loss = kfoldLoss(crossvalLoss)