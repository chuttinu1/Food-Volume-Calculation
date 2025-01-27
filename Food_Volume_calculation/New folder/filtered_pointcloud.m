% Apply Statistical Outlier Removal
% Set the number of nearest neighbors to consider
numNeighbors = 70;

% Set the standard deviation multiplier threshold
stdMultiplier = 0.1;

% Remove statistical outliers
[ptCloudFiltered, inlierIndices, outlierIndices] = pcdenoise(ptCloud, ...
    'NumNeighbors', numNeighbors, ...
    'Threshold', stdMultiplier);

% Create a figure with subplots for different angles
figure;

% Top view
subplot(1, 2, 1);
pcshow(ptCloudFiltered);
view(0, 90); % Top view
title('Top View');

% Isometric view
subplot(1, 2, 2);
pcshow(ptCloudFiltered);
view(45, 45); % Isometric view
title('Isometric View');

pcwrite(ptCloudFiltered, 'output_point_cloud.ply');

% Display the saved point cloud
%pcshow(pc);