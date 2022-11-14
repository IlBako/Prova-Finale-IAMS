function [rr, vv] = parorb2rv(a, e, i, OM, om, theta, mu)

% Transformation from orbital elements to Cartesian state 
% given n theta angles
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
% theta         [nx1]   true anomaly vector             [rad]
% mu            [1x1]   gravitational parameters        [km^3/s^2]
% 
% Output arguments:
% -----------------------------------------------------------------
% rr            [3xn]   position vector                 [km]
% vv            [3xn]   velocity vector                 [km/s]

R_OM = [cos(OM) sin(OM) 0; -sin(OM) cos(OM) 0; 0 0 1];      % Rotation around z axis with angle OM
R_i = [1 0 0; 0 cos(i) sin(i); 0 -sin(i) cos(i)];           % Rotation around x axis with angle i
R_om = [cos(om) sin(om) 0; -sin(om) cos(om) 0; 0 0 1];      % Rotation around z axis with angle om

Rot_matrix = R_OM'* R_i'*R_om';                             % Rotation matrix applies all rotations

p = a*(1-e^2);                                              % Semi-latus rectus
temp = p./(1+e*cos(theta));                                 % Radius trigonometric coefficient

% Calculate radius and velocity in the Perifocal system
r_PF = [temp.*cos(theta) temp.*sin(theta) temp.*0];
v_PF = sqrt(mu/p) .* [-sin(theta) e+cos(theta) zeros(size(theta, 1), 1)];

% Apply rotations to switch from perifocal to ECI system
rr = Rot_matrix * r_PF';
rr = rr';
vv = Rot_matrix * v_PF';
vv = vv';

end