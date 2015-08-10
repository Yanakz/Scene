function savemap(p,n)
%SAVEMAP Summary of this function goes here
%   Detailed explanation goes here

max_image_size = 256;
%SHOWHEATMAP Summary of this function goes here
%   Detailed explanation goes here
if(nargin ==1)
    n=1;
end

load(fullfile(p.path.tidy, 'fixations.mat'));
load(fullfile(p.path.tidy, 'imgInfo.mat'));
% load(fullfile(p.path.tidy, 'InOut_label.mat'));
% c1 =  load('GeometricContext/data/ijcvClassifier.mat');
% 
% c2 =  load('GeometricContext/data/ijcvClassifier_indoor.mat');


% [fi fj] = size(fixations);
% for i = 1:fi
%     for j = 1:fj
%         fixations{i,j}(3:end,:)=[];        
%     end
% end 
% 



% figure(1);
for i = n : p.nStimuli
    img = imread(fullfile(p.path.stimuli, p.stimuli{i}));
    subjData = vertcat(fixations{i, :});
    h=  imgInfo.size(i,1);
    w = imgInfo.size(i,2);
    scale = max_image_size/min(imgInfo.size(i,1),imgInfo.size(i,2));
    if min(imgInfo.size(i,1),imgInfo.size(i,2)) > max_image_size%change size
        img = imresize(img, scale, 'bicubic');
        [h, w, ~] = size(img);
    end
    
    
    
    
    fix_x = max(1, min(ceil(subjData(:, 2)), imgInfo.size(i, 2)));
    fix_y = max(1, min(ceil(subjData(:, 1)), imgInfo.size(i, 1)));
    fix_x = ceil(fix_x*scale);
    fix_y = ceil(fix_y*scale);
    
    
    map = zeros(h,w);
    degree = min(h,w);
    degree_s = floor(degree/5);
    degree_c = floor(degree/25);
    
    H = fspecial('gaussian',[degree_s degree_s],degree_c);
    l = length(fix_x);
    for k = 1:l
        map(fix_y(k),fix_x(k))=1;
    end
    map = imfilter(map,H,'same');%'replicate'
    map = map/max(max(map));
    
    
    %123=========================
%     img = im2double(img);
%     
%     if(InOut_label(i)==1)
%         [pg, ~, imsegs] = ijcvTestImage(img, [], c1);
%     else
%         [pg, ~, imsegs] = ijcvTestImage(img, [], c2);
%     end
%     
%     [cimages, ~] = pg2confidenceImages(imsegs, {pg});
% 
%     geom_c_map = cimages{1}(:,:,[1 5 7 8]);
%     
% 
%     
%     ground = geom_c_map(:,:,1);
%     pourous = geom_c_map(:,:,2);
%     sky = geom_c_map(:,:,3);
%     vertical = geom_c_map(:,:,4);
    %123============
%     
%     geom_cont_feature = single(down_sample(geom_c_map, 8, 8));
%     geof = geom_cont_feature(:);

%     s_map = s_bia(ground,sky,vertical);
    
    %     u1 = geom_c_map2(:,:,1);
    %     u2 = geom_c_map2(:,:,2);
    %     u3 = geom_c_map2(:,:,3);
    %     u4 = geom_c_map2(:,:,4);
    %================================
    Itti = ittikochmap(img);
%     
%     pause;
%     clf;
    
    
    
    
    
    
    
    %Show eye data with img:
    
    subplot(2,4,1); imshow(img);  title(num2str(i));
    
    subplot(2,4,2);   imshow(img);    title('fixation');
     hold on;
    fix_x = floor(fix_x);
    fix_y = floor(fix_y);
    plot(fix_x, fix_y, 'o', 'LineWidth',2, 'MarkerEdgeColor','k', 'MarkerFaceColor','g', 'MarkerSize',10);
    hold off;
    
    subplot(2,4,3);    imshow(map);    title('fixation map');
    freezeColors;
    
    subplot(2,4,4);    imshow(map);    colormap(jet);    title('heatmap');
    freezeColors;
    

    
%     subplot(3,4,5);    imshow(ground);    title('ground');    colormap(gray);
%     subplot(3,4,6);    imshow(sky);    title('sky');
%     subplot(3,4,7);    imshow(pourous);   title('pourous');
%     subplot(3,4,8);    imshow(vertical);   title('vertical');
%     
%     
%     
    u1 = Itti.top_level_feat_maps{1};
    u2 = Itti.top_level_feat_maps{2};
    u3 = Itti.top_level_feat_maps{3};
    u4 = Itti.master_map_resized;
    
    subplot(2,4,5);   imshow(u1);    title('u1 color');   
    subplot(2,4,6);   imshow(u2);    title('u2 intensity');
    subplot(2,4,7);   imshow(u3);    title('u3 orientation');    
    subplot(2,4,8);   imshow(u4);    title('u4');
    
    pause;
    
    
%     name_str = strcat('outfig/biafig/',num2str(i,'%.3d'));
%     saveas(gcf,name_str,'jpg');
% %     
    %     colorbar;
    %     axis off;
    
    %     imagesc(map);
    %     fix_x = floor(fix_x);
    %     fix_y = floor(fix_y);
    %     plot(fix_x, fix_y, 'o', 'LineWidth',2, 'MarkerEdgeColor','k', 'MarkerFaceColor','g', 'MarkerSize',10);
    %     pause
%     
    %     clf;
    
end
%==========================================================================

% str = 'data/stimuli/004.jpg';
% I = imread(str);
% out = ittikochmap(I);
% B = edge(rgb2gray(I),'canny',);
%
% imshow(B);
% c =  load('/home/open/src/GeometricContext/data/classifiers_08_22_2005.mat');
% [labels, conf_map, maps, pmaps] = APPtestImage(I, [], ...
%     c.vert_classifier,c.horz_classifier,c.segment_density);



end

