%% Load data
% load feature values from original (uncarved set)
[train_original, train_labels_original, test_original, test_labels_original] = ...
    loadTrainTestOriginal('../datalibsvm');

% load features from train and test set
[train_scales, train_labels_scales, test_scales, test_labels_scales] = ...
    loadTrainTestScales('../datalibsvm');

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
for i = 1 : length(test_scales)
    model = svmtrain([train_labels_scales(:,i) ; train_labels_original], [train_scales{i} ; train_original]);
    [lbl, acc, dec] = svmpredict(test_labels_scales(:,i),test_scales{i},model);
end
