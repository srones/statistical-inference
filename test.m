function test

    fs = 300;             % 1000 Hz = rev/sec
    t = linspace(0,1,fs); % x axis samled at fs
    
    f = 5;                % number of signals

    % Signal of f sin waves, period 2π, sample rate fs
    sig = sin(2*pi*f*t);
    fourier = fft(sig);

    close all;
    plot(t, sig)
    figure()
    plot(fourier)

    faxis = linspace(-fs/2, fs/2, 8192);
    plot(faxis, fftshift(abs(fft(sig, 8192)))/fs)

end