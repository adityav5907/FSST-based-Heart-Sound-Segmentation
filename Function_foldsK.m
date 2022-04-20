function grps = Function_foldsK(data, lab, k)

%the input arguments should not be less than three
  if nargin < 3
    k = 5;
  end
  
  %dividing data into k here 10 parts
  N = floor(length(data)/k);
  
  %initializing folds
  flds = {};
  
  %dividing data and corresponding labels in consecutive columns of folds 
  %into 10 parts
  for i=0:k-1
    flds{i+1,1} = data((i*N)+1:(i+1)*N);
    flds{i+1,2} = lab((i*N)+1:(i+1)*N);
  end
  
  
  % Check if there are any observation left without group
  m = mod(length(data),k);
  
  %if not equal to zero
  %adding the left data which didn't divide by dividing by 10
  %concatenation
  if m ~= 0   
    for p=1:m
      i_fld = mod(p,k);
      flds{i_fld,1} = [ flds{i_fld,1} data(end-p)];
      flds{i_fld,2} = [ flds{i_fld,2} lab(end-p)];
    end
  end
  
  %initialzing
  grps = {};
  
  %initialize with zero 
  arr_Log = false(1,k);
  
  %colun 2 to 10 will be 1
  arr_Log(2:k) = 1;
  
  
  for i=1:k
      
    %taking first row of folds as test data in columns 1 and 2
    testing = [ flds{arr_Log == 0,1}' flds{arr_Log == 0,2}' ];
    
    %from 2 to 10 removing the first one excpet test
    flds_train = [ flds(arr_Log,1) flds(arr_Log,2) ];
    
    %reshaping to get all the heart sound in one column for training
    training = [ reshape([ flds_train{:,1} ], [size([ flds_train{:,1} ],1)*size([ flds_train{:,1} ],2),1]) ...
              reshape([ flds_train{:,2} ], [size([ flds_train{:,2} ],1)*size([ flds_train{:,2} ],2),1]) ];
    
    %defining a strcuture
    grps{i,1} = struct();
    
    %putting train element in groups structure
    grps{i,1}.train = training;
    
    %putting validation in groups structure len*0.1 to end
    grps{i,1}.validation = [ testing(round(length(testing)*0.1):end,1) testing(round(length(testing)*0.1):end,2) ];
    
    %dividing into test set 1 to end-length*0.1-1
    grps{i,1}.test = [ testing(1:end-round(length(testing)*0.1)-1,1) testing(1:end-round(length(testing)*0.1)-1,2) ];
    
    %move zero forward in logical_array which will change the test data
    %from 1 to 2 and forward
    arr_Log = circshift(arr_Log,1);
  end
  
  
end
