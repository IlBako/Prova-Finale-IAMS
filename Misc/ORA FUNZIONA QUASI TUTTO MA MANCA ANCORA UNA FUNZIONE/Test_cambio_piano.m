clear, clc
close all

mu = 398600;
a = 13290;
e = 0.3855;
i_1 = 0.9528;
OM_1 = 2.5510;
w_1 = 2.2540;
i_2 = 0.3455;
OM_2 = 0.9218;

[dv_1, w_2, theta_2] = CambioPiano(a, e, i_1, OM_1, w_1, i_2, OM_2, mu);

plotOrbit(a, e, i_1, OM_1, w_1, 0, 2*pi, 0.01, mu);
hold on; grid minor; axis equal;
plotOrbit(a, e, i_2, OM_2, w_2, 0, 2*pi, 0.01, mu);

[rr_1, vv_1] = parorb2rv(a, e, i_1, OM_1, w_1, theta_2+pi, mu);
[rr_2, vv_2] = parorb2rv(a, e, i_2, OM_2, w_2, theta_2, mu);
plot3(rr_1(1), rr_1(2), rr_1(3), 'ok', 'LineWidth', 1.5);
plot3(rr_2(1), rr_2(2), rr_2(3), 'ok', 'LineWidth', 1.5);

plot3(0,0,0, 'xb', 'LineWidth', 3);