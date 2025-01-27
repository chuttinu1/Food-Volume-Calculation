% Load the first point cloud from the .ply file
ptCloud1 = pcread('object1.ply');  % Replace with your first .ply file path

% Load the second point cloud from the .ply file
ptCloud22 = pcread('object2.ply');  % Replace with your second .ply file path

% Convert point cloud locations to double arrays
points1 = double(ptCloud1.Location);
points2 = double(ptCloud22.Location);

% Compute the convex hull for the first point cloud
K1 = convhull(points1(:, 1), points1(:, 2), points1(:, 3));

% Compute the convex hull for the second point cloud
K2 = convhull(points2(:, 1), points2(:, 2), points2(:, 3));

% Create figure for subplots
figure;

% Isometric View - First Object
subplot(2,2,1);
pcshow(ptCloud1, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
title('Isometric View - Object 1');

hold on
plot3(points1(K1,1), points1(K1,2), points1(K1,3), 'r-', 'LineWidth', 2);  % Plot convex hull for Object 1
grid on;
hold off;

% Top View - First Object
subplot(2,2,2);
pcshow(ptCloud1, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
view(0, 90);  % Set view to top-down
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
title('Top View - Object 1');

hold on
plot3(points1(K1,1), points1(K1,2), points1(K1,3), 'r-', 'LineWidth', 2);  % Plot convex hull for Object 1
grid on;
hold off;

% Isometric View - Second Object
subplot(2,2,3);
pcshow(ptCloud22, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
title('Isometric View - Object 2');

hold on
plot3(points2(K2,1), points2(K2,2), points2(K2,3), 'r-', 'LineWidth', 2);  % Plot convex hull for Object 2
grid on;
hold off;

% Top View - Second Object
subplot(2,2,4);
pcshow(ptCloud22, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
view(0, 90);  % Set view to top-down
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
title('Top View - Object 2');

hold on
plot3(points2(K2,1), points2(K2,2), points2(K2,3), 'r-', 'LineWidth', 2);  % Plot convex hull for Object 2
grid on;
hold off;
