function [rr, vv] = Mat_parorb2rv(a, e, i, OM, om, theta_vect, mu)

% Transformation from Cartesian state to orbital elements 
% given theta as a vector
% [rr, vv] = parorb2rv(a, e, i, OM, om, theta_vect, mu)
%
% Input arguments:
% ----------------------------------------------------------------
% a             [1x1]   semi-major axis                 [Km]
% e             [1x1]   eccentricity                    [-]
% i             [1x1]   inclination                     [rad]
% OM            [1x1]   RAAN                            [rad]
% om            [1x1]   pericenter anomaly              [rad]
% theta_vect    [nx1]   vector of true anomalies        [rad]
% mu            [1x1]   gravitational parameters        [Km^3/s^2]
% 
% -----------------------------------------------------------------
% Output arguments:
% 
% rr            [3xn]   position matrix                 [Km]
% vv            [3xn]   velocity matrix                 [Km/s]

R_OM = [cos(OM) sin(OM) 0; -sin(OM) cos(OM) 0; 0 0 1];
R_i = [1 0 0; 0 cos(i) sin(i); 0 -sin(i) cos(i)];
R_om = [cos(om) sin(om) 0; -sin(om) cos(om) 0; 0 0 1];
Rot_matrix = R_OM'* R_i'*R_om';

p = a*(1-e^2);
temp = p./(1+e*cos(theta_vect));

r_PF = [temp.*cos(theta_vect) temp.*sin(theta_vect) temp.*0];
v_PF = sqrt(mu/p) .* [-sin(theta_vect) e+cos(theta_vect) zeros(size(theta_vect, 1), 1)];

rr = Rot_matrix * r_PF';
rr = rr';

vv = Rot_matrix * v_PF';
vv = vv';

end