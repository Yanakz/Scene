function [oc_s_bw,oc_g_bw,oc_v_bw,gb_av,semap,c2] = toline(img, input_g,input_s,input_p,input_v,gbfeature )
%19-9-2014 by Haoran Liang
% [h,w,~] = size(img);

se = strel('disk',10);

oc_g = imclose(input_g,se);
oc_s = imclose(input_s,se);
oc_p = imclose(input_p,se);
oc_v = imclose(input_v,se);


oc_s_bw = imopen(oc_s,se);
oc_s_bw = im2bw(oc_s_bw,0.1);
oc_v = oc_v-oc_g-oc_s+oc_p;
oc_g_bw = oc_g - oc_v - oc_s-oc_s;






oc_g_bw(oc_g_bw<0)=0;
oc_g_bw = imopen(oc_g_bw,se);
normal_ocg = oc_g_bw./(max(max(oc_g_bw)));
fd = normal_ocg(normal_ocg~=0);
m_ocg = mean(fd);
oc_g_bw = im2bw(normal_ocg,m_ocg*0.5);
% imshow(oc_g_bw);





ocgsum = sum(oc_g_bw,1);
hid = max(ocgsum);
hid = size(img,1)-hid;

% h_range = hid-35:hid+34;
h_range = hid-4:hid+3;
if(hid+3>size(img,1))
    h_range = hid-4:size(img,1);
end

semap = zeros(size(oc_g_bw));
semap(h_range,:)=1;
% semap = filnor(semap);
% img_se = img(h_range,:,:);




oc_v(oc_v<0)=0;
oc_v = imopen(oc_v,se);
normal_ocv = oc_v./(max(max(oc_v)));
fd = normal_ocv(normal_ocv~=0);
m_ocv = mean(fd);
oc_v_bw = im2bw(normal_ocv,m_ocv*0.8);


cutmap = zeros(size(oc_v_bw));
cutmap(1:hid,:)=1;


c2 = cutmap.*(~oc_s_bw); 




c1 = sum(c2,1);
% en = entropy(c1)
if(max(c1)<=50)
    c1 = c2;
    c1(hid+1:hid+30,:)=1;
   
    c1 = s_bia(imerode(c1,se));
end


% 
[~,gaborResult] = gaborFeatures(img,gbfeature,8,8);
gb_av = gaborResult;%cell(5,1);
% for i = 1:5
%     for j = 1:8
%         if(j==1)
%             gb = abs(gaborResult{i,j});
%         end
%         gb = gb+abs(gaborResult{i,j});        
%     end
%     gb = gb/8;
%     gb_av{i} = gb;
%     
% end
% 

% figure;
% subplot(1,5,1);imshow(gb_av{1},[]);
% subplot(1,5,2);imshow(gb_av{2},[]);
% subplot(1,5,3);imshow(gb_av{3},[]);
% subplot(1,5,4);imshow(gb_av{4},[]);
% subplot(1,5,5);imshow(gb_av{5},[]);
% 
% tb1 = abs(gaborResult{5,1});
% tb2 = abs(gaborResult{5,2});
% tb3 = abs(gaborResult{5,3});
% tb4 = abs(gaborResult{5,4});
% tb5 = abs(gaborResult{5,5});
% tb6 = abs(gaborResult{5,6});
% tb7 = abs(gaborResult{5,7});
% tb8 = abs(gaborResult{5,8});
% 
% [di,dj] = size(tb1);
% tbs = zeros(di,dj);
% for i = 1:di
%     for j=1:dj
% %         tbs(i,j) = max([ tb1(i,j),tb2(i,j),tb3(i,j),tb4(i,j),...
% %             tb5(i,j),tb6(i,j),tb7(i,j),tb8(i,j) ]);     
%          tbs(i,j)= max([ tb3(i,j),tb7(i,j) ]);
%     end
% end
% 
% % tbs = (tb1+tb2+tb3+tb4+tb5+tb6+tb7+tb8)/8;
% 
% subplot(1,2,2);imshow(tbs,[]);






% tb1_mean = mean(tb1,2);
% % tb1_sum = sum(tb,1);
% tb2_mean = mean(tb2,1);
% tb2_sum = sum(tb,2);









% map = ctmap(oc_v,50,50);


% imshow(oc_v_bw);
% oc_v_bw = imclose(oc_v_bw,se);
% roc_v_bw = ~oc_v_bw;


%1
% soc_v = sum(oc_v_bw,1);

% regl1 = find(soc_v==size(oc_v_bw,1));
% col1 =0;
% if(~isempty(regl1))
%     col1 = sum(regl1)/length(regl1);
% end

%2
% min_v = min(soc_v);
% col2 = soc_v(soc_v==min_v);
% col2 = find(soc_v<min_v+25);
% col2 = floor(sum(col2)/length(col2));
% 
% 
% col = col2; 
% 
% row = roc_v_bw(:,col2);
% row = find(row==false);
% 
% if(isempty(row))
%     row = sum(roc_v_bw,2);
%     row = row<length(row);
%     row1 = find(row,1,'first');
%     row2 = find(row,1,'last');
%     row =ceil((row1+row2)/2);
% else
%     row = row(end);
% end
% 
% if(min_v>=40)
%     row = row - 20;
% end








% figure;

% subplot(2,4,2);  plot(liney);        title('line');
% subplot(2,4,3);  plot(lineyd);       title('lined');
% subplot(2,4,4);  plot(lineydd);      title('linedd');
% subplot(2,4,2);  imshow(map);      title('map');

% subplot(2,4,3);  imshow(roc_v_bw);      title('roc_g_bw');
% 
% subplot(2,4,4);  imshow(oc_v_bw);      title('oc_g_bw');
% subplot(2,4,5);  imshow(oc_g);         title('oc_g');
% subplot(2,4,6);  imshow(oc_s);         title('oc_s');
% subplot(2,4,7);  imshow(oc_p);         title('oc_p');
% subplot(2,4,8);  imshow(oc_v);         title('oc_v');
% freezeColors;
% % subplot(2,4,5);  imshow(cmap);       title('cmap');
% subplot(2,4,1);  imshow(olmap);  title('olmap');
% freezeColors;
% row
% col


end





function cmap = ctmap(input_g,y,x)
[h,w]  = size(input_g);
m = zeros(h,w);

enlarge = 10;
if(y<10||x<10)
    enlarge = min(x,y)-1; 
end
if(h-y<10||w-x<10)
    enlarge = min(h-y,w-x)-1;
end

m(y-enlarge:y+enlarge,x-enlarge:x+enlarge) = 1;
% m(y-enlarge:y+enlarge,:) = 1;
cmap = s_bia(m);


end





function [xid,yid] = getid(input,th)
input_cur = sum(input,1);
input_cur = input_cur(1:size(input,1)-5);
[~,xid] = max(input_cur);
yid = input(:,xid);
yid = im2bw(yid,th);
yid = sum(yid);



end


function [line,lined,linedd] = calc_curve(input_cur,dim)
input_cur = smooth(input_cur,50);
L = length(input_cur);
x = 1:L;
x=x';
line = polyfit(x,input_cur,dim);
linex = x;
temp1 = line(dim+1); temp2 = 0;temp3 =0;

for i = 1:dim
    temp1 = temp1 + line(dim-i+1) * (linex.^i);
    temp2 = temp2 + line(dim-i+1) * (linex.^(i-1)) * i;
end
for i=1:dim-1
    temp3 = temp3 + (dim-i+1)*(dim-i) * line(i)* (linex.^(dim-i-1)); 
end
line = temp1;
lined = temp2;
linedd = temp3;

end

