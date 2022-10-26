function [dv, theta_3_a, theta_3_b] = CambioAnPericentro(a, e, w_i, w_f, mu)
    dw=w_f-w_i;

    if dw>=2*pi || w_i<0 || w_f<0
        error("Angoli sbagliati");
    end

    if dw>pi/2 && dw<(3*pi)/2
        dw=pi-abs(dw);

        theta_2_a=dw/2;
        theta_2_b=dw/2+pi;

        theta_3_a=theta_2_a;
        theta_3_b=theta_2_b;
    elseif dw<=pi/2 || dw>=(3*pi)/2
        theta_2_a=dw/2;
        theta_2_b=dw/2+pi;

        theta_3_a=2*pi-theta_2_a;
        theta_3_b=2*pi-theta_2_b;
    end

    p = a*(1-e^2);
    dv = 2*sqrt(mu/p)*e*sin(dw/2);

end