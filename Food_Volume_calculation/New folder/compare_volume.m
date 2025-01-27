% % Load the point cloud
% points = double(ptCloud1.Location);
% 
% % Extract x, y, and z coordinates
% x = points(:, 1);
% y = points(:, 2);
% z = points(:, 3);
% 
% % Remove NaN and Inf values
% validIdx = ~isnan(x) & ~isnan(y) & ~isnan(z) & isfinite(x) & isfinite(y) & isfinite(z);
% x = x(validIdx);
% y = y(validIdx);
% z = z(validIdx);
% 
% % Optional: Downsample the point cloud if it's too large
% maxPoints = 10000; % Adjust this number based on your needs
% if length(x) > maxPoints
%     randIdx = randperm(length(x), maxPoints);
%     x = x(randIdx);
%     y = y(randIdx);
%     z = z(randIdx);
% end
% 
% % Compute the convex hull and its volume using original coordinates
% try
%     [k, volume] = convhull(x, y, z);
% catch ME
%     disp('Error computing the convex hull:');
%     disp(ME.message);
%     return;
% end
% 
% % Create figure for subplots
% figure;
% 
% % Isometric View with Original Point Cloud
% subplot(2, 2, 1);
% pcshow(ptCloud1, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
% xlabel('X (cm)');
% ylabel('Y (cm)');
% zlabel('Z (cm)');
% title('Isometric View - Original Point Cloud');
% hold on;
% trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
% grid on;
% axis equal;
% hold off;
% 
% % Top View with Original Point Cloud
% subplot(2, 2, 2);
% pcshow(ptCloud1, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
% view(0, 90); % Set view to top-down
% xlabel('X (cm)');
% ylabel('Y (cm)');
% zlabel('Z (cm)');
% title('Top View - Original Point Cloud');
% hold on;
% trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
% grid on;
% axis equal;
% hold off;
% 
% % Volume Display
% subplot(2, 2, [3 4]);
% text(0.5, 0.5, ['Volume of Convex Hull: ', num2str(volume)], 'FontSize', 20, 'Color', 'k', 'BackgroundColor', 'w', 'HorizontalAlignment', 'center');
% axis off;
% title('Convex Hull Volume');
% 
% % Load the point cloud
% points = double(ptCloud22.Location);
% 
% % Extract x, y, and z coordinates
% x = points(:, 1);
% y = points(:, 2);
% z = points(:, 3);
% 
% % Remove NaN and Inf values
% validIdx = ~isnan(x) & ~isnan(y) & ~isnan(z) & isfinite(x) & isfinite(y) & isfinite(z);
% x = x(validIdx);
% y = y(validIdx);
% z = z(validIdx);
% 
% % Optional: Downsample the point cloud if it's too large
% maxPoints = 10000; % Adjust this number based on your needs
% if length(x) > maxPoints
%     randIdx = randperm(length(x), maxPoints);
%     x = x(randIdx);
%     y = y(randIdx);
%     z = z(randIdx);
% end
% 
% % Compute the convex hull and its volume using original coordinates
% try
%     [k, volume] = convhull(x, y, z);
% catch ME
%     disp('Error computing the convex hull:');
%     disp(ME.message);
%     return;
% end
% 
% % Create figure for subplots
% figure;
% 
% % Isometric View with Original Point Cloud
% subplot(2, 2, 1);
% pcshow(ptCloud22, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
% xlabel('X (cm)');
% ylabel('Y (cm)');
% zlabel('Z (cm)');
% title('Isometric View - Original Point Cloud');
% hold on;
% trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
% grid on;
% axis equal;
% hold off;
% 
% % Top View with Original Point Cloud
% subplot(2, 2, 2);
% pcshow(ptCloud22, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
% view(0, 90); % Set view to top-down
% xlabel('X (cm)');
% ylabel('Y (cm)');
% zlabel('Z (cm)');
% title('Top View - Original Point Cloud');
% hold on;
% trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
% grid on;
% axis equal;
% hold off;
% 
% % Volume Display
% subplot(2, 2, [3 4]);
% text(0.5, 0.5, ['Volume of Convex Hull: ', num2str(volume)], 'FontSize', 20, 'Color', 'k', 'BackgroundColor', 'w', 'HorizontalAlignment', 'center');
% axis off;
% title('Convex Hull Volume');

% Open the text file in append mode
fileID = fopen('volumes.txt', 'a');

% Add a timestamp to differentiate between runs
fprintf(fileID, '\nRun on %s\n', datestr(now));

% Process ptCloud1
volume1 = processPointCloud(ptCloud1, 'ptCloud1');
fprintf(fileID, 'Volume of ptCloud1: %.4f\n', volume1);

% Process ptCloud22
volume2 = processPointCloud(ptCloud22, 'ptCloud22');
fprintf(fileID, 'Volume of ptCloud22: %.4f\n', volume2);

% Close the file
fclose(fileID);

disp('Volumes appended to volumes.txt');

% Function definition must go at the end
function volume = processPointCloud(ptCloud, figureTitle)
    % Load the point cloud
    points = double(ptCloud.Location);

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

    % Compute the convex hull and its volume using original coordinates
    try
        [k, volume] = convhull(x, y, z);
    catch ME
        disp('Error computing the convex hull:');
        disp(ME.message);
        volume = NaN; % Assign NaN if there's an error
        return;
    end

    % Display the point cloud and convex hull
    figure;
    % Isometric View with Original Point Cloud
    subplot(2, 2, 1);
    pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
    xlabel('X (cm)');
    ylabel('Y (cm)');
    zlabel('Z (cm)');
    title(['Isometric View - ', figureTitle]);
    hold on;
    trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
    grid on;
    axis equal;
    hold off;

    % Top View with Original Point Cloud
    subplot(2, 2, 2);
    pcshow(ptCloud, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down', 'MarkerSize', 45);
    view(0, 90); % Set view to top-down
    xlabel('X (cm)');
    ylabel('Y (cm)');
    zlabel('Z (cm)');
    title(['Top View - ', figureTitle]);
    hold on;
    trisurf(k, x, y, z, 'FaceColor', 'cyan', 'FaceAlpha', 0.5);
    grid on;
    axis equal;
    hold off;

    % Volume Display
    subplot(2, 2, [3 4]);
    text(0.5, 0.5, ['Volume of Convex Hull: ', num2str(volume)], 'FontSize', 20, 'Color', 'k', 'BackgroundColor', 'w', 'HorizontalAlignment', 'center');
    axis off;
    title('Convex Hull Volume');
end
