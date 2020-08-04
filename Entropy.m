%bebinim ke aya ba axe lena fusion anjam mide dorost ?
clear;
lena=imread('33.jpg');
noisy=imnoise(lena,'salt & pepper',0.07);
se{1}=strel([0 0 0;1 1 1;0 0 0]);

se{2}=strel([1 0 0;0 1 0;0 0 1 ]);
   
se{3}=strel([ 0 0 1;0 1 0;1 0 0]);

se{4}=strel([ 0 1 0;0 1 0;0 1 0]);
   sumEntropy=0;   
open1=cell(4,1);
recons1=cell(4,1);
recons2=cell(4,1);
erode1=cell(4,1);
close1=cell(4,1);
b2=cell(4,1);
b3=cell(4,1);   
for i=1 : 4

open1{i}=imopen(noisy,se{i});
recons1{i}=imreconstruct(open1{i},noisy);
close1{i}=imclose(noisy,se{i});
recons2{i}=imreconstruct(close1{i},noisy);
erode1{i}=imerode(recons2{i},se{i});
b2{i}=imdilate(recons1{i},se{i});
b3{i}=imsubtract(recons1{i},recons2{i});

%figure,imshow(b3{i});title(i);
sumEntropy= sumEntropy+entropy(b3{i});
 %  figure, imshow(b5{i});title(i);
end

   b4=0;
     w=cell(4,1);
for i=1 : 4
    w{i}=entropy(b3{i})/sumEntropy;
    
    b4= w{i}*b3{i}+b4;
end
figure,imshow(b4);title('final');