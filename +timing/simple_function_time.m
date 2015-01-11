function [time]=simple_function_time(f)
% simple_function_time Measures the execution time of the given function.
%
% f - A function handle taking no arguments
%
% Returns the execution time in seconds.

tic;
f();
time=toc;

end
