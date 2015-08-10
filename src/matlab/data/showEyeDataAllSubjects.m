function showEyeDataAllSubjects(p)

load(fullfile(p.path.tidy, 'fixations.mat'));
load(fullfile(p.path.tidy, 'imgInfo.mat'));

% Go through each data file one at a time
figure(1);
for i = 1 : p.nStimuli
    img = imread(fullfile(p.path.stimuli, p.stimuli{i}));
    subjData = vertcat(fixations{i, :});
    
    fix_x = max(1, min(ceil(subjData(:, 2)), imgInfo.size(i, 2)));
    fix_y = max(1, min(ceil(subjData(:, 1)), imgInfo.size(i, 1)));
    
    %Show eye data with img:
    
    imshow(img); hold on;
    
    fix_x = floor(fix_x);
    fix_y = floor(fix_y);
    plot(fix_x, fix_y, 'o', 'LineWidth',2, 'MarkerEdgeColor','k', 'MarkerFaceColor','g', 'MarkerSize',10);
    title(num2str(i));
    pause
    hold off;

end
