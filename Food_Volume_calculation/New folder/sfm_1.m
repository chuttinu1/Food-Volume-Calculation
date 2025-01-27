clear;
clc;

% Specify the folder containing the images
imageDir = 'processed_images';  % Change this to your folder directory

% Get the list of image files in the directory
imageFiles = dir(fullfile(imageDir, '*.png'));  % Change the extension as needed

% Ensure there are at least two images in the directory
if numel(imageFiles) < 2
    error('There are not enough images in the specified directory. At least two images are required.');
end

% Load the first two images
I1 = imread(fullfile(imageDir, imageFiles(1).name));
I2 = imread(fullfile(imageDir, imageFiles(2).name));

% Create a tiled layout for subplots
figure;
t = tiledlayout(2, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

% Display the original images
nexttile;
imshowpair(I1, I2, 'montage');
title('Original Images Pair');

% Load Camera Parameters
load("matcam.mat");
intrinsics = cameraParams.Intrinsics;

% Find Point Correspondences Between The Images
imagePoints1 = detectMinEigenFeatures(im2gray(I1), 'MinQuality', 0.001);

% Visualize detected points
nexttile;
imshow(I1, 'InitialMagnification', 1465000);
title('150 Strongest Corners from the First Image');
hold on;
plot(selectStrongest(imagePoints1, 1600000));

% Create the point tracker
tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);

% Initialize the point tracker
imagePoints1 = imagePoints1.Location;
initialize(tracker, imagePoints1, I1);

% Track the points
[imagePoints2, validIdx] = step(tracker, I2);
matchedPoints1 = imagePoints1(validIdx, :);
matchedPoints2 = imagePoints2(validIdx, :);

% Visualize correspondences
nexttile;
showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
title('Tracked Features');

% Estimate the Essential Matrix
[E, epipolarInliers] = estimateEssentialMatrix(matchedPoints1, matchedPoints2, intrinsics, 'Confidence', 99.99);

% Find epipolar inliers
inlierPoints1 = matchedPoints1(epipolarInliers, :);
inlierPoints2 = matchedPoints2(epipolarInliers, :);

% Display inlier matches
nexttile;
showMatchedFeatures(I1, I2, inlierPoints1, inlierPoints2);
title('Epipolar Inliers');

% Reconstruct the 3-D Locations of Matched Points
border = 30;
roi = [border, border, size(I1, 2) - 2 * border, size(I1, 1) - 2 * border];
imagePoints1 = detectMinEigenFeatures(im2gray(I1), 'ROI', roi, 'MinQuality', 0.001);

% Create the point tracker
tracker = vision.PointTracker('MaxBidirectionalError', 1, 'NumPyramidLevels', 5);

% Initialize the point tracker
imagePoints1 = imagePoints1.Location;
initialize(tracker, imagePoints1, I1);

% Track the points
[imagePoints2, validIdx] = step(tracker, I2);
matchedPoints1 = imagePoints1(validIdx, :);
matchedPoints2 = imagePoints2(validIdx, :);

% Compute the Camera Pose
relPose = estrelpose(E, intrinsics, inlierPoints1, inlierPoints2);

% Compute the camera matrices for each position of the camera
camMatrix1 = cameraProjection(intrinsics, rigidtform3d);
camMatrix2 = cameraProjection(intrinsics, pose2extr(relPose));

% Compute the 3-D points
points3D = triangulate(matchedPoints1, matchedPoints2, camMatrix1, camMatrix2);

% Get the color of each reconstructed point
numPixels = size(I1, 1) * size(I1, 2);
allColors = reshape(I1, [numPixels, 3]);
colorIdx = sub2ind([size(I1, 1), size(I1, 2)], round(matchedPoints1(:, 2)), round(matchedPoints1(:, 1)));
color = allColors(colorIdx, :);

% Create the point cloud
ptCloud = pointCloud(points3D, 'Color', color);

% Display the 3-D Point Cloud
figure;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
title('Point Cloud');
