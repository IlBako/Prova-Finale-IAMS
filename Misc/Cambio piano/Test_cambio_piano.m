clear, clc
close all

% mu = 398600;
% a = 13290;
% e = 0.3855;
% i_1 = 0.9528;
% OM_1 = 2.5510;
% w_1 = 2.2540;
% i_2 = 0.3455;
% OM_2 = 0.9218;

% starting orbit
rr = [-1788.3462 -9922.9190 -1645.8335];
vv = [5.6510 -1.1520 -1.8710];
mu = 398600;

[a, e, i_1, OM_1, om_1, ~] = rv2parorb(rr, vv, mu);

% final orbit
i_2 = 0.9528;
OM_2 = 2.5510;
% om_2 = 2.2540;

[dv_1, om_2, theta_2] = CambioPiano(a, e, i_1, OM_1, om_1, i_2, OM_2, mu);

% correzione om_2<0
if om_2<0
    om_2=2*pi+om_2;
end

plotOrbit(a, e, i_1, OM_1, om_1, 0, 2*pi, 0.01, mu);
hold on; grid minor; axis equal;
plotOrbit(a, e, i_2, OM_2, om_2, 0, 2*pi, 0.01, mu);

[rr_1, vv_1] = parorb2rv(a, e, i_1, OM_1, om_1, theta_2, mu);
[rr_2, vv_2] = parorb2rv(a, e, i_2, OM_2, om_2, theta_2+pi, mu);
plot3(rr_1(1), rr_1(2), rr_1(3), 'ok', 'LineWidth', 1.5);
plot3(rr_2(1), rr_2(2), rr_2(3), 'ok', 'LineWidth', 1.5);

plot3(0,0,0, 'xb', 'LineWidth', 3);