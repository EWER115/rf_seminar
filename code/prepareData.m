%% PARAMETERS
dir = '../images';
data = '../data';
n_train = 1000;
scales = [1 4 7 10 13 16 20 23 26 30];
scale_min_max = [1, 30];
%% PREPARE IMAGES

% Divide dataset to train and test set
image_paths = scan_directory(dir);
[train_paths, idx] = datasample(image_paths, n_train, 'Replace', false);
image_paths(idx) = [];
test_paths = image_paths;

% Read corresponding images
train_images = cell(size(train_paths));
test_images = cell(size(test_paths));

for i = 1:n_train
   train_images{i} = imread(train_paths{i}); 
end

for i = 1:numel(test_images)
   test_images{i} = imread(test_paths{i}); 
end

disp('Finished reading images!');

%% COMPUTING FEATURES

% Compute features for original TRAIN images
featuresOriginalTrain = zeros(n_train, 48);

for i = 1:n_train
   featuresOriginalTrain(i,:) = compute_features(train_images{i}); 
end

disp('Finished computing features on ORIGINAL train images!');

% Compute features for original TEST images
featuresOriginalTest = zeros(numel(test_images), 48);

for i = 1:numel(test_images)
   featuresOriginalTest(i,:) = compute_features(test_images{i}); 
end

disp('Finished computing features on ORIGINAL test images!');


% Compute features for train images for all scales
featuresTrain  = cell(1, numel(scales));
[~, width, ~] = size(train_images{1});

for scale = 1:numel(scales)
   n = round((scales(scale) / 100) * width);
   f = zeros(n_train, 48);
   for i = 1:n_train
       f(i,:) = compute_features(seam_carving(train_images{i}, n));
   end
   featuresTrain{scale} = f;
   disp(['Finished scale[train]: ', scales(scale)]);
end

disp('Finished computing TRAIN features for all scales!');

% Compute features for test images for all scales
featuresTest  = cell(1, numel(scales));
[~, width, ~] = size(test_images{1});

for scale = 1:numel(scales)
   n = round((scales(scale) / 100) * width);
   f = zeros(numel(test_images), 48);
   for i = 1:numel(test_images)
       f(i,:) = compute_features(seam_carving(test_images{i}, n));
   end
   featuresTest{scale} = f;
   disp(['Finished scale[test]: ', scales(scale)]);
end

disp('Finished computing TEST features for all scales!');

% Compute features for test images for RANDOM[minScale, maxScale] scales
featuresTestRandom = zeros(numel(test_images), 48);
random_scales = randi(scale_min_max, 1, numel(test_images));

for i = 1:numel(test_images)
     n = round((random_scales(i) / 100) * width);
     featuresTestRandom(i,:) = compute_features(seam_carving(test_images{i}, n));
     disp(['Finished scale[test-random]: ', i]);
end

disp('Finished computing TEST features for all RANDOM scales!');

%% SAVING RESULTS
rmdir(data,'s');
mkdir(data);

% Save original train and test features [labels ; features]
% train_features_original.dat
% test_features_original.dat
csvwrite(strcat(data, '/train_features_original.dat'), [zeros(n_train, 1);featuresOriginalTrain]);
csvwrite(strcat(data, '/test_features_original.dat'), [zeros(numel(test_images), 1);featuresOriginalTest]);

% Save train and test features (each scale separately): 
% train_<scale>.dat and test_<scale>.dat 
% [labels ; features]
mask_train = strcat(data, '/train_%04d.dat');
mask_test = strcat(data, '/test_%04d.dat');

for i = 1:numel(scales)
    csvwrite(sprintf(mask_train, scales(i), [ones(n_train, 1);featuresTrain{i}]));
    csvwrite(sprintf(mask_test, scales(i), [ones(numels(test_images), 1);featuresTest{i}]));
end

% Save test features with RANDOM scales, save also scales used
% test_features_random.dat
% [scales ; labels ; features]
csvwrite(strcat(data, '/test_features_random.dat'), [random_scales';zeros(numel(test_images), 1);featuresTestRandom]);

% Save image paths used for train and test dataset
% image_test_paths.dat
% image_train_paths.dat
writetable(cell2table(train_paths', 'VariableNames', {'Path'}), strcat(data, '/image_train_paths.dat'));
writetable(cell2table(test_paths', 'VariableNames', {'Path'}), strcat(data, '/image_test_paths.dat'));

disp('Finished writing data!');