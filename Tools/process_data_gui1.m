function [X,gt,gt_new] = process_data_gui1(X,gt,gt_new)
    view = length(X);
    fprintf('归一化处理  view:%f num:%f \n',view,size(X{1},1));
    fprintf('class:%d minY:%d maxY:%d \n',length(unique(gt)),min(gt),max(gt));
    for i = 1:view
        X{i} = double(X{i}');
        norms = sqrt(sum(X{i}.^2, 1));
        norms(norms == 0) = 1e-16; 
        X{i} = X{i}./ repmat(norms, size(X{i}, 1), 1);
        fprintf('view:%d dim:%d \n',i,size(X{i},1));
        if size(gt_new{i},1)==1
            gt_new{i}=gt_new{i}';
        end
    end
    if size(gt,1)==1
        gt=gt';
    end
    
end