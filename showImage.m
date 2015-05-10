function varargout = showImage(varargin)
% SHOWIMAGE M-file for showImage.fig
%      SHOWIMAGE, by itself, creates a new SHOWIMAGE or raises the existing
%      singleton*.
%
%      H = SHOWIMAGE returns the handle to a new SHOWIMAGE or the handle to
%      the existing singleton*.
%
%      SHOWIMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOWIMAGE.M with the given input arguments.
%
%      SHOWIMAGE('Property','Value',...) creates a new SHOWIMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before showImage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to showImage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help showImage

% Last Modified by GUIDE v2.5 10-May-2015 17:10:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @showImage_OpeningFcn, ...
                   'gui_OutputFcn',  @showImage_OutputFcn, ...
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


% --- Executes just before showImage is made visible.
function showImage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to showImage (see VARARGIN)

% Choose default command line output for showImage
handles.output = hObject;
clc; 
% Update handles structure
handles.notInit = 1;
handles.width = 400 ; 
handles.height = 500; 



set(handles.checkButton, 'enable', 'off'); 

handles.dirTrainData = 'hasil resize'; 

set(handles.folderName, 'string' , handles.dirTrainData); 

guidata(hObject, handles);

% UIWAIT makes showImage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = showImage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openButton.
function openButton_Callback(hObject, eventdata, handles)
% hObject    handle to openButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path]= uigetfile('*.jpg', 'pilih file MATLAB'); 
if isa(file, 'char') 
     I = (imread([path, file]));
     I = imresize(I, [300, 300]); 
     handles.I = I; 
else
    return; 
end 
imshow(handles.I, 'parent', handles.initAxes ); 

grayImage = rgb2gray(I);
handles.grayImage = grayImage; 
imshow(grayImage,'parent', handles.grayAxes); 
% 
% axes(handles.axesHist); 
% imhist(rgb2gray(handles.I));
% imhist(rgb2gray(handles.I), 'parent', handles.axesHist); 

set(handles.checkButton, 'enable', 'off'); 
cla(handles.gaborAxes,'reset');  
guidata(hObject, handles);

% --- Executes on button press in showGrayButton.
function showGrayButton_Callback(hObject, eventdata, handles)
% hObject    handle to showGrayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    I = handles.I; 
catch ME
    return; 
end
grayImage = rgb2gray(I);
handles.grayImage = grayImage; 
imshow(grayImage,'parent', handles.grayAxes); 

guidata(hObject, handles); 

% --- Executes on button press in showGaborButton.
function showGaborButton_Callback(hObject, eventdata, handles)
% hObject    handle to showGaborButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    I  = handles.I; 
catch ME
    return; 
end
handles.orientasi = 8; 
gaborImage = gabor(I, handles.panjangGel , handles.orientasi ); 
imshow( gaborImage  , 'parent', handles.gaborAxes);

set(handles.checkButton, 'enable', 'on'); 
% 
% popup();
% pause(1.5); 
handles.gaborImage = gaborImage; 
% axes(handles.axesHist); 
% imhist( gaborImage );
guidata(hObject, handles); 


% --- Executes on button press in clearButton.
function clearButton_Callback(hObject, eventdata, handles)
% hObject    handle to clearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% cla(handles.initAxes,'reset'); 
% cla(handles.grayAxes,'reset'); 
cla(handles.gaborAxes,'reset'); 
% cla(handles.axesHist, 'reset'); 
set(handles.checkButton, 'enable', 'off'); 
guidata(hObject, handles ); 


% --- Executes on button press in checkButton.
function checkButton_Callback(hObject, eventdata, handles)
% hObject    handle to checkButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.notInit
    return; 
end

try
    I = handles.I; 
catch ME
    return;
end
I = handles.fPrep(I, handles.width, handles.height ); 
hasil = handles.fClass(handles.H, ... 
    I ); 
hasil = handles.map.get(hasil); 
set(handles.ketNamaPohon, 'string', hasil);

guidata(hObject, handles); 

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupPanjangGel.
function popupPanjangGel_Callback(hObject, eventdata, handles)
% hObject    handle to popupPanjangGel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupPanjangGel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupPanjangGel
val = get(hObject, 'value'); 
str = get(hObject, 'string'); 

panjangGel = str{val};
panjangGel = str2num(panjangGel); 

handles.panjangGel = panjangGel; 

guidata(hObject, handles ); 


% --- Executes during object creation, after setting all properties.
function popupPanjangGel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupPanjangGel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


handles.panjangGel = 3; 

guidata(hObject, handles); 


% --- Executes on selection change in popupOrientasi.
function popupOrientasi_Callback(hObject, eventdata, handles)
% hObject    handle to popupOrientasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject , 'value');
str = get(hObject, 'string'); 

orientasi = str{val}; 
orientasi = str2num(orientasi); 
handles.orientasi = val ; 

guidata(hObject, handles); 


% Hints: contents = get(hObject,'String') returns popupOrientasi contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupOrientasi
% --- Executes during object creation, after setting all properties.
function popupOrientasi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupOrientasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.orientasi = 1 ; 
guidata(hObject, handles); 


% --- Executes on button press in update.
function update_Callback(hObject, eventdata, handles)
% hObject    handle to update (see GCBO)
% eventdata  reserved - to be defined `in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.ketDatabase , 'string', 'WAIT...'); 
drawnow;

[handles.fPrep , handles.fClass, handles.H , handles.map ] ...
     = initSvm(handles.width, handles.height , handles.dirTrainData ); 

set(handles.ketDatabase , 'string', 'UPDATED'); 
handles.notInit = 0 ; 
guidata(hObject, handles); 


% --- Executes on button press in selectFolderButton.
function selectFolderButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectFolderButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathName= uigetdir('./');
if pathName == 0
    disp('not directory selected'); 
    return; 
end
mm = countImageFile(pathName);
if ~ (mm > 0 )
    return; 
end
handles.dirTrainData = pathName;  

temp = regexp(pathName,'\\' ,'split'); 
temp = temp{end}; 
set(handles.folderName, 'string' ,  temp ); 

guidata(hObject, handles); 
