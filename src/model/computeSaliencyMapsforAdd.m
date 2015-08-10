



md = importdata('/home/open/Scene_lhr/addtion/model_mkl.mat');
models = md.models;
features = md.features;

outputPath = '/home/open/Scene_lhr/addtion/output';
if ~exist(outputPath, 'dir')
    mkdir(outputPath);
end

img_dic = '/home/open/Scene_lhr/addtion/torontodata/toronto/';
img_file = fullfile(img_dic,'*.png');
img_dir = dir(img_file);
num_img = length(img_dir);
feature_path = '/home/open/Scene_lhr/addtion/torontodata/featuremap/';

h = 510;
w = 680;

model = models{1};
meanVec = model.whiteningParams(1, :);
stdVec = model.whiteningParams(2, :);
gaussian = fspecial('gaussian',[100,100],10);

for j = 1 :num_img
    
    
%     fileName = strcat(num2str(i),'.jpg');
    
     fileName = strcat(img_dir(j).name);
    
    %...........................
    
    allfeatures = zeros(1* h * w, length(features));
    for i = 1 : 1
        index = (i - 1) * h * w;
        for k = 1 : length(features)
            map = im2double(imread(strcat(feature_path, features{k},'/',num2str(j,'%.4d'),'.png')));
            map = imresize(map, [h w]);
            allfeatures(index + 1:index + h * w, k) = map(:);
        end
    end
    %.......................
    
    
    X = allfeatures;
    X = bsxfun(@minus, X, meanVec);
    X = X ./ repmat(stdVec, [size(X,1) 1]);
    
    Kt=mklkernel(X,model.InfoKernel,model.Weight,model.options,model.xapp,model.beta);
    predictions =Kt*model.w+model.b;
    
    map = reshape(predictions, [params.out.height params.out.width]);
    
    map = imfilter(map, gaussian,'replicate');
    map = normalise(map);
    
    imwrite(map, fullfile(outputPath, fileName));
end
