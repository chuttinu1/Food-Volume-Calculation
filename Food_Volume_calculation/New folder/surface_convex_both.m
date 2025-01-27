% Load the point cloud
points = double(ptCloud1.Location);

% Extract x, y, and z coordinates
x = points(:, 1);
y = points(:, 2);
z = points(:, 3);

% Remove NaN and Inf values
validIdx = ~isnan(x) & ~isnan(y) & ~isnan(z) & isfinite(x) & isfinite(y) & isfinite(z);
x = x(validIdx);
y = y(validIdx);
z = z(validIdx);

% Optional: Downsample the point cloud if it's too large
maxPoints = 10000; % Adjust this number based on your needs
if length(x) > maxPoints
    randIdx = randperm(length(x), maxPoints);
    x = x(randIdx);
    y = y(randIdx);
    z = z(randIdx);
end

% Compute the convex hull and its volume
try
    [k, volume] = convhull(x, y, z);
catch ME
    disp('Error computing the convex hull:');
    disp(ME.message);
    return;
end

% Create figure for subplots
figure;

% Isometric View
subplot(1, 2, 1);
pcshow(ptCloud1, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
title('Isometric View');
hold on;
trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
grid on;
axis equal;
hold off;

% Top View
subplot(1, 2, 2);
pcshow(ptCloud1, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
view(0, 90); % Set view to top-down
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
title('Top View');
hold on;
trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
grid on;
axis equal;
hold off;


points = double(ptCloud22.Location);

% Extract x, y, and z coordinates
x = points(:, 1);
y = points(:, 2);
z = points(:, 3);

% Remove NaN and Inf values
validIdx = ~isnan(x) & ~isnan(y) & ~isnan(z) & isfinite(x) & isfinite(y) & isfinite(z);
x = x(validIdx);
y = y(validIdx);
z = z(validIdx);

% Optional: Downsample the point cloud if it's too large
maxPoints = 10000; % Adjust this number based on your needs
if length(x) > maxPoints
    randIdx = randperm(length(x), maxPoints);
    x = x(randIdx);
    y = y(randIdx);
    z = z(randIdx);
end

% Compute the convex hull and its volume
try
    [k, volume] = convhull(x, y, z);
catch ME
    disp('Error computing the convex hull:');
    disp(ME.message);
    return;
end

% Create figure for subplots
figure;

% Isometric View
subplot(1, 2, 1);
pcshow(ptCloud22, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
title('Isometric View');
hold on;
trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
grid on;
axis equal;
hold off;

% Top View
subplot(1, 2, 2);
pcshow(ptCloud22, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
view(0, 90); % Set view to top-down
xlabel('X (cm)');
ylabel('Y (cm)');
zlabel('Z (cm)');
title('Top View');
hold on;
trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
grid on;
axis equal;
hold off;


