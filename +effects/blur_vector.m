function [out]=blur_vector(in)
% blur_vector Blur a 1xw row of pixels using a 3x(2+w) neighbourhood

out=                     in(1,2:end-1)           ...
       + in(2,1:end-2)+4*in(2,2:end-1)+in(2,3:end)   ...
                       + in(3,2:end-1);

out=out / 8; % normalise down

end
