function [train_original, test_original] = loadTrainTestOriginal(dir)
    train_original = csvread(fullfile(dir, 'train_features_original.dat'));
    test_original = csvread(fullfile(dir, 'test_features_original.dat'));
end

