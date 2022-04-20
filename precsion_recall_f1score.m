%confusion matrix
con=confusionmat([labelsTest{:}],[testPred{:}]);

conf=con';

dgnl=diag(conf);
rowsSum=sum(conf,2);

%precision for each class
prcsn=dgnl ./ rowsSum


%overall precision
prcsnOverall=mean(prcsn)

columnsSum= sum(conf,1);

%recall for each class
rcll= dgnl ./ columnsSum';

%overall recall 
rcllOverall=mean(rcll);

prcsn=prcsn'
rcll=rcll'

%accuracy
sumofCM=sum(conf,'all');
accuracy=( (sumofCM-(columnsSum'+rowsSum)+2*dgnl) ./sumofCM);
accuracy=accuracy'
accuracy_overall=mean(accuracy)

%f1 score for each class
for i=1:length(prcsn)
    f1Scr(i)=2*((prcsn(i)*rcll(i))/(prcsn(i)+rcll(i)))
end

%overall f1 score    
f1ScrOverall=2*((prcsnOverall*rcllOverall)/(prcsnOverall+rcllOverall))

sensitivity=rcll;
overall_sensitivity=rcllOverall;

