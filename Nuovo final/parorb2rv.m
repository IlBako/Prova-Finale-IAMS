function [rr, vv] = parorb2rv(a, e, i, OM, om, theta, mu)

% Transformation from orbital elements to Cartesian state
%
% [rr, vv] = parorb2rv(a, e, i, OM, om, theta, mu)
%
% Input arguments:
% ----------------------------------------------------------------
% a             [1x1]   semi-major axis                 [km]
% e             [1x1]   eccentricity                    [-]
% i             [1x1]   inclination                     [rad]
% OM            [1x1]   RAAN                            [rad]
% om            [1x1]   pericenter anomaly              [rad]
% theta         [1x1]   true anomaly                    [rad]
% mu            [1x1]   gravitational parameters        [km^3/s^2]
% 
% Output arguments:
% -----------------------------------------------------------------
% rr            [3x1]   position vector                 [km]
% vv            [3x1]   velocity vector                 [km/s]

R_OM = [cos(OM) sin(OM) 0; -sin(OM) cos(OM) 0; 0 0 1];
R_i = [1 0 0; 0 cos(i) sin(i); 0 -sin(i) cos(i)];
R_om = [cos(om) sin(om) 0; -sin(om) cos(om) 0; 0 0 1];

Rot_matrix = R_OM'* R_i'*R_om';

p = a*(1-e^2);
r_PF = (p/(1+e*cos(theta))) .* [cos(theta); sin(theta); 0];
v_PF = sqrt(mu/p) * [-sin(theta); e+cos(theta); 0];

rr = Rot_matrix*r_PF;
vv = Rot_matrix*v_PF;

end