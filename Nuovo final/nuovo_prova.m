clear, clc
close all

% starting orbit
rr = [-1788.3462 -9922.9190 -1645.8335];
vv = [5.6510 -1.1520 -1.8710];
mu = 398600;

[a_i, e_i, i_i, OM_i, om_i, theta_i] = rv2parorb(rr, vv, mu);

% final orbit
a_f = 13290;
e_f = 0.3855;
i_f = 0.9528;
OM_f = 2.5510;
om_f = 2.2540;
theta_f = 3.0360;


T_size=200;

[theta_vect] = calculateThetaVect(mu, a_i, e_i, T_size);
[rr_vect_i, vv_vect_i] = mat_parorb2rv(a_i,e_i,i_i,OM_i,om_i,theta_vect,mu);
[rr_vect_f, vv_vect_f] = mat_parorb2rv(a_f,e_f,i_f,OM_f,om_f,theta_vect,mu);

% plot orbita iniziale e finale
plot3(rr_vect_i(:,1),rr_vect_i(:,2),rr_vect_i(:,3),"m");
hold on, grid on, grid minor, axis equal
plot3(rr_vect_f(:,1),rr_vect_f(:,2),rr_vect_f(:,3),"m");

% Terra
earthPlot

for manovra=1:4
    if manovra==1
        [dv_1, om_1, theta_1] = CambioPiano(a_i, e_i, i_i, OM_i, om_i, i_f, OM_f, mu);
        [rr_piano_1, ~] = mat_parorb2rv(a_i, e_i, i_f, OM_f, om_1, theta_vect, mu);
        plot3(rr_piano_1(:,1),rr_piano_1(:,2),rr_piano_1(:,3),'--r')

        % IMPLEMENTARE (angolo minore)
        theta_1=theta_1+pi;

        % punto
        [punto, ~] = parorb2rv(a_i, e_i, i_f, OM_f, om_1, theta_1, mu);
        plot3(punto(1),punto(2),punto(3),'ok')

        % traiettoria
        [rr_vect_tra] = semiOrb(rr_vect_i,theta_i,theta_1,a_i,e_i,i_i,OM_i,om_i,mu);
        plot3(rr_vect_tra(:,1),rr_vect_tra(:,2),rr_vect_tra(:,3))
    elseif manovra==2
        [dv_2, theta_3_a, theta_3_b, om_2] = CambioAnPericentro(a_i, e_i, om_1, om_f, mu);

        % altro piano
        if abs(om_f-om_1)>pi/2 && abs(om_f-om_1)<(3*pi)/2
            [rr_piano_2, ~] = mat_parorb2rv(a_i, e_i, i_f, OM_f, om_2, theta_vect, mu);
        else
            [rr_piano_2, ~] = mat_parorb2rv(a_i, e_i, i_f, OM_f, om_f, theta_vect, mu);
        end
        plot3(rr_piano_2(:,1),rr_piano_2(:,2),rr_piano_2(:,3),'--r')

        % punti
        [punto, ~] = parorb2rv(a_i, e_i, i_f, OM_f, om_2, theta_3_a, mu);
        plot3(punto(1),punto(2),punto(3),'ok')
        [punto, ~] = parorb2rv(a_i, e_i, i_f, OM_f, om_2, theta_3_b, mu);
        plot3(punto(1),punto(2),punto(3),'ok')

        % traiettoria
        % NON FUNZIONA
        [rr_vect_tra] = semiOrb(rr_piano_1,theta_1,theta_3_b,a_i,e_i,i_f,OM_f,om_1,mu);
        plot3(rr_vect_tra(:,1),rr_vect_tra(:,2),rr_vect_tra(:,3))

        % prova pericentro
%         [pericentro_prova, ~] = parorb2rv(a_i, e_i, i_f, OM_f, om_2, 0, mu);
%         plot3(pericentro_prova(1),pericentro_prova(2),pericentro_prova(3),'or')
%         [pericentro_prova, ~] = parorb2rv(a_i, e_i, i_f, OM_f, om_1, 0, mu);
%         plot3(pericentro_prova(1),pericentro_prova(2),pericentro_prova(3),'ob')
    elseif manovra==3
        [dv_3, dv_4, dt_4] = CambioFormaOrbitaVect(a_i, e_i, a_f, e_f, om_2, om_f, mu, OM_f, i_f);
        if om_2==om_f
            % plot trasferimento
            [rr_peri_i, vv_peri_i] = mat_parorb2rv(a_i, e_i, i_f, OM_f, om_2, 0, mu);
            vv_peri_i=vv_peri_i+dv_3';
            [a_tras, e_tras, i_tras, OM_tras, om_tras, ~] = rv2parorb(rr_peri_i, vv_peri_i, mu);
            [rr_peri_tras, ~] = mat_parorb2rv(a_tras, e_tras, i_tras, OM_tras, om_tras, theta_vect, mu);
            plot3(rr_peri_tras(:,1),rr_peri_tras(:,2),rr_peri_tras(:,3),'--c')
            
            % plot trasferimento 2
            [rr_apo_tras, vv_apo_tras] = mat_parorb2rv(a_tras, e_tras, i_tras, OM_tras, om_tras, pi, mu);
            vv_apo_tras=vv_apo_tras+dv_4';
            [a_tras2, e_tras2, i_tras2, OM_tras2, om_tras2, ~] = rv2parorb(rr_apo_tras, vv_apo_tras, mu);
            [rr_peri_tras2, ~] = mat_parorb2rv(a_tras2, e_tras2, i_tras2, OM_tras2, om_tras2, theta_vect, mu);
            plot3(rr_peri_tras2(:,1),rr_peri_tras2(:,2),rr_peri_tras2(:,3),'--c')
        else
            % plot trasferimento
            [rr_peri_i, vv_peri_i] = parorb2rv(a_i, e_i, i_f, OM_f, w_2, 0, mu);
            vv_peri_i=vv_peri_i+dv_3;
            [a_tras, e_tras, i_tras, OM_tras, om_tras, ~] = rv2parorb(rr_peri_i, vv_peri_i, mu);
            [rr_peri_tras, ~] = mat_parorb2rv(a_tras, e_tras, i_tras, OM_tras, om_tras, theta_vect, mu);
            plot3(rr_peri_tras(:,1),rr_peri_tras(:,2),rr_peri_tras(:,3),'--c')
            
            % plot trasferimento 2
            [rr_apo_tras, vv_apo_tras] = parorb2rv(a_tras, e_tras, i_tras, OM_tras, om_tras, pi, mu);
            vv_apo_tras=vv_apo_tras+dv_4;
            [a_tras2, e_tras2, i_tras2, OM_tras2, om_tras2, ~] = rv2parorb(rr_apo_tras, vv_apo_tras, mu);
            [rr_peri_tras2, ~] = mat_parorb2rv(a_tras2, e_tras2, i_tras2, OM_tras2, om_tras2, theta_vect, mu);
            plot3(rr_peri_tras2(:,1),rr_peri_tras2(:,2),rr_peri_tras2(:,3),'--c')
        end
    else
    end
