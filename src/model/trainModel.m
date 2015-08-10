function trainModel(params, split)
% trainModel(params)
%
% ----------------------------------------------------------------------
% Matlab tools for "Predicting human gaze beyond pixels," Journal of Vision, 2014
% Juan Xu, Ming Jiang, Shuo Wang, Mohan Kankanhalli, Qi Zhao
%
% Copyright (c) 2014 NUS VIP - Visual Information Processing Lab
%
% Distributed under the MIT License
% See LICENSE file in the distribution folder.
% -----------------------------------------------------------------------
% gb = {'g11','g12','g13','g14',...
%     'g21','g22','g23','g24',...
%     'g31','g32','g33','g34',...
%     'g41','g42','g43','g44',...
%     'g51','g51','g53','g54'};
% gb = {'g1','g2','g3','g4','g5'};
features = {'bmcolor','color','intensity','g1','g2','gvbound'};
load(fullfile(params.path.data, 'splits.mat'));


trainingImgs = splits(split).files.train;
testingImgs = splits(split).files.test;

models = cell(1, 1);

[X, Y] = sampling(params, trainingImgs, features);
model = training_mkl(X, Y);
model.trainingImgs = trainingImgs;
model.testingImgs = testingImgs;
models{1} = model;


save(fullfile(params.path.data, 'model_mkl.mat'), 'models', 'features');