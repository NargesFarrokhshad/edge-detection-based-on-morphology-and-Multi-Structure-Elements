
clear all;clc;close all;%---Clear workspace and command window
%---Read image form the specified path and assign it to In
 [In,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';'*.*','All Files' },'Select Image File');
 Image =rgb2gray(imread(strcat(PathName,In)));  
noisy=imnoise(Image,'salt & pepper',0.05);

%create 8 SE
se{1}=[0 0 0 0 0           %0 degree 
       0 0 0 0 0
       1 1 1 1 1
       0 0 0 0 0
       0 0 0 0 0];

se{2}=[1 0 0 0 0        %135 degree
       0 1 0 0 0
       0 0 1 0 0
       0 0 0 1 0
       0 0 0 0 1];

se{3}=[ 0 0 0 0 1        %45 degree
        0 0 0 1 0
        0 0 1 0 0
        0 1 0 0 0
        1 0 0 0 0];

se{4}=[ 0 0 1 0 0        %90 degree
        0 0 1 0 0
        0 0 1 0 0
        0 0 1 0 0
        0 0 1 0 0];
    
se{5}=[ 0 0 0 0 0        %22.5 degree
        0 0 0 0 1
        0 0 1 0 0
        1 0 0 0 0
        0 0 0 0 0];
    
se{6}=[ 0 0 0 0 0        %90 degree
        1 0 0 0 0
        0 0 1 0 0
        0 0 0 0 1
        0 0 0 0 0];
    
se{7}=[ 0 0 0 1 0        %90 degree
        0 0 0 0 0
        0 0 1 0 0
        0 0 0 0 0
        0 1 0 0 0];
    
se{8}=[ 0 1 0 0 0        %90 degree
        0 0 0 0 0
        0 0 1 0 0
        0 0 0 0 0
        0 0 0 1 0];
 
    
sumEntropy=0;   
b1=cell(8,1);
b2=cell(8,1);
b3=cell(8,1);
I1=cell(8,1);
I2=cell(8,1);
I3=cell(8,1);
I4=cell(8,1);

   %our algorithm with reconstruction and multi structure
for i=1 : 8
I1{i} = imerode(noisy, se{i});
I2{i} = imreconstruct(I1{i}, noisy); %after opening by reconstruction
I3{i} = imdilate(I2{i}, se{i});
I4{i} = imreconstruct(imcomplement(I3{i}), imcomplement(I2{i}));
I4{i} = imcomplement(I4{i}); %denoised image

b1{i}=imclose(I4{i},se{i});
b2{i}=imdilate(b1{i},se{i});
b3{i}=imsubtract(b2{i},b1{i}); %8 edge detected

sumEntropy= sumEntropy+entropy(b3{i});
  % figure, imshow(b3{i});title(i);
end

    b4=0;
     w=cell(8,1);
for i=1 : 8
    w{i}=entropy(b3{i})/sumEntropy;
    
    b4= w{i}*b3{i}+b4; %final edge detected
end
subplot(121),imshow(b4);title('multi strcuture novel');


%Zhao
see=strel('square',5);
a1=imclose(noisy,see);
a2=imopen(a1,see);
a3=imclose(a2,see);
a4=imdilate(a3,see);
a6=imsubtract(a4,a3);
subplot(122),imshow(a6);title('Zhao');

% classic edge detectors
sobel=edge(noisy,'sobel');
prewitt=edge(noisy,'prewitt');
roberts=edge(noisy,'roberts');
log=edge(noisy,'log');
figure;
 subplot(323),imshow(sobel);title('sobel');
 subplot(324),imshow(prewitt);title('prewitt');
 subplot(325),imshow(log);title('log');
 subplot(326),imshow(roberts);title('roberts');
 subplot(322),imshow(noisy);title('noisy');
 subplot(321),imshow(Image);title('origin');
