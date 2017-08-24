function P = normalization(P,source,f,conf)
    switch source
    case 'point'
        P = 4*pi * P;
    case 'line'
        omega = 2*pi*f;
        P = sqrt(8*pi*omega / conf.c) * exp(1i*pi / 4) * P;
    end
end
