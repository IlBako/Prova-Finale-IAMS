%% starting and final orbits

clear, clc
close all

% starting orbit
rr = [-1788.3462 -9922.9190 -1645.8335];
vv = [5.6510 -1.1520 -1.8710];
mu = 398600;

[a_1, e_1, i_1, OM_1, om_1, theta_1] = rv2parorb(rr, vv, mu);

% theta defined as vector
theta_vect=linspace(0,2*pi,200);

% creating the rr and vv vectos
rr_vect_1=[];
vv_vect_1=[];
for theta=theta_vect
    [rr, vv] = parorb2rv(a_1, e_1, i_1, OM_1, om_1, theta, mu);
    rr_vect_1=[rr_vect_1 rr];
    vv_vect_1=[vv_vect_1 vv];
end
rr_vect_1=rr_vect_1';
vv_vect_1=vv_vect_1';

% modules
rr_module=sqrt(rr_vect_1(:,1).^2+rr_vect_1(:,2).^2+rr_vect_1(:,3).^2);
vv_module=sqrt(vv_vect_1(:,1).^2+vv_vect_1(:,2).^2+vv_vect_1(:,3).^2);

% plots
% plot((1:length(rr_module)),rr_module)       % radius
% grid on, grid minor
% figure
% plot((1:length(vv_module)),vv_module)       % velocity
% grid on, grid minor

% velocity
vel_apo_start=min(vv_module);               % km/s
vel_per_start=max(vv_module);               % km/s

% radius
radius_apo_start=max(rr_module);            % km
radius_per_start=min(rr_module);            % km

% final orbit

a_2 = 13290;
e_2 = 0.3855;
i_2 = 0.9528;
OM_2 = 2.5510;
om_2 = 2.2540;
theta_2 = 3.0360;

rr_vect_2=[];
vv_vect_2=[];
for theta=theta_vect
    [rr, vv] = parorb2rv(a_2, e_2, i_2, OM_2, om_2, theta, mu);
    rr_vect_2=[rr_vect_2 rr];
    vv_vect_2=[vv_vect_2 vv];
end
rr_vect_2=rr_vect_2';
vv_vect_2=vv_vect_2';

% Earth settings
earthPlot;

plot3(rr_vect_1(:,1),rr_vect_1(:,2),rr_vect_1(:,3));
plot3(rr_vect_2(:,1),rr_vect_2(:,2),rr_vect_2(:,3));
view(120,20)