%% test 1

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.3855;
i = 0.9528;
OM = 2.5510;
om = 2.2540;
theta = 3.0360;

[rr_t1, vv_t1] = parorb2rv(a, e, i, OM, om, theta, mu);
[a_t1, e_t1, i_t1, OM_t1, om_t1, theta_t1] = rv2parorb (rr_t1, vv_t1, mu);


%% test 2

clear, clc
close all

rr = [-1788.3462 -9922.9190 -1645.8335];
vv = [5.6510 -1.1520 -1.8710];
mu = 398600;

[a_t2, e_t2, i_t2, OM_t2, om_t2, theta_t2] = rv2parorb (rr, vv, mu);
[rr_t2, vv_t2] = parorb2rv(a_t2, e_t2, i_t2, OM_t2, om_t2, theta_t2, mu);


%% test 2 orbits

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.3855;
i = 0.9528;
OM = 2.5510;
om = 2.2540;
rr = [-1788.3462 -9922.9190 -1645.8335];
vv = [5.6510 -1.1520 -1.8710];
[a_t2, e_t2, i_t2, OM_t2, om_t2, theta_t2] = rv2parorb(rr, vv, mu);

figure;
grid on, grid minor
axis equal
hold on
view(120, 20);

plotOrbit(a, e, i, OM, om, 0, 2*pi, 0.01, mu);
plotOrbit(a_t2, e_t2, i_t2, OM_t2, om_t2, 0, 2*pi, 0.01, mu);