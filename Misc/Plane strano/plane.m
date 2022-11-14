%% plane

clear, clc
close all

p1=[10 15 17];
p2=[8 10 20];

p1_norm=p1/norm(p1);
p2_norm=p2/norm(p2);


Normal=cross(p1_norm,p2_norm);
NN=Normal/norm(Normal);

% f=@(x,y,z) NN(1)*(x)+NN(2)*(y)+NN(3)*(z);
% 
% x_plot=linspace(-100,100,1000);
% y_plot=linspace(-100,100,1000);
% z_plot=linspace(-100,100,1000);


% [x y] = meshgrid(-5:1:5);
% z = (-NN(2)*x + -NN(3)*y)/NN(3);
% surf(x,y,z);

hold on, axis equal

normal_vect=[0 0 0; NN].*100;
p1_vect=[0 0 0; p1].*10;
p2_vect=[0 0 0; p2].*10;
plot3(normal_vect(:,1),normal_vect(:,2),normal_vect(:,3))
plot3(p1_vect(:,1),p1_vect(:,2),p1_vect(:,3))
plot3(p2_vect(:,1),p2_vect(:,2),p2_vect(:,3))

dot(p1,NN)
dot(p2,NN)

disp("LOL viene 0")



%% plane 2 la vendetta

clear, clc
close all

% p1=[10 15 17]; % apocentro
% p2=[8 10 20];

p1=[-3.360786213172955e+03,1.297933989936567e+04,-1.252734187009409e+04];   % apocentro
p2=[-1788.3462 -9922.9190 -1645.8335];

p1_norm=p1/norm(p1);
p2_norm=p2/norm(p2);

Normal=cross(p1_norm,p2_norm);
NN=Normal/norm(Normal);

% [x y] = meshgrid(-5:1:5);
% z = -(NN(1)*x + NN(2)*y)/NN(3);
% surf(x,y,z);
% 
% hold on, axis equal
% 
% normal_vect=[0 0 0; NN].*10;
% p1_vect=[0 0 0; p1_norm].*10;
% p2_vect=[0 0 0; p2_norm].*10;
% plot3(normal_vect(:,1),normal_vect(:,2),normal_vect(:,3))
% plot3(p1_vect(:,1),p1_vect(:,2),p1_vect(:,3))
% plot3(p2_vect(:,1),p2_vect(:,2),p2_vect(:,3))


n_normalized=cross([0 0 1],NN);

if dot(n_normalized,[0 1 0])>=0
    OM=acos(dot([1 0 0],n_normalized));
else
    OM=2*pi-acos(dot([1 0 0],n_normalized));
end

e_norm=-p1_norm;

if dot(e_norm,[0 0 1])>=0
    om=acos(dot(n_normalized,e_norm));
else
    om=2*pi-acos(dot(n_normalized,e_norm));
end

i=acos(dot(NN,[0 0 1]));