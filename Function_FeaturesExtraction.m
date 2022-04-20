function [fsstSignalsTrain, fsstSignalsVal, fsstSignalsTest] = Function_FeaturesExtraction(data_frame, fs)
    
    %all train signals of group1 in trainsignals
    signalsTrain = data_frame.train(:,1);
    
    %initializing horizontal array of 1*length cells
    fsstSignalsTrain = cell(size(signalsTrain));
    
    %initializing vertical array of length*1 cells
    trainMean = cell(1,length(signalsTrain));
    trainStd = cell(1,length(signalsTrain));
    
    
    for j = 1:length(signalsTrain)
       disp("Training Feature extraction- " + j)
       
       %finding fsst 
       [s,w,~] = fsst(signalsTrain{j},fs,kaiser(128));
       
       %if((w>25)& (w < 200)) f=1 else f=0
       f = (w > 25) & (w < 200);
       
       %for f=1 consider for signalfssttrain
       %separated real and imaginary part
       %concatinated real and imaginary part aone after the other 44*2000
       fsstSignalsTrain{j} = [real(s(f,:)); imag(s(f,:))];

       %mean of each row in meanTrain 44*1
       trainMean{j} = mean(fsstSignalsTrain{j},2);
       %same as mean
       trainStd{j} = std(fsstSignalsTrain{j},[],2);
    end
    
    %standardizing the data
    %subtracting the mean and dividing by standard deviation
    standardizeFun = @(x) (x - mean(cell2mat(trainMean),2))./mean(cell2mat(trainStd),2);
    
    %Putting in a cell all the values
    fsstSignalsTrain = cellfun(standardizeFun,fsstSignalsTrain,'UniformOutput',false);
    
    %all validation signals of group1 in signalsVal
    signalsVal = data_frame.validation(:,1);
    %initializing horizontal array of 1*length cells
    fsstSignalsVal = cell(size(signalsVal));
    
    for j = 1:length(signalsVal)
       disp("Validation Feature extraction- " + j)
       
       %finding fsst
       [s,w,~] = fsst(signalsVal{j},fs,kaiser(128));
       
       %if((w>25)& (w < 200)) f=1 else f=0
       f =  (w > 25) & (w < 200);
       
       %for f=1 consider for signalfsstVal
       %separated real and imaginary part
       %concatinated real and imaginary part aone after the other 44*2000
       fsstSignalsVal{j}= [real(s(f,:)); imag(s(f,:))]; 
    end

    %standardizing the data
    %subtracting the mean and dividing by standard deviation
    fsstSignalsVal = cellfun(standardizeFun,fsstSignalsVal,'UniformOutput',false);
    
    %all test signals of group1 in signalsTest
    signalsTest = data_frame.test(:,1);
    %initializing horizontal array of 1*length cells
    fsstSignalsTest = cell(size(signalsTest));
    
    for j = 1:length(signalsTest)
       disp("Evaluation Feature extraction- " + j)
       
       %finding fsst
       [s,w,~] = fsst(signalsTest{j},fs,kaiser(128));
       
       %if((w>25)& (w < 200)) f=1 else f=0
       f =  (w > 25) & (w < 200);
       
       %for f=1 consider for signalfsstTest
       %separated real and imaginary part
       %concatinated real and imaginary part aone after the other 44*2000
       fsstSignalsTest{j}= [real(s(f,:)); imag(s(f,:))]; 
    end
    
    %standardizing the data
    %subtracting the mean and dividing by standard deviation
    fsstSignalsTest = cellfun(standardizeFun,fsstSignalsTest,'UniformOutput',false);
end
