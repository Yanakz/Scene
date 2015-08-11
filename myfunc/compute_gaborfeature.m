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


function  compute_gaborfeature(img,gaborArray,i)

[~,gaborResult] = gaborFeatures(img,gaborArray,4,4);
gb_av = gaborResult;
% for m = 1:5
%     for n = 1:8
%         gbf = abs(gb_av{m,n});
%         gbf = normalise(gbf);
%         str = strcat('./data/featuremap/g',num2str(m),num2str(n),'/');
%         di = exist(str,'dir');
%         if(di==0)
%             mdir(str);
%         end
%         name_str = strcat(str,num2str(i,'%.3d'),'.jpg');
%         imwrite(gbf,name_str,'jpg');
%     end
% end


for m = 1:5
    gbtemp = zeros(256,256);
    for n = 1:8
        gbf = abs(gb_av{m,n});
        gbf = normalise(gbf);
        gbtemp = gbtemp+gbf;
    end
    gbtemp = gbtemp/8;
    str = strcat('./data/featuremap/g',num2str(m),'/');
    di = exist(str,'dir');
    if(di==0)
        mdir(str);
    end
    name_str = strcat(str,num2str(i,'%.3d'),'.jpg');
    imwrite(gbtemp,name_str,'jpg');
    
end

end

