function [dv, theta_3_a, theta_3_b] = CambioAnPericentro2(a, e, w_i, w_f, theta_i, mu)
    dw=w_f-w_i;

    if dw>=2*pi
        error("Angoli sbagliati");
    end

    if abs(dw)>pi/2 && abs(dw)<(3*pi)/2
        dw=pi-abs(dw);

        theta_2_a=dw/2;
        theta_2_b=dw/2+pi;

        theta_3_a=theta_2_a;
        theta_3_b=theta_2_b;
    elseif abs(dw)<pi/2 || abs(dw)>(3*pi)/2
        theta_2_a=dw/2;
        theta_2_b=dw/2+pi;

        theta_3_a=2*pi-theta_2_a;
        theta_3_b=2*pi-theta_2_b;
    else
        error("Non ancora implementato");
    end

    p = a*(1-e^2);
    dv = 2*sqrt(mu/p)*e*sin(dw/2);

end