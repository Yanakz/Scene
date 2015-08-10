function compute_horizonfeature( img,dims,i )

h=getHorizon(img);

% Turn it into a map
HorizonMap=zeros(dims);
horizon=round((h+0.5)*dims(1));
HorizonMap(horizon-2:horizon+2, :)=1;
HorizonMap=antonioGaussian(HorizonMap, 2); % blur features
HorizonMap=HorizonMap/max(HorizonMap(:)); % make range 0-1
semap=HorizonMap;%(:);


str = './data/featuremap/gvbound/';
name_str = strcat(str,num2str(i,'%.3d'),'.jpg');
di = exist(str,'dir');
if(di==0)
    mdir(str);
end


imwrite(semap,name_str,'jpg');

end

