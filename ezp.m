%%% RUN THIS FILE, OR TYPE 'ezp' IN THE COMMAND WINDOWS TO START THE GUI. 
%%% ezp 
%%% Copyright (c) 2019, Martin Carrington
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions
% are met:
%
% 1. Redistributions of source code must retain the above copyright
% notice, this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright
% notice, this list of conditions and the following disclaimer in the
% documentation and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
% FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
% HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
% TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
% OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
% OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function varargout = ezp(varargin)
% EZP MATLAB code for ezp.fig
%      EZP, by itself, creates a new EZP or raises the existing
%      singleton*.
%
%      H = EZP returns the handle to a new EZP or the handle to
%      the existing singleton*.
%
%      EZP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EZP.M with the given input arguments.
%
%      EZP('Property','Value',...) creates a new EZP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ezp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ezp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ezp

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ezp_OpeningFcn, ...
                   'gui_OutputFcn',  @ezp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
               
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function struct = setup_struct()
f1.name = 'func1';
f2.name = 'func2';
f3.name = 'func3';
f1.Style = '-';
f2.Style = '-';
f3.Style = '-';
f1.Color = 'b';
f2.Color = 'r';
f3.Color = 'k';
f1.Linewidth = 0.5;
f2.Linewidth = 0.5;
f3.Linewidth = 0.5;
struct = {f1,f2,f3};

% --- Executes just before ezp is made visible.
function ezp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ezp (see VARARGIN)

% Choose default command line output for ezp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ezp wait for user response (see UIRESUME)
% uiwait(handles.figure1);

handles.figureGUI = handles.figure1;
handles.figure1 = figure;
axis([-1 1 -1 1])

handles.figure1.UserData = setup_struct();
guidata(hObject,handles)

set(handles.figure1,'WindowScrollWheelFcn', @my_zoom_fcn);
set(handles.figure1, 'WindowButtonDownFcn', @mypan);

uicontrol(handles.edit1); % give focus to text edit

%screenSize = get(0, 'ScreenSize');
%   [1  1   1920    1080]

%set(handles.figureGUI,'Units', 'pixels');
% figureGUI_dims = handles.figureGUI.Position(3:end)
% set(handles.figureGUI,'Position', [0 (1080-figureGUI_dims(2)) figureGUI_dims]);
% handles.figureGUI.Position

movegui(handles.figureGUI, 'northwest')
%gui_pos = handles.figureGUI.Position;
%handles.figureGUI.Units

%set(handles.figure1,'Units', 'pixels');
%start = 90 + handles.figureGUI.Position(3);
%plot_pos = [gui_pos(1)+gui_pos(3)+0, gui_pos(2),  560, 420];
%plot_pos(1) = plot_pos(1) + 300;
%set(handles.figure1,'Position', 'north');
movegui(handles.figure1,'north')


set(handles.pop_colorf1, 'Value', 6);
set(handles.pop_colorf2, 'Value', 4);
set(handles.pop_colorf3, 'Value', 8);

% --- Outputs from this function are returned to the command line.
function varargout = ezp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% add function string to figure's UserData property

edit_string = get(handles.edit1,'String');

fcn_string = fcn_string_from_edit_string(edit_string);
if ~isvalid(handles.figure1) % check if figure has been closed
    handles.figure1 = figure;
    axis([-1 1 -1 1])
    handles.figure1.UserData = setup_struct(); 
    guidata(hObject,handles)
    set(handles.figure1,'WindowScrollWheelFcn', @my_zoom_fcn);
    set(handles.figure1, 'WindowButtonDownFcn', @mypan);
end

fig = handles.figure1;

fig.UserData{1}.fcn_string = fcn_string;

% display fcn_string in GUI
handles.matlab_expression.String = fcn_string;
   
   
try
    plot_fcns(fig, true);
    handles.text_error.String{1} = ""; % remove error message
catch e
    handles.text_error.String{1} = e.message;
end


uicontrol(handles.edit1); % give focus to text edit


function editf2_Callback(hObject, eventdata, handles)
% hObject    handle to editf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editf2 as text
%        str2double(get(hObject,'String')) returns contents of editf2 as a double
edit_string = get(handles.editf2,'String');

% replace params with their values
%edit_string = strrep(edit_string, 'a', num2str(handles.slider1.Value));

fcn_string = fcn_string_from_edit_string(edit_string);

%handles.figure1 = figure(44)

if ~isvalid(handles.figure1) % check if figure has been closed
    handles.figure1 = figure;
    axis([-1 1 -1 1])
    handles.figure1.UserData = setup_struct();
        
    guidata(hObject,handles)
    set(handles.figure1,'WindowScrollWheelFcn', @my_zoom_fcn);
    set(handles.figure1, 'WindowButtonDownFcn', @mypan);
