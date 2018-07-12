%% ��ʼ�������ռ�
clc
clear
close all

%% ��������
load fisheriris

%% ���ݻ���
% ��������ӣ�Ϊ���������Ŀ��ظ���
rng(1);

% ȡ��15��������Ϊ��������
cvp = cvpartition(species,'holdout',15);
datTrain = meas(cvp.training,:);
labTrain = species(cvp.training,:);
datTest = meas(cvp.test,:);
labTest = species(cvp.test,:);

%% Ŀ�꺯�������ֵloss
% �����ʱ��loss
nca = fscnca(datTrain,labTrain,'FitMethod','none');
L0 = loss(nca,datTrain,labTrain);

% lambdaΪ0ʱ��loss
nca = fscnca(datTrain,labTrain,'FitMethod','exact','Lambda',0,...
    'Solver','sgd','Standardize',true);
L1 = loss(nca,datTrain,labTrain);

%% ���Ե���lambdaֵ (5�۽�����֤)
cvp = cvpartition(labTrain,'kfold',5);
numvalidsets=cvp.NumTestSets;
n = length(labTrain);
lambdavals = (0:1:20)/n;
lossvals = zeros(length(lambdavals),numvalidsets);
for i = 1:length(lambdavals)
    for k = 1:numvalidsets
        x = datTrain(cvp.training(k),:);
        y = labTrain(cvp.training(k),:);
        
        xvalid = datTrain(cvp.test(k),:);
        yvalid = labTrain(cvp.test(k),:);
        
        nca = fscnca(x,y,'FitMethod','exact','Solver','sgd','Lambda',lambdavals(i),...
            'IterationLimit',30,'GradientTolerance',1e-4,'Standardize',true);
        lossvals(i,k) = loss(nca,xvalid,yvalid,'LossFunction','classiferror');
    
    end
end
meanloss = mean(lossvals,2);
figure(1);
plot(lambdavals,meanloss,'ro-')
xlabel('Lambda');
ylabel('Loss (MSE)');
grid on

%% Ѱ�����lambda
[~,idx] = min(meanloss);
bestlambda = lambdavals(idx);
bestloss = meanloss(idx);

%% �������lambda�µ�����Ȩ��
nca = fscnca(datTrain,labTrain,'FitMethod','exact','Solver','sgd',...
    'Lambda',bestlambda,'Standardize',true,'Verbose',1);
figure(2)
bar(nca.FeatureWeights)
xlabel('Feature index')
ylabel('Feature weight')
grid on
