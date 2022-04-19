% EECE 5612 HW6
% Stav Rones
% 3.21.2022

function hw6

    clc;
    close all;

    y = load("hwk6.mat");
    g_t = y.g;
    v_t = y.v;

    % Compute the cross correlation of v_t and g_t
    [R_vg, lag] = xcorr(v_t, g_t);

    % Visualize xcorr
    plot(lag, R_vg);
   
    % ML Estimation
    [~, tau_index] = max(R_vg);
    tau_ML = lag(tau_index);
    tau_ML = tau_ML / 50;   %convert sample index to time

    fprintf("tau_ML: %4.2f\n", tau_ML);

end