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



function compute_ittifeature(img,i,h,w)

params = makeGBVSParams;
    params.ittiblurfrac = 0;
    params.channels = 'DIO';
    params.useIttiKochInsteadOfGBVS = 1;
    params.verbose = 0;
    params.salmapmaxsize = round( max(size(img))/8 );
    params.ittiDeltaLevels = [ 2 3 ];
    Itti = gbvs(img,params);       
    color = imresize(Itti.top_level_feat_maps{1},[h,w]);
    intensity =imresize(Itti.top_level_feat_maps{2},[h,w]);

    name_str = strcat('./data/featuremap/color/',num2str(i,'%.3d'),'.jpg');   
    str = './data/featuremap/color';
    di = exist(str,'dir');
    if(di==0)
        mdir(str);
    end    
    imwrite(color,name_str,'jpg');
    

    name_str = strcat('./data/featuremap/intensity/',num2str(i,'%.3d'),'.jpg');
    str = './data/featuremap/intensity';
    di = exist(str,'dir');
    if(di==0)
        mdir(str);
    end    
    imwrite(color,name_str,'jpg');
    imwrite(intensity,name_str,'jpg');


end