% Some simple examples of using timing.simple_function_time

f=@()( sin(1) );
timing.simple_function_time(f)

for n=2.^(1:12)
    f=@()( randn(n) );
    t=timing.simple_function_time(f);
    fprintf('n =%6d, t =%9.5f\n', n, t);
end