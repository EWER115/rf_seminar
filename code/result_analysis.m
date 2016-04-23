% variable setup
maskTrain = '../datascaled2/train_%04d.lsvm';
maskTest = '../datascaled2/test_%04d.lsvm';
maskRandom = '../datascaled2/random_%04d.lsvm';
scales = [1 4 7 10 13 16 20 23 26 30];

%% Same scaling factor in train and test
% prepare variables for ROC curve
trueClass = zeros(338,length(scales));
predClass = zeros(338,length(scales));

accur = zeros(1,length(scales));

% iterate through all scales
for i = 1 : length(scales)
    [labelsT, mtrxT] = libsvmread(sprintf(maskTrain, scales(i)));
    model = svmtrain(labelsT,mtrxT);
    [labels, mtrx] = libsvmread(sprintf(maskTest, scales(i)));
    [lbl, acc, dec] = svmpredict(labels,mtrx,model);
    
    % store predictions
    trueClass(:,i) = labels;
    predClass(:,i) = dec;
    accur(1,i) = acc(1);
end

% calculate ROC curve - smaller scales (up to 13%)
figure(1);
hold on;
for i = 1 : 5
    [X,Y] = perfcurve(trueClass(:,i),predClass(:,i),1);
    plot(X,Y);
end
legend('1%','4%','7%','10%','13%','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC krivulje SVM modelov pri enakem skaliranju')
hold off;

% calculate ROC curve - larger scales (up from 16%)
figure(2);
hold on;
for i = 6 : 10 
    [X,Y] = perfcurve(trueClass(:,i),predClass(:,i),1);
    plot(X,Y);
end
legend('16%','20%','23%','26%','30%','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC krivulje SVM modelov pri enakem skaliranju')
hold off;

% % store trueClass and predClass
% csvwrite('../results/trueClass_same.csv',trueClass);
% csvwrite('../results/predClass_same.csv',predClass);
csvwrite('../results/accur_same.csv',accur);

%% Different scaling factors in train and random scaling in test data
% prepare variables for ROC curve
trueClass = zeros(338,length(scales));
predClass = zeros(338,length(scales));

accur = zeros(1,length(scales));

% iterate through all scales
for i = 1 : length(scales)
    [labelsT, mtrxT] = libsvmread(sprintf(maskTrain, scales(i)));
    model = svmtrain(labelsT,mtrxT);
    [labels, mtrx] = libsvmread(sprintf(maskRandom, scales(i)));
    [lbl, acc, dec] = svmpredict(labels,mtrx,model);
    
    % store predictions
    trueClass(:,i) = labels;
    predClass(:,i) = dec;
    accur(:,i) = acc(1);
end

% calculate ROC curve - smaller scales (up to 13%)
figure(3);
hold on;
for i = 1 : 5
    [X,Y] = perfcurve(trueClass(:,i),predClass(:,i),1);
    plot(X,Y);
end
legend('1%','4%','7%','10%','13%','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC krivulje SVM modelov z naključnimi testnimi podatki')
hold off;

% calculate ROC curve - larger scales (up from 16%)
figure(4);
hold on;
for i = 6 : 10 
    [X,Y] = perfcurve(trueClass(:,i),predClass(:,i),1);
    plot(X,Y);
end
legend('16%','20%','23%','26%','30%','Location','Best')
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC krivulje SVM modelov z naključnimi testnimi podatki')
hold off;

% % store trueClass and predClass
% csvwrite('../results/trueClass_random_all.csv',trueClass);
% csvwrite('../results/predClass_random_all.csv',predClass);
csvwrite('../results/accur_random_all.csv',accur);

%% Train on complete training set that consist of differently scaled images
[labelsT, mtrxT] = libsvmread('../datascaled2/train_complete.lsvm');
model = svmtrain(labelsT,mtrxT);
[labels, mtrx] = libsvmread('../datascaled2/random_complete.lsvm');
[lbl, acc, dec] = svmpredict(labels,mtrx,model);

% plot ROC curve
figure(5);
hold on;
[X,Y] = perfcurve(labels,dec,1);
plot(X,Y);
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC krivulje SVM modela treniranega na celotni učni množici')
hold off;

% % store trueClass and predClass
% csvwrite('../results/trueClass_complete.csv',lbl);
% csvwrite('../results/predClass_complete.csv',dec);
csvwrite('../results/accur_complete.csv',acc(1));