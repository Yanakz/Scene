dic = 'gvbound/';
dic_file = fullfile(dic,'*.jpg');
dic_dir = dir(dic_file);

l = length(dic_dir);

for i = 1:l
    img = imread(strcat(dic,dic_dir(i).name));
    
    img = zeros(256,256);
    img(95:100,:)=1;

    img = antonioGaussian(img,2);
    
    
    imshow(img);
    pause;
    
   
    
    
    
    
end
