HPCE 2014 - Coursework 1
========================

Due Jan 27th, 23:59, via [blackboard](https://bb.imperial.ac.uk)

The live version of this document can be found at: [HPCE/hpce-2014-cw1](https://github.com/HPCE/hpce-2014-cw1)

The next three courseworks will be released on a week by week
basis, with two weeks to do each:

- CW2: Issued Jan 20th, due Feb 3rd
- CW3: Issued Jan 27th, due Feb 10th
- CW4: Issued Feb 3rd, due Feb 17th

The last two courseworks do not overlap, and deadlines are:
- CW5: Issued Feb 17th, due Mar 1st
- CW6: Issued Mar 2nd, due Fri 13th

The deadlines are designed to get out of the way
of DoC revision and exams in weeks 10 and 11, and
other coursework heavy end of term things.

Getting started
----------------

### Bugs / Improvements

There may well be errors in this spec, in the instructions,
in the code, or simple things like spelling. If you find
a problem or have a question, [please share it](background-bugs.md).

### Getting the files

We will be working with github throughout the course, initially
as a mode of distribution, but in somewhat more complicated
ways later on.

For now, you only really need to worry about the following:

1. This document and supporting code are part of a **repository**
    called `hpce-2014-cw1`.
    
2. The repository tracks changes I make to files in the repository,
    recording each set of changes as a **commit**.

3. From your point of view, the repository on github is the **"remote"**
    repository, and you only have read access to it.

4. You need to **clone** the remote repository to get a "local" or "working"
    repository, which is a copy of the files that you can work with and modify.
    
5. If I make changes to the remote repository on github,
    you can **pull** those changes so that your local copy
    is updated.
    
For more information on git, and how you can work with
repositories, see this brief [intro to Git](background-git.md).

As has been suggested (thanks darioml), it is possible to simply
download this repository as a zip, but it is much better to clone it:

- It helps you to get started with git.
- When there are updates (and that is very likely), you'll be able to
  integrate back into your working copy.

You also have the ability to commit within your local repository,
which allows you to track changes that you are making. I
would encourage you to do this, but it is not required.

Also, for those of you who have used git/github
before, please do not fork into a publically visible
repository. It is best to limit opportunities for
plagiarism, even in low-stakes coursework.

### Submission

There is a file in this directory called `prepare_submission.m`, which
will check that the required files exist, run some _very simple_
sanity checks, then create a zip file for submission. This script
does _not_ check that all the functions are correct - the main
goal is to reduce the turnaround time for marking, and to eliminate
small problems with incorrect file names, or missing pdfs.

Submission will be via blackboard.

### Correctness

Correctness is much more important than performance. Everything
in this exercise should either result in a function that produces
exactly the same output as a previous function, or there is
a known good output against which it can be compared.

Last year I spent some time trying to force students to
check their code worked (partially successful), but this
year I'll just leave it up to you. The only coments I'll
make are:

- Checking image `im1` is identical to image `im2` is as simple 
  as `assert(all(all(im1==im2)))`.

- I _am_ forcing you to test functions for different parameters,
  and to check old against new. It would be trivial to create
  a function that _compares_ the output of two functions, rather
  than meauring execution times.
  
- Interesting test-inputs are generally "0", "1", "2", and "many",
  which is true for image widths and heights, as well as kernel
  sizes.

### Modules

Matlab supports a simple module (or namespace) system, whereby
a directory with a leading `+` represents a module. For example,
a directory called `+XXX` establishes a module called `XXX`, and
any functions in that directory can be called from within matlab
using `XXX.` prefix. For example, a directory called `+wibble`
containing a file called `wobble.m` establishes a function that
can be called from within matlab as `wibble.wobble`. For more
information, search the matlab documentation for "Packages Create Namespaces".

This coursework assumes that your matlab current directory is
set to the same directory as _this_ file (`spec.md`). You
can check this by typing `ls('spec.md')` into the matlab
prompt. If it can't find the file, you need to change your
directory.

### Saving figures

One of the things you are _required_ to do is to save certain
graphs as pdfs. The existence of these figures is assessed
(i.e. worth marks), but the content of them is not. The reason
for getting you to generate and save them is to make sure that
you have actually run the experiments - it is purely educational.

So for saved graphs, getting the marks depends on:

- (Automatic, Everyone) Does the pdf file exist?

- (Automatic, Everyone) Is the file size less than 256KB?

- (Automatic, Everyone) Is the file actually a pdf?

- (Manual, Random) Is the graph of what it is supposed to be?

I will randomly sample a small number of the graphs (10% or so)
to check them manually. I fully expect all the graphs to be fine;
the sampling and marks is just a nudge to make sure that
people don't optimise these steps out in the interest of time.

You do _not_ have to stick to the specific parameters I have
given, and in fact I encourage you to explore the ranges of
`n` and the exact functions you time in order to get the best
graphs for your machine. If you want to have multiple figures
one one plot, then go for it.

The requirement on file size is to stop people
taking... interesting... approaches to producing pdfs.
Previous submissions have seen people:

1. Taking photos of graphs on the monitor with their
   camera, then converting to pdf.

2. Printing graphs, then taking a photo with their camera,
   then converting to pdf.
   
3. Same as above, but using a scanner (looks ok, but ends
   up with an 8MB file).
   
Please don't be that person. There is a `File -> Save As`
option on matlab figures, which supports direct pdf generation.
Unless you have a huge number of points in your plot you
should come in at well under 256KB - it is somewhat difficult
to get the file size above 100KB for these kinds of graphs.

E1 - Timing
-----------

Before starting this, you may wish to look at [background-timing.md](bakground-timing.md]

In the +timing directory, there is a very simple
function called `function_time_simple`, which is
just a wrapper round `tic` and `toc`. It takes a
single function with no parameters, and returns the
execution time. To see it in use on various functions,
run the script `timing.demo`.

### E1.1 - Reliable Timing

Add a file called `+timing/function_time.m`, with the
same prototype as `function_time_simple` plus some
additional accuracy constraints:

``` matlab
function [t]=function_time(f)
% function_time Return the execution time for a single execution of f() in seconds
% 
%  f : A function with no inputs
% 
% The timing accuracy is 10% or better. So if the true time is
% "t" and the measured time is "m", it should attempt to ensure
% that abs((m-t)/t) < 0.1". This function supports
% execution times of f from micro-seconds to minutes
% efficiently.
%
% The user of this function takes on responsibility for
% making sure that the machine is not loaded, and that
% frequency scaling is turned off.
%    
% Examples:
%  
% > f=@()( sin(1) );  timing.function_time(f)
%
% > timing.function_time(@()( randn(1000)*randn(1000) ) )
```

Hints:

- What is a "fast" function in the context and timing capabilities of matlab?

- What do you need to do for "fast" functions to ensure start-up costs and
  timing resolution are compensated for?
  
- How do you make sure that "slow" functions are still timed "efficiently"?

### E1.2 - Scaling of performance

Create a function called `+timing/function_time_against_n.m`
with the following prototype and behaviour:

``` matlab
function [ts,ns]=function_time_against_n(f, ns, maxTime)
% function_time_against_n Measure the execution time of a function with varying inputs
%
%  f       : A function taking a single positive integer parameter n. Execution time
%            is assumed to increase monotonically (approximately) with n.
%  ns      : A vector of monotonically increasing positive integers.
%  maxTime : Maximum amount of time the function should take (default == 3 seconds)
%  
%  This function calculates the changing execution time for a
%  function of a single parameter, as that parameter takes on
%  a vector of increasing values. The total time used to calculate
%  calculate times should be (approximately) bounded by the maxTime
%  parameter. The function should investigate as many data-points as
%  possible - if time runs out, all remaining ts values should be NaN (Not a Number).
%
%  Usage:
%
%  > f=@(n)( randn(n).^2 );
%  > timing.function_time_against_n(f, 1:20)
%
%  > [ts,ns]=timing.function_time_against_n(@(n)( randn(10)^n, 1:20) ); plot(ns,ts);
%
%  > [ts,ns]=timing.function_time_against_n(@(n)( inv(randn(n), 1:100), 10.0)  % Increase maxTime
```

Hints:

- The function `nan` can be used to create a vector of NaN values of chosen size.

- When you need to measure two overlapping time-spans, you can use the 'tId=tic(); t=toc(tId)' form.

### Discussion

Once your 'function_time_against_n' function works, you can
use the helper function 'timing.plot_function_time_against_n', to
plot function execution time against parameter:

``` matlab
> timing.plot_function_time_against_n(@rand)
```

or to compare two different functions:

``` matlab
f1=@(n)( rand(n,1) );
f2=@(n)( rand(n,n) );
f3=@(n)( rand(n,n)^2 );
f4=@(n)( rand(n)*rand(n) );
timing.plot_function_time_against_n( { f1, f2, f3, f4 } );
```

**Save as**: figures/e1_2_scaling.pdf

_Note_: This originally said "figures/e1_2_comparison.pdf", but
`prepare_submission.m` used the scaling name.

To compare the scalability of one function in different ways, do:

``` matlab
f=@(x,y)( randn(x)^y );
f1=@(n)( f(100,n) );
f2=@(n)( f(n,100) );
timing.plot_function_time_against_n( { f1, f2 } );
```

Beware of processor throttling and frequency scaling, especially
in laptops, but sometimes in desktops and servers now. A good
sanity check for this is to time the same function twice:

``` matlab
f1=@(n)( rand(n) );
timing.plot_function_time_against_n( { f1, f1 } );
```

Is the same function substantionally faster the second
time (and can you hear the fan speed up)?

E2 - Seperating function and execution
--------------------------------------

In the `+effects` directory there are two functions `blur_scalar`
and `invert_scalar`. Both functions are image processing kernels,
and transform a square window of grayscale pixels into a single
output pixel. Inversion is only based on the input pixel, so it
consumes a 1x1 input window, while blur requires a 3x3 input window.

In the `+render` directory there is a function `apply_scalar`, which
will take pixel kernels, and apply them to all the pixels in
an image. This function is responsible for extracting windows from
the image, and applying a given function - see the documentation
of the function for the specification.

Run the script `effects.demo` to see some examples of using the
two together.

### E2.1 - Add a Scharr kernel

The Scharr edge detection kernel is a Sobel-like operator that
determines how "edgey" a pixel is http://en.wikipedia.org/wiki/Sobel_operator.

Add a function `+effects/scharr_scalar.m` which implements a per-pixel
edge detection kernel. The function should calclate the vertical
and horizontal strength G_x and G_y, then combine them into the
output pixel using the mapping:

    G = sqrt(G_x^2+G_y^2));
    pixel = min(G/8, 1);
    
An example of reference output is included as `+effects/cameraman.scharr.ref.png`,
which I generated using the code:

``` matlab
im= double(imread('cameraman.tif'))/256;
im=render.apply_scalar(@effects.scharr_scalar, 1, im);
% Don't execute this unless you want to overwrite the reference
% imwrite(im,'+effects/cameraman.scharr.ref.png');
```

Some examples of applying the function:

``` matlab
% Some basic tests
effects.scharr_scalar(zeros(3)); % == 0
effects.scharr_scalar([1 1 1 ; 0.5 0.5 0.5 ; 0 0 0]); % == 1
effects.scharr_scalar([0.5 0.6 0.7; 0.5 0.6 0.7; 0.5 0.6 0.7]); % == 0.4
% Apply the function
im= double(rgb2gray(imread('pears.png')))/256;
imshow( render.apply_scalar( @effects.scharr_scalar, 1, im ) );
```

Hint:

- Start from the blur kernel

- Handle just the horizontal or vertical direction first, then work
  on combining them together.  
  
- Use the reference image as a comparison against yours. You can
  easily load images and subtract them.

### E2.2 - Add a median kernel

The median kernel replaces each pixel with the median of
the pixels in the window, which removes noise, but tends
to retain edges: http://en.wikipedia.org/wiki/Median_filter

Add a function `+effects/median_scalar.m` which implements a per-pixel
median filter. The filter should be able to deal with any
odd-sized window, e.g. 1x1 (border=0), 3x3 (border=1), 11x11 (border=5).

There is reference output in `+effects/cameraman.median7x7.ref.png' which
I generated with:
``` matlab
im= double(imread('cameraman.tif'))/256;
im=render.apply_scalar(@effects.median_scalar, 3, im);
% Don't execute this unless you want to overwrite the reference
% imwrite(im,'+effects/cameraman.median7x7.ref.png');
```

Other basic tests to perform are:
``` matlab
% Some basic tests
effects.median_scalar([1 2 3; 4 5 6; 7 8 9]); % == 5
effects.median_scalar([1 1 1; 7 7 7; 5 5 5]); % == 5
% Apply the function
im= double(rgb2gray(imread('pears.png')))/256;
imshow( render.apply_scalar( @effects.median_scalar, 1, im ) );
pause;
imshow( render.apply_scalar( @effects.median_scalar, 6, im ) );
```

Hints:

- There is a function called [`median`](http://uk.mathworks.com/help/matlab/ref/median.html)
  supplied by matlab, but it does not behave in the way we want for 2D matrices.

- You can use [`reshape`](http://uk.mathworks.com/help/matlab/ref/reshape.html) to
  flatten the input pixels, for example turning a 3x3 array into a 1x9 array for input to `median`.
  
- Or matlab also allows [linear indexing](http://uk.mathworks.com/help/matlab/math/matrix-indexing.html)
  into two dimensional arrays. For example, try `x=[1 0 1; 2 0 2; 9 9 9], x(1:9)`.

Because the median filter has another (implicit) parameter, you are
now in a position to explore the scaling in execution time
for that parameter:

``` matlab
f1=@(n)( render.apply_scalar( @effects.median_scalar, n, rand(100) ) );
f2=@(n)( render.apply_scalar( @effects.median_scalar, 4, rand(96+n) ) );
timing.plot_function_time_against_n( {f1, f2}, 4:1000 )
```

**Save as**: `figures/e2_2_median_window_scaling.pdf`

### E2.3 - Measuring the cost of abstraction

Using an intermediate function gives us flexibility (which we'll
exploit in a minute), but this abstraction comes at a cost. Create
a function called `+effects/render_blur.m`, with the following
prototype and behaviour:

``` matlab
function [out] = render_blur(in)
% render_blur Directly blurs an image
%
%  This function is defined by equivalence with scalar_apply and blur_scalar:
%  > [o1]=render.apply_scalar(@effects.blur_scalar, 1, im);
%  > [o2]=render.render_blur(im);
%  > assert(o1==o2);
%
%  As much as possible this should be a simple de-abstraction, with the
%  body of effects.blur_scalar inserted directly into render.apply_scalar,
%  with no further optimisations.
```

You can use this to explore the cost of abstraction:

``` matlab
f1=@(n)( render.apply_scalar( @effects.blur_scalar, 1, rand(n) ) );
f2=@(n)( effects.render_blur( rand(n) ) );
timing.plot_function_time_against_n( {f1, f2}, 10:10:1000 )
```

**Save as**: figures/e2_3_abstraction_cost.pdf

This allows you to quite accurately infer the overead involved
in creating an anonymous function. The overhead in matlab is
quite high, so we need to make sure that:

- The cost of the work within the function is much higher than the
  overhead.

- Or, the functional gain due to abstraction is worth the performance
  hit.
  
- Or, ideally, both.


E3 - Parallelising loops
-------------------------------

Matlab contains a [`parfor`](http://uk.mathworks.com/help/distcomp/parfor.html)
loop, which allows the iterations of certain types of `for` loops to be
executed in parallel. The documentation for matlab goes into much more
detail; have a quick read, but don't worry about diving too deeply
into the details. The essential property we need is that a statement of the form:

``` matlab
for i=1:100
   x(i)= something(i);
end
```

can be transformed into:

``` matlab
parfor i=1:100
   x(i)= something(i);
end
```

Each iteration needs to be _independent_ in order for this
to work, so executing `something(4)` should have no effect
on the output of `something(5)`.

### E3.1 - Parallelising the inner loop

Create a new function `+render/apply_scalar_par_inner.m`, based
on the original 'render.apply_scalar`. Modify the function so that
the inner loop over x, is now a `parfor` loop (it is exactly
as easy as it sounds).

You should now be able to run:

``` matlab
tic; render.apply_scalar_par_inner( @effects.invert_scalar, 0, rand(500) ); toc
```

Some things that you might see happening (in matlab r2014a):

- Matlab will explain that it is starting up worker threads, and there
  may be a brief pause.

- If you have a CPU activity monitor running, the CPU should spike
  up on all CPUs, with copies of matlab running on each.
  
- If you use a processor or task monitor, you can see extra copies
  of matlab which are just hanging around in the background.

In older version of matlab, you need to explicitly start the
parallel pool using the `matlabpool` command, then try running
the command again.

Compare the timing of the parallel version against the
original (sequential) version. Is it faster? Do you expect it to be?

There is a startup cost associated with running any code,
which is usually much lower on subsequent code. When you
started matlab originally, how long did you have to wait
before you exected the first command? How long do you
have to wait between commands after the first command?

Try looking at the scaling of the function along different
parameters (you may need to tweak the parameters a little
depending on your machine):

``` matlab
ftall=@(n)( render.apply_scalar_par_inner( @effects.invert_scalar, 0, rand(n,8) ));
fwide=@(n)( render.apply_scalar_par_inner( @effects.invert_scalar, 0, rand(8,n) ));
timing.plot_function_time_against_n({ftall,fwide}, 2.^(3:16), 5);
```

How does the image being tall or wide relate to the parallelism? What
could the relationship between the size of the sequential loop
versus the parallel loop be?

Inversion is a very cheap operation, with just one subtraction per
pixel. Median is much more complex, particularly as the window size
grows. Try exploring the change in window size (note that this
has a minute timeout, as you want to see the entire graph):

``` matlab
f1=@(n)( render.apply_scalar( @effects.median_scalar, n, rand(50,50) ));
f2=@(n)( render.apply_scalar_par_inner( @effects.median_scalar, n, rand(50,50) ));
timing.plot_function_time_against_n({f1,f2}, 0:24, 60);
```

**Save as**: figures/e3_1_median_scaling.pdf

How do you explain the behaviour of the sequential version? similarly,
how do you explain the behaviour of the parallel version?

### E3.2 - Parallelising the inner loop

Create another new function `+render/apply_scalar_par_outer.m`, based
on the original `render.apply_scalar` . Modify the function so that
the outer loop over y is now a `parfor` loop, but the inner
x loop is _not_ a `parfor` (again, extremely simple).

Try the same experiment as before:

``` matlab
ftall=@(n)( render.apply_scalar_par_outer( @effects.invert_scalar, 0, rand(n,8) ));
fwide=@(n)( render.apply_scalar_par_outer( @effects.invert_scalar, 0, rand(8,n) ));
timing.plot_function_time_against_n({ftall,fwide}, 2.^(3:16), 5);
```

**Save as**: figures/e3_2_scaling_versus_aspect.pdf

(_note: Originally had the wrong extension ".m")

How is it different in terms of:

- Raw execution speed?

- Relative difference between tall and skinny?

### Discussion

It's now worth comparing all three versions:

``` matlab
border=3;
f1=@(n)( render.apply_scalar( @effects.median_scalar, border, rand(n,n) ) );
f2=@(n)( render.apply_scalar_par_inner( @effects.median_scalar, border, rand(n,n) ) );
f3=@(n)( render.apply_scalar_par_outer( @effects.median_scalar, border, rand(n,n) ) );
timing.plot_function_time_against_n({f1,f2,f3}, 50:50:1000, 10);
```

For the parallelised outer loop, should see a speed-up close-ish
to the number of CPUs that matlab is using, while for smaller images
the sequential version is likely to be faster.

The median filter is relatively complex, as for every (x,y) co-ordinate,
it does a lot of work, particularly for larger windows. If you vary the
window/border size, you (should) see that as the window gets larger, the
image size at which the par_outer version beats the original version moves
to the left.

Inversion does almost nothing per pixel, so the relative overhead
of the parallel loop is higher. However, think of the rough structure
of apply_scalar_par_outer:

    parfor y
        for x
            out(y,x)=1-in(y,x);

As the image size gets larger, there are more rows, which means
more parallel iterations. As we've seen, there is a cost associated
with doing something in parallel, so more parallel iterations seems
bad. However, as the image gets bigger, there are also more columns,
which means that the inner sequential for loop contains more and
more work. 

So even for the very lightweight inversion, it is entirely
possible we'll get a speed-up as we scale up width and height:

``` matlab
f1=@(n)( render.apply_scalar( @effects.invert_scalar, 0, rand(n,n) ) );
f2=@(n)( render.apply_scalar_par_outer( @effects.invert_scalar, 0, rand(n,n) ) );
timing.plot_function_time_against_n({f1,f2}, 50:50:1000, 10);
```

**A reminder**: _don't forget to try varying things like the `ns`
to try to explore how your specific machine behaves_.

The notion of where to introduce parallelism into a program
is quite fundamental in making sure that you want to make
things faster. We have seen that making the inner loop
parallel is a disaster in terms of performance, and makes
it much slower. Thinking about the structure of
apply_scalar_par_inner, it expands as:

    for y
        parfor x
            out(y,x)=1-in(y,x);

Every time we want to pass a parallel iteration to a different
processor, there is a communication cost. This the unavoidable
overhead of supporting parallelism, and is pure cost. Once
a parallel iteration has started, we can work sequentially
within it with little overhead, so the general principle
is to move parallelism to the _outer_ loop whereever possible.

E4 - Vectorising
----------------

Parallelism is sometimes a cheap way of getting a speed-up,
but a more classic, and often more effective way is
[vectorisation](http://uk.mathworks.com/help/matlab/matlab_prog/vectorization.html).
The fundamental idea of vectorisation is to apply a function to many independent pieces of data
at the same time, rather than calling the function on
each piece of data sequentially.

A canonical example in matlab is the replacement of
for loops with indices:

``` matlab
x=1:1000;

% Call the sin function on each piece of data
for i=1:length(x)
    a(i)=sin(x(i));
end

% Call the sin function once with all data
b=sin(i);

```

Vectorisation is well known as an optimisation technique in matlab,
but is an important concept across the high performance computing
world. Multi-core programming tools such as TBB and OpenMP use
it as a way of expressing parallelism, while it is fundamental
to the low-level architecture of GPUs.

### E4.1 - Vectorising the mapping

Create a new function called `+render/apply_vector_rows.m`, based
on apply_scalar. This function will do the same basic operation
as before, but will now pass rows of pixels to the kernel, so
the documentation should be updated (the documentation hints
at how to achieve it):

``` matlab
function [out]=apply_vector_rows(f, border, in)
% apply_scalar_vector_rows Applies a pixel-by-pixel effect to an image.
%
% f - A function taking a 2*border+1 x 2*border+w row of pixels,
%     and producing a 1 x w row of output pixels
% border - How much extra surrounding input is needed to produce one pixel
% in - Input image as a gray-scale double-precision matrix
%
% Given an input image of width=size(in,2) and height=size(in,1), this
% produces an image of size (height-2*border) x (width-2*border).
%
% Ensures that for all border<y<=height-border and border<x<=width-border
%  out(y-border,1:end) = f( in(y-border:y+border,:) )
%
% > [out]=render.apply_vector_rows(@(x)(1-x), 0, image); % invert an image
```

Vectorise the inner loop of the function, so that there is
only one outer loop. Each iteration of that loop should read
a wide strip of pixels, pass it to the kernel function, then
write the row of produced pixels into the output.

Hints:

- To indicate you want the entire width of a matrix, you can use colon,
  as in `m(y,:)` or `m(1:10,:)`.

- The `nhood` matrix now spans the entire width of the input image.

- The output row spans the entire width of the output image.

You should now be able to apply some (but not all) kernel functions, such as
inversion:

``` matlab
im= double(rgb2gray(imread('pears.png')))/256;
imshow( render.apply_vector_rows( @effects.invert_scalar, 0, im ) );
```

Looking at the performance of the vector version versus scalar
and parallel, you should see a massive difference:

``` matlab
f1=@(n)( render.apply_scalar( @effects.invert_scalar, 0, rand(n) ));
f2=@(n)( render.apply_vector_rows( @effects.invert_scalar, 0, rand(n) ));
f3=@(n)( render.apply_scalar_par_outer( @effects.invert_scalar, 0, rand(n) ));
timing.plot_function_time_against_n({f1,f2,f3});
```

**Save as**: figures/e4_1_vector_speedup.pdf

An improvement of 100x over the original version is likely, which
can be attributed to various types of overhead being reduced:

- Interpreter overhead: a for loop in matlab is executed by the
  matlab interpreter, so each operation ('+', '*', etc.) will
  often map to many hundreds of machine instructions. Once vectorised,
  the loop is lowered to compiled C code, which can get close
  to one machine instruction per operation.
  
- Abstraction overhead: we wrappd the kernel inside a function
  handle, so there is some overead involved in unpacking the function
  for each pixel. This overhead now only happens once per vector.
  
If we consider the loops and the overheads, the original looked
like this:

    for y
        Overhead: intepreter loop
        for x
            Overhead: interpeter loop
            Overhead: function abstraction
            Overhead: interpreter wrapper around low-level '1-x'
                Progress: machine instruction for '1-x'

while the rewritten version looks like:

    for y
        Overhead: interpreter loop
        Overhead: function abstraction
        Overhead: interpreter wrapper around low-level '1-x'
        for x
            Progress: maching instruction for '1-x'

In the first version, we get all the overhead on every pixel,
while in the second version we only get the overhead once per
row.

Note how similar this is to the experience with introducing
parallelism, as the same general principle holds - push the high
overhead parts to the outer-most loop possible, and make sure
the inner loop is running as fast as it can.

### 4.2 - Vectorise the effects (edge detection)

If you try to apply the other scalar effects, they will fail, as they
assume that the input is a square surrounding the desired pixel. The
function `effects.blur_vector` gives an example of a vectorised
version of blur_scalar:

``` matlab
im= double(rgb2gray(imread('pears.png')))/256;
imshow( render.apply_vector_rows( @effects.blur_vector, 1, im ) );
```

Create an equivalent function `effects.scharr_vector` which supports
the Scharr operator, and can be called in the same way. e.g.:

``` matlab
im= double(rgb2gray(imread('pears.png')))/256;
imshow( render.apply_vector_rows( @effects.scharr_vector, 1, im ) );
```

Hints:

- The function should not contain any for loops (if it does, it isn't vectorised).

Our vector function should also meet the definition of a scalar function,
so can still be used with `apply_scalar`. What are the changes
in function execution time?:

``` matlab
f1=@(n)( render.apply_scalar( @effects.scharr_scalar, 1, rand(n) ));
f2=@(n)( render.apply_scalar( @effects.scharr_vector, 1, rand(n) ));
f3=@(n)( render.apply_vector_rows( @effects.scharr_vector, 1, rand(n) ));
timing.plot_function_time_against_n({f1,f2,f3}, 10:10:1000, 5);
```

**Save as**: figures/e4_2_scharr_scaling.pdf

Pay particular attention to where the lines cross, and think about
why they are crossing - what are the changing overheads, and how
often does that overhead get incurred?

### 4.3 - Pseudo-vectorise the effects (median)

If you look at the `median_scalar` function, it is less obvious how to
vectorise it due to the call to the internal `median` function. The
first approach is to "fake" the abstraction, and simply to include
a for loop - the function appears vectorised, but internally is not
truly vectorised.

Create a function `+effects/median_vector_fake.m` which implements
a function appropriate for use with `render.apply_vector`. Try not
to add too much optimisation, think of it as simply pushing the
x loop from scalar_map "into" median_scalar.

By inference from the function definitions, the following code should
work, and the assertion should hold:

``` matlab
im=rand(100);
out1=render.apply_scalar(@effects.median_scalar, 3, im);
out2=render.apply_vector_rows(@effects.median_vector_fake, 3, im);
assert(all(all(out1==out2)));
```

Hints:

- You need to infer the border parameter, which you can calculate
  from the height of the input pixels.

As always, we want to know about the cost/benefit of this. While
we haven't truly vectorised the function, we have possibly
removed some per-pixel abstraction penalty and made it per-row
instead:

``` matlab
f1=@(n)( render.apply_scalar(@effects.median_scalar, 1, rand(n)) );
f2=@(n)( render.apply_vector_rows(@effects.median_vector_fake, 1, rand(n)) );
timing.plot_function_time_against_n({f1,f2}, 20:20:1000);
```
**Save as**: figures/e4_3_median_fake_scaling.pdf

What about if we hold the image size constant, and change the window?:

``` matlab
f1=@(n)( render.apply_scalar(@effects.median_scalar, n, rand(200)) );
f2=@(n)( render.apply_vector_rows(@effects.median_vector_fake, n, rand(200)) );
timing.plot_function_time_against_n({f1,f2},1:10 );
```

The tradeoff between these two methods is essentially whether
the interpreted x loop is in apply_scalar, outside the abstraction:

    for y
        Overhead: interpreter
        for x
            Overhead: interpreter
            Overhead: f -> median_scalar abstraction 
            Work: extract pixels, run median

or to have the x loop inside the abstraction:

    for y   
        Overhead: interpreter
        Overhead: f -> median_vector abstraction 
        for x
            Overhead: interpreter
            Work: extract pixels, run median

Visually adding up the overhead, which one comes out better?
Does it match the results?

### 4.4 Properly vectorise (median)

_Don't worry if you can't get this working, it is
more a matlab skill than a general HPC technique_. 

It is actually possible to fully vectorise median_scalar, though
it requires some mental gyrations. This can be somewhat
tricky to get right if you don't know matlab well, and to
a certain extent these tricks are mainly to get round the
speed problems of the matlab interpreter. 

So create a function `+effects/median_vector` which is a true
vectorised version of `+effects/median_vector`. It should have
the same functionality but be fully vectorised, so it should
contain no for loop.

_If you can't get this working in a fully vectorised
version, make `+effects/median_vector.m` a more
optimal version of `+effects/median_vector_fake.m`, which
removes any unnecessary operations._

Hints:

- The matlab `median` function has specific behaviour if the
  input is a 2D array. Read the documentation, and try running
  `x=[1 2 3 4 5 6 ; 7 8 9 10 11 12 ; 6 5 4 3 2 1], median(x)`.

- The matrix functions `repmat` and `reshape` are very useful
  in terms of building up complex indexing primitives.

- Draw pictures. What matrix of pixels do you need to pass to `median`? What
  are the indices of those pixels within the original image?
  
- Think about linear indexing. How can you create a vector of
  linear indices which pulls out the pixels you want?
   
Assuming you can get this working, check the effect on performance
as the image size goes up:

``` matlab
f1=@(n)( render.apply_vector_rows(@effects.median_vector_fake, 1, rand(n)) );
f2=@(n)( render.apply_vector_rows(@effects.median_vector, 1, rand(n)) );
timing.plot_function_time_against_n({f1,f2}, 20:20:1000);
```

**Save as**: e4_4_median_vector_scaling.pdf

Equally interesting is what happens when the window size is changed:

``` matlab
f1=@(n)( render.apply_vector_rows(@effects.median_vector_fake, n, rand(100)) );
f2=@(n)( render.apply_vector_rows(@effects.median_vector, n, rand(100)) );
timing.plot_function_time_against_n({f1,f2}, 1:50, 10);
```

5 - Combining vectorisation and parallelism
-------------------------------------------

Vectorisation and parallelism are deeply related. A simplistic
way of viewing things is that vectorisation exploits data-parallelism
at a fine-grain instruction level, while parallelism exploits
it at a coarse-grain thread or process level. As vectorisation
has lower startup overhead, we generally want to make sure
that parallelism is wrapped _around_ vectorisation.

### 5.1 - Simple parallelism and vectorisation

Create a file called `+render/apply_vector_rows_par_outer.m`, which is
based on apply_vector_rows, but now uses a parfor loop (again, it
is as easy as it sounds).

Compare the performance of the combined version against the
two originals:

``` matlab
f1=@(n)( render.apply_vector_rows(@effects.scharr_vector, 1, rand(n)) );
f2=@(n)( render.apply_scalar_par_outer(@effects.scharr_scalar, 1, rand(n)) );
f3=@(n)( render.apply_vector_rows_par_outer(@effects.scharr_vector, 1, rand(n)) );
timing.plot_function_time_against_n({f1,f2, f3}, 50:50:5000, 10);
```
**Save as**: figures/e5_1_simple_par_vec_scaling.pdf

Depending on your computer, OS, and many other things, you might
see various behaviour here. The parallel scalar version is always
going to be comparitively slow, but the relationship between the
vector and vector-p arallel versions is less predictable. Most
likely, the vector-parallel version will be somewhat worse than,
or at best the same speed as, the vector version.

### 5.2 - Chunked parallelism

The parallel version still incurrs a lot of overhead for each
row, which is large compared to the faster vectorised row
effects. Currently the loops like:

    parfor y
        Overhead: parallel
        Overhead: interpreter
        Overhead: abstraction
        Work: vectorised function

The parallel overhead per iteration is very high, and we
simply don't need 100s of parallel iterations. It is quite
common to have 1000 rows of pixels, but it is (currently)
rare to have much more than 8 cores on a desk-top.

Create a function `+render/apply_vector_rows_par_coarse.m`, which
is based on apply_vector_rows_par_outer, but which splits
the x loop into (at most) 16 parallel outer iterations, and w/16 sequential
inner iterations:

    parfor yCoarse
        Overhead: parallel
        for y=yFine
            Overhead: interpreter
            Overhead: abstraction
            Work: vectorised function

The outer (coarse) loop should execute 16 iterations, i.e. it
creates 16 parallel pieces of work, each handling 1/16 of the
image rows. _You can assume that the height of all images is
more than 32_.

``` matlab
f1=@(n)( render.apply_vector_rows_par_outer(@effects.scharr_vector, 1, rand(n)) );
f2=@(n)( render.apply_vector_rows_par_coarse(@effects.scharr_vector, 1, rand(n)) );
timing.plot_function_time_against_n({f1,f2}, 50:50:5000, 10);
```
**Save as**: figures/e5_2_par_chunked.pdf

Hints:

- Keep the outer for loop non parallel _until_ you are sure the
  partitioning into two loops is correct.

- Establish a vector `yC` of length 17, such that `yC(i)..yC(i+1)-1` is the
  range handled by coarse iteration `i`. Boundary conditions are
  `yC(1)==1`, and `yC(17)==wOut+1`.

- You may start to encounter problems with matlab complaining about
  'parfor', and its inability to classify variables. First, read
  the documentation - the error message will both contain suggestions
  on what to do, and links to much longer discussions.

- A decent pattern is to build up part of the output image within
  a private matrix in the inner sequential loop, then append it
  to the output matrix right at the end. Something like:

    ``` matlab
    out=[];
    parfor i=1:16
        localOut=zeros(localHeight, wOut);
        for y=1:...
            localOut(y,:)=f( ... );
        end
        out=[out ; localOut];
    end
    ```

- Matlab will warn about having to send the entire input image
  to every parallel worker. It will be happier (at least
  int terms of performance) if you select just the input
  region needed within one parallel iteration at the start
  of each parallel iteration, then only read from that matrix.
  
- Draw pictures of the for loops and matrices.

### 5.2 - Optimal version

Create a function `+render/apply_vector_opt.m`, which
uses any techniques you think appropriate to get the
best speed across a range of input image sizes and functions.
You can assume that all kernel functions will be row vectorised.

_There is no specific technique expected here, just
try to think of any optimisations or tricks you can
use to make things faster. Remember, my machine is
different to yours - how can you try to get "good"
performance everywhere?_

Submission
----------

Submission steps:

1. Run the script `prepare_submission`.

2. Fix unexpected problems (missing files, etc.)

3. Think again: "have I actually tested my functions?"

4. Submit the zip via blackboard.

Credits
=======

- darioml : Pointing out the mis-match between filename in the
  readme and in `prepare_submission.m`.

- darioml : For various improvements to specification syntax.
