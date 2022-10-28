function [dv, theta_3_a, theta_3_b, w_f2] = CambioAnPericentro(a, e, w_i, w_f, mu)

% Transform the orbit changing the pericenter (w e theta)
%
% [dv, theta_3_a, theta_3_b, w_f2] = CambioAnPericentro(a, e, w_i, w_f, mu)
%
% Input arguments:
% ----------------------------------------------------------------
% a             [1x1]   semi-major axis                 [Km]
% e             [1x1]   eccentricity                    [-]
% w_i           [1x1]   pericenter anomaly (initial)    [rad]
% w_f           [1x1]   pericenter anomaly (final)      [rad]
% mu            [1x1]   gravitational parameters        [Km^3/s^2]
% 
% -----------------------------------------------------------------
% Output arguments:
% 
% dv            [1x1]   delta v                         [km/s]
% theta_3_a     [1x1]   encounter point 1               [rad]
% theta_3_b     [1x1]   encounter point 2               [rad]
% w_f2          [1x1]   pericenter anomaly (latest)     [rad]

    dw=w_f-w_i;

    if dw>=2*pi || w_i<0 || w_f<0 || (w_i==0 && w_f==0)
        error("Angoli sbagliati");
    end

    if dw>pi/2 && dw<(3*pi)/2
        dw=pi-abs(dw);

        theta_2_a=dw/2;
        theta_2_b=dw/2+pi;

        theta_3_a=theta_2_a;
        theta_3_b=theta_2_b;
        
        w_f2=w_f-pi;
    elseif dw<=pi/2 || dw>=(3*pi)/2
        theta_2_a=dw/2;
        theta_2_b=dw/2+pi;

        theta_3_a=2*pi-theta_2_a;
        theta_3_b=2*pi-theta_2_b;

        w_f2=w_f;
    end

    p = a*(1-e^2);
    dv = 2*sqrt(mu/p)*e*sin(dw/2);

end