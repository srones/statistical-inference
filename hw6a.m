% EECE 5612 HW6a
% Stav Rones
% 3.28.22

function hw6a

    clc;
    close all;

    % -------- Load Data ----------
    v_t = load("hwk6_1.mat").v;     % baseband received signal
    u_t = load("hwk6_1.mat").u;     % baseband signal corresponding to Barker sequence
    fs = load("hwk6_1.mat").fs;     % sample rate of signals (Hz)

    fprintf("signal length: %i\n", length(v_t));
    
    % ------- estimate the doppler frequency offset -----------

    % f_D should be 5khz 
    n = 1024;  %why?
    sigFFT = fftshift(abs(fft(v_t .* conj(u_t), n)));
    [~, f_D] = max(sigFFT);
    %f_D = f_D * fs / n;

    fprintf("f_D (Hz): %i\n", f_D);
    

    % visualize FFT
    faxis = linspace(-fs/2,fs/2,n);
    plot(faxis, sigFFT);

    % ------- Calculate v from f_D -----------

    % v should be 37.5 m/s
    f_0 = 20 * 10^9;
    c = 3 * 10^8;
    v = c * (f_D / f_0) ;
    fprintf("v (m/s): %6.2f\n", v);
  
end