
fprintf('Loading image...');
im=imread('pears.png'); % Load a matlab builtin image
im=rgb2gray(im); % Convert from colour to grayscale
im=double(im)/255; % Move from 8-bit integer to doubles in [0,1]

imshow(im);
fprintf('done (might need to change windows). Press return.\n');
pause;

fprintf('Inverted image, window is 1x1...');
imshow(render.apply_scalar(@effects.invert_scalar, 0, im));
fprintf('done (press return.\n');
pause;

fprintf('Blurred image, window is 3x3...');
imshow(render.apply_scalar(@effects.blur_scalar, 1, im));
fprintf('done (press return.\n');
pause;

fprintf('Eroding image, window is 5x5...');
imshow(render.apply_scalar(@(x)( min(min(x))), 5, im));
fprintf('done (press return).\n');
pause;

fprintf('Blurring random image, window is 3x3...');
imshow(render.apply_scalar(@effects.blur_scalar, 1, rand(800,600)));
fprintf('done (press return).\n');
pause;

    