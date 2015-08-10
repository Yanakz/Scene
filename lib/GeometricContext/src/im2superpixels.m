function imsegs = im2superpixels(im)

% %-----------
% prefix = num2str(floor(rand(1)*10000000));
% fn1 = ['./tmpim' prefix '.ppm'];
% fn2 = ['./tmpimsp' prefix '.ppm'];
% % segcmd = '/media/Data/Code/scene-saliency/GeometricContext/segment_pedro/segment 0.8 100 100';
% 
% segcmd = '/home/open/src/GeometricContext/segment_pedro/segment 0.8 100 100';
% 
% imwrite(im, fn1);
% system([segcmd ' ' fn1 ' ' fn2]);
% delete(fn1);
% %-----------
% 


regionSizes = [10 20 30] ;
regularizers = [0.01 0.05 0.1 1] ;
im = im2single(im);
segments = vl_slic(im, regionSizes(3), regularizers(1), 'verbose') ;
segments = uint8(segments);
prefix = num2str(floor(rand(1)*10000000));
fn2 = ['./slic_seg',prefix,'.ppm'];
imwrite(segments,fn2);


imsegs = processSuperpixelImage(fn2);


delete(fn2);