clear, clc
close all

mu = 398600;
a = 13290;
e = 0.95;
i = 0.9528;
OM = 2.5510;
w_1 = 2.2540;
w_2 = 1.3142;
theta_1 = 0;

w = flip(linspace(2.5, 5, 50));
k = 1;

M = ["Num" "w_i" "w_f" "dw" "th3_a" "th3_b" "dv" "dt_a" "dt_b" "th_4"];
writematrix(M, "Log_peri.xls", "WriteMode","overwrite");

for w_2 = w

%     figure

    [dv, theta_3, theta_4, dt] = Log_cambioPeri(a, e, w_1, w_2, theta_1, mu, k);
    
%     plotOrbit(a, e, i, OM, w_1, 0, 2*pi, 0.01, mu);
%     hold on; grid minor; axis equal;
%     plotOrbit(a, e, i, OM, w_2, 0, 2*pi, 0.01, mu);
%     
%     [rr_1, vv_1] = parorb2rv(a, e, i, OM, w_1, theta_3, mu);
%     [rr_2, vv_2] = parorb2rv(a, e, i, OM, w_2, theta_4, mu);
%     plot3(rr_1(1), rr_1(2), rr_1(3), 'xb', 'LineWidth', 1.5);
%     plot3(rr_2(1), rr_2(2), rr_2(3), 'ok', 'LineWidth', 1.5);
%     
%     [rr_1_0, vv_1_0] = parorb2rv(a, e, i, OM, w_1, 0, mu);
%     [rr_1_pi, vv_1_pi] = parorb2rv(a, e, i, OM, w_1, pi, mu);
%     [rr_2_0, vv_2_0] = parorb2rv(a, e, i, OM, w_2, 0, mu);
%     [rr_2_pi, vv_2_pi] = parorb2rv(a, e, i, OM, w_2, pi, mu);
%     
%     l1 = [rr_1_0'; rr_1_pi'];
%     l2 = [rr_2_0'; rr_2_pi'];
%     
%     plot3(l1(:, 1), l1(:, 2), l1(:, 3), '--k', 'LineWidth',1.5);
%     plot3(l2(:, 1), l2(:, 2), l2(:, 3), '--k', 'LineWidth',1.5);
%     
%     view(0, 90);
%     plot3(0,0,0, 'xb', 'LineWidth', 3);
    k = k+1;

end


%% test

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.95;
i = 0.9528;
OM = 2.5510;
w_i = 0*pi;
w_f = 0.7*pi;
theta_i = 0; % theta iniziale

% orbite iniziale e voluta
[dv, theta_3, theta_4] = CambioAnPericentro2(a, e, w_i, w_f, theta_i, mu);
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
    w_f=w_f-pi;
    [rr_f2, ~] = mat_parorb2rv(a, e, i, OM, w_f, theta_vect, mu);
    plot3(rr_f2(:,1),rr_f2(:,2),rr_f2(:,3))
    legend1=1; % alcuni valori mancherebbero...
end

% plot punti di intersezione
[rr_3, ~] = parorb2rv(a, e, i, OM, w_f, theta_3, mu);
[rr_4, ~] = parorb2rv(a, e, i, OM, w_f, theta_4, mu);
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