function varargout = LED_Blink(varargin)
% LED_BLINK MATLAB code for LED_Blink.fig
%      LED_BLINK, by itself, creates a new LED_BLINK or raises the existing
%      singleton*.
%
%      H = LED_BLINK returns the handle to a new LED_BLINK or the handle to
%      the existing singleton*.
%
%      LED_BLINK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LED_BLINK.M with the given input arguments.
%
%      LED_BLINK('Property','Value',...) creates a new LED_BLINK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LED_Blink_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LED_Blink_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LED_Blink

% Last Modified by GUIDE v2.5 13-Jan-2018 12:56:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LED_Blink_OpeningFcn, ...
                   'gui_OutputFcn',  @LED_Blink_OutputFcn, ...
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


% --- Executes just before LED_Blink is made visible.
function LED_Blink_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LED_Blink (see VARARGIN)

% Choose default command line output for LED_Blink
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
delete(instrfind({'PORT'},{'COM10'}));
clear all;
clc;
global a;
a = arduino;
tempSensor = spidev(a, 'D10');
writeRead(tempSensor, [hex2dec('12'), regVal], 'uint8');
% UIWAIT makes LED_Blink wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LED_Blink_OutputFcn(hObject, eventdata, handles) 
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
global a;
writeDigitalPin(a,'D13',1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
writeDigitalPin(a,'D13',0);
