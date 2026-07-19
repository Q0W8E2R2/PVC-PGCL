%--------------------------------------------------------------------------
% This function takes an adjacency matrix of a graph and computes the 
% clustering of the nodes using the spectral clustering algorithm of 
% Ng, Jordan and Weiss.
% CMat: NxN adjacency matrix
% n: number of groups for clustering
% groups: N-dimensional vector containing the memberships of the N points 
% to the n groups obtained by spectral clustering
%--------------------------------------------------------------------------
% Copyright @ Ehsan Elhamifar, 2012
%--------------------------------------------------------------------------

function [groups,sil_score,ch_score,db_score] = SpectralClustering(CKSym,n)
sil_score =0;
ch_score=0;
db_score=0;
% ========================
% for reproduction
stream = RandStream.getGlobalStream;
reset(stream);
% rng(1234,'twister');
% ========================

warning off;
N = size(CKSym,1);
MAXiter = 1000; % Maximum number of iterations for KMeans 
REPlic = 20; % Number of replications for KMeans

% Normalized spectral clustering according to Ng & Jordan & Weiss
% using Normalized Symmetric Laplacian L = I - D^{-1/2} W D^{-1/2}
DN = diag( 1./sqrt(sum(CKSym)+eps) );
LapN = speye(N) - DN * CKSym * DN;
[uN,sN,vN] = svd(LapN);
kerN = vN(:,N-n+1:N);
for i = 1:N
    kerNS(i,:) = kerN(i,:) ./ norm(kerN(i,:)+eps);
end
groups = kmeans(kerNS,n,'maxiter',MAXiter,'replicates',REPlic,'EmptyAction','singleton');
data = kerNS;
my_clusters=groups;
eva_sil = evalclusters(data, my_clusters, 'silhouette');
sil_score = eva_sil.CriterionValues; % 提取数值，越大越好

% 计算 Calinski-Harabasz 指数<br/>
% 
eva_ch = evalclusters(data, my_clusters, 'CalinskiHarabasz');
ch_score = eva_ch.CriterionValues; % 提取数值，越大越好<br/><br/>

% 计算 Davies-Bouldin 指数<br/>

eva_db = evalclusters(data, my_clusters, 'DaviesBouldin');
db_score = eva_db.CriterionValues; % 提取数值，越小越好<br/><br/>