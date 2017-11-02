T = readtable('ecoli.dat');
raw = table2array(T(:,2:6));
raw(:,3) = [];
labels = table2array(T(:,8));
model = fitcnb(raw,labels);

crossvalidation = crossval(model);
BayestLoss = kfoldLoss(crossvalidation)


raw = table2array(T(:,2:6));
Formated=[];
FLabels=[];
KnnLabels = [];
labels = table2array(T(:,8));
for i =1:336
    tmp = labels(i);
    c = tmp{1};
    Type = char(c); 
    if(Type == "ims")
        FLabels(i) = 3;
        KnnLabels(i,3) = 3;
    elseif(Type == "imL")
        FLabels(i) = 4;
        KnnLabels(i,4) = 4;
    elseif(Type == "imU")
        FLabels(i) = 5;
        KnnLabels(i,5) = 5;
    elseif(Type == "omL")
        FLabels(i) = 7;
        KnnLabels(i,7) = 7;
    elseif(Type == "pp")
        FLabels(i) = 8;
        KnnLabels(i,8) = 8;
    elseif(Type == "cp")
        FLabels(i) = 1;
        KnnLabels(i,1) = 1;
    elseif(Type == "im")
        FLabels(i) = 2;
        KnnLabels(i,2) = 2;
    elseif(Type == "om")
        FLabels(i) = 6;
        KnnLabels(i,6) = 6;
    end
end
KNN = fitcknn(raw,FLabels);
crossvalLoss = crossval(KNN);

KNNLoss = kfoldLoss(crossvalLoss)
