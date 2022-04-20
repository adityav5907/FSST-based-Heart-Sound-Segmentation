clear
close all

%length of signal
LenSignal = 2000;

%get signals labels and features from the function loadninputdata
[Sig, Lab] = Function_loadDataInput();

%returns the length of signals 
SignalsLength = cellfun(@(x) length(x), Sig);

%only signals greater than 2000 i.e., signal length are allowed
%others equal to zero
Lab = Lab(SignalsLength >= LenSignal);
Sig = Sig(SignalsLength >= LenSignal);

%all the data in one variable
[SigFramed, LabFramed] = Function_SignalsFrame(Sig, Lab, 1000, 2000);

%transpose and call of function kfolds
grps = Function_foldsK(SigFramed', LabFramed', 10);

%extracting features for one of the groups out of 10
[trainWFE, valWFE, testWFE] = WithoutFeatureExtraction(grps{1}, 1000);

%all rows of second column 
labelsTrain = grps{1}.train(:,2);
labelsTest = grps{1}.test(:,2);

%trained network as net
%info has information of validation accuracy, mini batch accuracy,
%validation loss, minibatch loss
[net, info] = Function_training(grps{1}.train(:,2), trainWFE, valWFE, grps{1}.validation(:,2));

%predTrain is predicted value of labels on the training data
%trainScores is a n*k matrix
[trainPred, scoresTrain] = classify(net,trainWFE,'MiniBatchSize',50);

%PredTest is the predicted value for test data
%scores for some sample data
[testPred, scoresTest] = classify(net,testWFE,'MiniBatchSize',50);

%Confusion matrix using preducted and original labels
%Row summary row-normalized show the percentage of correct and
%incorrect observations for true classes.
figure
confusionchart([labelsTrain{:}],[trainPred{:}],'RowSummary','row-normalized','ColumnSummary','column-normalized','Title','Training');

%Column summary column normalized show the percentage of correct and
%incorrect observations for each predicted class
%as percentages of the number of observations of the corresponding predicted class.
figure
confusionchart([labelsTest{:}],[testPred{:}],'RowSummary','row-normalized','ColumnSummary','column-normalized','Title','Testing');

%the Receiver Operation Characteristic (ROC) curve
%all labels in a single variable
Lab = [labelsTest{:}];

%all scores in a single variable
%stacked all scores increasing row numbers
scrs = [scoresTest{:}];

Function_rocCurveMultipleClass(Lab, scrs, {'S1','Systole','S2','Diastole'});
