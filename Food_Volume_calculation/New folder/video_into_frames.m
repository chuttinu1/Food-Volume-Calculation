clear;
clc;
% Allow the user to select a video file
[videoFileName, videoFilePath] = uigetfile({'*.mp4;*.avi;*.mov', 'Video Files (*.mp4, *.avi, *.mov)'}, 'Select a Video File');

% Check if the user selected a file
if isequal(videoFileName, 0)
    disp('User selected Cancel');
    return;
end

% Full path of the selected video file
videoFile = fullfile(videoFilePath, videoFileName);

% Create a VideoReader object
video = VideoReader(videoFile);

% Get the number of frames in the video
numFrames = video.NumFrames;

% Create a directory to save the frames
outputDir = 'video_frames';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Loop through each frame
for k = 1:numFrames
    % Read the current frame
    frame = read(video, k);
    
    % Create a filename for the frame
    frameFileName = fullfile(outputDir, sprintf('frame_%04d.png', k));
    
    % Save the frame as an image
    imwrite(frame, frameFileName);
end

disp('Video frames have been successfully saved.');
