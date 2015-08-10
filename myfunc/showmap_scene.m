function showmap_scene( input_args )
%SHOWMAP_SCENE Summary of this function goes here
%   Detailed explanation goes here

subplot(2,4,1);
imshow(ground);
title('ground');

subplot(2,4,2);
imshow(sky);
title('sky');

subplot(2,4,3);
imshow(pourous);
title('pourous');

subplot(2,4,4);
imshow(vertical);
title('vertical');

subplot(2,4,5);
imshow(ground1);
title('ground');

subplot(2,4,6);
imshow(sky1);
title('sky');

subplot(2,4,7);
imshow(pourous1);
title('pourous');

subplot(2,4,8);
imshow(vertical1);
title('vertical');


end