end

fig = handles.figure1;

fig.UserData{2}.fcn_string = fcn_string;

% display fcn_string in GUI
handles.matlab_expression.String = fcn_string;

try
    plot_fcns(fig, true);
    handles.text_error.String{1} = ""; % remove error message
catch e
    handles.text_error.String{1} = e.message;
end

uicontrol(handles.editf2); % give focus to text edit

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function xmax_Callback(hObject, eventdata, handles)
% hObject    handle to xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmax as text
%        str2double(get(hObject,'String')) returns contents of xmax as a double
value = hObject.String;
fig = handles.figure1;
fig.CurrentAxes.XLim(2) = str2double(value);
plot_fcns(fig)
uicontrol(handles.xmax);

% --- Executes during object creation, after setting all properties.
function xmax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function xmin_Callback(hObject, eventdata, handles)
% hObject    handle to xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmin as text
%        str2double(get(hObject,'String')) returns contents of xmin as a double
value = hObject.String;
fig = handles.figure1;
fig.CurrentAxes.XLim(1) = str2double(value);
plot_fcns(fig)
uicontrol(handles.xmin);

% --- Executes during object creation, after setting all properties.
function xmin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ymin_Callback(hObject, eventdata, handles)
% hObject    handle to ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymin as text
%        str2double(get(hObject,'String')) returns contents of ymin as a double
value = hObject.String;
fig = handles.figure1;
fig.CurrentAxes.YLim(1) = str2double(value);
plot_fcns(fig)
uicontrol(handles.ymin);

% --- Executes during object creation, after setting all properties.
function ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ymax_Callback(hObject, eventdata, handles)
% hObject    handle to ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymax as text
%        str2double(get(hObject,'String')) returns contents of ymax as a double
value = hObject.String;
fig = handles.figure1;
fig.CurrentAxes.YLim(2) = str2double(value);
plot_fcns(fig)
uicontrol(handles.ymax);

% --- Executes during object creation, after setting all properties.
function ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in help.
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ezp_help % call help gui fcn

% --- Executes on button press in toggle_grid.
function toggle_grid_Callback(hObject, eventdata, handles)
% hObject    handle to toggle_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gv = handles.figure1.CurrentAxes.XGrid;
if strcmp(gv, 'off')
     grid(handles.figure1.CurrentAxes,'on')
else
    grid(handles.figure1.CurrentAxes, 'off')
end
    
% --- Executes on button press in axis_equal.
function axis_equal_Callback(hObject, eventdata, handles)
% hObject    handle to axis_equal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axis(handles.figure1.CurrentAxes,'equal')

% --- Executes during object creation, after setting all properties.
function editf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double
ah = handles.figure1.CurrentAxes;
title(ah,hObject.String)

% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_xlabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlabel as text
%        str2double(get(hObject,'String')) returns contents of edit_xlabel as a double
ah = handles.figure1.CurrentAxes;
xlabel(ah,hObject.String)

% --- Executes during object creation, after setting all properties.
function edit_xlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double
ah = handles.figure1.CurrentAxes;
ylabel(ah,hObject.String)

% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in pop_stylef1.
function pop_stylef1_Callback(hObject, eventdata, handles)
% hObject    handle to pop_stylef1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_stylef1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_stylef1
contents = cellstr(get(hObject,'String'));
val = contents{get(hObject,'Value')};
switch val
    case 'solid line'
        style = '-';
    case 'dashed line'
        style = '--';
    case 'dotted line'
        style = ':';
    case 'dash-dot line'
        style = '-.';      
end
handles.figure1.UserData{1}.Style = style;
plot_fcns(handles.figure1)

% --- Executes during object creation, after setting all properties.
function pop_stylef1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_stylef1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_colorf1.
function pop_colorf1_Callback(hObject, eventdata, handles)
% hObject    handle to pop_colorf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_colorf1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_colorf1
contents = cellstr(get(hObject,'String'));
val = contents{get(hObject,'Value')};
switch val
    case 'yellow'
        col = 'y';
    case 'magenta'
        col = 'm';
    case 'cyan'
        col = 'c';
    case 'red'
        col = 'r';
    case 'green'
        col = 'g';
    case 'blue'
        col = 'b';
    case 'white'
        col = 'w';
    case 'black'
        col = 'k';
end
handles.figure1.UserData{1}.Color = col;
plot_fcns(handles.figure1)


% --- Executes during object creation, after setting all properties.
function pop_colorf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_colorf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_stylef2.
function pop_stylef2_Callback(hObject, eventdata, handles)
% hObject    handle to pop_stylef2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_stylef2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_stylef2
contents = cellstr(get(hObject,'String'));
val = contents{get(hObject,'Value')};
switch val
    case 'solid line'
        style = '-';
    case 'dashed line'
        style = '--';
    case 'dotted line'
        style = ':';
    case 'dash-dot line'
        style = '-.';      
