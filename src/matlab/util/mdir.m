function abs_path = mdir( rel_path, act_path )
    if nargin < 2
            act_path = pwd;
    end
    abs_path = abspath(rel_path, act_path, false);
    if ~exist(abs_path, 'dir')
        mkdir(abs_path);
    end
end

