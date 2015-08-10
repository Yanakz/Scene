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

    computeSaliencyMaps(p);
    
    disp(split);
end
refinemap();
toc;