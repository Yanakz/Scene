function refinemap()

dic_map = './data/saliencymap/';
dic_bias = './data/featuremap/structure_bia/';
dr1 = dir(fullfile(dic_map,'*.jpg'));
dr2 = dir(fullfile(dic_bias,'*.jpg'));
for i = 1:length(dr1)
    im1 = im2double(imread([dic_map dr1(i).name]));
    im2 = im2double(imread([dic_bias dr2(i).name]));
    im = im1.*im2;
    str = './data/refined_saliencymap/';
    if(exist(str,'dir')==0)
        mdir(str);
    end
    name = strcat(str,num2str(i,'%.3d'),'.jpg');
    imwrite(im,name);
end

