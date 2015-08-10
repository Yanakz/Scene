function color_conMap = mi_avgcolor( rgb_img )

% 
cform = makecform('srgb2lab');
img = applycform(rgb_img,cform);
img = im2double(img);
c1 = img(:,:,1);
c2 = img(:,:,2);
c3 = img(:,:,3);

c1_av = mean(c1(:));
c2_av = mean(c2(:));
c3_av = mean(c3(:));

c1_con = abs(c1-c1_av);
c2_con = abs(c2-c2_av);
c3_con = abs(c3-c3_av);

% img = c1_con+c2_con+c3_con;

img(:,:,1) = c1_con;
img(:,:,2) = c2_con;
img(:,:,3) = c3_con;


img(img<0.3)=0;
img = rgb2gray(img);

img = s_bia(img);

% subplot(2,2,1);imshow(c1_con);
% subplot(2,2,2);imshow(c2_con);
% subplot(2,2,3);imshow(c3_con);
% subplot(2,2,4);imshow(img);
color_conMap=img;
end

