%% test

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.95;
i = 0.9528;
OM = 1.5510;
w_i = -1.2*pi;
w_f = 1.7*pi;
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

if w_i<0
    w_i=2*pi+w_i;
end
if w_f<0
    w_f=2*pi+w_f;
end
if w_i<0 || w_f<0
    error("w_i<0 || w_f<0")
end

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



%%

clear, clc
close all

% starting orbit
rr = [-1788.3462 -9922.9190 -1645.8335];
vv = [5.6510 -1.1520 -1.8710];
mu = 398600;

[a_i, e_i, i_i, OM_i, w_i, theta_i] = rv2parorb(rr, vv, mu);

% final orbit
% a_f = 13290;
% e_f = 0.3855;
i_f = 0.9528;
OM_f = 2.510;
w_f = 2.2540;
% theta_f = 3.0360;

% orbite iniziale e voluta
[dv_1, w_1, theta_1] = CambioPiano(a_i, e_i, i_i, OM_i, w_i, i_f, OM_f, mu);
[dv, theta_3, theta_4, w_f2] = CambioAnPericentro(a_i, e_i, w_1, w_f, mu);
theta_vect=linspace(0,2*pi,200)';
[rr_i, ~] = mat_parorb2rv(a_i, e_i, i_f, OM_f, w_1, theta_vect, mu);
[rr_f, ~] = mat_parorb2rv(a_i, e_i, i_f, OM_f, w_f, theta_vect, mu);

plot3(rr_i(:,1),rr_i(:,2),rr_i(:,3))
hold on, grid on, grid minor, axis equal
plot3(rr_f(:,1),rr_f(:,2),rr_f(:,3))
view(-10,-10)

if w_i<0
    w_i=2*pi+w_i;
end
if w_f<0
    w_f=2*pi+w_f;
end
if w_i<0 || w_f<0
    error("w_i<0 || w_f<0")
end



legend1=0;
% caso con pericentri opposti e tra condizioni if
if abs(w_f-w_1)>pi/2 && abs(w_f-w_1)<(3*pi)/2
    [rr_f2, ~] = mat_parorb2rv(a_i, e_i, i_f, OM_f, w_f2, theta_vect, mu);
    plot3(rr_f2(:,1),rr_f2(:,2),rr_f2(:,3),'--y')
    legend1=1; % alcuni valori mancherebbero...
end

% plot punti di intersezione
[rr_3, ~] = parorb2rv(a_i, e_i, i_f, OM_f, w_f2, theta_3, mu);
[rr_4, ~] = parorb2rv(a_i, e_i, i_f, OM_f, w_f2, theta_4, mu);
plot3(rr_3(1),rr_3(2),rr_3(3),'o',Color='red')
plot3(rr_4(1),rr_4(2),rr_4(3),'o',Color='red')

% plot punto iniziale (theta_i, pericentro iniziale)
[rr_t, ~] = parorb2rv(a_i, e_i, i_f, OM_f, w_i, theta_i, mu);
plot3(rr_t(1),rr_t(2),rr_t(3),'x',Color='blue')

if legend1
    legend("Orbita iniziale","Orbita finale","Orbita ottenuta","Intersezione 1","Intersezione 2","Perigeo inziale");
else
    legend("Orbita iniziale","Orbita finale","Intersezione 1","Intersezione 2","Perigeo inziale");
end