%% test Earth (https://it.mathworks.com/help/matlab/visualize/displaying-topographic-data.html)
% https://towardsdatascience.com/how-to-animate-plots-in-matlab-fa42cf994f3e

clear, clc
close all

[x,y,z] = sphere(50);          % create a sphere 
hold on
mult=10;
s = surface(x*mult,y*mult,z*mult);            % plot spherical surface

load topo 
s.FaceColor = 'texturemap';    % use texture mapping
s.CData = topo;                % set color data to topographic data
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light

axis equal
grid on, grid minor
view(200,20)
light('Position',[-1 0 1])     % add a light


%% test Earth animation

clear, clc
close all

[x,y,z] = sphere(50);          % create a sphere 
hold on
s = surface(x,y,z);            % plot spherical surface

load topo
s.FaceColor = 'texturemap';    % use texture mapping
s.CData = topo;                % set color data to topographic data
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light

axis square off
light('Position',[-1 0 1])     % add a light

view(-20,0);
filename = 'animation_earth.gif';

frame1=60;

for k=1:frame1
    angle=360/frame1;
    rotate(s, [0 0 1],angle)

    pause(0.01)

    % Saving the figure
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,...
        'DelayTime',0.1);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append',...
        'DelayTime',0.1);
    end
end