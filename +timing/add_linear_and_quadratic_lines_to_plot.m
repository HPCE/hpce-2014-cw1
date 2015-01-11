function [ output_args ] = add_linear_and_quadratic_lines( ax )

if nargin < 1
    ax=gca();
end

currHeld=ishold();

if ~currHeld
    hold on;
end

% Helper method for adding linear and quadratic scaling lines to a graph.

bounds=axis(ax);
for i=-32:32
    xx=logspace(-32,32);
    loglog(ax, xx,xx*10^i,'k:');
    loglog(ax, xx,xx.^2*10^i, 'k:');
end
axis(ax,bounds);

if ~currHeld
    hold off;
end

end

