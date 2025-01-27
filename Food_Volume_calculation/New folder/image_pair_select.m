% Prompt user to select the directory containing the frames
imgDir = 'video_frames'

% Check if a directory was selected
if imgDir == 0
    error('No directory selected. Exiting...');
end

% Get the list of image files in the directory
imgFiles = dir(fullfile(imgDir, '*.png'));  % Assuming .png format
numFrames = length(imgFiles);

% Initialize variables for the best matching pair and the list of pairs
bestPair = [];
maxInliers = 0;
matchingPairs = {};  % Cell array to store matching pairs and inliers

% Loop through every 10th image and compare with the next image
for i = 1:10:numFrames-10
    % Read the current image and the image 10 frames ahead
    img1 = imread(fullfile(imgDir, imgFiles(i).name));
    img2 = imread(fullfile(imgDir, imgFiles(i+10).name));
    
    % Convert to grayscale
    img1Gray = rgb2gray(img1);
    img2Gray = rgb2gray(img2);
    
    % Detect and extract features for both images
    points1 = detectSURFFeatures(img1Gray);
    points2 = detectSURFFeatures(img2Gray);
    [features1, validPoints1] = extractFeatures(img1Gray, points1);
    [features2, validPoints2] = extractFeatures(img2Gray, points2);
    
    % Match features
    indexPairs = matchFeatures(features1, features2);
    matchedPoints1 = validPoints1(indexPairs(:, 1), :);
    matchedPoints2 = validPoints2(indexPairs(:, 2), :);
    
    % Check if there are enough matched points
    if size(matchedPoints1, 1) < 4 || size(matchedPoints2, 1) < 4
        continue;  % Skip if not enough matches
    end
    
    % Estimate homography
    [~, inlierIdx] = estimateGeometricTransform2D(matchedPoints1, matchedPoints2, 'projective');
    numInliers = sum(inlierIdx);
    
    % Store the current pair and inliers in the matchingPairs list
    matchingPairs{end+1, 1} = [i, i+10];
    matchingPairs{end, 2} = numInliers;
    
    % Check if this pair has the most inliers
    if numInliers > maxInliers
        maxInliers = numInliers;
        bestPair = [i, i+10];  % Store the pair (current image, next image in sliding window)
    end
end

% Check if any matching pairs were found
if isempty(matchingPairs)
    error('No matching pairs found with sufficient inliers.');
end

% Display the best matching pair
fprintf('Best matching pair: Frame %d and Frame %d with %d inliers\n', bestPair(1), bestPair(2), maxInliers);

% Delete the remaining frames
for k = 1:numFrames
    % Skip the best pair images
    if ~ismember(k, bestPair)
        delete(fullfile(imgDir, imgFiles(k).name));
    end
end

disp('The best matching pair has been kept, and the remaining frames have been deleted.');
