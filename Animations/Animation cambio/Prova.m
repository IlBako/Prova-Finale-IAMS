clear, clc
close all

mu = 398600;
a = 13290;
e = 0.3855;
OM = 2.5510;
om = 2.2540;

theta_vect=linspace(0,2*pi,201)';

figure
hold on

grid minor
axis equal
view(140,20);

filename = '.\Prova\animation';

i=linspace(0,0.4*pi,201);

[dv_1, w_2, theta_2] = CambioPiano(a, e, i(1), OM, 0, i(1+1), OM, mu);
[rr_vect, vv_vect] = mat_parorb2rv(a,e,i(1+1),OM,w_2,theta_vect,mu);
[rr_vect] = InvRR(rr_vect);         % fix orbit starting point

x=rr_vect(:,1);
y=rr_vect(:,2);
z=rr_vect(:,3);

ww=plot3(x,y,z,'--m');
earthPlot

set(gca,'XLim',[-1.5e4 2e4])
set(gca,'YLim',[-2e4 1.5e4])
set(gca,'ZLim',[-1.5e4 1.5e4])

name=append(filename,"_01.png");
exportgraphics(gcf,name,'Resolution',300)

% Iterating through the length of the time array
for k = (2:length(theta_vect)-1)

    [dv_1, w_2, theta_2] = CambioPiano(a, e, i(k), OM, 0, i(k+1), OM, mu);
    [rr_vect, vv_vect] = mat_parorb2rv(a,e,i(k+1),OM,w_2,theta_vect,mu);
    [rr_vect] = InvRR(rr_vect);         % fix orbit starting point
    
    x=rr_vect(:,1);
    y=rr_vect(:,2);
    z=rr_vect(:,3);
    
    delete(ww)
    ww=plot3(x,y,z,'--m');

    % Updating the title
    %title(sprintf('V= %f km/s', vel_tot(k)), 'Interpreter', 'Latex');
    % Delay
    pause(0.01)
    % Saving the figure
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
%     if k == 2
%         imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.1);
%     else
%         imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1);
%     end
    if k<10
        name=append(filename,"_0",num2str(k),".png");
    else
        name=append(filename,"_",num2str(k),".png");
    end
    exportgraphics(gcf,name,'Resolution',300)
end