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

%% ��ξ���
data=[meas(:,3), meas(:,4)];
datalink=linkage(data,'average','euclidean');
% ������״ͼ
figure;
dendrogram(datalink,10)
title('��״ͼ��10�ڵ㣩')
figure;
dendrogram(datalink,0)
title('��״ͼ�����нڵ㣩')

%% �ָʽ1��������ֵ
T1 = cluster(datalink,'cutoff',1.2,'Criterion','distance');
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

%% �ָʽ2��Ⱥ��Ŀ
T2 = cluster(datalink,'maxclust',3);
% ��ŵ���
cen=[mean(data(T2==1,:));...
    mean(data(T2==2,:));...
    mean(data(T2==3,:))];
dist=sum(cen.^2,2);
[dump,sortind]=sort(dist,'ascend');
newT2=zeros(size(T2));
for i =1:3
    newT2(T2==i)=find(sortind==i);
end

% ���곤�Ⱥͻ�����ɢ��ͼ(��ʵ���:ʵ��Բ+kmeans����:Ȧ)
figure;
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
hold on
gscatter(data(:,1),data(:,2),newT2,['r','g','b'],'o',10)
scatter(cen(:,1),cen(:,2),300,'m*')
hold off
xlabel('���곤��')
ylabel('������')
title('��ʵ���:ʵ��Բ+kmeans����:Ȧ')
set(gca,'FontSize',12)
set(gca,'FontWeight','bold')

%% �������� ConfusionMatrix
T2ConfMat=confusionmat(speciesNum,newT2)
error23=(speciesNum==2)&(newT2==3);
errDat23=data(error23,:)
error32=(speciesNum==3)&(newT2==2);
errDat32=data(error32,:)
