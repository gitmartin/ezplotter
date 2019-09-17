function mypan(src, callbackdata) %windowbuttowndownfcn
% src is the figure object here
fig = src;
seltype = fig.SelectionType;
edit_string = fig.UserData;
ah = fig.CurrentAxes;

if strcmp(seltype, 'open') % detect double click
    reset_axes = true;
    plot_fcns(fig, reset_axes)
end

if strcmp(seltype,'normal') % left click
%    src.Pointer = 'fleur';
%https://undocumentedmatlab.com/blog/undocumented-mouse-pointer-functions
    setptr(gcf, 'closedhand');
    cp = ah.CurrentPoint;
    xlim_init = ah.XLim;
    ylim_init = ah.YLim;
    xinit = cp(1,1);
    yinit = cp(1,2);
%    hl = line('XData',xinit,'YData',yinit,'Marker','p','color','b');
    src.WindowButtonMotionFcn = @wbmcb;
    src.WindowButtonUpFcn = @wbucb;
end

    function wbmcb(src,callbackdata) % button motion
        cpbm = ah.CurrentPoint;
  %      cpbm
        newX = cpbm(1,1);
        newY = cpbm(1,2);
        deltaX = newX - xinit;
        deltaY = newY - yinit;
        ah.XLim = xlim_init - deltaX;
        ah.YLim = ylim_init - deltaY;
        
        %     xinit = newX;
        xlim_init = ah.XLim;
        %        xlim_init = xlim_init + (- deltaX);
        %     yinit = newY;
        ylim_init = ah.YLim; % ylim_init - deltaY;
    end

  

    function wbucb(src,callbackdata)  % button up
        fig = src;
         setptr(fig, 'hand1');
         src.WindowButtonMotionFcn = @deadfcn;
         plot_fcns(fig)
         
%         last_seltype = src.SelectionType;
%         if strcmp(last_seltype,'alt')
%             src.Pointer = 'arrow';
%             src.WindowButtonMotionFcn = '';
%             src.WindowButtonUpFcn = '';
%         else
%             return
%         end
    end

    function deadfcn(src, callbackdata) % stop the button motion function
    end
end