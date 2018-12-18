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
%% kmeans ����
data=[meas(:,3), meas(:,4)];
K=3;
[idx,cen]=kmeans(data,K,'Distance','sqeuclidean','Replicates',5,'Display','Final');
% �������
dist=sum(cen.^2,2);
[dump,sortind]=sort(dist,'ascend');
newidx=zeros(size(idx));
for i =1:K
    newidx(idx==i)=find(sortind==i);
end

% ���곤�Ⱥͻ�����ɢ��ͼ(kmeans����)
figure;
gscatter(data(:,1),data(:,2),newidx,['r','g','b'])
hold on
scatter(cen(:,1),cen(:,2),300,'m*')
hold off
xlabel('���곤��')
ylabel('������')
title('kmeans����')
set(gca,'FontSize',12)
set(gca,'FontWeight','bold')

% ���곤�Ⱥͻ�����ɢ��ͼ(��ʵ���:ʵ��Բ+kmeans����:Ȧ)
figure;
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
hold on
gscatter(data(:,1),data(:,2),newidx,['r','g','b'],'o',10)
scatter(cen(:,1),cen(:,2),300,'m*')
hold off
xlabel('���곤��')
ylabel('������')
title('��ʵ���:ʵ��Բ+kmeans����:Ȧ')
set(gca,'FontSize',12)
set(gca,'FontWeight','bold')

%% �������� ConfusionMatrix
confMat=confusionmat(speciesNum,newidx)
error23=speciesNum==2&newidx==3;
errDat23=data(error23,:)
error32=speciesNum==3&newidx==2;
errDat32=data(error32,:)
