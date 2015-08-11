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



function compute_structurefeature(label,i,h,w,x_scale,y_scale)


%struct
se = strel('disk',13);
strcmap = zeros(h,w);
strc = label{i};
if ~isempty(strc)
    strc(:,1) = fix(strc(:,1)*x_scale);
    strc(:,2) = fix(strc(:,2)*y_scale);
end
for j = 1:size(strc,1)
    strcmap(strc(j,2),strc(j,1))=1;
end

strcmap = imdilate(strcmap,se);
strcmap = antonioGaussian(strcmap,6);
name_str = strcat('./data/featuremap/structure/',num2str(i,'%.3d'),'.jpg');
str = './data/featuremap/structure/';
if(exist(str,'dir')==0)
    mdir(str);
end
imwrite(strcmap,name_str,'jpg');

%bias
strcmap = zeros(h,w);
if(size(strc,1)==0)
    strcmap = 1-strcmap;
    path = './data/featuremap/structure_bia/';
    name_str = strcat(path,num2str(i,'%.3d'),'.jpg');
    if(exist(path,'dir')==0)
        mdir(path);
    end   
    imwrite(strcmap,name_str,'jpg');
    
    return;
end
for m = 1:h
    for n = 1:w
        b1=(m-strc(:,2)).^2;
        b2=(n-strc(:,1)).^2;
        b3=min(b1+b2);
        b3 = floor(sqrt(b3));
        strcmap(m,n) = b3;
        
    end
end
path = './data/featuremap/structure_bia/';
strcmap = 1-strcmap/max(strcmap(:));
name_str = strcat(path,num2str(i,'%.3d'),'.jpg');
if(exist(path,'dir')==0)
    mdir(path);
end
imwrite(strcmap,name_str,'jpg');





end

