%% ��ʼ�������ռ�
clc
clear all
close all
% ��������(������net)
load CSNetSpring.mat
global net counter
%����ͼ����ʾ������
counter=0;
%% ����ͼ�������豸��image acquisition toolbox��
% �鿴ϵͳͼ�������豸  imaqhwinfo
% Window �豸����ͨ��Ϊ  'winvideo'
%'YUY2_640x480'
vid = videoinput('winvideo', 3,'YUY2_640x480');

% ����ͼ���������
fig = figure('Visible', 'off');
vidRes = vid.VideoResolution;
imageRes = fliplr(vidRes);
% subplot(1,2,1)
hImage = imshow(zeros(imageRes));
axis image;
title('ʵʱͼ��')
% ����previewˢ�º���
setappdata(hImage,'UpdatePreviewWindowFcn',@update_display4);
preview(vid,hImage)

