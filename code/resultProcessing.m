%% Load data
% load feature values from original (uncarved set)
[train_original, train_labels_original, test_original, test_labels_original] = ...
    loadTrainTestOriginal('../datalibsvm');

% load features from train and test set
[train_scales, train_labels_scales, test_scales, test_labels_scales] = ...
    loadTrainTestScales('../datalibsvm');

%% Create new files that include original data and scaled data
% mask = '../datalibsvm/test_mixed_%04d.lsvm';
% scales = [1 4 7 10 13 16 20 23 26 30];
% for i = 1 : length(test_scales)
%     lbls = [test_labels_scales(1:180,i) ; test_labels_original(181:end)];
%     mtrx = [test_scales{i}(1:180,:) ; test_original(181:end,:)];
%     libsvmwrite(sprintf(mask, scales(i)), lbls, mtrx);
% end


%% Optimize parameters
% % read training set for parameter optimization
% [lvtrainOpt, trainOpt] = libsvmread('../datascaled/valid.lsvm');
% 
% % read validation set for parameter optimization
% [lvvalid, validOpt] = libsvmread('../datascaled/valid_test.lsvm');
% 
% 
% % gamma testing
% n2 = -17:-5;
% accuracy2 = nan(size(n2));
% 
% for i=1:numel(n2);   % n = {-17,...,17}
%     c=2^n2(i);       
%     % create model
%     model = svmtrain(lvtrainOpt, trainOpt,['-q -t 2 -g ' num2str(c)]); 
%         % option: -t 4 -> precomputed kernel
%     [lbl, acc, dec] = svmpredict(lvvalid, validOpt, model);
%     accuracy2(i) = acc(1);
% end
% 
% figure(1);
% plot(accuracy2);
% xlabel('g'), ylabel('Accuracy'); title('Accuracy vs. gamma');
% 
% 
% % c testing
% n1 = -17:17;
% accuracy1 = nan(size(n1));
% 
% for i=1:numel(n1);   % n = {-17,...,17}
%     c=2^n1(i);       
%     % create model
%     model = svmtrain(lvtrainOpt, trainOpt,['-q -t 2 -g ' num2str(c)]); 
%         % option: -t 4 -> precomputed kernel
%     [lbl, acc, dec] = svmpredict(lvvalid, validOpt, model);
%     accuracy1(i) = acc(1);
% end
% 
% figure(2);
% plot(accuracy1);
% xlabel('c'), ylabel('Accuracy'); title('Accuracy vs. cost');

%% Test for each scale
maskTrain = '../datascaled2/train_%04d.lsvm';
maskTest = '../datascaled2/test_%04d.lsvm';
scales = [1 4 7 10 13 16 20 23 26 30];

 for i = 1 : length(test_scales)
    [labelsT, mtrxT] = libsvmread(sprintf(maskTrain, scales(i)));
    model = svmtrain(labelsT,mtrxT);
    [labels, mtrx] = libsvmread(sprintf(maskTest, scales(i)));
    [lbl, acc, dec] = svmpredict(labels,mtrx,model);
 end

