function hw9

    clc;
    close all;
    y = load("hwk9.mat").y; % 36x1 vector

    %% Estimate a0, a1 using first 24 values
    n = 24;
    Sxy = sum(y(1:n).*(1:n));
    Sxx = sum((1:n).^2);
    Sx  = sum(1:n);
    Sy  = sum(y(1:n));

    a1  = (Sxy - Sx*Sy/n)/(Sxx-(Sx^2)/n);
    a0  = (Sy - a1*Sx)/n;

    fprintf("a0: %3.2f\n", a0);
    fprintf("a1: %3.2f\n", a1);

    y_lin = (1:length(y))*a1 + a0;

    %% Estyimate a using AR-1 model
    DeltaY = y(1:n) - y_lin(1:n);

    acf = autocorr(DeltaY);
    R = toeplitz(acf,acf);
    r = circshift(acf,-1)';

    R = R(1,1);
    r = r(1);

    a_hat = R*r;

    %% Predict 25-36
    y_hat = zeros(36,1);

    deltaY = y(24) - y_lin(24);

    for i = 25:36
        y_hat(i) = y_lin(i) + a_hat*deltaY;
        deltaY = y_hat(i) - y_lin(i);
    end

    %% Visualize
    plot(y, 'bo');
    hold on;
    plot(y_lin)
    hold on;
    plot(y_hat, "o")
    legend("Truth", "Linear", "Prediction");

    %% Part II
    
    % training:
    for i = 2:24

    end

end