end
handles.figure1.UserData{2}.Style = style;
handles.figure1.UserData{2};
plot_fcns(handles.figure1)

% --- Executes during object creation, after setting all properties.
function pop_stylef2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_stylef2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in pop_colorf2.
function pop_colorf2_Callback(hObject, eventdata, handles)
% hObject    handle to pop_colorf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_colorf2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_colorf2
contents = cellstr(get(hObject,'String'));
val = contents{get(hObject,'Value')};
switch val
    case 'yellow'
        col = 'y';
    case 'magenta'
        col = 'm';
    case 'cyan'
        col = 'c';
    case 'red'
        col = 'r';
    case 'green'
        col = 'g';
    case 'blue'
        col = 'b';
    case 'white'
        col = 'w';
    case 'black'
        col = 'k';
end
handles.figure1.UserData{2}.Color = col;
plot_fcns(handles.figure1)



% --- Executes during object creation, after setting all properties.
function pop_colorf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_colorf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_linewidthf1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_linewidthf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_linewidthf1 as text
%        str2double(get(hObject,'String')) returns contents of edit_linewidthf1 as a double
fig = handles.figure1;
val = str2double(get(hObject,'String'));
fig.UserData{1}.Linewidth = val;
plot_fcns(fig);



% --- Executes during object creation, after setting all properties.
function edit_linewidthf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_linewidthf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_linewidthf2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_linewidthf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_linewidthf2 as text
%        str2double(get(hObject,'String')) returns contents of edit_linewidthf2 as a double
fig = handles.figure1;
val = str2double(get(hObject,'String'));
fig.UserData{2}.Linewidth = val;
plot_fcns(fig);

% --- Executes during object creation, after setting all properties.
function edit_linewidthf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_linewidthf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_stylef3.
function pop_stylef3_Callback(hObject, eventdata, handles)
% hObject    handle to pop_stylef3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_stylef3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_stylef3
contents = cellstr(get(hObject,'String'));
val = contents{get(hObject,'Value')};
switch val
    case 'solid line'
        style = '-';
    case 'dashed line'
        style = '--';
    case 'dotted line'
        style = ':';
    case 'dash-dot line'
        style = '-.';      
end
handles.figure1.UserData{3}.Style = style;
plot_fcns(handles.figure1)


% --- Executes during object creation, after setting all properties.
function pop_stylef3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_stylef3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_colorf3.
function pop_colorf3_Callback(hObject, eventdata, handles)
% hObject    handle to pop_colorf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_colorf3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_colorf3
contents = cellstr(get(hObject,'String'));
val = contents{get(hObject,'Value')};
switch val
    case 'yellow'
        col = 'y';
    case 'magenta'
        col = 'm';
    case 'cyan'
        col = 'c';
    case 'red'
        col = 'r';
    case 'green'
        col = 'g';
    case 'blue'
        col = 'b';
    case 'white'
        col = 'w';
    case 'black'
        col = 'k';
end
handles.figure1.UserData{3}.Color = col;
plot_fcns(handles.figure1)

% --- Executes during object creation, after setting all properties.
function pop_colorf3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_colorf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_linewidthf3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_linewidthf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_linewidthf3 as text
%        str2double(get(hObject,'String')) returns contents of edit_linewidthf3 as a double
fig = handles.figure1;
val = str2double(get(hObject,'String'));
fig.UserData{3}.Linewidth = val;
plot_fcns(fig);

% --- Executes during object creation, after setting all properties.
function edit_linewidthf3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_linewidthf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editf3_Callback(hObject, eventdata, handles)
% hObject    handle to editf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editf3 as text
%        str2double(get(hObject,'String')) returns contents of editf3 as a double
edit_string = get(handles.editf3,'String');

fcn_string = fcn_string_from_edit_string(edit_string);

if ~isvalid(handles.figure1) % check if figure has been closed
    handles.figure1 = figure;
    axis([-1 1 -1 1])
    handles.figure1.UserData = setup_struct();
    guidata(hObject,handles)
    set(handles.figure1,'WindowScrollWheelFcn', @my_zoom_fcn);
    set(handles.figure1, 'WindowButtonDownFcn', @mypan);
end

fig = handles.figure1;

fig.UserData{3}.fcn_string = fcn_string;

% display fcn_string in GUI
handles.matlab_expression.String = fcn_string;


try
    plot_fcns(fig, true);
    handles.text_error.String{1} = ""; % remove error message
catch e
    handles.text_error.String{1} = e.message;
end
uicontrol(handles.editf3); % give focus to text edit

% --- Executes during object creation, after setting all properties.
function editf3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function text_error_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object deletion, before destroying properties.
function text_error_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to text_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
