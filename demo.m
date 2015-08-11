% This Matlab script demonstrates the usage of this package.
%
% ----------------------------------------------------------------------
% Matlab tools for "Saliency Prediction with Scene Structural Guidance" in arxiv, 2015
% Haoran Liang, Ming Jiang, Ronghua Liang and Qi Zhao, 
%
% Copyright (c) 2015 NUS VIP - Visual Information Processing Lab
%
% Distributed under the MIT License
% See LICENSE file in the distribution folder.
% -----------------------------------------------------------------------

fprintf('Setting up the environment.\n');

% addpath(genpath(pwd));
addpath(genpath('src'));

% % initialize simplemkl
addpath(genpath('lib'));
cd ./lib/simplemkl
mex vectorize.c
mex vectorize_single.c
mex devectorize.c
mex devectorize_single.c
cd ../../

% load parameters
p = config;

fprintf('Computing fixation maps.\n');
tic;
computeFixationMaps(p);
toc;

fprintf('Computing feature maps.\n');
computefeaturemap;
% train and evaluate the saliency model with an n-fold cross validation
fprintf('Training and testing mkl model.\n');

tic;
splitData(p);
for split = 1:p.ml.nSplit
    trainModel(p, split);
    %compute the saliency map using trained model for each split.
    computeSaliencyMaps(p);    
end
%refine the saliency map using DTS map.
refinemap();
toc;