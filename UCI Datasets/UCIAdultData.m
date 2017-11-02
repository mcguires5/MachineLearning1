T = readtable('C:\Users\baseb_000\Desktop\AdultData.csv');
T = rmmissing(T);
model = fitcnb(T(:,1:5),T(:,6));

crossvalLoss = crossval(model);
Loss = kfoldLoss(crossvalLoss)

Adultraw(:,1) = table2array(T(:,1));
tmp = table2array(T(:,2));
Adultraw(:,2) = tmp{1};
tmp;
AdultLabels = zeros(2,32561);
KnnLabels = zeros(1,32561);
for i = 1:32561
   if i == 1
      tmp = Adultraw(i,6); 
   end
   if i > 1 && tmp == Adultraw(i,6)
       KnnLabels(i) = 1;
       AdultLabels(1,i) = 1;
   else
       KnnLabels(i) = 2;
       AdultLabels(2,i) = 2;
   end
end
KNN = fitcknn(T(:,1:5),KnnLabels(:));

crossvalLoss = crossval(KNN);
KNNLoss = kfoldLoss(crossvalLoss)

net = feedforwardnet(10);
net.trainParam.showWindow = 1;
net = train(net, Adultraw',AdultLabels);
pre = net(Adultraw');
plotconfusion(AdultLabels, pre, 'Classifications and Missclassifications');

