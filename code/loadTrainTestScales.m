function [train_scales, train_labels_scales, test_scales, test_labels_scales] = loadTrainTestScales(dir)
    mask_train = 'train_%04d.lsvm';
    mask_test = 'test_%04d.lsvm';
    
    train_scales = cell(0);
    train_labels_scales = [];
    test_scales = cell(0);
    test_labels_scales = [];
    
    for i = 1:99
        train_name = sprintf(mask_train, i);
        test_name = sprintf(mask_test, i);

        if exist(fullfile(dir, train_name), 'file')
            [labels, features] = libsvmread(fullfile(dir, train_name));
            train_scales{i} = features;
            train_labels_scales = [train_labels_scales, labels];
        end;

        if exist(fullfile(dir, test_name), 'file')
            [labels, features] = libsvmread(fullfile(dir, test_name));
            test_scales{i} = features;
            test_labels_scales = [test_labels_scales, labels];
        end;
    end;
    
    train_scales = train_scales(~cellfun(@isempty, train_scales));
    test_scales = test_scales(~cellfun(@isempty, test_scales));
end

