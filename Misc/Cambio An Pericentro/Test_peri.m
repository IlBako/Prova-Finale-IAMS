%% test

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.95;
i = 0.9528;
OM = 2.5510;
w_i = 0*pi;
w_f = 1.2*pi;
theta_i = 0; % theta iniziale

% orbite iniziale e voluta
[dv, theta_3, theta_4, w_f2] = CambioAnPericentro(a, e, w_i, w_f, mu);
theta_vect=linspace(0,2*pi,200)';
[rr_i, ~] = mat_parorb2rv(a, e, i, OM, w_i, theta_vect, mu);
[rr_f, ~] = mat_parorb2rv(a, e, i, OM, w_f, theta_vect, mu);

plot3(rr_i(:,1),rr_i(:,2),rr_i(:,3))
hold on, grid on, grid minor, axis equal
plot3(rr_f(:,1),rr_f(:,2),rr_f(:,3))
view(-10,-10)

legend1=0;
% caso con pericentri opposti e tra condizioni if
if abs(w_f-w_i)>pi/2 && abs(w_f-w_i)<(3*pi)/2
    [rr_f2, ~] = mat_parorb2rv(a, e, i, OM, w_f2, theta_vect, mu);
    plot3(rr_f2(:,1),rr_f2(:,2),rr_f2(:,3))
    legend1=1; % alcuni valori mancherebbero...
end

% plot punti di intersezione
[rr_3, ~] = parorb2rv(a, e, i, OM, w_f2, theta_3, mu);
[rr_4, ~] = parorb2rv(a, e, i, OM, w_f2, theta_4, mu);
plot3(rr_3(1),rr_3(2),rr_3(3),'o',Color='red')
plot3(rr_4(1),rr_4(2),rr_4(3),'o',Color='red')

% plot punto iniziale (theta_i, pericentro iniziale)
[rr_t, ~] = parorb2rv(a, e, i, OM, w_i, theta_i, mu);
plot3(rr_t(1),rr_t(2),rr_t(3),'x',Color='blue')

if legend1
    legend("Orbita iniziale","Orbita finale","Orbita ottenuta","Intersezione 1","Intersezione 2","Perigeo inziale");
else
    legend("Orbita iniziale","Orbita finale","Intersezione 1","Intersezione 2","Perigeo inziale");
end