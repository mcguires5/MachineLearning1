% Max_Fail Parameter to show differences in cuttof fialur amout
% Train BR is the train basian


data1 = mvnrnd([3 4],[1,.8;.8,1],1000);
data2 = mvnrnd([3 7],[1,.8;.8,1],1000);
labels = [ones(length(data1),1);2*ones(length(data2),1)];
X = [data1;data2];
hold on
plot(data1(:,1),data1(:,2),'.r')
plot(data2(:,1),data2(:,2),'+b')
hold off
X= X';
Y = labels;
t = zeros(2,length(Y));
for i = 1: length(Y)
    if(Y(i)==1)
        t(1,i) = 1;
        t(2,i) = 0;
    else
        t(1,i) = 0;
        t(2,i) = 1;
    end
end
%net = feedforwardnet(50,'trainbr');
%net.divideFcn = '';
net = feedforwardnet(50);
net.trainParam.max_fail = 5;
net.trainParam.showWindow = 1;
net = train(net, X,t);
pre = net(X);
plotconfusion(t, pre, 'Classifications and Missclassifications');
figure
hold on
WrongClass1 = 0;
WrongClass2 = 0;
for i = 1:2000
    if(pre(1,i) > pre(2,i))
        plot(X(1,i),X(2,i),'.r');
        if(i > 1000)
           WrongClass1 = WrongClass1 + 1; 
           plot(X(1,i),X(2,i),'or');
        else
            plot(X(1,i),X(2,i),'.r');
        end
    else
        plot(X(1,i),X(2,i),'+b');
        if(i <= 1000)
           WrongClass2 = WrongClass2 + 1; 
           plot(X(1,i),X(2,i),'ob');
        else
            plot(X(1,i),X(2,i),'+b');
        end
    end
end
V = sprintf('Missclassified in class 1: %d',WrongClass1);
Z = sprintf('Missclassified in class 2: %d',WrongClass2);
disp(V);
disp(Z);
hold off