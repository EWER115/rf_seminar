function [sequence] = scan_directory(dir)
% SCAN_DIRECTORY scans a directory for images matching the following
% pattern:
%   ucid00001.tif, ucid00002.tif, ucid00003.jpg ...
% and returns an ordered cell array of the full file paths to the images

sequence = cell(0, 0);

i = 0;

mask = 'ucid%05d.tif';

while true
    i = i + 1;
    
    image_name = sprintf(mask, i);

    if ~exist(fullfile(dir, image_name), 'file')
        break;
    end;

    sequence{i} = fullfile(dir, image_name);

end;
