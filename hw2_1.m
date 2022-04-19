% EECE 5612 HW2_1
% Stav Rones
% 2.2.2022
function hw2_1

%     x = -10:0.01:10;
% 
%     z0 = (1/sqrt(2*pi))*exp(1).^((-(x.^2))/2);
%     z1 = (1/(10*sqrt(2*pi)))*exp(1).^((-(x.^2))/(2*10^2));
% 
%     plot(x,z0,x,z1)

%     x = -3:0.01:15;
% 
%     l = 0.5;
%     z = (l/2)*exp(1).^(-l*abs(x));
% 
%     P = zeros(16,1);
%     for SNR = 0:15
%         A = sqrt(10^(SNR/10));
%         l = sqrt(2);
%         P(SNR+1,1) = (1/2)*exp(1)^((-l*A)/2);
%     end
% 
%     semilogy(0:15, P(:,1));
%     xlabel("SNR (dB)")
%     ylabel("Probability")

%     P = zeros(16,2);
%     for SNR = 0:15
% 
%         s1 = 10^(SNR/10);
%         gamma = sqrt(((s1+1)/s1)*log(s1+1));
% 
%         P(SNR+1,1) = 2*qfunc(abs(gamma));
%         P(SNR+1,2) = 1-2*qfunc(abs(gamma/sqrt((s1+1))));
%     end
% 
%     figure(2)
%     semilogy(0:15, P(:,1), 0:15, P(:,2));
%     xlabel("SNR (dB)")
%     ylabel("Probability")
%     legend("Pfa", "Pmd")

    p0 = .1;
    p1 = .9;
    SNR_db = 3;

    A = sqrt(10^(SNR_db/10));
    gamma = (A/2) +log(p0/p1)/A;

    pfa = qfunc(gamma);
    pmd = qfunc(A-gamma);
    pe  = p0*pfa+p1*pmd;

    disp(pfa);
    disp(pmd);
    disp(pe);

end