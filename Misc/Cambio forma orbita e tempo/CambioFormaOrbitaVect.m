function [dv_3, dv_4, dt_4] = CambioFormaOrbitaVect(a_i, e_i, a_f, e_f, om_i, om_f, mu, OM, i, choice)

% Transform the orbit changing a, e and w
%
% [dv_3, dv_4, dt_4] = CambioFormaOrbitaVect(a_i, e_i, a_f, e_f, om_i, om_f, mu, OM, i, choice)
%
% Input arguments:
% ----------------------------------------------------------------
% a_i           [1x1]   semi-major axis (initial)       [Km]
% a_f           [1x1]   semi-major axis (final)         [Km]
% e_i           [1x1]   eccentricity (initial)          [-]
% e_f           [1x1]   eccentricity (final)            [-]
% om_i          [1x1]   pericenter anomaly (initial)    [rad]
% om_f          [1x1]   pericenter anomaly (final)      [rad]
% mu            [1x1]   gravitational parameters        [Km^3/s^2]
% OM            [1x1]   raan                            [rad]
% i             [1x1]   inclination                     [rad]
% choice        [1x1]   starting point (0=apo, 1=peri)  [-]
% 
% -----------------------------------------------------------------
% Output arguments:
% 
% dv_3          [3x1]   delta v (first impulse)         [km/s]
% dv_4          [3x1]   delta v (second impulse)        [km/s]
% dt_4          [1x1]   delta t (tras orbit)            [km/s]

if om_i~=om_f && abs(om_i-om_f)~=pi
    error("Wrong angles!")
end
if a_i==a_f && e_i==e_f && om_i==om_f
    error("Same orbits, generated data is inconclusive!")
end

inverted = false;

[r_p_i, v_p_i] = parorb2rv(a_i, e_i, i, OM, om_i, 0, mu);
[r_p_f, v_p_f] = parorb2rv(a_f, e_f, i, OM, om_f, 0, mu);
[r_a_i, v_a_i] = parorb2rv(a_i, e_i, i, OM, om_i, pi, mu);
[r_a_f, v_a_f] = parorb2rv(a_f, e_f, i, OM, om_f, pi, mu);

if choice
    if om_i==om_f
        e_tras=(norm(r_a_f)-norm(r_p_i))/(norm(r_a_f)+norm(r_p_i));
        p_tras=norm(r_p_i)*(1+e_tras);
        a_tras=p_tras/(1-e_tras^2);
    else
        e_tras=(norm(r_p_f)-norm(r_p_i))/(norm(r_p_f)+norm(r_p_i));
        a_tras=(norm(r_p_i)+norm(r_p_f))/2;
    end
else
    if om_i==om_f
        e_tras=(norm(r_a_i)-norm(r_p_f))/(norm(r_a_i)+norm(r_p_f));
        p_tras=norm(r_a_i)*(1-e_tras);
        a_tras=p_tras/(1-e_tras^2);
    else
        e_tras=(norm(r_a_f)-norm(r_a_i))/(norm(r_a_f)+norm(r_a_i));
        a_tras=(norm(r_a_i)+norm(r_a_f))/2;
    end
end

if e_tras < 0
    inverted = true;
    e_tras = -e_tras;
end

[~, v_p_tras] = parorb2rv(a_tras, e_tras, i, OM, om_i, 0, mu);
[~, v_a_tras] = parorb2rv(a_tras, e_tras, i, OM, om_i, pi, mu);

if choice
    if om_i==om_f
        if inverted
            dv_3 = v_a_tras - v_p_i;
            dv_4 = v_a_f - v_p_tras;
        else
            % perigeo
            dv_3=v_p_tras-v_p_i;
            % apogeo
            dv_4=v_a_f-v_a_tras;
        end
    else
        if inverted
            dv_3 = v_a_tras - v_p_i;
            dv_4 = v_p_f - v_p_tras;
        else
            % perigeo
            dv_3=v_p_tras-v_p_i;
            % apogeo
            dv_4=v_p_f-v_a_tras;
        end
    end
else
    if om_i==om_f
        if inverted
            dv_3 = v_p_tras - v_a_i;
            dv_4 = v_p_f - v_a_tras;
        else
            % apogeo
            dv_3=v_a_tras-v_a_i;
            % perigeo
            dv_4=v_p_f-v_p_tras;
        end
    else
        if inverted
            dv_3 = v_a_tras - v_a_i;
            dv_4 = v_a_f - v_p_tras;
        else
            % apogeo
            dv_3=v_p_tras-v_a_i;
            % perigeo
            dv_4=v_a_f-v_a_tras;
        end
    end
end

dt_4 = CalcoloTempi(a_tras, e_tras, mu, 0, pi);     % da controllare

end