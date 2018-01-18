function varargout = ONR_testSetupGUI(varargin)
% ONR_TESTSETUPGUI MATLAB code for ONR_testSetupGUI.fig
%      ONR_TESTSETUPGUI, by itself, creates a new ONR_TESTSETUPGUI or
%      raises the existing singleton*.
%
%      H = ONR_TESTSETUPGUI returns the handle to a new ONR_TESTSETUPGUI or
%      the handle to the existing singleton*.
%
%      ONR_TESTSETUPGUI('CALLBACK',hObject,eventData,handles,...) calls the
%      local function named CALLBACK in ONR_TESTSETUPGUI.M with the given
%      input arguments.
%
%      ONR_TESTSETUPGUI('Property','Value',...) creates a new
%      ONR_TESTSETUPGUI or raises the existing singleton*.  Starting from
%      the left, property value pairs are applied to the GUI before
%      ONR_testSetupGUI_OpeningFcn gets called.  An unrecognized property
%      name or invalid value makes property application stop.  All inputs
%      are passed to ONR_testSetupGUI_OpeningFcn via varargin.
%
%      *See GUI Options stream GUIDE's Tools menu.  Choose "GUI allows only
%      one instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ONR_testSetupGUI

% Last Modified by GUIDE v2.5 16-Jan-2018 16:35:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ONR_testSetupGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ONR_testSetupGUI_OutputFcn, ...
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

% --- Executes just before ONR_testSetupGUI is made visible.
function ONR_testSetupGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn. hObject    handle to
% figure eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) varargin
% command line arguments to ONR_testSetupGUI (see VARARGIN)

% Choose default command line output for ONR_testSetupGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%close all;          % close all figures clear;          % clear all
%workspace variables
clc;                % clear the command line
fclose('all');      % close all open files
delete(instrfindall);   % Reset Com Port
delete(timerfindall);   % Delete Timers
global INPUTBUFFER 
INPUTBUFFER = 512;
%ports = instrfindall;
global ports remainingComports1 remainingComports2 remainingComports3
ports = seriallist;
% remainingComports = ports;
%ports = {ports,"COM8", "COM9", "COM10"};
remainingComports1 = ports;

%ports = {ports};
comports = [];
%portNames = ports.name for i = 1:size(ports,2)
%comports(i) = string(ports.name(i));
set(handles.Select_tempSensorCOM,'String',remainingComports1);
contents = get(handles.Select_tempSensorCOM,'String');
value = get(handles.Select_tempSensorCOM,'Value');
% contents = cellstr(get(hObject,'String'));
selectedTempComPort = contents(value); %returns selected item from Select_forceSensorCOM
remainingComports2 = ports(string(ports)~=selectedTempComPort);
set(handles.Select_forceSensorCOM,'String',remainingComports1);

contents = get(handles.Select_forceSensorCOM,'String');
value = get(handles.Select_forceSensorCOM,'Value');
selectedForceComPort = contents(value); %returns selected item from Select_forceSensorCOM
% contents = cellstr(get(hObject.Select_tempSensorCOM,'String'));
% selectedForceComPort = contents{get(hObject,'Value')}; %returns selected item from Select_forceSensorCOM
remainingComports3 = remainingComports2(string(remainingComports2)~=selectedForceComPort);
set(handles.Select_MotorCOM,'String',remainingComports1);

%set(handles.text1,'String',num2str(numConnectedCameras));
%end

% global forceSensor; global thermocouple;
global number;
global startTime;
global fid;
global mData;
global t;

number = 1;
t=0;
stop = false;
startTime = datetime('now');
header1 = 'Time';
header2 = 'Temperature!';
header3 = 'Force';
fid = fopen('timeTempForce.txt','w');
fprintf(fid, [ header1 '     ' header2 '     ' header3 '\n']);
mData = [];
% UIWAIT makes ONR_testSetupGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = ONR_testSetupGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT); hObject
% handle to figure eventdata  reserved - to be defined in a future version
% of MATLAB handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function Select_tempSensorCOM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Select_tempSensorCOM (see GCBO) eventdata  reserved
% - to be defined in a future version of MATLAB handles    empty - handles
% not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background stream Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes stream selection change in Select_tempSensorCOM.
function Select_tempSensorCOM_Callback(hObject, eventdata, handles)
% hObject    handle to Select_tempSensorCOM (see GCBO) eventdata  reserved
% - to be defined in a future version of MATLAB handles    structure with
% handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns
% Select_tempSensorCOM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        Select_tempSensorCOM
%global INPUTBUFFER ports remainingComports
% contents = cellstr(get(hObject,'String'));
% selectedTempComPort = contents{get(hObject,'Value')}; %returns selected item from Select_forceSensorCOM
% remainingComports = ports(string(ports)~=selectedTempComPort);
% set(handles.Select_forceSensorCOM,'String',remainingComports);
% set(handles.Select_MotorCOM,'String',remainingComports);

