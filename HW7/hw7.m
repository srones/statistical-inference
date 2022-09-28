function hw7

    clc;

    % -------------- Load data --------------
    v = load("hwk7-1.mat").Y;
    m = length(v);

    % -------------- Find delta_phi GML --------------
    delta_phi = linspace(0, 2*pi, 500); % search space
    
    GML = zeros(1,500);
    for i = 1:length(delta_phi)

        % calculate steering vector
        a = exp((0:m-1)' * -1j * delta_phi(i));

        % calculate delta phi estimate
        GML(i) = abs(a'*v);
    end

    [~, i_max] = max(GML);
    delta_phi_gml = delta_phi(i_max);

    fprintf("Noise:\ndelta_phi_gml (deg): %6.2f\n", rad2deg(delta_phi_gml));

    % -------------- visualize GML function -------------- 
    plot(rad2deg(delta_phi), GML);
    xlabel("\Delta \phi º");
    ylabel("|a'*v|");

    % -------------- delta_phi -> Theta -------------- 
    f0 = 3E9;
    c = 3E8;
    d = 0.05;

    theta_gml = asin(delta_phi_gml*c / (2*pi*f0*d));
    fprintf("theta_gml (deg): %6.2f\n", rad2deg(theta_gml));

    % ----------------------------------------
    % -------------- Noiseless ---------------
    % ----------------------------------------

    d = .05;                 % distance between sensors
    c = 3E8;                 % wave speed
    f0 = 3E9;                % 3 KHz frequency (what is this)?
    
    theta_true = pi/4;
    delta_phi_true = 2*pi*f0*d/c*sin(theta_true);

    % -------------- Generate observed array --------------

    V_t = zeros(16,1);
    for m = 1:16
        V_t(m) = exp(-1j*(m-1)*delta_phi_true);
    end


    % -------------- Find GML delta phi --------------
    delta_phi = linspace(0, 2*pi, 500); % search space
    
    GML = zeros(1,500);
    for i = 1:length(delta_phi)

        % calculate steering vector
        a = exp((0:15)' * -1j * delta_phi(i));

        % calculate delta phi estimate
        GML(i) = abs(a'* V_t);
    end

    [~, i_max] = max(GML);
    delta_phi_gml = delta_phi(i_max);

    fprintf("\nNoiseless:\ndelta_phi_gml (deg): %6.2f\n", rad2deg(delta_phi_gml));

    % -------------- visualize GML function -------------- 
    plot(rad2deg(delta_phi), GML);
    xlabel("\Delta \phi º");
    ylabel("|a'*v|");

    % -------------- delta_phi -> Theta -------------- 
    f0 = 3E9;
    c = 3E8;
    d = 0.05;

    theta_gml = asin(delta_phi_gml*c / (2*pi*f0*d));
    fprintf("theta_gml (deg): %6.2f\n", rad2deg(theta_gml));
    

end