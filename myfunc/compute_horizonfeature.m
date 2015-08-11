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



function compute_horizonfeature( img,dims,i )

h=getHorizon(img);

% Turn it into a map
HorizonMap=zeros(dims);
horizon=round((h+0.5)*dims(1));
HorizonMap(horizon-2:horizon+2, :)=1;
HorizonMap=antonioGaussian(HorizonMap, 2); % blur features
HorizonMap=HorizonMap/max(HorizonMap(:)); % make range 0-1
semap=HorizonMap;%(:);


str = './data/featuremap/gvbound/';
name_str = strcat(str,num2str(i,'%.3d'),'.jpg');
di = exist(str,'dir');
if(di==0)
    mdir(str);
end


imwrite(semap,name_str,'jpg');

end

