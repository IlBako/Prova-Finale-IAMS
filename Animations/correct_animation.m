clear, clc
close all

mu = 398600;
a = 13290;
e = 0.3855;
i = 0.9528;
OM = 2.5510;
om = 2.2540;

T_tot=2*pi*sqrt(a^3/mu);
T_size=200;
T_vect=linspace(0,T_tot,T_size);

theta_vect=[];
for k=1:length(T_vect)
    t=T_vect(k);
    tp=T_tot/2;

    theta = calculateTh(t, tp, mu, a, e);

    theta_vect=[theta_vect; theta];
end

[rr_vect, vv_vect] = mat_parorb2rv(a,e,i,OM,om,theta_vect, mu);
[rr_vect] = InvRR(rr_vect);         % fix orbit starting point

x=rr_vect(:,1);
y=rr_vect(:,2);
z=rr_vect(:,3);

% calcolo T orbita
Periodo_rivoluzione=T_tot;
Riduzione=1200;
Periodo_rivoluzione=Periodo_rivoluzione/Riduzione;
Durata_frame=Periodo_rivoluzione/length(x);

% calcolo T Terra
Periodo_rivoluzione_Terra=24*60*60;
Periodo_rivoluzione_Terra=Periodo_rivoluzione_Terra/Riduzione;
Vel_angolare_Terra=360/Periodo_rivoluzione_Terra;
Angolo_rotazione_Terra_frame=Vel_angolare_Terra*Durata_frame;

figure
hold on

%title(sprintf('V= %f km/s', vel_tot(1)), 'Interpreter', 'Latex');
title(sprintf('Real T = %.2f s\nReal time = Plot time * 1200', ((Periodo_rivoluzione*Riduzione)/T_size)), 'Interpreter', 'Latex');
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
    title(sprintf('Real T = %.2f s\nReal time = Plot time * 1200', ((Periodo_rivoluzione*Riduzione)/T_size)*k), 'Interpreter', 'Latex');
    % Delay
    pause(0.01)
    % Saving the figure
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,...
        'DelayTime',Durata_frame);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append',...
        'DelayTime',Durata_frame);
    end
end