function varargout = main_gui(varargin)
% MAIN_GUI MATLAB code for main_gui.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_gui

% Last Modified by GUIDE v2.5 24-Oct-2022 18:06:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @main_gui_OutputFcn, ...
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


% --- Executes just before main_gui is made visible.
function main_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_gui (see VARARGIN)

% Choose default command line output for main_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

global dirOutput;   %dicom所在的文件夹
global num;   %dicom文件的个数
global index;   %读取第index个dicom文件
global pathname;   %dicom文件名
global img2;
global img;
pathname = uigetdir(cd,'pick a dicom folder');
if isequal(pathname,0)
    return;
end
dirOutput=dir(fullfile(pathname,'*.dcm'));
num=size(dirOutput);
index=1; %默认显示文件夹下的第一副dicom图像
filename=dirOutput(index).name; 
fpath=fullfile(pathname,filename);
disp(fpath);
axes(handles.axes1);
set(handles.axes1,'xtick',[]);
set(handles.axes1,'xtick',[]);
imgsrc=dicomread(fpath);
setappdata(handles.axes1,'imgsrc',imgsrc);
imshow(imgsrc,[]);
img = imgsrc;
img2 =img;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

global dirOutput;
global index;
global pathname;
global img2;
global img;
if(index<2)
    f=warndlg('已经是第一张图片了哦！','警告');
    return;
end
index=index-1;
filename=dirOutput(index).name;
fpath=fullfile(pathname,filename);
disp(fpath);
axes(handles.axes1);
set(handles.axes1,'xtick',[]);
set(handles.axes1,'xtick',[]);
imgsrc=dicomread(fpath);
setappdata(handles.axes1,'imgsrc',imgsrc);
imshow(imgsrc,[]);
img = imgsrc;
img2 =img;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

global dirOutput;
global num;
global index;
global pathname;
global imgsrc;
global img;
global img2;
if(index>num-1)
    f=warndlg('已经是最后图片了哦！','警告');
    return;
end
index=index+1;
filename=dirOutput(index).name;
fpath=fullfile(pathname,filename);
disp(fpath);
axes(handles.axes1);
set(handles.axes1,'xtick',[]);
set(handles.axes1,'xtick',[]);
imgsrc=dicomread(fpath);
setappdata(handles.axes1,'imgsrc',imgsrc);
imshow(imgsrc,[]);
img = imgsrc;
img2 =img;


% --- Executes on button press in exitbutton.
function exitbutton_Callback(hObject, eventdata, handles)
close;

% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function yuzhi_Callback(hObject, eventdata, handles)
% hObject    handle to yuzhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yuzhi as text
%        str2double(get(hObject,'String')) returns contents of yuzhi as a double


% --- Executes during object creation, after setting all properties.
function yuzhi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yuzhi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fengebutton.
function fengebutton_Callback(hObject, eventdata, handles)
global img2;
global img;
global T;
global img5;
num = str2num(get(handles.hand,'string'));
if isempty(img) || (isempty(img2)&&isempty(num))
    errordlg('未选择图片或未选择分割方法','警告','modal');
    
elseif isempty(num)
axes(handles.axes2)
imshow(img2,[]);
clear global img2;
clear global img;

else
img5 = im2bw(img5,num/255);
axes(handles.axes2)
imshow(img5,[]);
img5 = img2;
clear global img2;
clear global img;

end
set(handles.yuzhi,'String',num2str(T*225));


function hand_Callback(hObject, eventdata, handles)
% hObject    handle to hand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hand as text
%        str2double(get(hObject,'String')) returns contents of hand as a double


% --- Executes during object creation, after setting all properties.
function hand_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img3;
global img4;
img4 = img3;
imshow(img4,[]);
axes(handles.axes2)
clear global img3;

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
global img3;
img3=~img3;
se1=strel('disk',3);
img3=imerode(img3,se1);
img3=~img3;


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
global img3;
[m,n]=size(img3);
img3=ones(m,n)-img3;
B=[0 1 0;1 1 1;0 1 0];
img3 = imdilate(img3,B);
img3=ones(m,n)-img3;


% --- Executes on button press in checkbox2.
function checkbox3_Callback(hObject, eventdata, handles)
global img3;
[m,n]=size(img3);
img3=ones(m,n)-img3;
img3 = imfill(img3,'holes');
img3 = ones(m,n)-img3;


