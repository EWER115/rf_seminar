function [test_random, test_random_labels] = loadTestRandom(dir)
    [test_random_labels, test_random] = libsvmread(fullfile(dir, 'test_features_random.lsvm'));
end

