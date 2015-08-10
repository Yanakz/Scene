function [og,os,ov,semap] = toline2(input_g,input_s,input_v)
%TOLINE2 Summary of this function goes here
%   Detailed explanation goes here
[h,w,~] = size(input_g);

map = zeros(h,w);
pg = map;
ps = map;
pv = map;


for i = 1:h
    for j = 1:w
        [~,id] = max([input_g(i,j),input_s(i,j),input_v(i,j)]);
        
        if id == 1
            pg(i,j) =1;
        end
        if id == 2
            ps(i,j) =1;
        end
        if id == 3
            pv(i,j) =1;
        end
               
        
    end
end
% se = strel('disk',10);
og = pg;%imclose(pg,se);
os = ps;%imclose(ps,se);
ov = pv;%imclose(pv,se);
% 
% subplot(1,3,1);imshow(pg);
% subplot(1,3,2);imshow(ps);
% subplot(1,3,3);imshow(pv);

ocgsum = sum(og,1);

fssum = sum(os,1);
hsid = max(fssum);


hid = max(ocgsum);

if hsid+hid>size(og,1)
    hid = hsid;
else
    hid = size(og,1)-hid;
end
% h_range = hid-35:hid+34;
h_range = hid-30:hid+29;
if(hid+34>size(og,1))
    h_range = hid-35:size(og,1);
end

semap = zeros(size(og,1));
semap(h_range,:)=1;


end

