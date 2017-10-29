T = readtable('C:\Users\baseb_000\Desktop\AdultData.csv');
T.Properties.VariableNames = {'Age' 'Workclass' 'fnlwgt' 'education' 'educationNum' 'maritalStatus' 'occupation' 'relationship' 'race' 'sex' 'capitalGain' 'capitalLoss' 'hoursPerWeek' 'nativeCountry' 'MoneyOrNo'};
model = fitcnb(T,T.MoneyOrNo);

%%WinLoseIndex = strcmp(model.ClassNames,'MoneyOrNO');
%%estimates = model.DistributionParameters;

%%e = estimates(1,10);
%%e{1}

crossvalidation = crossval(model);
defaultLoss = kfoldLoss(crossvalidation)
crossvalLoss = crossval(model);
Loss = kfoldLoss(crossvalLoss)