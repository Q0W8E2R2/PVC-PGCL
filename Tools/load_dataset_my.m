function [X, gt] = load_dataset_my(dataName)
%     dsPath = 'Datasets\';
    dsPath = 'dataset\';
    ds = {dataName};
    dataName = ds{1};
    %% my_UCI
    if strcmp(dataName,'my_UCI')
          load(strcat(dsPath,dataName));
          X{1} = X1;  X{2} = X2;  X{3} = X3;Y = gt;
    end
    %% my_BBCSport
    if strcmp(dataName,'my_BBCSport')
        load(strcat(dsPath,dataName));
        X{1} = X1;  X{2} = X2;
        Y = gt;
    %     detapara=1.000000, m=50.000000 gamma=1000.000000
    end
    %% my_NGs
    if strcmp(dataName,'my_NGs')
        load(strcat(dsPath,dataName));
        X{1}=X1;X{2}=X2;X{3}=X3;
        Y=gt;
    end
    %% CUB
    if strcmp(dataName,'CUB')
        load(strcat(dsPath,dataName));
        gt = Y;
        X = X';
    end
    %% BBC
    if strcmp(dataName,'BBC')
        load(strcat(dsPath,dataName));
        gt = Y;
        X = X';
    end
    
    %% 100leaves
    if strcmp(dataName,'100leaves')
        load(strcat(dsPath,dataName));
        gt = Y;
    end
    %% Citeseer
    if strcmp(dataName,'citeseer')
        load(strcat(dsPath,dataName));
        X{1} = double(X{1}');  X{2} = double(X{2}');
        Y = double(Y);
        gt = Y;
    end
    %% BDGP
    if strcmp(dataName,'BDGP')
        load(strcat(dsPath,dataName));
        X{1} = double(X1');  X{2} = double(X2');
        Y = double(Y');
        gt = Y;
    end
    %% scene15
    if strcmp(dataName,'Scene-15')
         load(strcat(dsPath,dataName));
         X{1} = X{1}';  X{2} = X{2}';  X{3} = X{3}';
         gt = Y;
    end
    %% MNIST-USPS
    if strcmp(dataName,'MNIST-USPS')
        load(strcat(dsPath,dataName));
        X{1}=X1';X{2}=X2';
        Y = double(Y');
        gt =Y;
    end
    %% AWA
    if strcmp(dataName,'AWA')
         load(strcat(dsPath,dataName));
         X=X';
         gt = Y;      
    end
    %% MNIST_fea
    if strcmp(dataName,'MNIST_fea')
        load(strcat(dsPath,dataName));
        X{1} = X{1}';X{2} = X{2}';X{3} = X{3}';
        X=X';
        gt = Y;
    end
    %% YoutubeFace_sel_fea
    if strcmp(dataName,'YoutubeFace_sel_fea')
        load(strcat(dsPath,dataName));
        X=X';
        minY  = min(Y);
        maxY = max(Y);
        gt = Y;
        for i =1:length(X)
        X{i}=X{i}';
        end
    end
     if strcmp(dataName,'3sources')
        load(strcat(dsPath,dataName));
        X = data;
        Y = truelabel{1}';
        gt = Y;
    end
    if strcmp(dataName,'ORL_3views')
        load(strcat(dsPath,dataName));
        X{1} = x1';X{2} = x2';X{3} = x3';
        Y = gt;
        
    end
   if strcmp(dataName,'COIL20_3views')
        load(strcat(dsPath,dataName));
        X{1} = x1';X{2} = x2';X{3} = x3';
        Y = gt;
        
   end

    view = length(X);
    fprintf('dataset:%s view:%f num:%f \n',dataName,view,size(X{1},2));
    fprintf('class:%d minY:%d maxY:%d \n',length(unique(gt)),min(gt),max(gt));
    for i = 1:view
        norms = sqrt(sum(X{i}.^2, 1));
        norms(norms == 0) = 1e-16; 
        X{i} = X{i} ./ repmat(norms, size(X{i}, 1), 1);
        fprintf('view:%d dim:%d \n',i,size(X{i},1));
    end
end
