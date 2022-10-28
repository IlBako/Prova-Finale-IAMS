function [dv_3, dv_4, dt_4] = CambioFormaOrbitaVect(a_i, e_i, a_f, e_f, w_i, w_f, mu, OM, i)

% Transform the orbit changing a, e and w
%
% [dv_3, dv_4, dt_4] = CambioFormaOrbitaVect(a_i, e_i, a_f, e_f, w_i, w_f, mu, OM, i)
%
% Input arguments:
% ----------------------------------------------------------------
% a_i           [1x1]   semi-major axis (initial)       [Km]
% a_f           [1x1]   semi-major axis (final)         [Km]
% e_i           [1x1]   eccentricity (initial)          [-]
% e_f           [1x1]   eccentricity (final)            [-]
% w_i           [1x1]   pericenter anomaly (initial)    [rad]
% w_f           [1x1]   pericenter anomaly (final)      [rad]
% mu            [1x1]   gravitational parameters        [Km^3/s^2]
% OM            [1x1]   raan                            [rad]
% i             [1x1]   inclination                     [rad]
% 
% -----------------------------------------------------------------
% Output arguments:
% 
% dv_3          [1x1]   delta v (first)                 [km/s]
% dv_4          [1x1]   delta v (second)                [km/s]
% dt_4          [1x1]   delta t (tras orbit)            [km/s]

if w_i~=w_f && abs(w_i-w_f)~=pi
    error("Angoli sbagliati")
end

[r_p_i, v_p_i] = parorb2rv(a_i, e_i, i, OM, w_i, 0, mu);
[r_p_f, v_p_f] = parorb2rv(a_f, e_f, i, OM, w_f, 0, mu);
% [r_a_i, v_a_i] = parorb2rv(a_i, e_i, i, OM, w_i, pi, mu);
[r_a_f, v_a_f] = parorb2rv(a_f, e_f, i, OM, w_f, pi, mu);

if w_i==w_f
    e_tras=(norm(r_a_f)-norm(r_p_i))/(norm(r_a_f)+norm(r_p_i));
else
    e_tras=(norm(r_p_f)-norm(r_p_i))/(norm(r_p_f)+norm(r_p_i));
end

p_tras=norm(r_p_i)*(1+e_tras);
a_tras=p_tras/(1-e_tras^2);

[~, v_p_tras] = parorb2rv(a_tras, e_tras, i, OM, w_i, 0, mu);
[~, v_a_tras] = parorb2rv(a_tras, e_tras, i, OM, w_i, pi, mu);

if w_i==w_f
    % perigeo
    dv_3=v_p_tras-v_p_i;
    % apogeo
    dv_4=v_a_f-v_a_tras;
else
    % perigeo
    dv_3=v_p_tras-v_p_i;
    % apogeo
    dv_4=v_p_f-v_a_tras;
end

dt_4 = CalcoloTempi(a_tras, e_tras, mu, 0, pi);     % da controllare

end