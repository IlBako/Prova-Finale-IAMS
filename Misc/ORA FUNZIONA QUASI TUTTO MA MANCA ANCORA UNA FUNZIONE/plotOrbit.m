function plotOrbit(a, e, i, OM, om, th0, thf, dt, mu)

% Function to plot a 3D orbit in the inertial frame
%
%
% plotOrbit(a, e, i, OM, om, th0, thf, dt, mu)
%
% Input arguments:
% ---------------------------------------------------------------------
% a             [1x1]   semi-major axis                     [km]
% e             [1x1]   eccentricity                        [-]
% i             [1x1]   inclination                         [rad]
% OM            [1x1]   RAAN                                [rad]
% om            [1x1]   pericenter anomaly                  [rad]
% th0           [1x1]   initial true anomaly                [rad]
% thf           [1x1]   final true anomaly                  [rad]
% dth           [1x1]   true anomaly discretisation step    [rad]
% mu            [1x1]   gravitational parameters            [km^3/s^2]

if (th0 > thf)
    thf = thf+2*pi;
end

theta_vect = (th0:dt:(thf+dt))';
[rr_vect] = mat_parorb2rv(a,e,i,OM,om,theta_vect, mu);

plot3(rr_vect(:,1), rr_vect(:,2), rr_vect(:,3));

end