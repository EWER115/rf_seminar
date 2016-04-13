%% PARAMETERS
dir = '../images_object_removed/removed';
dir2 = '../images_object_removed/control';
%% PREPARE IMAGES

image_paths = scan_directory(dir, true);
image_paths2 = scan_directory(dir2, true);

% Read corresponding images
train_images = cell(size(image_paths));
control_images = cell(size(image_paths2));

for i = 1:numel(image_paths)
   train_images{i} = imread(image_paths{i}); 
end

for i = 1:numel(image_paths2)
   control_images{i} = imread(image_paths2{i}); 
end

disp('Finished reading images!');

%% COMPUTING FEATURES

% Compute features for original TRAIN images
featuresOriginalTrain = zeros(numel(train_images), 48);
featuresOriginalControl = zeros(numel(control_images), 48);

for i = 1:numel(train_images)
   featuresOriginalTrain(i,:) = compute_features(train_images{i}); 
end

for i = 1:numel(control_images)
   featuresOriginalControl(i,:) = compute_features(control_images{i}); 
end

disp('Finished computing features on ORIGINAL train images!');

%% WRITE DATA
libsvmwrite(strcat(dir, '/removed_objects_control.lsvm'),[ones(numel(train_images), 1) ; zeros(numel(control_images),1)],[sparse(featuresOriginalTrain);sparse(featuresOriginalControl)]);