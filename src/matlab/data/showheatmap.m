function showheatmap(p,n)
%SHOWHEATMAP Summary of this function goes here
%   Detailed explanation goes here
if(nargin ==1)
    n=1;
end
    
load(fullfile(p.path.tidy, 'fixations.mat'));
load(fullfile(p.path.tidy, 'imgInfo.mat'));

figure(1);
for i = n : p.nStimuli
    img = imread(fullfile(p.path.stimuli, p.stimuli{i}));
    subjData = vertcat(fixations{i, :});
    
    fix_x = max(1, min(ceil(subjData(:, 2)), imgInfo.size(i, 2)));
    fix_y = max(1, min(ceil(subjData(:, 1)), imgInfo.size(i, 1)));
    map = zeros(imgInfo.size(i,1),imgInfo.size(i,2));
    degree = min(imgInfo.size(i, 1),imgInfo.size(i, 2));
    degree_s = floor(degree/5);
    degree_c = floor(degree/25);
    
    H = fspecial('gaussian',[degree_s degree_s],degree_c);
    l = length(fix_x);
    for k = 1:l
        map(fix_y(k),fix_x(k))=1;
    end
    map = imfilter(map,H,'same');%'replicate'
    map = map/max(max(map));
    pause(5);
    clf;
    
    %Show eye data with img:
    
    subplot(2,2,1);
    imshow(img); 
    title('image');
    
    subplot(2,2,2);
    imshow(img);
    title('fixation');
    hold on;
    fix_x = floor(fix_x);
    fix_y = floor(fix_y);
    plot(fix_x, fix_y, 'o', 'LineWidth',2, 'MarkerEdgeColor','k', 'MarkerFaceColor','g', 'MarkerSize',10);

    
    subplot(2,2,3);   
    imshow(map);
    freezeColors;
    title('fixation map');
    

    subplot(2,2,4);    
    imshow(map);
    colormap(jet);
    title('heatmap');
%     colorbar;
%     axis off;
    
%     imagesc(map);
%     fix_x = floor(fix_x);
%     fix_y = floor(fix_y);
%     plot(fix_x, fix_y, 'o', 'LineWidth',2, 'MarkerEdgeColor','k', 'MarkerFaceColor','g', 'MarkerSize',10);
%     pause
    hold off;
%     clf;

end


end

