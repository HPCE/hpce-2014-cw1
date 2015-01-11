function [out]=blur_scalar(in)
% blur_scalar Perform blur of 1 pixel using 3x3 neighbourhood
%
% in - A 3x3 matrix of grayscale pixels
%
% Produces a single pixel representing the blurred centre pixel.

out=               in(1,2)           ...
       + in(2,1)+4*in(2,2)+in(2,3)   ...
                 + in(3,2);

out=out / 8; % normalise down

end
