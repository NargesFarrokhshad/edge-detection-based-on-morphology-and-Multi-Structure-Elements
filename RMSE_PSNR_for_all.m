clear;
srcFiles_origin=dir('C:\Users\narg\Desktop\maghale\inputs\*.jpg');
srcFiles_edge_detected_by_multi=dir('C:\Users\narg\Desktop\maghale\multi_structure\*.jpg');
srcFiles_edge_detected_by_zhao=dir('C:\Users\narg\Desktop\maghale\Zhao_outputs\*.jpg');
%srcFiles_edge_detected_by_reconstruct=dir('C:\Users\narg\Desktop\maghale\Reconstruction_output\*.jpg');

RMSE1=cell(182,1);
RMSE2=cell(182,1);
RMSE3=cell(182,1);

psnr1=cell(182,1);
psnr2=cell(182,1);
psnr3=cell(182,1);


for j = 1 : length(srcFiles_origin)

    filename_origin = strcat('C:\Users\narg\Desktop\maghale\inputs\',srcFiles_origin(j).name);
    filename_multi = strcat('C:\Users\narg\Desktop\maghale\multi_structure\',srcFiles_edge_detected_by_multi(j).name);
    filename_Zhao = strcat('C:\Users\narg\Desktop\maghale\Zhao_outputs\',srcFiles_edge_detected_by_zhao(j).name);
    %filename_reconst = strcat('C:\Users\narg\Desktop\maghale\Reconstruction_output\',srcFiles_edge_detected_by_reconstruct(j).name);

    origin =rgb2gray(imread(filename_origin));
    edge_detected_by_multi=imread(filename_multi);
    edge_detected_by_zhao=imread(filename_Zhao);
    %edge_detected_by_reconstruct=imread(filename_reconst);
    n=size(origin); M=n(1); N=n(2);
    
RMSE1{j} = sqrt(sum(sum((origin-edge_detected_by_multi).^2))/(M*N));
 
RMSE2{j} = sqrt(sum(sum((origin-edge_detected_by_zhao).^2))/(M*N));

%RMSE3{j} = sqrt(sum(sum((origin-edge_detected_by_reconstruct).^2))/(M*N));
    
psnr1{j} = 10*log10(255*255/mean2((origin-edge_detected_by_multi).^2));

psnr2{j} = 10*log10(255*255/mean2((origin-edge_detected_by_zhao).^2));

%psnr3{j} = 10*log10(255*255/mean2((origin-edge_detected_by_reconstruct).^2));
end


RMSE_multi_Mean=mean(table2array(RMSE1));
fprintf('\nRMSE_multi: %7.2f ', RMSE_multi_Mean);

RMSE_Zhao_Mean=mean(table2array(RMSE2));
fprintf('\nRMSE_Zhao: %7.2f ', RMSE_Zhao_Mean);

%RMSE_reconst_Mean=mean(table2array(RMSE3));

PSNR_multi_Mean=mean(table2array(psnr1));
fprintf('\nPSNR_multi: %7.2f ', PSNR_multi_Mean);
PSNR_Zhao_Mean=mean(table2array(psnr2));
fprintf('\nPSNR_Zhao: %7.2f ', PSNR_Zhao_Mean);
%PSNR_reconst_Mean=mean(table2array(psnr3));
