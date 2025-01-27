clear;
clc;
% Specify the folders to delete
foldersToDelete = {'video_frames', 'processed_images'};
% Delete the specified folders
for k = 1:numel(foldersToDelete)
    folder = foldersToDelete{k};
    if exist(folder, 'dir')
        disp(['Deleting folder: ', folder]);
        rmdir(folder, 's');  % 's' for recursive deletion (delete all contents)
    else
        disp(['Folder not found: ', folder]);
    end
end

% Display a message
disp('Running Script 1...');
run('video_into_frames.m');

disp('Running Script 2...');
run('image_pair_select.m');

disp('Running Script 3...');
run('back_remover.m');

disp('Running Script 4...');
run('sfm_1.m')

disp('Running Script 5...');
run('filtered_pointcloud.m');

disp('Running Script 5.1...');
run('segment.m');

disp('Running Script 6...');
run('both_convex.m');

disp('Running Script 7...');
run('surface_convex_both.m');

disp('Running Script 8...');
run('compare_volume.m');

% Display a completion message
disp('All scripts have been run successfully.');


