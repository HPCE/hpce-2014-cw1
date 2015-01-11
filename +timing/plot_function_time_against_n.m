function [ output_args ] = plot_function_time_against_n( fs, ns, maxTime )
% plot_function_time_against_n Times and plots the execution times of one
% or more functions.
%
% fs - Either a function handle of one parameter, or a cell array of
%      function handles.
% ns - (Optional) A vector of monotonically increasing positive integer
%      values
% maxTime - (Optional) Maximum total time to spend timing the function(s)


if ~iscell(fs)
    fs={fs};
end

if nargin < 2
   ns=round(10.^(0:0.25:6));
end
if nargin < 3
    maxTime=3;
end

timePerFunc=maxTime / length(fs);

colours=char('-or','-og','-ob','-oy');
names=[];

hold off;
for fi=1:length(fs)
    f=fs{fi};
    [ts,ns]=timing.function_time_against_n(f,ns,timePerFunc);
    loglog(ns,ts,colours(mod(fi-1,length(colours))+1,:));
    hold on;
    
    if fi==1
        names=func2str(f);
    else
        names=char(names, func2str(f));
    end
end
hold off;

xlabel('n');
ylabel('t (sec)');
timing.add_linear_and_quadratic_lines_to_plot();
legend({names}, 'Interpreter', 'none');

arch= computer('arch');
matlabpool SIZE;
nWorkers=ans;
if nWorkers==0
    nWorkers='None';
else
    nWorkers=sprintf('%d', nWorkers);
end

title(sprintf('Arch=%s, ParWorkers=%s, MaxTime=%g',arch,nWorkers, maxTime));

end
