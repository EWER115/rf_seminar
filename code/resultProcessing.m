%% Load data
% load feature values from original (uncarved set)
[train_original, train_labels_original, test_original, test_labels_original] = ...
    loadTrainTestOriginal('../datalibsvm');

% load features from train and test set
[train_scales, train_labels_scales, test_scales, test_labels_scales] = ...
    loadTrainTestScales('../datalibsvm');

% load random set
[labRand, mtrxRand] = libsvmread('/home/anze/Faks/GitRepos/forenzika/rf_seminar/datalibsvm/test_features_random.lsvm');

%% Create new files that include original data and scaled data
% mask = '../datalibsvm/test_mixed_%04d.lsvm';
% scales = [1 4 7 10 13 16 20 23 26 30];
% for i = 1 : length(test_scales)
%     lbls = [test_labels_scales(1:180,i) ; test_labels_original(181:end)];
%     mtrx = [test_scales{i}(1:180,:) ; test_original(181:end,:)];
%     libsvmwrite(sprintf(mask, scales(i)), lbls, mtrx);
% end

% % Add some unmodified images to random set
% newRandlbls = [labRand(1:180) ; test_labels_original(181:end)];
% newMtrxRand = [mtrxRand(1:180,:); test_original(181:end,:)]; 
% libsvmwrite('/home/anze/Faks/GitRepos/forenzika/rf_seminar/datalibsvm/test_random.lsvm', newRandlbls, newMtrxRand);

% mask = '../datalibsvm/train_mixed_%04d.lsvm';
% scales = [1 4 7 10 13 16 20 23 26 30];
% crr = 0;
% lbls = []; mtrx = [];
% for i = 1 : length(scales)
%     idx1 = crr + 1;
%     crr = crr + 55;
%     idx2 = crr;
%     lbls = [lbls; train_labels_scales(idx1:idx2,i)];
%     mtrx = [mtrx; train_scales{i}(idx1:idx2,:)];
%     
% end
% 
% lbls = [lbls ; train_labels_original(551:1000)];
% mtrx = [mtrx ; train_original(551:1000,:)];
% 
% libsvmwrite('/home/anze/Faks/GitRepos/forenzika/rf_seminar/datalibsvm/train_complete.lsvm', lbls, mtrx);

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
% maskTrain = '../datascaled2/train_%04d.lsvm';
% maskTest = '../datascaled2/test_%04d.lsvm';
% maskRandom = '../datascaled2/random_%04d.lsvm';
% scales = [1 4 7 10 13 16 20 23 26 30];
% 
%  for i = 1 : length(test_scales)
%     [labelsT, mtrxT] = libsvmread(sprintf(maskTrain, scales(i)));
%     model = svmtrain(labelsT,mtrxT);
%     [labels, mtrx] = libsvmread(sprintf(maskTest, scales(i)));
%     [lbl, acc, dec] = svmpredict(labels,mtrx,model);
%  end

