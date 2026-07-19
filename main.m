function [] = main(data,y_new,aligned_sample_index,unaligned_sample_index,y_raw,dataname,p,flag,paramflag)

[Xs,y_raw,y_new] = process_data_gui1(data,y_raw,y_new);
data_size = size(Xs{1},2);
view = length(Xs);
Xa = cell(1,view);
Xu = cell(1,view);
N = data_size;
aligned_sample_index_old =aligned_sample_index+1;
if flag =="all_unalign"
    aligned_sample_index = [];
    unaligned_sample_index = 1:N;
elseif flag =="order_half_unalign"
    aligned_sample_index = 1:ceil(5*N/10);
    unaligned_sample_index =  setdiff(1:N, aligned_sample_index);
elseif flag =="pvp"
    aligned_sample_index = aligned_sample_index+1;
    unaligned_sample_index = unaligned_sample_index +1;
end
for v = 1:view
    Xa{v} = Xs{v}(:, aligned_sample_index);
    Xu{v} = Xs{v}(:, unaligned_sample_index );
end
fprintf("\n实际对齐样本数:%d   对齐样本数:%d\n",length(aligned_sample_index_old),length(aligned_sample_index));
y_raw = double(y_raw);
gt_a = double(y_raw(aligned_sample_index,:));
gt_u_cell = cell(1,view);
for v =1:view
    y_new{v} = double(y_new{v});
    gt_u_cell{v} = double(y_new{v}(unaligned_sample_index,:));
end
As = cell(1,view);
k = length(unique(y_raw));

mlist = [0.1]*data_size;
lambda1 = 1e0;
lambda2 = 1e0;
if paramflag =="tune"
    gamma1list = [1e-1,1e-3,1e-2,1e0,1e1,1e2,1e3,1e4,1e5];
    gamma2list = [1e3,1e-3,1e-2,1e-1,1e0,1e1,1e2,1e4,1e5];
elseif paramflag=="fix"
    [gamma1,gamma2]=getparam(dataname,p);
    gamma1list = [gamma1];
    gamma2list = [gamma2];
end

for midx = 1:length(mlist)
    m = round(mlist(midx));
    for v = 1:view
        stream = RandStream.getGlobalStream;
        reset(stream);
        [~,Av] = litekmeans(Xs{v}', m, 'MaxIter', 1000, 'Replicates', 50);
        Av = Av';
        As{v} = Av;
    end

    for g1idx = 1:length(gamma1list)
        for g2idx = 1:length(gamma2list)
            gamma1 = gamma1list(g1idx);
            gamma2 = gamma2list(g2idx);
            fprintf("m:%d,lambda1:%f,lambda2:%f,gamma1:%f,gamma2:%f\n", ...
                m,lambda1,lambda2,gamma1,gamma2);
            [sil_score, db_score, res] = ...
                PVC_PGCL(Xs, Xu, Xa, As, aligned_sample_index, ...
                unaligned_sample_index, y_new, ...
                lambda1, lambda2, gamma1, gamma2,flag);
            fprintf("----------------------------------------------------------------\n");



        end %
    end %
end %

fprintf("-------------------------------------*********************************------------------------------\n");