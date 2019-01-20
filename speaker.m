function varargout = speaker(varargin)
% SPEAKER MATLAB code for speaker.fig
%      SPEAKER, by itself, creates a new SPEAKER or raises the existing
%      singleton*.
%
%      H = SPEAKER returns the handle to a new SPEAKER or the handle to
%      the existing singleton*.
%
%      SPEAKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEAKER.M with the given input arguments.
%
%      SPEAKER('Property','Value',...) creates a new SPEAKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before speaker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to speaker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help speaker

% Last Modified by GUIDE v2.5 31-May-2016 09:41:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @speaker_OpeningFcn, ...
                   'gui_OutputFcn',  @speaker_OutputFcn, ...
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


% --- Executes just before speaker is made visible.
function speaker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to speaker (see VARARGIN)

% Choose default command line output for speaker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes speaker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = speaker_OutputFcn(hObject, eventdata, handles) 
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
global vin y;
vin = mfcc2(y); 

dirname=('C:\Users\HP\Documents\MATLAB\speaker identification\database1');

  cur_dir=cd;
  cd (dirname)
  dir_struct = dir(dirname);
  [sorted_names,sorted_index] = sortrows({dir_struct.name}');
  ind=max(sorted_index);
  cd(cur_dir) 

  for ii=3:ind
    
    fname=dir_struct(ii).name;
    tmp='\';
    fullpath=[dirname tmp fname];
    
    [y, fs] = wavread(fullpath);
    v = mfcc2(y);
   
 codebook{ii-2} = v;
        
  end    
   
  distmin = inf;
  k1 = 0;
 
  for l = 1:length(codebook)      % each trained codebook, compute distortion
      d = eqdist(vin, codebook{l});
      dist = sum(min(d,[],2)) / size(d,1)
      
      if dist < distmin
         distmin = dist;
         k1 = l;
      end      
  end

  nm=dir_struct(k1+2).name;
  
  
    l=length(nm);
    nmout=nm(1:l-4) ;
    
    set(handles.text4,'String',nmout)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vin1 y;
vin1 = lpc(y);   
dirname=('C:\Users\HP\Documents\MATLAB\speaker identification\database1');

  cur_dir=cd;
  cd (dirname)
  dir_struct = dir(dirname);
  [sorted_names,sorted_index] = sortrows({dir_struct.name}');
  ind=max(sorted_index);
  cd(cur_dir) 

  for ii=3:ind
    
    fname=dir_struct(ii).name;
    tmp='\';
    fullpath=[dirname tmp fname];
    
    [y, fs] = wavread(fullpath);
    v = lpc(y);
    codebook{ii-2} = v;
        
  end    
   
  distmin = inf;
  k1 = 0;
 
  for l = 1:length(codebook)      % each trained codebook, compute distortion
      d = eqdist(vin1, codebook{l});
      dist = sum(min(d,[],2)) / size(d,1)
      
      if dist < distmin
         distmin = dist;
         k1 = l;
      end      
  end

  nm=dir_struct(k1+2).name;
  
  
    l=length(nm);
    nmout=nm(1:l-4) 
set(handles.text4,'String',nmout)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vin2 y;
vin2 = plp(y);

dirname=('C:\Users\HP\Documents\MATLAB\speaker identification\database1');

  cur_dir=cd;
  cd (dirname)
  dir_struct = dir(dirname);
  [sorted_names,sorted_index] = sortrows({dir_struct.name}');
  ind=max(sorted_index);
  cd(cur_dir) 

  for ii=3:ind
    
    fname=dir_struct(ii).name;
    tmp='\';
    fullpath=[dirname tmp fname];
    
    [y, fs] = wavread(fullpath);
    v = plp(y);
    codebook{ii-2} = v;
        
  end    
   
  distmin = inf;
  k1 = 0;
 
  for l = 1:length(codebook)      % each trained codebook, compute distortion
      d = eqdist(vin2, codebook{l});
      dist = sum(min(d,[],2)) / size(d,1)
      
      if dist < distmin
         distmin = dist;
         k1 = l;
      end      
  end

  nm=dir_struct(k1+2).name;
  
  
    l=length(nm);
    nmout=nm(1:l-4) 
set(handles.text4,'String',nmout)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y vin ;

fs=22000;

[f p]=uigetfile('*.*','Open speech signal');
fp=[p f];
%dirname=('D:\code1516\matlab1516\cummins\speaker identification\input1\u3.wav');
[y, fs] = wavread(fp);


axes(handles.axes1)
plot(y);
% title('plot of voice part of a signal');
% xlabel('sample number');
% ylabel('amplitude');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


close all;