% --- Executes on button press in checkbox1.
function checkbox4_Callback(hObject, eventdata, handles)
global img3;
img3=~img3;
img3 = bwareaopen(img3,50);
img3=~img3;


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axis off 
global img2;
%a3=des3;
global img3;
img3 = imbinarize(img2); 
axes(handles.axes2);
imshow(img3);


% --- Executes on button press in baocunbutton.
function baocunbutton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';...
                                 '*.bmp','Bitmap(*.bmp)';...
                                 '*.gif','GIF(*.gif)';...
                                 '*.*',  'All Files (*.*)'},...
                                 'Save Picture','Untitled');
if FileName==0
    return;
else
    h=getframe(handles.axes2);
    imwrite(h.cdata,[PathName,FileName]);
end;


% --- Executes on button press in moving.
function moving_Callback(hObject, eventdata, handles)
global img2;
global img4;
global T;
set(handles.watershed,'Value',0);
set(handles.watershed2,'Value',0);
set(handles.basis,'Value',0);
set(handles.Otus,'Value',0);
set(handles.changable,'Value',0);
set(handles.smooth,'Value',0);
set(handles.area,'Value',0);
set(handles.grow,'Value',0);
set(handles.edge,'Value',0);
if isempty(img2)
    errordlg('未选择需要分割的图像','警告','modal');
    set(handles.moving,'Value',0);
else if handles.moving.Value~=0
    movingGUI;
    img4=img2;
else
        clear global img2;
    end
end


% --- Executes on button press in basis.
function basis_Callback(hObject, eventdata, handles)
global img2;
global img5;
global T;
set(handles.moving,'Value',0);
set(handles.watershed,'Value',0);
set(handles.watershed2,'Value',0);
set(handles.Otus,'Value',0);
set(handles.changable,'Value',0);
set(handles.smooth,'Value',0);
set(handles.area,'Value',0);
set(handles.grow,'Value',0);
set(handles.edge,'Value',0);
if isempty(img2)
    errordlg('未选择需要分割的图像','警告','modal');
    set(handles.basis,'Value',0);
else if handles.basis.Value~=0
    basis;
    img5=img2;
else
        clear global des2;
    end
end


% --- Executes on button press in Otus.
function Otus_Callback(hObject, eventdata, handles)
global img2;
global img;
global img4;
global T;
set(handles.watershed,'Value',0);
set(handles.moving,'Value',0);
set(handles.watershed2,'Value',0);
set(handles.smooth,'Value',0);
set(handles.basis,'Value',0);
set(handles.changable,'Value',0);
set(handles.area,'Value',0);
set(handles.grow,'Value',0);
set(handles.edge,'Value',0);
if isempty(img2)
    errordlg('未选择需要分割的图片','警告','modal');
    set(handles.Otus,'Value',0);
else if handles.Otus.Value~=0
    %otus分割部分
    [T,SM] = graythresh(img2);
    img2 = im2bw(img,T);
    img4=img2;
else
        clear global img2;
    end
end


% --- Executes on button press in smooth.
function smooth_Callback(hObject, eventdata, handles)
global img;
global img2;
global img4;
global T;
set(handles.moving,'Value',0);
set(handles.watershed,'Value',0);
set(handles.watershed2,'Value',0);
set(handles.Otus,'Value',0);
set(handles.basis,'Value',0);
set(handles.changable,'Value',0);
set(handles.area,'Value',0);
set(handles.grow,'Value',0);
set(handles.edge,'Value',0);
if isempty(img)
    errordlg('未选择需要分割的图像','警告','modal');
    set(handles.smooth,'Value',0);
else if handles.smooth.Value~=0
    smoothed;
    img4=img2;
else
        clear global img2;
    end
end


% --- Executes on button press in watershed.
function watershed_Callback(hObject, eventdata, handles)
global img;
global img2;
global img5;
global T;
set(handles.moving,'Value',0);
set(handles.watershed2,'Value',0);
set(handles.basis,'Value',0);
set(handles.Otus,'Value',0);
set(handles.changable,'Value',0);
set(handles.smooth,'Value',0);
set(handles.area,'Value',0);
set(handles.grow,'Value',0);
set(handles.edge,'Value',0);
if isempty(img)
    errordlg('未选择需要分割的图像','警告','modal');
    set(handles.watershed,'Value',0);
else if handles.watershed.Value~=0
    Watershed;
    img5=img2;
else
        clear global img2;
    end
end


