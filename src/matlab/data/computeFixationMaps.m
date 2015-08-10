function computeFixationMaps(params)
% computeFixationMaps(params)
%
% ----------------------------------------------------------------------
% Matlab tools for "Saliency in crowd," ECCV, 2014
% Ming Jiang, Juan Xu, Qi Zhao
%
% Copyright (c) 2014 NUS VIP - Visual Information Processing Lab
%
% Distributed under the MIT License
% See LICENSE file in the distribution folder.
% -----------------------------------------------------------------------

load(fullfile(params.path.eye, 'fixations.mat'));

outputPath = params.path.maps.fixation;
if ~exist(outputPath, 'dir')
    mkdir(outputPath);
end

for i = 1 : params.nStimuli
    filename = params.stimuli{i};
    shortname = filename(1 : end - length(params.ext));
    img = im2double(imread(fullfile(params.path.stimuli, filename)));
    [h w ~] = size(img);
    map = zeros([256 256]);
    
    y_scale = 256/h;
    x_scale = 256/w;
    
    
    fix_x = [];
    fix_y = [];
    fix_duration = [];
    for j = 1:size(fixations,2)%length(fixations{i}.subjects)
        sub = fixations{i,j};%{i}.subjects{j};
        if(isempty(sub))
            continue;
        end
        fix_x = [fix_x; max(1, min(round(sub(:,2)*x_scale), 256))];
        fix_y = [fix_y; max(1, min(round(sub(:,1)*y_scale), 256))];
        fix_duration = [fix_duration ;sub(:,4)];
    end
    
    fix_x = floor(fix_x);
    fix_y = floor(fix_y);
    for k = 1 : length(fix_x)       
        map(fix_y(k), fix_x(k)) = 1;
    end
    
    fixationPts = map;
    save(fullfile(outputPath, [shortname '.mat']), 'fixationPts', 'fix_x', 'fix_y', 'fix_duration');
    map = imfilter(map, params.eye.gaussian);
    map = normalise(map);
%     map = s_bia(map);
    imwrite(map, fullfile(outputPath, filename));
end
end