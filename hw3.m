% EECE 5612 HW3
% Stav Rones
% 2.16.2022

function hw3

    SNR0_db = 10;
    SNR1_db = 15;

    A0 = sqrt(10^(SNR0_db/10));
    A1 = sqrt(10^(SNR1_db/10));

    % Thry| Pcd | Pfa
    P = zeros(11,3);
    for i = 1:11

        Pfa_const = (i-1)/10;

        gamma = A0 + qfuncinv(Pfa_const);
        P(i,1) = qfunc(gamma - A1);
        [P(i,2), P(i,3)] = trials10k(Pfa_const);
        
    end

    plot(0:.1:1, P(:,1), 0:.1:1, P(:,3), "ro", 0:.1:1, P(:,2), "ko")
    title("Calculated vs Theoretical ROC")
    xlabel("Pfa*")
    ylabel("Pcd")
    legend("Pcd Theoretical", "Pcd Observed", "Pfa Observed")
end

function [Pcd, Pfa] = trials10k(Pfa_const)

    SNR0_db = 10;
    SNR1_db = 15;

    A0 = sqrt(10^(SNR0_db/10));
    A1 = sqrt(10^(SNR1_db/10));

    gamma = A0 + qfuncinv(Pfa_const);

    TP = 0; TN = 0;
    FP = 0; FN = 0;

    for i = 1:10000

        % Generate signal
        y = randn();
        if (rand() <= 0.3)
            H0_label = true;
            y = y + A0;
        else
            H0_label = false;
            y = y + A1;
        end

        % NP Detection
        if (y < gamma)
            H0_decision = true;
        else
            H0_decision = false;
        end

        % Determine correctness
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


    % Return Calculated Accuracy
    Pcd = TP / (TP + FN); % (Decide 1|1) / (total 1 occurrences)
    Pfa = FP / (FP + TN); % (Decide 1|0) / (total 0 occurrences)
end