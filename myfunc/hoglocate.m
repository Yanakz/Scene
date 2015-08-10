function [hogmap,oriemap] = hoglocate(img)
%27/9/2014 by Haoran Liang

    feat = features(img,8);
    
    [hogmap,oriemap,oriemap_sim] = orihog(feat);
    
%     [s1,s2,~] = size(hogmap);
% %     oriemap = imresize(oriemap,[s1,s2]);
% %     hogmap = imresize(hogmap,[s1,s2]);
%     
%     oc_s_bw = ~oc_s_bw;   
%     oc_s_bw = imresize(oc_s_bw,[s1,s2]);
%     
%     oriemap = double(oriemap).*oc_s_bw;
% 
% %     oc_s_bw = imresize(oc_s_bw,size(oriemap));
%   
%     hogmap =  hogmap.*oc_s_bw;
    
%     [H,T,R] = hough(hogmap);
%      P  = houghpeaks(H,5);
%     lines = houghlines(hogmap,T,R,P);
%     
%     for k = 1:length(lines)
%        xy = [lines(k).point1; lines(k).point2];
%        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%        hold on;
%     end
%     
    
%     sim_map = oriemap_sim.*imresize(oc_s_bw,size(oriemap_sim));
%     vp = findvp(sim_map);
    
%     bw_g = im2bw(oc_g,0.1);
%     hog_region = bw_g.*double(oriemap);
%     ori_hist = zeros(9,s2);
%     for col = 1:s2
%         for i = 1:9
%             count = length(find(hog_region(:,col)==i));
%             ori_hist(i,col) = count;
%         end
%     end

    
    
    
end

function vp = findvp(orimap)

[s1,s2] = size(orimap);
ori_num = 6;
ori_type = [2,3,4,7,8,9];
count = zeros(ori_num,1);
ori_idmap = zeros(s1,s2,length(ori_type));
k = [tan(20),tan(40),tan(60),-tan(60),-tan(40),-tan(20)];
for i = 1:ori_num
    count(i) = length(find(orimap==ori_type(i)));       
    submat = repmat(ori_type(i),2,2);
    [id1,id2] = findsubmat(orimap,submat);
    ori_idmap(id1,id2,i) = 1; 
    
    
    
    
end




a =1;




end

