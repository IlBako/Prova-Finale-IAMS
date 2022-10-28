function [dv, theta_3, theta_4, dt] = CambioAnPericentro(a, e, w_i, w_f, theta_i, mu)

    dw = w_f - w_i;                 % Calcolo deltaw

    theta_3_a = dw/2;               % Theta_3: punti di cambio orbita per l'orbita iniziale
    theta_3_b = dw/2+pi;            % a) più vicino  alla terra |b) più lontano

    p = a*(1-e^2);
    dv = 2*sqrt(mu/p)*e*sin(dw/2);

    dt_a = CalcoloTempi(a, e, mu, theta_i, theta_3_a);
    dt_b = CalcoloTempi(a, e, mu, theta_i, theta_3_b);

    if dt_a < dt_b
        dt = dt_a;
        theta_3 = theta_3_a;
    else
        dt = dt_b;
        theta_3 = theta_3_b;
    end

    theta_4 = 2*pi - theta_3;

end