%% ��ʼ�������ռ�
clc
clear all
close all

%% ��������
load fisheriris

%% ��ά����
% ���곤�ȡ������ȡ����೤��ɢ��ͼ(�ޱ��)
figure;
speciesNum = grp2idx(species);
plot3(meas(:,3),meas(:,4),meas(:,1),'.','MarkerSize',20)
grid on
view([60,24])
xlabel('���곤��')
ylabel('������')
zlabel('��Ƭ����')
title('�ޱ��')
set(gca,'FontSize',12)
set(gca,'FontWeight','Bold')

% ���곤�ȡ������ȡ����೤��ɢ��ͼ(��ʵ���)
figure;
hold on
colorArray=['r','g','b'];
for  i= 1:3
    plotind=speciesNum==i;
    plot3(meas(plotind,3),meas(plotind,4),meas(plotind,1),'.','MarkerSize',20,'MarkerEdgeColor',colorArray(i))
end
hold off
grid on
view([60,24])
xlabel('���곤��')
ylabel('������')
zlabel('��Ƭ����')
title('��ʵ���')
set(gca,'FontSize',12)
set(gca,'FontWeight','Bold')


%% kmeans ����
data2=[ meas(:,3), meas(:,4),meas(:,1)];
K=3;
[idx2,cen2]=kmeans(data2,K,'Distance','sqeuclidean','Replicates',5,'Display','Final');
% �������
dist2=sum(cen2.^2,2);
[dump2,sortind2]=sort(dist2,'ascend');
newidx2=zeros(size(idx2));
for i =1:K
    newidx2(idx2==i)=find(sortind2==i);
end

% ���곤�Ⱥͻ�����ɢ��ͼ(��ʵ���:ʵ��Բ+kmeans����:Ȧ)
figure;
hold on
colorArray=['r','g','b'];
for  i= 1:3
    plotind=speciesNum==i;
    plot3(meas(plotind,3),meas(plotind,4),meas(plotind,1),'.','MarkerSize',15,'MarkerEdgeColor',colorArray(i))
end

for  i= 1:3
    plotind=newidx2==i;
    plot3(meas(plotind,3),meas(plotind,4),meas(plotind,1),'o','MarkerSize',10,'MarkerEdgeColor',colorArray(i))
end
for i=1:3
    plot3(cen2(i,1),cen2(i,2),cen2(i,3),'*m')
end

hold off
grid on
view([60,24])
xlabel('���곤��')
ylabel('������')
zlabel('��Ƭ����')
title('��ʵ���:ʵ��Բ+kmeans����:Ȧ')
set(gca,'FontSize',12)
set(gca,'FontWeight','Bold')

%% �������� ConfusionMatrix
confMat=confusionmat(speciesNum,newidx2)
error23=speciesNum==2&newidx2==3;
errDat23=data2(error23,:)
error32=speciesNum==3&newidx2==2;
errDat32=data2(error32,:)
[dump, errdatSort]=sort(errDat32(:,3));
errDat32Sort=errDat32(errdatSort,:)
