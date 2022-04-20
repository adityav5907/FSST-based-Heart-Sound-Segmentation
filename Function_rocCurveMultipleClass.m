function Function_rocCurveMultipleClass(lab,scrs,leg)

    figure
    grid on
    hold on
    
    %initializing auc vector
    %auc is area under curve 
    areaUCs = zeros(1,size(scrs,1));
    
    %size(scores,1) is 4
    for k=1:size(scrs,1)
        
        %scores(i,:) 1*14000 one row 
        %perfcurve has third as class 
        %x fpr, y tpr
        %~ above this tpr and below this fpr
        %auc is area under curve
        [X,Y,T,areaUC] = perfcurve(lab,scrs(k,:), int2str(k));
        fprintf("Class %d areaUC- %.3f\n", k, areaUC)
        areaUCs(k) = areaUC;
        plot(X,Y)
    end
    
    title('Receiver Operation Characteristic(ROC) Curve')
    xlabel('False positive rate(FPR)') 
    ylabel('True positive rate(TPR)')
    legend(leg)

    %average auc
    fprintf("Average AUC: %.3f\n", mean(areaUCs))
end