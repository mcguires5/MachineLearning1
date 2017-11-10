T = readtable('TicTacToe.csv');
T.Properties.VariableNames = {'Pos1' 'Pos2' 'Pos3' 'Pos4' 'Pos5' 'Pos6' 'Pos7' 'Pos8' 'Pos9' 'WinLose'};
model = fitcnb(T,T.WinLose);

crossvalidation = crossval(model);
BayestLoss = kfoldLoss(crossvalidation)


irisraw = table2array(T(:,1:10));
Formated=[];
FLabels=[];
KnnLabels = [];
for i =1:957
    for j = 1:9
        tmp = irisraw(i,j);
    if(tmp{1} == 'x')
       Formated(i,j) = 1;
    elseif tmp{1} == 'o'
       Formated(i,j) = 2; 
    else
        Formated(i,j) = 3;
    end
    end
    tmp = irisraw(i,10);
    if(tmp{1} == 'positive')
        FLabels(i) = 1;
        KnnLabels(i,1) = 1;
    else
        FLabels(i) = 2;
        KnnLabels(i,2) = 2;
    end
end
KNN = fitcknn(Formated(:,1:9),FLabels);
crossvalLoss = crossval(KNN);

KNNLoss = kfoldLoss(crossvalLoss)

net = feedforwardnet(10);
net.trainParam.showWindow = 1;
net = train(net, Formated',KnnLabels');
pre = net(Formated');
plotconfusion(KnnLabels', pre, 'Classifications and Missclassifications');

