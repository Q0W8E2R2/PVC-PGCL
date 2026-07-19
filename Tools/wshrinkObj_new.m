function [x,objV] = wshrinkObj(x,rho,sX, isWeight,mode)

if isWeight == 1
    C = sqrt(sX(3)*sX(2));
end
if ~exist('mode','var')
    mode = 1;
end

X=reshape(x,sX);
if mode == 1
    Y=X2Yi(X,3);
elseif mode == 3
    Y=shiftdim(X, 1);
else
    Y = X;
end

Yhat = fft(Y,[],3);
objV = 0;
if mode == 1
    n3 = sX(2);
elseif mode == 3
    n3 = sX(1);
else
    n3 = sX(3);
end

if mod(n3, 2) == 0
    endValue = int16(n3/2+1);
    for i = 1:endValue
        [uhat,shat,vhat] = svd(full(Yhat(:,:,i)),'econ');
        
        if isWeight
            weight = C./(diag(shat) + eps);
            tau = rho*weight;
            shat = soft(shat,diag(tau));
        else
            tau = rho;
            shat = max(shat - tau,0);
        end                 
        
        objV = objV + sum(shat(:));
        Yhat(:,:,i) = uhat*shat*vhat';
        if i > 1
            test1 = n3-i+2;
            Yhat(:,:,n3-i+2) = conj(uhat)*shat*conj(vhat)';
            objV = objV + sum(shat(:));
%             disp([i,test1]);
        end
    end
%     [uhat,shat,vhat] = svd(full(Yhat(:,:,endValue+1)),'econ');
%     if isWeight
%        weight = C./(diag(shat) + eps);
%        tau = rho*weight;
%        shat = soft(shat,diag(tau));
%     else
%        tau = rho;
%        shat = max(shat - tau,0);
%     end
%     
%     objV = objV + sum(shat(:));
%     Yhat(:,:,endValue+1) = uhat*shat*vhat';
else
   endValue = int16(n3/2+1);
    for i = 1:endValue
%         temp_i = Yhat(:,:,i);
        [uhat,shat,vhat] = svd(full(Yhat(:,:,i)),'econ');
        if isWeight
            weight = C./(diag(shat) + eps);
            tau = rho*weight;
            shat = soft(shat,diag(tau));
        else
            tau = rho;
            shat = max(shat - tau,0);
        end
        objV = objV + sum(shat(:));
        Yhat(:,:,i) = uhat*shat*vhat';
%          temp_i=Yhat(:,:,i);
        if i > 1
            test1 = n3-i+2;
%             disp([i,test1]);
            Yhat(:,:,n3-i+2) = conj(uhat)*shat*conj(vhat)';
            objV = objV + sum(shat(:));
        end
    end 
end

Yhat_new = fft(Y,[],3);
if isinteger(n3/2)
    endValue = int16(n3/2+1);
    for i = 1:endValue
        [uhat,shat,vhat] = svd(full(Yhat_new(:,:,i)),'econ');
        
        if isWeight
            weight = C./(diag(shat) + eps);
            tau = rho*weight;
            shat = soft(shat,diag(tau));
        else
            tau = rho;
            shat = max(shat - tau,0);
        end                 
        
        objV = objV + sum(shat(:));
        Yhat_new(:,:,i) = uhat*shat*vhat';
        if i > 1
            Yhat_new(:,:,n3-i+2) = conj(uhat)*shat*conj(vhat)';
            objV = objV + sum(shat(:));
        end
    end
    [uhat,shat,vhat] = svd(full(Yhat_new(:,:,endValue+1)),'econ');
    if isWeight
       weight = C./(diag(shat) + eps);
       tau = rho*weight;
       shat = soft(shat,diag(tau));
    else
       tau = rho;
       shat = max(shat - tau,0);
    end
    
    objV = objV + sum(shat(:));
    Yhat_new(:,:,endValue+1) = uhat*shat*vhat';
else
   endValue = int16(n3/2+1);
    for i = 1:endValue
        temp_i = Yhat(:,:,i);
        [uhat,shat,vhat] = svd(full(Yhat_new(:,:,i)),'econ');
        if isWeight
            weight = C./(diag(shat) + eps);
            tau = rho*weight;
            shat = soft(shat,diag(tau));
        else
            tau = rho;
            shat = max(shat - tau,0);
        end
        objV = objV + sum(shat(:));
        Yhat_new(:,:,i) = uhat*shat*vhat';
%          temp_i=Yhat_new(:,:,i);
        if i > 1
            test1 = n3-i+2;
%             disp([i,test1]);
            Yhat_new(:,:,n3-i+2) = conj(uhat)*shat*conj(vhat)';
            objV = objV + sum(shat(:));
        end
    end 
end




Y = ifft(Yhat,[],3);
Y_new = ifft(Yhat_new,[],3);
try
   [I, J, K] = ind2sub(size(Yhat), find(Yhat ~= Yhat_new)); 
disp(['数值不同的具体坐标 [行, 列, 页]：']); disp([I, J, K]);
catch ME
    fprintf('程序报错了: %s\n', ME.message);
    fprintf('报错位置: %s, 行号: %d\n', ME.stack(1).name, ME.stack(1).line);
    keyboard; 
    
    
end

if mode == 1
    X = Yi2X(Y,3);
elseif mode == 3
    X = shiftdim(Y, 2);
else
    X = Y;
end

x = X(:);

end
 