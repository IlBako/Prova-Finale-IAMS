%% earth plot

clear, clc
close all

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
axis equal

image_file = 'https://svs.gsfc.nasa.gov/vis/a000000/a003600/a003615/flat_earth03.jpg';
cdata = imread(image_file);
cdata=cdata([end:-1:1],:,:);
set(s, 'FaceColor', 'texturemap', 'CData', cdata, 'EdgeColor', 'none');

view(120,20)


%% test earth plot

clear, clc
close all

[s] = earthPlot ();