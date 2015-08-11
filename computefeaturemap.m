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



addpath(genpath(pwd));
dic = './data/stimuli/';
pic_path = fullfile(dic,'*.jpg');
dir_dic = dir(pic_path);

%load parameters and initialize gbvs
gaborArray = gaborFilterBank(5,8,29,29); 
l = length(dir_dic);
cd ./lib/gbvs
gbvs_install
cd ../
cd ../
for i=1:length(dir_dic)    
    %load images and resize. Here we use 256 X 256.
    str = strcat(dic,dir_dic(i).name);
    img = im2double(imread(str));    
    [hs,ws,~] =size(img);
    y_scale = 256/hs;
    x_scale = 256/ws; 
    img = imresize(img,[256,256]);
    [h,w,~] = size(img);

    %compute itti feature-- color, intensity
    compute_ittifeature(img,i,h,w);
    %compute gabor feature in 5 scales. 
    compute_gaborfeature(img,gaborArray,i);
    %compute horizon line.
    compute_horizonfeature(img,256,i);
    
    %compute structural feature and DTS map.
    label = importdata('./myfunc/str_label.mat');
    compute_structurefeature(label,i,h,w,x_scale,y_scale);
      
    fprintf('processing...%d\n',i);
    
end
