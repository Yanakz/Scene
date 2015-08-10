img = imread('328.jpg');
img = imresize(img,[256,256]);
img = rgb2gray(img);


gaborArray = gaborFilterBank(5,8,39,39);

featureVector = gaborFeatures(img,gaborArray,4,4);