%% bug
% circonferenza finale

a_i = 20000;
e_i = 0.8;
a_f = 20000;
e_f = 0;
om_i = 1.3*pi;
om_f = 0.3*pi;
scelta=0;


%% prova copy

clear, clc
close all

mu = 398600;

a_i = 20000;
e_i = 0.8;
a_f = 20000;
e_f = 0;
om_i = 1.3*pi;
om_f = 0.3*pi;
scelta=0;

i = 0.9528;
OM = 2.5510;

theta_vect=linspace(0,2*pi,200)';
[rr_i, vv_i] = mat_parorb2rv(a_i, e_i, i, OM, om_i, theta_vect, mu);
[rr_f, vv_f] = mat_parorb2rv(a_f, e_f, i, OM, om_f, theta_vect, mu);

plot3(rr_i(:,1),rr_i(:,2),rr_i(:,3))
hold on, grid on, grid minor, axis equal
plot3(rr_f(:,1),rr_f(:,2),rr_f(:,3))
view(-10,-10)

[dv_3, dv_4, dt_4] = CambioFormaOrbitaVect(a_i, e_i, a_f, e_f, om_i, om_f, mu, OM, i, scelta);

% plot trasferimento 1
if scelta
    [rr_1_i, vv_1_i] = parorb2rv(a_i, e_i, i, OM, om_i, 0, mu); % 1 = pericentro, 2 = apocentro
else
    [rr_1_i, vv_1_i] = parorb2rv(a_i, e_i, i, OM, om_i, pi, mu); % 1 = apocentro, 2 = pericentro
end
vv_1_i=vv_1_i+dv_3;
[a_tras, e_tras, i_tras, OM_tras, om_tras, theta_tras] = rv2parorb(rr_1_i, vv_1_i, mu);
[rr_peri_tras, ~] = mat_parorb2rv(a_tras, e_tras, i_tras, OM_tras, om_tras, theta_vect, mu);
plot3(rr_peri_tras(:,1),rr_peri_tras(:,2),rr_peri_tras(:,3))

% plot trasferimento 2
angle = theta_tras+pi;
[rr_2_tras, vv_2_tras] = parorb2rv(a_tras, e_tras, i_tras, OM_tras, om_tras, angle, mu);
vv_2_tras=vv_2_tras+dv_4;
[a_tras2, e_tras2, i_tras2, OM_tras2, om_tras2, ~] = rv2parorb(rr_2_tras, vv_2_tras, mu);
[rr_peri_tras2, ~] = mat_parorb2rv(a_tras2, e_tras2, i_tras2, OM_tras2, om_tras2, theta_vect, mu);
plot3(rr_peri_tras2(:,1),rr_peri_tras2(:,2),rr_peri_tras2(:,3),'--',Color='cyan')

legend("Inziale","Finale","Trasferimento","Prova orbita finale");

fprintf("DeltaV = %.4f km/s\nTime = %.0f s\n",norm(dv_3)+norm(dv_4),dt_4);



%%

clear, clc
close all

mu = 398600;

a_i = 14000;
e_i = 0.75;
a_f = 10290;
e_f = 0.55;
om_i=1.2*pi;
om_f=0.2*pi;

i = 0.9528;
OM = 2.5510;

[r_p_i, v_p_i] = parorb2rv(a_i, e_i, i, OM, om_i, 0, mu);
[r_p_f, v_p_f] = parorb2rv(a_f, e_f, i, OM, om_f, 0, mu);
[r_a_i, v_a_i] = parorb2rv(a_i, e_i, i, OM, om_i, pi, mu);
[r_a_f, v_a_f] = parorb2rv(a_f, e_f, i, OM, om_f, pi, mu);

e_tras=(norm(r_p_f)-norm(r_p_i))/(norm(r_p_f)+norm(r_p_i));
p_tras=norm(r_p_i)*(1+e_tras);
a_tras=p_tras/(1-e_tras^2);

theta_vect=linspace(0,2*pi,200)';
[rr, vv] = mat_parorb2rv(a_tras, e_tras, i, OM, om_i, theta_vect, mu);

plot3(rr(:,1),rr(:,2),rr(:,3));
hold on, grid on, grid minor, axis equal

[rr, vv] = mat_parorb2rv(a_i, e_i, i, OM, om_i, theta_vect, mu);
plot3(rr(:,1),rr(:,2),rr(:,3));
[rr, vv] = mat_parorb2rv(a_f, e_f, i, OM, om_f, theta_vect, mu);
plot3(rr(:,1),rr(:,2),rr(:,3));
legend("Trasferimento","Iniziale","Finale")



% punti
[rr, vv] = mat_parorb2rv(a_i, e_i, i, OM, om_i, 0, mu);
plot3(rr(1),rr(2),rr(3),'o')
[rr, vv] = mat_parorb2rv(a_f, e_f, i, OM, om_f, 0, mu);
plot3(rr(1),rr(2),rr(3),'o')
[rr, vv] = mat_parorb2rv(a_i, e_i, i, OM, om_i, pi, mu);
plot3(rr(1),rr(2),rr(3),'o')
[rr, vv] = mat_parorb2rv(a_f, e_f, i, OM, om_f, pi, mu);
plot3(rr(1),rr(2),rr(3),'o')