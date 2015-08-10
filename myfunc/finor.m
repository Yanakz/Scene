function filmap = finor( inmap,p )
%FINOR Summary of this function goes here
%   Detailed explanation goes here

   map = imfilter(inmap, p.eye.gaussian);
   filmap = normalise(map);
end

