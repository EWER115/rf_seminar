function [train_scales, test_scales] = loadTrainTestScales(dir)
    mask_train = strcat(data, 'train_%04d.dat');
    mask_test = strcat(data, 'test_%04d.dat');
    
    train_scales = cell(0);
    test_scales = cell(0);
    
    for i = 1:99
        train_name = sprintf(mask_train, i);
        test_name = sprintf(mask_test, i);

        if exist(fullfile(dir, train_name), 'file')
            train_scales{i} = csvread(fullfile(dir, train_name));
        end;

        if exist(fullfile(dir, test_name), 'file')
            test_scales{i} = csvread(fullfile(dir, test_name));
        end;
        
    end;
end

