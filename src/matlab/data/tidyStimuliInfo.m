function tidyStimuliInfo(p)

for iImg = 1:p.nStimuli
    img = imread(fullfile(p.path.stimuli, p.stimuli{iImg}));
    imgInfo.size(iImg,:) = [size(img, 1), size(img, 2)];
end

save(fullfile(p.path.tidy, 'imgInfo.mat'), 'imgInfo');