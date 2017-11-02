%SVMNoSlack

clear all
clc;clf;
%Data Sets
set1 = mvnrnd([5 10],[1,1],100);
set2 = mvnrnd([6 1],[1,1],100);

%Plot Data
figure;
title('Initial Data')
hold on;
plot(set1(:,1),set1(:,2), 'b.')
plot(set2(:,1),set2(:,2), 'r+')
hold off;

%Data Portions
TotalData = [set1;set2];
TotalX = TotalData(:,1);
TotalY = TotalData(:,2);
one = zeros(length(set1)+length(set2),1);
Z = cat(2,one,TotalX,TotalY);

Class1 = 1;

%Parameters for quadprog
H = [1 0 0;0 1 0;0 0 1];
W = [1 Class1 1];
Y = diag([ones(length(set1),1);-ones(length(set1),1)]);
b = -ones(length(set1)+length(set2),1);
A = -Y*Z;

%Run Quadprog
Result = quadprog(H,[],A,b);
Class1 = [];
Class2 = [];
for i = 1:length(Z)
   %Calculate the output value
    Output = Result(1) + TotalX(i)*Result(2) + TotalY(i)*Result(3);
    %Class1
    if(Output >= 1)
        Class1 = [Class1;TotalX(i) TotalY(i)];
    %Class2    
    elseif(Output <= -1)
        Class2 = [Class2;TotalX(i) TotalY(i)]; 
    end  
    
end
X = [0:0.01:10];
figure;
title("Processed Data");
hold on
%Plot Data
plot(Class1(:,1),Class1(:,2),'b.'); %plot
plot(Class2(:,1),Class2(:,2),'r+');
%Draw boundry lines
plot(X,-1*(Result(1)+Result(2)*X+1)/Result(3));
plot(X,-1*(Result(1)+Result(2)*X-1)/Result(3));
plot(X,-1*(Result(1)+Result(2)*X)/Result(3));
hold off


