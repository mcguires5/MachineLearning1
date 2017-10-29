T = readtable('C:\Users\baseb_000\Desktop\winequality-white.csv');
T.Properties.VariableNames = {'fixed_acidity' 'volatile_acidity' 'citric_acid' 'residual_sugar' 'chlorides' 'free_sulfur_dioxide' 'total_sulfur_dioxide' 'density' 'ph' 'sulphates' 'alcholol' 'quality'};
model = fitcnb(T,T.quality);

WinLoseIndex = strcmp(model.ClassNames,'quality');
estimates = model.DistributionParameters;

e = estimates(1,10);
e{1}

crossvalidation = crossval(model);
defaultLoss = kfoldLoss(crossvalidation)
crossvalLoss = crossval(model);
Loss = kfoldLoss(crossvalLoss)