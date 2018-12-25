%% ��ʼ�������ռ�
clc
clear all
close all

%% ��������
load fisheriris

%% ��ά����
% ���곤�Ⱥͻ�����ɢ��ͼ(��ʵ���)
figure;
speciesNum = grp2idx(species);
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
xlabel('���곤��')
ylabel('������')
title('��ʵ���')
set(gca,'FontSize',12)
set(gca,'FontWeight','bold')

% ���곤�Ⱥͻ�����ɢ��ͼ���ޱ�ǣ�
figure;
scatter(meas(:,3),meas(:,4),150,'.')
xlabel('���곤��')
ylabel('������')
title('�ޱ��')
set(gca,'FontSize',12)
set(gca,'FontWeight','bold')

%% ��˹���ģ�;���
data = [meas(:,3), meas(:,4)];
% 1 �Զ���
% GMModel = fitgmdist(data,3);

% 2 �ֶ���ʼ����
Mu=[0.25 1.5; 4.0 1.25; 5.5 2.0 ];
Sigma(:,:,1) = [1 1;1 2];
Sigma(:,:,2) = [1 1;1 2];
Sigma(:,:,3) = [1 1;1 2];
Pcom=[1/3 1/3 1/3];
S = struct('mu',Mu,'Sigma',Sigma,'ComponentPropotion',Pcom);
GMModel = fitgmdist(data,3,'Start',S);

% ����
T1 = cluster(GMModel,data);

% ��ŵ���
cen=[mean(data(T1==1,:));...
    mean(data(T1==2,:));...
    mean(data(T1==3,:))];
dist=sum(cen.^2,2);
[dump,sortind]=sort(dist,'ascend');
newT1=zeros(size(T1));
for i =1:3
    newT1(T1==i)=find(sortind==i);
end

% ���곤�Ⱥͻ�����ɢ��ͼ(��ʵ���:ʵ��Բ+kmeans����:Ȧ)
figure;
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
hold on
gscatter(data(:,1),data(:,2),newT1,['r','g','b'],'o',10)
scatter(cen(:,1),cen(:,2),300,'m*')
hold off
xlabel('���곤��')
ylabel('������')
title('��ʵ���:ʵ��Բ+kmeans����:Ȧ')
set(gca,'FontSize',12)
set(gca,'FontWeight','bold')

%% �������� ConfusionMatrix
T2ConfMat=confusionmat(speciesNum,newT1)
error23=(speciesNum==2)&(newT1==3);
errDat23=data(error23,:)
error32=(speciesNum==3)&(newT1==2);
errDat32=data(error32,:)

%% ��˹ģ�͵ȸ���ͼ
% ɢ��ͼ
figure;
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
hold on
scatter(cen(:,1),cen(:,2),300,'m*')
hold off
xlabel('���곤��')
ylabel('������')
title('��˹ģ�͵ȸ���ͼ')
set(gca,'FontSize',12)
set(gca,'FontWeight','bold')
% ���ӵȸ���
haxis=gca;
xlim = get(haxis,'XLim');
ylim = get(haxis,'YLim');
dinter=(max([xlim, ylim]) - min([xlim, ylim]))/100;
[Grid1, Grid2] = meshgrid(xlim(1):dinter:xlim(2), ylim(1):dinter:ylim(2));
hold on
GMMpdf=reshape(pdf(GMModel, [Grid1(:) Grid2(:)]), size(Grid1,1), size(Grid2,2));
contour(Grid1, Grid2, GMMpdf, 30);
hold off

% ��ϸ�˹ģ������ͼ
figure;
surf(GMMpdf)
xlabel('���곤��')
ylabel('������')
title('��˹ģ������ͼ')
view(-3,65)





