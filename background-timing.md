Problems with timing
--------------------

To achieve high performance you need to be able to:

1. Measure and compare the performance of implementations

2. Understand how performance changes as parameters change

Matlab provides `tic` and `toc` to measure time. For
example, to measure how long it takes to generate a
random 2x2 matrix and invert it, execute:

    tic; inv(rand(2)); toc;

It is worth running the command a few times, to see
how the reported execution varies. Also try running
with the command for different matrix sizes (e.g.
replace 2 with 4, 8, etc.), and see how much it
goes up with matrix size.

An easier way of running multiple sizes is to put it
in a loop, such as:

    for i=1:10, tic; inv(rand(i)); toc; end

The last reported time is for `inv(rand(10))`, and
you may wish to compare against doing a standalone
command:

    tic; inv(rand(10)); toc;
    
As a final experiment, instead of just one inversion,
try doing it 10 times (note the loop over `r`):

    for i=1:10, tic; for r=1:10, inv(rand(i)); end; toc; end

Compare the times against those above, and check
whether it takes 10 times longer if it is done 10 times.

Finally, let's pull the inversion out into an
anonymous function with one parameter `n`:

    f=@(n)( inv(rand(n)) );
    
The variable `f` now contains a function which we can
call with a single argument, so let's try the unrepeated
version again:

    for i=1:10, tic; f(i); toc; end

I can't predict what results you'll see, as it depends
on the version of matlab, your CPU, your OS, and a
whole bunch else. However, some general effects you
are likely to see are:

1. Cold-start overhead: the first time you run a function
   it may be slower than successive times, possibly by
   a very large factor.

2. Measurement variability: Running the same function with
   the same scale of input problem will rarely result in
   exactly the same time.

3. Fixed overhead: There is often a high cost associated
   with executing something once, while the incremental
   cost of executing it again may be much less.

4. Poor resolution: It is difficult to accurately and
   reliably measure small execution times, especially
   in the sub-millisecond range.

5. Context dependence: the same code may be optimised
   differently when placed in different contexts (for
   example, on the command line versus in an anonymous
   function).
