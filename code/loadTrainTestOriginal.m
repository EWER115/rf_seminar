function [train_original, train_labels_original, test_original, test_labels_original] = loadTrainTestOriginal(dir)
    [train_labels_original, train_original] = libsvmread(fullfile(dir, 'train_features_original.lsvm'));
    [test_labels_original, test_original] = libsvmread(fullfile(dir, 'test_features_original.lsvm'));
end

