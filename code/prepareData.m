%% PARAMETERS
dir = 'C:/Users/Dejan Štepec/Desktop/images';
datalibsvm='../datalibsvm';
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
       disp(['Scale[train]: ', int2str(scales(scale)), ' iteration:', int2str(i)]);
   end
   featuresTrain{scale} = f;
   disp(['Finished scale[train]: ', int2str(scales(scale))]);
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
       disp(['Scale[test]: ', int2str(scales(scale)), ' iteration:', int2str(i)]);
   end
   featuresTest{scale} = f;
   disp(['Finished scale[test]: ', int2str(scales(scale))]);
end

disp('Finished computing TEST features for all scales!');

% Compute features for test images for RANDOM[minScale, maxScale] scales
featuresTestRandom = zeros(numel(test_images), 48);
random_scales = randi(scale_min_max, 1, numel(test_images));

for i = 1:numel(test_images)
     n = round((random_scales(i) / 100) * width);
     featuresTestRandom(i,:) = compute_features(seam_carving(test_images{i}, n));
     disp(['Finished scale[test-random]: ', int2str(i)]);
end

disp('Finished computing TEST features for all RANDOM scales!');

%% SAVING RESULTS LIBSVM format
if exist(datalibsvm, 'dir')
    rmdir(datalibsvm,'s');
end
mkdir(datalibsvm);

% Save original train and test features [labels ; features]
% train_features_original.lsvm
% test_features_original.lsvm
libsvmwrite(strcat(datalibsvm, '/train_features_original.lsvm'),zeros(n_train, 1),sparse(featuresOriginalTrain));
libsvmwrite(strcat(datalibsvm, '/test_features_original.lsvm'),zeros(numel(test_images), 1),sparse(featuresOriginalTest));

% Save train and test features (each scale separately): 
% train_<scale>.dat and test_<scale>.lsvm
% [labels ; features]
mask_train = strcat(datalibsvm, '/train_%04d.lsvm');
mask_test = strcat(datalibsvm, '/test_%04d.lsvm');

for i = 1:numel(scales)
    libsvmwrite(sprintf(mask_train, scales(i)), ones(n_train, 1),sparse(featuresTrain{i}));
    libsvmwrite(sprintf(mask_test, scales(i)), ones(numel(test_images), 1),sparse(featuresTest{i}));
end

% Save test features with RANDOM scales, save also scales used
% test_features_random.dat
% [scales ; labels ; features]
libsvmwrite(strcat(datalibsvm, '/test_features_random.lsvm'), ones(numel(test_images), 1),sparse(featuresTestRandom));

% Save image paths used for train and test dataset
% image_test_paths.dat
% image_train_paths.dat
writetable(cell2table(train_paths', 'VariableNames', {'Path'}), strcat(data, '/image_train_paths.dat'));
writetable(cell2table(test_paths', 'VariableNames', {'Path'}), strcat(data, '/image_test_paths.dat'));

disp('Finished writing data in libsvm format!');