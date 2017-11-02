T = readtable('C:\Users\baseb_000\Desktop\Yeast.csv');
T.Properties.VariableNames = {'mcg' 'gvh' 'alm' 'mit' 'vac' 'unkown' 'nuc'};
model = fitcnb(T,T.nuc);

%%WinLoseIndex = strcmp(model.ClassNames,'nuc');
%%estimates = model.DistributionParameters;

%%e = estimates(1,10);
%%e{1}

crossvalidation = crossval(model);
BayesLoss = kfoldLoss(crossvalidation)
raw = table2array(T(:,1:6));
Lraw = table2array(T(:,7));
Formated=[];
FLabels=[];
KnnLabels = [];
for i =1:1484
    
    tmp = Lraw(i);
    if(tmp{1} == 'MIT')
        FLabels(i) = 1;
        KnnLabels(i,1) = 1;
    elseif(tmp{1} == 'NUC')
        FLabels(i) = 2;
        KnnLabels(i,2) = 2;
    elseif(tmp{1} == 'CYT')
        FLabels(i) = 3;
        KnnLabels(i,3) = 3;
    elseif(tmp{1} == 'ME1')
        FLabels(i) = 4;
        KnnLabels(i,4) = 4;
    elseif(tmp{1} == 'EXC')
        FLabels(i) = 5;
        KnnLabels(i,5) = 5;
    elseif(tmp{1} == 'ME2')
        FLabels(i) = 6;
        KnnLabels(i,6) = 6;
    elseif(tmp{1} == 'ME3')
        FLabels(i) = 7;
        KnnLabels(i,7) = 7;
    elseif(tmp{1} == 'VAC')
        FLabels(i) = 8;
        KnnLabels(i,8) = 8;
    elseif(tmp{1} == 'POX')
        FLabels(i) = 9;
        KnnLabels(i,9) = 9;
    elseif(tmp{1} == 'ERL')
        FLabels(i) = 10;
        KnnLabels(i,10) = 10;
    else
        FLabels(i) = 11;
        KnnLabels(i,11) = 11;
    end
end
KNN = fitcknn(raw,FLabels);

crossvalLoss = crossval(KNN);
KNNLoss = kfoldLoss(crossvalLoss)

net = feedforwardnet(10);
net.trainParam.showWindow = 1;
net = train(net, raw',KnnLabels');
pre = net(raw');
plotconfusion(KnnLabels', pre, 'Classifications and Missclassifications');