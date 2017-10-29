T = readtable('C:\Users\baseb_000\Desktop\TicTacToe.csv');
T.Properties.VariableNames = {'Pos1' 'Pos2' 'Pos3' 'Pos4' 'Pos5' 'Pos6' 'Pos7' 'Pos8' 'Pos9' 'WinLose'};
model = fitcnb(T,T.WinLose);

WinLoseIndex = strcmp(model.ClassNames,'WinLose');
estimates = model.DistributionParameters;

e = estimates(1,10);
e{1}

crossvalidation = crossval(model);
defaultLoss = kfoldLoss(crossvalidation)
crossvalLoss = crossval(model);
Loss = kfoldLoss(crossvalLoss)