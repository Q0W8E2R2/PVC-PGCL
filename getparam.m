function [gamma1,gamma2] =getparam(dataname,p)
if dataname =="CUB"
    if p ==0.1
        gamma1 = 10;gamma2=10;
    elseif p==0.3 || p==0.5 ||p==0.7
        gamma1 = 10;gamma2=1;
    elseif p==0.9
        gamma1 = 10;gamma2=1000;
    end
elseif dataname =="RGB-D"
    if p ==0.1
        gamma1 = 1;gamma2=10;
    elseif p==0.3 || p==0.7 ||p==0.9
        gamma1 = 1;gamma2=1000;
    elseif p==0.5
        gamma1 = 1;gamma2=100;
    end
elseif dataname =="UCI"
    if p ==0.1 || p==0.3 || p==0.5 ||p==0.7
        gamma1 = 10;gamma2=1;
    elseif p==0.9
        gamma1 = 10;gamma2=10;
    end
elseif dataname == "LandUse-21"
    gamma1 = 0.1;gamma2=10000;
elseif dataname =="Caltech101-20"
    if p ==0.1
        gamma1 = 1000;gamma2=1;
    elseif p==0.5 || p==0.7 ||p==0.9
        gamma1 = 100;gamma2=1;
    elseif p==0.3
        gamma1 = 100000;gamma2=1;
    end
elseif dataname =="Scene-15"
    if p ==0.1 || p ==0.5
        gamma1 = 0.1;gamma2=1000;
    elseif p==0.3 ||p==0.9
        gamma1 = 0.1;gamma2=10000;
    elseif p==0.7
        gamma1 = 1;gamma2=10000;
    end
elseif dataname =="YaleFace"
    if p ==0.1 
        gamma1 = 0.1;gamma2=1;
    elseif p==0.3
        gamma1 =0.01;gamma2=0.01;
    elseif p==0.5 
        gamma1 = 10;gamma2=0.1;
    elseif p==0.7
        gamma1 = 100;gamma2=0.1;
    elseif p==0.9
        gamma1 = 0.1;gamma2=100;
    end
elseif dataname =="ALOI"
  gamma1 = 1;gamma2=1;
end