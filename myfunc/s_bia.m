function s_map= s_bia( map)
%S_BIA Summary of this function goes here
%   Detailed explanation goes here


[h,w] = size(map);

degree = min(h,w);
degree_s = floor(degree/5);
degree_c = floor(degree/25);

f=fspecial('gaussian',[degree_s degree_s],degree_c);
s_map = imfilter(map,f);
s_map = s_map./max(max(s_map));



end

