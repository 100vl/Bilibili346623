%% ��ȡ�β�����ݼ�
load fisheriris

%%% �������meas
% meas���β��һЩ�����ļ�����������С150*4
% measÿһ�ж�Ӧһ���۲������������ݼ���150���۲���
% measÿһ�ж�Ӧ�β����һ���������ԣ�
% means��4�ж�Ӧ�����Էֱ��ǣ���Ƭ���ȣ���Ƭ��ȣ����곤�ȣ�������

%%% ������ species
% species���β������
% setosa ɽ�β, versicolor ��ɫ�β, virginica ���������β
hf1=figure;
hf1.Units='pixels';
hf1.Position=[50 50 900 400];
subplot(1,3,1)
imshow(imread('Iris setosa.jpg'));
title('Iris Setosa ɽ�β')
subplot(1,3,2)
imshow(imread('Iris versicolor.jpg'));
title('Iris Versicolor ��ɫ�β')
subplot(1,3,3)
imshow(imread('Iris virginica.jpg'));
title('Iris Virginica ���������β')


% ��ʼ����ͼ����
hf2=figure;
hf2.Units='pixels';
hf2.Position=[50 50 800 800];
% set(hf,'Position',[50 50 600 600])

%����ɢ��ͼ����
speciesNum = grp2idx(species);
[H,AX,BigAx] = gplotmatrix(meas,[],speciesNum,['r' 'g' 'b']);
legend(AX(13+3),{'Setosa ɽ�β','Versicolor ��ɫ�β','Virginica ���������β'},'Location','northwest','FontWeight','Bold','Fontsize',10)
title(BigAx,'�β����������ɢ��ͼ����','FontWeight','Bold','Fontsize',16)
%���������
xlabel(AX(4),{'Sepal Length';'��Ƭ����'},'FontWeight','Bold','Fontsize',12)
xlabel(AX(8+1),{'Sepal Width';'��Ƭ���'},'FontWeight','Bold','Fontsize',12)
xlabel(AX(12+2),{'Petal Length','���곤��'},'FontWeight','Bold','Fontsize',12)
xlabel(AX(16+3),{'Petal Width','������'},'FontWeight','Bold','Fontsize',12)
% ���������
ylabel(AX(1),{'Sepal Length';'��Ƭ����'},'FontWeight','Bold','Fontsize',12)
ylabel(AX(2),{'Sepal Width';'��Ƭ���'},'FontWeight','Bold','Fontsize',12)
ylabel(AX(3),{'Petal Length','���곤��'},'FontWeight','Bold','Fontsize',12)
ylabel(AX(4),{'Petal Width','������'},'FontWeight','Bold','Fontsize',12)