% --- Executes on button press in watershed.
function radiobutton31_Callback(hObject, eventdata, handles)
global img;
global img2;
global img5;
global T;
set(handles.moving,'Value',0);
set(handles.watershed2,'Value',0);
set(handles.basis,'Value',0);
set(handles.Otus,'Value',0);
set(handles.changable,'Value',0);
set(handles.smooth,'Value',0);
set(handles.area,'Value',0);
set(handles.grow,'Value',0);
set(handles.edge,'Value',0);
if isempty(img)
    errordlg('未选择需要分割的图像','警告','modal');
    set(handles.Watershed,'Value',0);
else if handles.Watershed.Value~=0
    Watershed;
    img5=img2;
else
        clear global img2;
    end
end


% --- Executes on button press in watershed2.
function watershed2_Callback(hObject, eventdata, handles)
global img;
global img2;
global img5;
global T;
set(handles.moving,'Value',0);
set(handles.watershed,'Value',0);
set(handles.basis,'Value',0);
set(handles.Otus,'Value',0);
set(handles.changable,'Value',0);
set(handles.smooth,'Value',0);
set(handles.area,'Value',0);
set(handles.grow,'Value',0);
set(handles.edge,'Value',0);
if isempty(img)
    errordlg('未选择需要分割的图像','警告','modal');
    set(handles.watershed2,'Value',0);
else if handles.watershed2.Value~=0
    Watershed2;
    img5=img2;
else
        clear global img2;
    end
end


% --- Executes on button press in grow.
function grow_Callback(hObject, eventdata, handles)
global img;
global img2;
global img5;
global T;
set(handles.moving,'Value',0);
set(handles.watershed,'Value',0);
set(handles.basis,'Value',0);
set(handles.Otus,'Value',0);
set(handles.changable,'Value',0);
set(handles.smooth,'Value',0);
set(handles.area,'Value',0);
set(handles.watershed2,'Value',0);
set(handles.edge,'Value',0);
if isempty(img)
    errordlg('未选择需要分割的图像','警告','modal');
    set(handles.grow,'Value',0);
else if handles.grow.Value~=0
 tmp=img2;
[rows,cols]=size(img2); 
img2=double(img2);
rongcha=60; %此处可以自己指定容差范围，即阈值
[y0,x0]=getpts;%getpts函数本身就可以获得多个点，并返回多个点的坐标
x0=round(x0);
y0=round(y0);
R=zeros(rows,cols);
R=uint8(R);%作为检测区域是否满足区域生长条件的判断矩阵
ii=length(x0);
for k=1:ii
    seed(k)=img2(x0(k),y0(k));
    R(x0(k),y0(k))=255; %把选定的点作为起始点
end
avr=mean(seed);
totalnum=ii;  %计算生长区域内像素点的个数，此处为初始化
msum=sum(seed); %计算生长区域内像素的总和，此处为初始化
count=1;
while count>0
    count=0;
    for i=1:rows
        for j=1:cols
            if R(i,j)==255
                if i>1&&i<rows&&j>1&&j<cols%图像边界判断
                    for u=-1:1
                        for v=-1:1
                            if R(i+u,j+v)==0&&abs(img2(i+u,j+v)-avr)<=rongcha
                                R(i+u,j+v)=255;
                                count=1;
                                totalnum=totalnum+1;
                                msum=msum+img2(i+u,j+v);
                            end
                        end
                    end
                end
            end
        end
    end
    avr=msum/totalnum;
end
imd=imdilate(R,strel('disk',3));
res=imfill(imd,'holes');
axes(handles.axes2);
imshow(res,[]);

[row, col] = ind2sub(size(res),find(res~=0));
res_img=zeros(size(img2));
for i = 1 : length(row)
    res_img(row(i),col(i),:) = tmp(row(i),col(i));
end
else
        clear global img2;
    end
end


% --- Executes on button press in edge.
function edge_Callback(hObject, eventdata, handles)
global img;
global img2;
global img5;
global T;
set(handles.moving,'Value',0);
set(handles.watershed,'Value',0);
set(handles.watershed2,'Value',0);
set(handles.Otus,'Value',0);
set(handles.basis,'Value',0);
set(handles.changable,'Value',0);
set(handles.area,'Value',0);
set(handles.grow,'Value',0);
set(handles.smooth,'Value',0);
if isempty(img)
    errordlg('未选择需要分割的图像','警告','modal');
    set(handles.edge,'Value',0);
else if handles.edge.Value~=0
    edged;
    img5=img2;
else
        clear global img2;
    end
end
