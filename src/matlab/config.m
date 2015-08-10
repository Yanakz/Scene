function p = config()
    p=[];
    %% path settings
    
    p.path.proj = mdir('./.');
    
    % data folders
    p.path.data = mdir('data', p.path.proj);
    p.path.stimuli = mdir('stimuli', p.path.data);
    p.path.tidy = mdir('tidy', p.path.data);
    p.path.raw = mdir('raw', p.path.data);
    p.path.tmp = mdir('tmp', p.path.data);
    
    % report folders
%     p.path.fig = mdir('fig', p.path.proj);
%     p.path.md = mdir('md', p.path.proj);
%     p.path.tex = mdir('tex', p.path.proj);
    
    %% expt params
    p.expt.nBlock = 5;
    p.expt.nTrial = 100;
    p.expt.viewingTime = 5;
    p.expt.waitingTime = 2;
    
    %% stimuli
    p.ext =  '.jpg';
    files = dir(fullfile(p.path.stimuli, ['*' p.ext]));
    p.stimuli = {files.name};
    p.nStimuli = length(files);
    
    
    p.path.data = [p.path.proj, '/data'];
%     p.path.stimuli = [p.path.data, '/stimuli'];
    p.path.maps.fixation = [p.path.data, '/fixation_maps'];
    
    p.path.labels = [p.path.data, '/labels'];
    p.path.eye = [p.path.data, '/tidy'];
    p.path.raw = [p.path.data, '/raw'];
    
    p.path.maps.feature = [p.path.data, '/featuremap'];
    p.path.maps.saliency = [p.path.data, '/saliencymap'];
    
    p.file.fixations = [p.path.eye, '/fixations.mat'];
    
    p.eye.radius = 8;
    
%     p.ext = '.jpg';
    
    p.out.sigma = 8;
    p.out.width = 256;
    p.out.height = 256;
    
    p.ml.nCrowdLevel = 1;
    p.ml.nSplit = 10;
    p = postConfig(p);


end



function [params] = postConfig( params )
winSize = ceil(params.eye.radius * 6);
params.eye.gaussian = fspecial('gaussian', [winSize winSize], params.eye.radius);

winSize = ceil(params.out.sigma * 6);
params.out.gaussian = fspecial('gaussian', [winSize winSize], params.out.sigma);

files = dir([params.path.stimuli, '/*', params.ext]);
params.stimuli = {files.name};
params.nStimuli = length(params.stimuli);
end