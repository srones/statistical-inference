% EECE 5612 HW1
% Stav Rones
% 2.2.2022

function hw1

    % P_thry | Pfp | Pfn | Pe
    P = zeros(16,4);
 
    for SNR_db = 0:15
        i = SNR_db + 1;

        A = sqrt(10^((SNR_db)/10));

        % P Theroretical
        P(i,1) = qfunc(A/2);

        [P(i,2), P(i,3)] = mlTest10k(SNR_db);
        P(i,4) = 0.3 * P(i,2) + 0.7 * P(i,3);
    end

    figure(1)
    semilogy(0:15,P(:,1), 0:15, P(:,2), "ro" , 0:15, P(:,3), "ko", 0:15, P(:,4), "bo")
    title('SNR vs P(FP), P(FN), P(E)')
    xlabel('SNR (db)')
    ylabel('Probability')
    legend("Pthry", "P(FP)", "P(FN)", "P(E)")
end


% Use ML to test binary hypotheses:
function [Pfp, Pfn] = mlTest10k(SNR)

    disp("Testing SNR = " + SNR);

    % Convert SNR to Amplitude
    A = sqrt(10^(SNR/10));

    FP = 0; FN = 0;
    TP = 0; TN = 0;

    for i = 1:10000
   
        % Generate signal
        y = randn();
        H0_label = true;
        if (rand() > 0.3)
            y = A + y;
            H0_label = false;
        end
        
        % Decide using ML
        H0_decision = true; 
        if y > A / 2
            H0_decision = false;
        end


        if H0_label
            if H0_decision
                TN = TN + 1;
            else
                FP = FP + 1;
            end
        else
            if H0_decision
                FN = FN + 1;
            else
                TP = TP + 1;
            end
        end
    end

    Pfp = FP/(FP+TN);
    Pfn = FN/(FN+TP);
end








