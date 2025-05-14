function cornea_detection_gui
    % Create the main figure
    fig = figure('Name', 'Cornea Detection', 'Position', [100, 100, 800, 600], ...
        'NumberTitle', 'off', 'MenuBar', 'none', 'Resize', 'on');

    % Create panels
    controlPanel = uipanel('Parent', fig, 'Title', 'Controls', ...
        'Position', [0.02, 0.02, 0.2, 0.96]);

    imagePanel = uipanel('Parent', fig, 'Title', 'Image Display', ...
        'Position', [0.24, 0.02, 0.74, 0.96]);

    % Create axes for displaying images
    ax1 = axes('Parent', imagePanel, 'Position', [0.05, 0.55, 0.45, 0.4]);
    title(ax1, 'Original Image');

    ax2 = axes('Parent', imagePanel, 'Position', [0.55, 0.55, 0.45, 0.4]);
    title(ax2, 'Color Threshold Mask');

    ax3 = axes('Parent', imagePanel, 'Position', [0.05, 0.05, 0.45, 0.4]);
    title(ax3, 'Cleaned Mask');

    ax4 = axes('Parent', imagePanel, 'Position', [0.55, 0.05, 0.45, 0.4]);
    title(ax4, 'Cornea Detection Result');

    % Create buttons
    uicontrol('Parent', controlPanel, 'Style', 'pushbutton', ...
        'String', 'Load Image', 'Position', [20, 400, 120, 40], ...
        'Callback', @loadImage);

    uicontrol('Parent', controlPanel, 'Style', 'pushbutton', ...
        'String', 'Execute', 'Position', [20, 340, 120, 40], ...
        'Callback', @executeDetection);

    uicontrol('Parent', controlPanel, 'Style', 'pushbutton', ...
        'String', 'Reset', 'Position', [20, 280, 120, 40], ...
        'Callback', @resetGUI);

    uicontrol('Parent', controlPanel, 'Style', 'pushbutton', ...
        'String', 'Exit', 'Position', [20, 220, 120, 40], ...
        'Callback', @exitGUI);

    % Status text
    statusText = uicontrol('Parent', controlPanel, 'Style', 'text', ...
        'String', 'Ready', 'Position', [20, 160, 120, 40], ...
        'HorizontalAlignment', 'left');

    % Store data in figure
    setappdata(fig, 'ImageData', []);
    setappdata(fig, 'Axes', {ax1, ax2, ax3, ax4});  % Store as cell array
    setappdata(fig, 'StatusText', statusText);

    % -------- Callback functions -------- %
    function loadImage(~, ~)
        [imageFile, imagePath] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files'}, 'Select an Image');
        if imageFile == 0
            updateStatus('No image selected.');
            return;
        end
        imageFullPath = fullfile(imagePath, imageFile);
        try
            img = imread(imageFullPath);
            if size(img, 3) ~= 3
                updateStatus('Error: The input image must be an RGB image.');
                return;
            end
            setappdata(fig, 'ImageData', img);
            axes(ax1); imshow(img); title('Original Image');
            axes(ax2); cla; title('Color Threshold Mask');
            axes(ax3); cla; title('Cleaned Mask');
            axes(ax4); cla; title('Cornea Detection Result');
            updateStatus(['Loaded: ', imageFile]);
        catch e
            updateStatus(['Error loading image: ', e.message]);
        end
    end

    function executeDetection(~, ~)
        img = getappdata(fig, 'ImageData');
        if isempty(img)
            updateStatus('Error: No image loaded.');
            return;
        end
        updateStatus('Processing...');
        try
            imgDouble = im2double(img);
            R = imgDouble(:,:,1); G = imgDouble(:,:,2); B = imgDouble(:,:,3);
            mask = (R > G) & (G > B) & (R > 0.3) & (R < 0.6) & (G > 0.2) & (B < 0.4);
            axes(ax2); imshow(mask); title('Color Threshold Mask');
            se1 = strel('disk', 3); mask_opened = imopen(mask, se1);
            se2 = strel('disk', 5); mask_cleaned = imclose(mask_opened, se2);
            axes(ax3); imshow(mask_cleaned); title('Cleaned Mask');
            [labeledImage, numComponents] = bwlabel(mask_cleaned);
            stats = regionprops(labeledImage, 'Area', 'Perimeter', 'Centroid', 'BoundingBox');
            [h, w, ~] = size(img);
            centerX = w / 2; centerY = h / 2;
            bestScore = -Inf; bestIdx = -1;
            for i = 1:numComponents
                area = stats(i).Area;
                perimeter = stats(i).Perimeter;
                circularity = (4 * pi * area) / (perimeter^2);
                if area < (w * h * 0.01), continue; end
                centroid = stats(i).Centroid;
                dist = sqrt((centroid(1) - centerX)^2 + (centroid(2) - centerY)^2);
                normDist = dist / (sqrt(w^2 + h^2) / 2);
                score = circularity * (1 - normDist);
                if score > bestScore
                    bestScore = score;
                    bestIdx = i;
                end
            end
            axes(ax4); imshow(img); title('Cornea Detection Result');
            if bestIdx > 0
                bbox = stats(bestIdx).BoundingBox;
                cx = bbox(1) + bbox(3)/2;
                cy = bbox(2) + bbox(4)/2;
                radius = max(bbox(3), bbox(4))/2;
                hold on; viscircles([cx, cy], radius, 'Color', 'g', 'LineWidth', 2); hold off;
                updateStatus('Cornea Detection: SUCCESS');
            else
                updateStatus('Cornea Detection: FAILED');
            end
        catch e
            updateStatus(['Error during processing: ', e.message]);
        end
    end

    function resetGUI(~, ~)
        axesHandles = getappdata(fig, 'Axes');
        for i = 1:4
            axes(axesHandles{i});
            cla;
        end
        title(ax1, 'Original Image');
        title(ax2, 'Color Threshold Mask');
        title(ax3, 'Cleaned Mask');
        title(ax4, 'Cornea Detection Result');
        setappdata(fig, 'ImageData', []);
        updateStatus('Reset complete.');
    end

    function exitGUI(~, ~)
        close(fig);
    end

    function updateStatus(msg)
        set(statusText, 'String', msg);
        drawnow;
    end
end