end




%%

hold on

%title(sprintf('V= %f km/s', vel_tot(1)), 'Interpreter', 'Latex');
% title(sprintf('Real T = %.2f s\nReal time = Plot time * 1200', ((Periodo_rivoluzione*Riduzione)/T_size)), 'Interpreter', 'Latex');
xlabel('x', 'Interpreter', 'Latex')
ylabel('y', 'Interpreter', 'Latex')
zlabel('z', 'Interpreter', 'Latex')
grid minor
axis equal
view(140,20);                                   % viewing angle

filename = 'animation_vel.gif';

% Earth settings
[x1,y1,z1] = sphere(50);
mult=6378;                                      % Earth radius
s = surface(x1*mult,y1*mult,z1*mult);

load topo 
s.FaceColor = 'texturemap';    % use texture mapping
s.CData = topo;                % set color data to topographic data
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light

rotate(s, [0 0 1],220,[0 0 0])  % pre-rotation

light('Position',[1 1 1])     % add a light

% plot GIF
plot3(x,y,z,'Color','none');
p = plot3(x(1),y(1),z(1),'b');
m = scatter3(x(1),y(1),z(1),'filled','b');

% Iterating through the length of the time array
for k = (1:length(x))
    % Earth rotation
%     rotate(s, [0 0 1],Angolo_rotazione_Terra_frame,[0 0 0])

    % Updating the line
    p.XData = x(1:k);
    p.YData = y(1:k);
    p.ZData = z(1:k);
    % Updating the point
    m.XData = x(k);
    m.YData = y(k);
    m.ZData = z(k);
    % Updating the title
    %title(sprintf('V= %f km/s', vel_tot(k)), 'Interpreter', 'Latex');
%     title(sprintf('Real T = %.2f s\nReal time = Plot time * 1200', ((Periodo_rivoluzione*Riduzione)/T_size)*k), 'Interpreter', 'Latex');
    % Delay
    pause(0.01)
    % Saving the figure
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,...
        'DelayTime',0.05);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append',...
        'DelayTime',0.05);
    end
end


%%

clear, clc
close all

% starting orbit
rr = [-1788.3462 -9922.9190 -1645.8335];
vv = [5.6510 -1.1520 -1.8710];
mu = 398600;

[a_i, e_i, i_i, OM_i, om_i, theta_i] = rv2parorb(rr, vv, mu);

% final orbit
a_f = 13290;
e_f = 0.3855;
i_f = 0.9528;
OM_f = 2.5510;
om_f = 2.2540;
theta_f = 3.0360;


T_size=200;

[theta_vect] = calculateThetaVect(mu, a_i, e_i, T_size);
[rr_vect_i, vv_vect_i] = mat_parorb2rv(a_i,e_i,i_i,OM_i,om_i,theta_vect,mu);
[rr_vect_f, vv_vect_f] = mat_parorb2rv(a_f,e_f,i_f,OM_f,om_f,theta_vect,mu);

% plot orbita iniziale e finale
plot3(rr_vect_i(:,1),rr_vect_i(:,2),rr_vect_i(:,3),"--m");
hold on, grid on, grid minor, axis equal
plot3(rr_vect_f(:,1),rr_vect_f(:,2),rr_vect_f(:,3),"--m");

% Terra
% earthPlot

% prima manovra (cambio piano)
[dv_1, om_1, theta_1] = CambioPiano(a_i, e_i, i_i, OM_i, om_i, i_f, OM_f,mu);
[rr_vect_1, vv_vect_1] = mat_parorb2rv(a_i,e_i,i_f,OM_f,om_1,theta_vect,mu);
plot3(rr_vect_1(:,1),rr_vect_1(:,2),rr_vect_1(:,3),"--b");

% seconda manovra (cambio An pericentro)
[dv_2, theta_2_a, theta_2_b, om_2] = CambioAnPericentro(a_i, e_i, om_i, om_f, mu);
[rr_vect_2, vv_vect_2] = mat_parorb2rv(a_i,e_i,i_f,OM_f,om_2,theta_vect,mu);
plot3(rr_vect_2(:,1),rr_vect_2(:,2),rr_vect_2(:,3),"--b");

% terza manovra (cambio a ed e)
[dv_3, dv_4, dt_4] = CambioFormaOrbitaVect(a_i, e_i, a_f, e_f, om_f, om_2, mu, OM_f, i_f);
