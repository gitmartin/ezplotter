function my_zoom_fcn(src, cbdata)
fig = src;
ah = fig.CurrentAxes;

cpaxes = mean(ah.CurrentPoint);
X = cpaxes(1);
Y = cpaxes(2);
%cbdata.VerticalScrollCount

mag = 1.1;
scroll = cbdata.VerticalScrollCount;

keypress=fig.CurrentModifier;
if isempty(keypress)
    keypress={''}; 
end

switch keypress{1}
    case ''
        ah.XLim = (ah.XLim - X)*mag^scroll + X;
        ah.YLim = (ah.YLim - Y)*mag^scroll + Y;
    case 'control'
        ah.XLim = (ah.XLim - X)*mag^scroll + X;
    case 'shift'
        ah.YLim = (ah.YLim - Y)*mag^scroll + Y;     
end

plot_fcns(fig);
end
