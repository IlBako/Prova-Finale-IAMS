%% test

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.3855;
i = 0.9528;
OM = 2.5510;
om = 2.2540;

theta_vect = (0:0.05:(2*pi+0.01))';

% Norms
norms = zeros(size(vv_vect,1), 1);
for i=1:size(vv_vect,1)
    norms(i) = norm(vv_vect(i, :));
end

pts = point_distribution(0, 2*pi, max(norms)./(norms));
[rr_vect, vv_vect] = mat_parorb2rv(a,e,i,OM,om,pts, mu);

figure
grid on
axis equal
hold on

% Earth
[x1,y1,z1] = sphere(50);
mult=6378;                      % Earth radius
s = surface(x1*mult,y1*mult,z1*mult);
load topo 
s.FaceColor = 'texturemap';     % use texture mapping
s.CData = topo;                 % set color data to topographic data
s.EdgeColor = 'none';           % remove edges
s.FaceLighting = 'gouraud';     % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;       % change the strength of the reflected light
light('Position',[1 1 1])       % add a light

plot3(rr_vect(:,1), rr_vect(:,2), rr_vect(:,3));
view(120,20);


%% comet

x=rr_vect(:,1);
y=rr_vect(:,2);
z=rr_vect(:,3);

comet3(x,y,z);


%% For loop test (standard function)

% r_vect = [];
% for th= 0:0.01:(2*pi+0.01);
%     [r, v] = parorb2rv(a,e,i,OM,om,th,mu);
%     r_vect = [r_vect; r'];
% end