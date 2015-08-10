function  fixmap  = gtmap( p,n,fix,info)

resize_onoff = 0;
max_image_size = 256;

if(nargin ==1)
    n=1;
end

% load(fullfile(p.path.tidy, 'fixations.mat'));
% load(fullfile(p.path.tidy, 'imgInfo.mat'));
fixations =fix;
imgInfo = info;

% [fi fj] = size(fixations);
% for i = 1:fi
%     for j = 1:fj
%         fixations{i,j}(3:end,:)=[];        
%     end
% end 
% 

    img = imread(fullfile(p.path.stimuli, p.stimuli{n}));
    subjData = vertcat(fixations{n, :});
%     h=  imgInfo.size(n,1);
%     w = imgInfo.size(n,2);
%     scale = max_image_size/min(imgInfo.size(n,1),imgInfo.size(n,2));
%     if min(imgInfo.size(n,1),imgInfo.size(n,2)) > max_image_size%change size
%         img = imresize(img, scale, 'bicubic');
% 
%         [h, w, ~] = size(img);
%     end
%     
if resize_onoff==1
    y_scale = max_image_size/imgInfo.size(n,1);
    x_scale = max_image_size/imgInfo.size(n,2);
    img = imresize(img, [256,256]);
else
    y_scale=1;
    x_scale=1;
end
    
    [h, w, ~] = size(img);
    
    fix_x = max(1, min(ceil(subjData(:, 2)), imgInfo.size(n, 2)));
    fix_y = max(1, min(ceil(subjData(:, 1)), imgInfo.size(n, 1)));
    fix_x = ceil(fix_x*x_scale);
    fix_y = ceil(fix_y*y_scale);
    
    
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
    fixmap = map;
% 
%     subplot(2,4,1); imshow(img);  title('image');
%     
%     subplot(2,4,2);   imshow(img);    title('fixation');
%      hold on;
%     fix_x = floor(fix_x);
%     fix_y = floor(fix_y);
%     plot(fix_x, fix_y, 'o', 'LineWidth',2, 'MarkerEdgeColor','k', 'MarkerFaceColor','g', 'MarkerSize',10);
%     hold off;
%     
%     subplot(2,4,3);    imshow(map);    title('fixation map');
%     freezeColors;
%     
%     subplot(2,4,4);    imshow(map);    colormap(jet);    title('heatmap');
%     freezeColors;
%     

  




end

