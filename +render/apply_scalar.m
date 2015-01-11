function [out]=apply_scalar(f, border, in)
% apply_scalar Applies a pixel-by-pixel effect to an image.
%
% f - A function taking a 2*border+1 x 2*border+1 matrix of pixels
% win - How much extra surrounding input is needed to produce one pixel
% in - Input image as a gray-scale double-precision matrix
%
% Given an input image of width=size(in,2) and height=size(in,1), this
% produces an image of size (height-2*border) x (width-2*border).
%
% Ensures that for all border<y<=height-border and border<x<=width-border
%  out(y-border,x-border) = f( in(y-border:y+border,x-border:x+border) )
%
% > [out]=render.apply_scalar(@(x)(1-x), 0, image); % invert an image

hIn=size(in,1);
wIn=size(in,2);

hOut=hIn-2*border;
wOut=wIn-2*border;

assert(hOut>=1);
assert(wOut>=1);

out=zeros(hOut,wOut);

for y=1:hOut
    for x=1:wOut
        nhood = in(y:y+2*border , x:x+2*border );
        out(y,x) = f(nhood);
    end
end
