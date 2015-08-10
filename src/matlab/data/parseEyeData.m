function parseEyeData(p)

% for iImg = 1:p.nStimuli
%     img = imread(fullfile(p.path.stimuli, p.stimuli{iImg}));
%     imgInfo.size(iImg,:) = [size(img, 1), size(img, 2)];
% end

load(fullfile(p.path.tidy, 'imgInfo.mat'));

ascDir = mdir('asc', p.path.raw);
files = dir(fullfile(ascDir, '*.asc'));
names = {files.name};
nFiles = length(files);

for iFile = 1 : nFiles
    filename = names{iFile};
    fid = fopen(fullfile(ascDir, filename));
    tline = fgets(fid);
    flag_fix = 0;
    imgid = 0;
    while ischar(tline)
        word = textscan(tline, '%s');
        c = word{1};
        if size(c, 1) > 1
            if strcmp(c(1), 'MSG')
                if strcmp(c(3), 'DISPLAY_COORDS')
                    win_size = [str2double(c(7))-str2double(c(5))+1, ...
                        str2double(c(6)) - str2double(c(4)) + 1];
                elseif strcmp(c(3), 'IMAGESTART')
                    disp(c{4});
                    imgid = find(strcmp(c{4}, p.stimuli));
                    fix_x = [];
                    fix_y = [];
                    fix_latency = [];
                    fix_duration = [];
                    flag_fix = 0;
                    start_time = str2double(c{2});
                    img_h =imgInfo.size(imgid, 1);
                    img_w =imgInfo.size(imgid, 2);
                    scale_ratio = min(win_size(1)/img_h, win_size(2)/img_w);
                elseif strcmp(c(3), 'IMAGEEND')
                    fixations{imgid, iFile} = [fix_y, fix_x, fix_latency, fix_duration];
                    imgid = 0;
                end
            elseif strcmp(c(1), 'SFIX')
                if imgid > 0
                    flag_fix = 1;
                end
            elseif strcmp(c(1), 'EFIX')
                if flag_fix == 1
                    fl = sscanf(c{3}, '%f') - start_time;
                    fd = sscanf(c{5}, '%f');
                    fx = sscanf(c{6}, '%f');
                    fy = sscanf(c{7}, '%f');
                    fx = fx - (win_size(2) - img_w * scale_ratio) / 2;
                    fy = fy - (win_size(1) - img_h * scale_ratio) / 2;
                    fx = fx / scale_ratio;
                    fy = fy / scale_ratio;
                    if fx > 0 && fy > 0 && fx <= img_w && fy <= img_h
                        fix_x = [fix_x; fx];
                        fix_y = [fix_y; fy];
                        fix_duration = [fix_duration; fd/1000];
                        fix_latency = [fix_latency; fl/1000];
                    end
                    flag_fix = 0;
                end
            end
        end
        tline = fgets(fid);
    end
    
    fclose(fid);
end

save(fullfile(p.path.tidy, 'fixations.mat'), 'fixations');
end
