close all;
clear;
addpath(genpath(pwd));

% I = imread('test_dir/images/130.jpg');
I = imread('/home/open/scene-saliency/data/stimuli/001.jpg');
I = im2double(I);

% B = edge(rgb2gray(I),'canny',0.4,0.5);
% imshow(B);
% c =  load('/home/open/src/GeometricContext/data/classifiers_08_22_2005.mat');
% [labels, conf_map, maps, pmaps] = APPtestImage(I, [], ...
%     c.vert_classifier,c.horz_classifier,c.segment_density);

c =  load('/home/open/src/GeometricContext/data/ijcvClassifier.mat');
[pg, data, imsegs] = ijcvTestImage(I, [], c);


[cimages, cnames] = pg2confidenceImages(imsegs, {pg});
% only keep ground pourous sky vertical [1 5 7 8]
geom_c_map = cimages{1}(:,:,[1 5 7 8]);

ground = geom_c_map(:,:,1);
pourous = geom_c_map(:,:,2);
sky = geom_c_map(:,:,3);
vertical = geom_c_map(:,:,4);

figure;
subplot(2,2,1);
imshow(ground);

subplot(2,2,2);
imshow(pourous);

subplot(2,2,3);
imshow(sky);

subplot(2,2,4);
imshow(vertical);
%===================================
% geom_c_map = cimages{1}(:,:,[2 3 4 6]);
% 
% ground = geom_c_map(:,:,1);
% pourous = geom_c_map(:,:,2);
% sky = geom_c_map(:,:,3);
% vertical = geom_c_map(:,:,4);
% 
% figure;
% subplot(2,2,1);
% imshow(ground);
% 
% subplot(2,2,2);
% imshow(pourous);
% 
% subplot(2,2,3);
% imshow(sky);
% 
% subplot(2,2,4);
% imshow(vertical);



