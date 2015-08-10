addpath(genpath(pwd));
dic = './data/stimuli/';
pic_path = fullfile(dic,'*.jpg');
dir_dic = dir(pic_path);
gaborArray = gaborFilterBank(5,8,29,29); 
c1 =  load('GeometricContext/data/ijcvClassifier.mat');
l = length(dir_dic);
cd ./lib/gbvs
gbvs_install
cd ../
cd ../
for i=1:length(dir_dic)    
    str = strcat(dic,dir_dic(i).name);
    img = im2double(imread(str));    
    [hs,ws,~] =size(img);
    y_scale = 256/hs;
    x_scale = 256/ws; 
    img = imresize(img,[256,256]);
    [h,w,~] = size(img);

    compute_ittifeature(img,i,h,w);
    compute_gaborfeature(img,gaborArray,i);
    compute_horizonfeature(img,256,i);
    
    label = importdata('./myfunc/structure_label.mat');
    compute_structurefeature(label,i,h,w,x_scale,y_scale);
      
    fprintf('processing...%d\n',i);
    
end