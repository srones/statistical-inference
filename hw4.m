% EECE 5612 HW4
% Stav Rones
% 2.22.2022

function hw4

    % load file
    Y = table2array(struct2table(load('hwk4.mat')));
    bits = zeros(0);

    for y = 1:length(Y)

        complex = Y(y);
        phi = angle(complex);
        
        if (phi < 0)
            phi = (2*pi) + phi;
        end

        enum = round(phi/(pi/4));
        
        if (enum == 8)
         enum = 0;
        end

        bits = cat(2,bits,dec2bin(enum, 3));
    end

    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    message = '';

    for i = 1:(length(bits))/5
        
        bits5 = bits((5*i)-4 : 5*i);
        bitsStr = strjoin(string(bits5));
        enum2 = bin2dec(bitsStr);

        if (enum2 == 0)
            message = append(message, " ");
        else
            message = append(message, alphabet(enum2));
        end
    end

    disp(message)
end