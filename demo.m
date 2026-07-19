clear;clc;
% maxNumCompThreads(20);
addpath('Measurements','Datasets','Tools');
datanamelist = ["CUB","RGB-D","UCI","LandUse-21","Caltech101-20","Scene-15","YaleFace","ALOI100"];
datanamelist = ["YaleFace"];
unalign_plist =[0.1,0.3,0.5,0.7,0.9];

for dataidx = 1:length(datanamelist)
    dataname = datanamelist(dataidx);
    for p_idx = 1:length(unalign_plist)
        unalign_p = unalign_plist(p_idx);
        if dataname == "ALOI100" || dataname == "YaleFace"
            dataname_seed_p = strcat('dataset\unaligned\',dataname,'\', dataname,'_unaligned_p_',num2str(unalign_p),'_view3.mat');
        else
            dataname_seed_p = strcat('dataset\unaligned\',dataname,'\', dataname,'_unaligned_p_',num2str(unalign_p),'_view2.mat');
        end
        load(dataname_seed_p);
        view = length(data);
        dataname_seed_p_record = strcat('dataset\unaligned\',dataname,'\', dataname,'_aligned_p_',num2str(unalign_p),'_view',num2str(view),'.txt');
        diary(dataname_seed_p_record);
        main(data,y_new,aligned_sample_index,unaligned_sample_index,y_raw,dataname,unalign_p,"pvp","fix")
    end
    diary off;
end


