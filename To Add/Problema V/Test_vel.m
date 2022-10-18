%% test solo geometria

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.3855;
i = 0.9528;
OM = 2.5510;
om = 2.2540;
dth = 0.05;

theta_vect = (0:dth:(2*pi+dth))';
[rr_vect, vv_vect] = Mat_parorb2rv(a,e,i,OM,om,theta_vect, mu);          % Modified function


[x1,y1,z1] = sphere(50);
hold on
mult=6371;
s = surface(x1*mult,y1*mult,z1*mult);

load topo 
s.FaceColor = 'texturemap';
s.CData = topo;
s.EdgeColor = 'none';
s.FaceLighting = 'gouraud';
s.SpecularStrength = 0.4;

axis equal
light('Position',[-1 0 1])

[rr]=InvVel(rr_vect,a,e);

x=rr_vect(:,1);
y=rr_vect(:,2);
z=rr_vect(:,3);

plot3(x,y,z);
grid on, grid minor
view(140,20);

figure
[x1,y1,z1] = sphere(50);
hold on
mult=6371;
s = surface(x1*mult,y1*mult,z1*mult);

load topo 
s.FaceColor = 'texturemap';
s.CData = topo;
s.EdgeColor = 'none';
s.FaceLighting = 'gouraud';
s.SpecularStrength = 0.4;

axis equal
light('Position',[-1 0 1])

x=rr(:,1);
y=rr(:,2);
z=rr(:,3);

plot3(x,y,z);
grid on, grid minor
view(140,20);



%% test con animazione

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.3855;
i = 0.9528;
OM = 2.5510;
om = 2.2540;
dth = 0.01;

theta_vect = (0:dth:(2*pi+dth))';
[rr_vect, vv_vect] = Mat_parorb2rv(a,e,i,OM,om,theta_vect, mu);          % Modified function

[rr_vect]=InvVel(rr_vect,a,e);
[rr_vect] = InvRR(rr_vect);

x=rr_vect(:,1);
y=rr_vect(:,2);
z=rr_vect(:,3);

vel_tot=sqrt(vv_vect(:,1).^2+vv_vect(:,2).^2+vv_vect(:,3).^2);

% calcolo T orbita
Periodo_rivoluzione=2*pi*sqrt(a^3/mu);
Riduzione=1200;
Periodo_rivoluzione=Periodo_rivoluzione/Riduzione;
t = (1:length(x));
Durata_frame=Periodo_rivoluzione/length(t);

% calcolo T Terra
Periodo_rivoluzione_Terra=24*60*60;
Periodo_rivoluzione_Terra=Periodo_rivoluzione_Terra/Riduzione;
Vel_angolare_Terra=360/Periodo_rivoluzione_Terra;
Angolo_rotazione_Terra_frame=Vel_angolare_Terra*Durata_frame;

figure
hold on

% UNITA' DI MISURA VELOCITA'????????????????????????
%title(sprintf('V= %f km/s', vel_tot(1)), 'Interpreter', 'Latex');
title(sprintf('Real T = %.2f s\nReal time = Plot time * 1200', ((Periodo_rivoluzione*Riduzione)/length(t))), 'Interpreter', 'Latex');
xlabel('x', 'Interpreter', 'Latex')
ylabel('y', 'Interpreter', 'Latex')
zlabel('z', 'Interpreter', 'Latex')
grid minor
axis equal
view(140,20);                                   % viewing angle

filename = 'animation_vel.gif';

% Earth settings
[x1,y1,z1] = sphere(50);
mult=6371;                                      % Earth radius
s = surface(x1*mult,y1*mult,z1*mult);

load topo topo topomap1 
s.FaceColor = 'texturemap';    % use texture mapping
s.CData = topo;                % set color data to topographic data
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light

light('Position',[-1 0 1])     % add a light

% plot GIF
plot3(x,y,z,'Color','none');
p = plot3(x(1),y(1),z(1),'b');
m = scatter3(x(1),y(1),z(1),'filled','b');

% Iterating through the length of the time array
for k = t
    % Earth rotation
    rotate(s, [0 0 1],Angolo_rotazione_Terra_frame,[0 0 0])

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
    title(sprintf('Real T = %.2f s\nReal time = Plot time * 1200', ((Periodo_rivoluzione*Riduzione)/length(t))*k), 'Interpreter', 'Latex');
    % Delay
    pause(0.01)
    % Saving the figure
%     frame = getframe(gcf);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     if k == 1
%         imwrite(imind,cm,filename,'gif', 'Loopcount',inf,...
%         'DelayTime',Durata_frame);
%     else
%         imwrite(imind,cm,filename,'gif','WriteMode','append',...
%         'DelayTime',Durata_frame);
%     end
end