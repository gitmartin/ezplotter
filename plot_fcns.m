function plot_fcns(fig, varargin)

tit = fig.CurrentAxes.Title.String;
xlab = fig.CurrentAxes.XLabel.String;
ylab = fig.CurrentAxes.YLabel.String;

gv = fig.CurrentAxes.XGrid;

figure(fig) % give focus to fig

for func = fig.UserData % plot all the functions
    func = func{1}; 
    % func is now a structure
    if ~isfield(func, 'fcn_string') % no fcn string provided.
        continue
    end
    fcn_string = func.fcn_string; %cell2mat(fcn);
    
    if length(fcn_string) < 1
        continue
    end
    
    ah = fig.CurrentAxes;
    xlim = ah.XLim;
    ylim = ah.YLim;
    
    if (nargin == 2 && varargin{1}) % reset
        xlim = [-1 1];
    end
    
    lengthx = xlim(2) - xlim(1);
    x = linspace(xlim(1) - 2*lengthx, xlim(2) + 2*lengthx, 15000);
    
 %   syms x
 %   symbolic_expression = eval(fcn_string);
%    f_of_t = subs(symbolic_expression, t);
    f_of_x = eval(fcn_string);
 
    spec = [func.Style func.Color];
    plot(fig.CurrentAxes, x, f_of_x, spec, 'linewidth', func.Linewidth)
    
    if (nargin == 2 && varargin{1}) % reset
        ah.XLim = [-1 1];
    else
        axis(ah,[xlim ylim]);
    end
    
    if strcmp(gv, 'off')
        grid(fig.CurrentAxes,'off')
    else
        grid(fig.CurrentAxes, 'on')
    end
    
    hold(fig.CurrentAxes,'on')
    %break
end
hold(fig.CurrentAxes,'off')

ah = fig.CurrentAxes;
title(ah,tit)
xlabel(ah,xlab)
ylabel(ah,ylab)

end