T = readtable('C:\Users\baseb_000\Desktop\AdultData.csv');
T.Properties.VariableNames = {'Age' 'Workclass' 'fnlwgt' 'education' 'educationNum' 'maritalStatus' 'occupation' 'relationship' 'race' 'sex' 'capitalGain' 'capitalLoss' 'hoursPerWeek' 'nativeCountry' 'MoneyOrNo'};

%About 32k total data points
T1 = T(1:22400,{'Age' 'Workclass' 'fnlwgt' 'education' 'educationNum' 'maritalStatus' 'occupation' 'relationship' 'race' 'sex' 'capitalGain' 'capitalLoss' 'hoursPerWeek' 'nativeCountry' 'MoneyOrNo'});
Test = T(22401:32000,{'Age' 'Workclass' 'fnlwgt' 'education' 'educationNum' 'maritalStatus' 'occupation' 'relationship' 'race' 'sex' 'capitalGain' 'capitalLoss' 'hoursPerWeek' 'nativeCountry' 'MoneyOrNo'});

model = fitcnb(T1,T1.MoneyOrNo);

cpre = predict(model,Test);
correct = 0;
wrong = 0;
for i = 1:9600
    T1 = Test.MoneyOrNo(i);
    Actual1 = cpre(i);
   if(T1{1} == Actual1{1})
        correct = correct + 1;
   else
       wrong = wrong + 1;
   end
end
wrong
correct
crossvalidation = crossval(model,'KFold',5);
defaultLoss = kfoldLoss(crossvalidation)
