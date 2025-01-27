% Load the point cloud
pc = pcread('output_point_cloud.ply');

% Perform Euclidean clustering
minDistance = 2;  % Minimum distance to consider clusters (tune this value)
labels = pcsegdist(pc, minDistance);

% Get the indices of points for each cluster
cluster1_indices = labels == 1;
cluster2_indices = labels == 2;

% Extract each cluster as a new point cloud
pc1 = select(pc, cluster1_indices); % First object
pc2 = select(pc, cluster2_indices); % Second object

% Save the separated point clouds
pcwrite(pc1, 'object1.ply');
pcwrite(pc2, 'object2.ply');

% Visualize the separated point clouds
figure;
subplot(1,2,1);
pcshow(pc1);
title('Object 1');
subplot(1,2,2);
pcshow(pc2);
title('Object 2');
