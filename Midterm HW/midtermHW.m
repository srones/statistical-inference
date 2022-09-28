% EECE 5612 Midterm Project
% Stav Rones
% 3.9.22

function midtermHW

    % Read in noisy image
    Y = load('mdt22.mat').y;
    ret = zeros(1000);
    
    % Method 2 (Decide pixel
    window_radius = 14;
    for i = (window_radius + 1):(1000 - window_radius)
        for j = (window_radius + 1):(1000 - window_radius) 
    
            x_range = (i - window_radius):(i + window_radius);
            y_range = (j - window_radius):(j + window_radius);
    
            window = Y(x_range, y_range);
    
            if mean(window, 'all') > (255 / 2)
                ret(i,j) = 255;
            end
        end
    end
    
    figure()
    imshow(Y)

    end 
