function [Sig, Lab] = Function_loadDataInput()

    %the dataset has 792 values of audio signals
    load('D:/10th sem/MTP-2/project new/Codes_heartSoundSegmentation/HeartSounds_dataset.mat')
    
    %labels and signals 
    Lab = springer_dataset.labels;
    Sig = springer_dataset.audio_data;
   
    %selecting first 100 signals
    Sig = Sig(1,1:2);
    Lab = Lab(1,1:2);
   
    
    %put all the signals in a cell so that they can open columnwise
    Sig = cellfun(@(x) x', Sig, 'UniformOutput', false);
    
end