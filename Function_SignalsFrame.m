function [SigFramed, LabFramed] = Function_SignalsFrame(Sig, Lab, stride, m)

%initialization
  SigFramed = [];
  LabFramed = [];
  
  
  for j=1:length(Sig)
    %storing each signal with a number 
    sig = Sig{j};
    sigLab = Lab{j};
    M = length(sig);
    N = floor((M-m-1)/stride);
    
    for k=0:N
        
      %storing signals column wise
      SignalFramed{k+1,1} = sig(:,k*stride+1:k*stride+m);
      
      %categorical is display in categories without colon
      SignalFramedLabels{k+1,1} = categorical(sigLab(k*stride+1:k*stride+m))';
    end
    
    if N <= 0
      SignalFramed = { sig(:,1:m) };
      SignalFramedLabels = { categorical(sigLab(1:m))' };
    end
    
    % concatenation one after the other
    % all the framed_signals and their labels come in one variable
    %nearly 12200 frames of signals
    SigFramed = [ SigFramed; SignalFramed ];
    LabFramed = [ LabFramed; SignalFramedLabels ];
  end
end
