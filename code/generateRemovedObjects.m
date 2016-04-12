%% PARAMETERS
dir = 'C:\Users\Dejan �tepec\Desktop\images_object_removed\removed';
%% PREPARE IMAGES

image_paths = scan_directory(dir, true);

% Read corresponding images
train_images = cell(size(image_paths));

for i = 1:numel(image_paths)
   train_images{i} = imread(image_paths{i}); 
end

disp('Finished reading images!');

%% COMPUTING FEATURES

% Compute features for original TRAIN images
featuresOriginalTrain = zeros(numel(train_images), 48);

for i = 1:numel(train_images)
   featuresOriginalTrain(i,:) = compute_features(train_images{i}); 
end

disp('Finished computing features on ORIGINAL train images!');

%% WRITE DATA

libsvmwrite(strcat(dir, '/removed_objects.lsvm'),ones(numel(train_images), 1),sparse(featuresOriginalTrain));