% --- Executes during object creation, after setting all properties.
function Select_forceSensorCOM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Select_forceSensorCOM (see GCBO) eventdata  reserved
% - to be defined in a future version of MATLAB handles    empty - handles
% not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background stream Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes stream selection change in Select_forceSensorCOM.
function Select_forceSensorCOM_Callback(hObject, eventdata, handles)
% hObject    handle to Select_forceSensorCOM (see GCBO) eventdata  reserved
% - to be defined in a future version of MATLAB handles    structure with
% handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns
% Select_forceSensorCOM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        Select_forceSensorCOM
% global INPUTBUFFER ports remainingComports
% contents = cellstr(get(hObject,'String'));
% selectedForceComPort = contents{get(hObject,'Value')}; %returns selected item from Select_forceSensorCOM
% remainingComports = remainingComports(string(remainingComports)~=selectedForceComPort);
% set(handles.Select_tempSensorCOM,'String',remainingComports);
% set(handles.Select_MotorCOM,'String',remainingComports);

% --- Executes during object creation, after setting all properties.
function Select_MotorCOM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Select_MotorCOM (see GCBO) eventdata  reserved - to
% be defined in a future version of MATLAB handles    empty - handles not
% created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in Select_MotorCOM.
function Select_MotorCOM_Callback(hObject, eventdata, handles)
% hObject    handle to Select_MotorCOM (see GCBO) eventdata  reserved - to
% be defined in a future version of MATLAB handles    structure with
% handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns Select_MotorCOM
% contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        Select_MotorCOM
% global INPUTBUFFER ports remainingComports
% contents = cellstr(get(hObject,'String'));
% selectedTempComPort = contents{get(hObject,'Value')}; %returns selected item from Select_forceSensorCOM
% remainingComports = remainingComports(string(remainingComports)~=selectedTempComPort);
% set(handles.Select_tempSensorCOM,'String',remainingComports);
% set(handles.Select_forceSensorCOM,'String',remainingComports);

% --- Executes stream button press in Open_Ports.
function Open_Ports_Callback(hObject, eventdata, handles)
% hObject    handle to Open_Ports (see GCBO) eventdata  reserved - to be
% defined in a future version of MATLAB handles    structure with handles
% and user data (see GUIDATA)

%fscanf(thermocouple);


% --- Executes on button press in startStopTemp.
function startStopTemp_Callback(hObject, eventdata, handles)
    % hObject    handle to startStopTemp (see GCBO) eventdata  reserved - to be
    % defined in a future version of MATLAB handles    structure with handles
    % and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of startStopTemp
    global INPUTBUFFER
    global number;
    global startTime;
    global fid;
    global mData;
    global t;
    h1 = animatedline;
    h2 = animatedline;
    contents = get(handles.Select_tempSensorCOM,'String');
    value = get(handles.Select_tempSensorCOM,'Value');
    selectedTempComPort = contents(value); %returns selected item from Select_tempSensorCOM
    thermocouple = serial(selectedTempComPort, 'BaudRate', 115200, 'DataBits',8);
    set(thermocouple,'InputBufferSize', INPUTBUFFER);
    fopen(thermocouple);          %opens the serial port
    
    contents = get(handles.Select_forceSensorCOM,'String');
    value = get(handles.Select_forceSensorCOM,'Value');
    selectedForceComPort = contents(value); %returns selected item from Select_forceSensorCOM
    forcesensor = serial(selectedForceComPort, 'BaudRate', 115200, 'DataBits',8);
    set(forcesensor,'InputBufferSize', INPUTBUFFER);
    %fopen(forcesensor);          %opens the serial port
    
    contents = get(handles.Select_MotorCOM,'String');
    value = get(handles.Select_MotorCOM,'Value');
    selectedMotorComPort = contents(value); %returns selected item from Select_forceSensorCOM
    motor = serial(selectedMotorComPort, 'BaudRate', 115200, 'DataBits',8);
    set(motor,'InputBufferSize', INPUTBUFFER);
    %fopen(motor);          %opens the serial port
    
    if (isvalid([thermocouple, forcesensor, motor]))
        set(handles.status,'String',"Success");
    end
    
    %if(get(hObject,'Value'))
        
        
        
        %send a code to arduino that indicates the start of motor in a certain
        %direction this code should include the number from the slider that
        %shows the goal position of the motor
        %fscanf(forceSensor)
%         while(number<15000)
        while(get(hObject,'Value'))
        %query the temperature
        temperature = (fscanf(thermocouple));
        temperature = strsplit(temperature,' '); % same character as the Arduino code
        mData(1) = str2double(temperature(1)); 
        % query the force sensor
%         fprintf(forcesensor,'?');
%         fprintf(forcesensor,'CR/LF');
%         data = (fscanf(forcesensor));
%         force = strsplit(data,' '); % same character as the Arduino code
       % mData(2) = str2double(force(1)); 
        % Get current time
        t =  second(datetime('now')) - second(startTime); 
        axisTime = datetime('now') - startTime; 
        %%============================================= Draw animatedline
        % Add points to animation
        %axes(handles.axes1);
        addpoints(h1,datenum(axisTime),mData(1))
        % Update axes
        tempGraph.XLim = datenum([axisTime-seconds(15) axisTime]);
        datetick('x','keeplimits')
        drawnow
        
        %axes(handles.axes2);
%         addpoints(h2,datenum(axisTime),mData(2))
%         % Update axes
%         forceGraph.XLim = datenum([axisTime-seconds(15) axisTime]);
%         datetick('x','keeplimits')
%         drawnow
        %%==============================================
        number = number+1;
        fprintf(fid, '%f %f %f \n', t,mData(1),mData(1));
        pause(.001)
        end
%     else
%         delete(instrfindall);
%     end
% --- Executes stream button press in OFF.


% --- Executes during object creation, after setting all properties.
function status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
