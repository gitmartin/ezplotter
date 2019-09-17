function varargout = ezp_help(varargin)
% EZP_HELP MATLAB code for ezp_help.fig
%      EZP_HELP, by itself, creates a new EZP_HELP or raises the existing
%      singleton*.
%
%      H = EZP_HELP returns the handle to a new EZP_HELP or the handle to
%      the existing singleton*.
%
%      EZP_HELP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EZP_HELP.M with the given input arguments.
%
%      EZP_HELP('Property','Value',...) creates a new EZP_HELP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ezp_help_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ezp_help_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to ezp_help ezp_help

% Last Modified by GUIDE v2.5 14-Sep-2019 14:46:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ezp_help_OpeningFcn, ...
                   'gui_OutputFcn',  @ezp_help_OutputFcn, ...
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


% --- Executes just before ezp_help is made visible.
function ezp_help_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ezp_help (see VARARGIN)

% Choose default command line output for ezp_help
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ezp_help wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ezp_help_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
