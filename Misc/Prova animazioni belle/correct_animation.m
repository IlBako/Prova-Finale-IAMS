%% animation engine

clear, clc
close all


% --------------- ORBITS ---------------

% orbita iniziale
rr_i = [-1788.3462 -9922.9190 -1645.8335];
vv_i = [5.6510 -1.1520 -1.8710];
mu = 398600;
[a_i, e_i, i_i, OM_i, om_i, theta_i] = rv2parorb(rr_i, vv_i, mu);

% orbita finale
a_f = 13290;
e_f = 0.3855;
i_f = 0.9528;
OM_f = 2.5510;
om_f = 2.2540;
theta_f = 3.0360;

% --------------------------------------


% ------------- VARIABLES -------------

T_size=20;                          % per orbita
export=1;
filename = 'F:\Matlab\Orbita';      % directory + .PNGs names
frame_duration=0.08;
number_of_frames=20;                % per manovre

% -------------------------------------


% --------------- SETUP ---------------

if export
    export=answerFunction(export);
end
[theta_vect] = calculateThetaVect(mu, a_i, e_i, T_size);

figure
view(140,20);
hold on, grid minor, axis equal

% earth
s=earthPlot;

one_orbit_time=frame_duration*T_size;
orbit_duration=2*pi*sqrt((a_i^3)/mu);

factor=one_orbit_time/orbit_duration;

earth_rotation_duration=24*60*60;
earth_rotation_duration=earth_rotation_duration*factor;
angular_vel=360/earth_rotation_duration;
frame_rotation_angle=angular_vel*frame_duration;

% framing
[apo_i, ~] = parorb2rv(a_i, e_i, i_i, OM_i, om_i, pi, mu);
[apo_f, ~] = parorb2rv(a_f, e_f, i_f, OM_f, om_f, pi, mu);
max_frame=max(norm(apo_i),norm(apo_f));

set(gca,'XLim',[-max_frame max_frame])
set(gca,'YLim',[-max_frame max_frame])
set(gca,'ZLim',[-max_frame max_frame])

% filename
name=append(filename,"_1.png");

% -------------------------------------






% --------------- ENGINE ---------------

j=0;

% cambio piano
[dv_1, om_1, theta_cambioPiano] = CambioPiano(a_i, e_i, i_i, OM_i, om_i, i_f, OM_f, mu);

% semiOrb 1
angle1=theta_i;           % relative to the 1st orbit, rad
angle2=theta_cambioPiano;      % relative to the 1st orbit, rad

[rr_vect_complete, ~] = mat_parorb2rv(a_i,e_i,i_i,OM_i,om_i,theta_vect,mu); % complete orbit
[rr_semiVect] = semiOrb(rr_vect_complete,angle1,angle2,a_i, e_i, i_i, OM_i, om_i, mu);

type=0;
plot_temp=plot3(rr_vect_complete(:,1),rr_vect_complete(:,2),rr_vect_complete(:,3),'--m');
for k=1:length(rr_semiVect)
    j=j+1;
    rr_orb=rr_semiVect(1:k,:);
    exportPng(rr_orb,j,filename,export,type,s,frame_rotation_angle);
end
delete(plot_temp)

% manovra 1
[i_vect,OM_vect,om_vect]=parametersSpread(number_of_frames,i_i,i_f,OM_i,OM_f,om_i,om_1);

type=1;
plot_temp=plot3(rr_semiVect(end,1),rr_semiVect(end,2),rr_semiVect(end,3),'or');
for k=2:number_of_frames % without initial orbit
    j=j+1;  % global
    [rr_orb, ~] = mat_parorb2rv(a_i,e_i,i_vect(k),OM_vect(k),om_vect(k),theta_vect,mu);
    exportPng(rr_orb,j,filename,export,type,s,frame_rotation_angle);
end
delete(plot_temp)



% manovra 2
[dv_2, theta_2_a, theta_2_b, om_2] = CambioAnPericentro(a_i, e_i, om_1, om_f, mu);

% LOL
while theta_2_a>2*pi
    theta_2_a=theta_2_a-2*pi;
end
while theta_2_b>2*pi
    theta_2_b=theta_2_b-2*pi;
end


% semi orb 2 (tra orbita iniziale e cambiata di piano)
% om_f==om_2
angle1=theta_cambioPiano;
angle2=2*pi-theta_2_b;
% angle2=2*pi-theta_2_a;

[rr_vect_complete, ~] = mat_parorb2rv(a_i,e_i,i_f,OM_f,om_1,theta_vect,mu); % complete orbit
[rr_semiVect] = semiOrb(rr_vect_complete,angle1,angle2,a_i, e_i, i_f, OM_f, om_1, mu);

type=0;
plot_temp=plot3(rr_vect_complete(:,1),rr_vect_complete(:,2),rr_vect_complete(:,3),'--m');
for k=1:length(rr_semiVect)
    j=j+1;
    rr_orb=rr_semiVect(1:k,:);
    exportPng(rr_orb,j,filename,export,type,s,frame_rotation_angle);
end
delete(plot_temp)


% manovra plot
[i_vect,OM_vect,om_vect]=parametersSpread(number_of_frames,0,0,0,0,om_1,om_f);

type=1;
plot_temp=plot3(rr_semiVect(end,1),rr_semiVect(end,2),rr_semiVect(end,3),'or');
for k=2:number_of_frames % without initial orbit
    j=j+1;  % global
    [rr_orb, ~] = mat_parorb2rv(a_i,e_i,i_f,OM_f,om_vect(k),theta_vect,mu);
    exportPng(rr_orb,j,filename,export,type,s,frame_rotation_angle);
end
delete(plot_temp)

% x=rr_orb(:,1);
% y=rr_orb(:,2);
% z=rr_orb(:,3);
% plot3(x,y,z,'--m');
% 
% [rr_orb, ~] = mat_parorb2rv(a_i,e_i,i_f,OM_f,om_vect(end),theta_2_a,mu);
% x=rr_orb(:,1);
% y=rr_orb(:,2);
% z=rr_orb(:,3);
% frame1=plot3(x,y,z,'ob');
% 
% [rr_orb, ~] = mat_parorb2rv(a_i,e_i,i_f,OM_f,om_vect(end),theta_2_b,mu);
% x=rr_orb(:,1);
% y=rr_orb(:,2);
% z=rr_orb(:,3);
% frame1=plot3(x,y,z,'ob');



% semiOrb afsgdhgfjk
angle1=theta_2_b;           % relative to the 1st orbit, rad
angle2=0;      % relative to the 1st orbit, rad

[rr_vect_complete, ~] = mat_parorb2rv(a_i,e_i,i_f,OM_f,om_2,theta_vect,mu); % complete orbit
[rr_semiVect] = semiOrb(rr_vect_complete,angle1,angle2,a_i, e_i, i_f, OM_f, om_2, mu);

type=0;
plot_temp=plot3(rr_vect_complete(:,1),rr_vect_complete(:,2),rr_vect_complete(:,3),'--m');
for k=1:length(rr_semiVect)
    j=j+1;
    rr_orb=rr_semiVect(1:k,:);
    exportPng(rr_orb,j,filename,export,type,s,frame_rotation_angle);
end
delete(plot_temp)



% sghjfgkgjhgf
choice=1;
[dv_3, dv_4, dt_4] = CambioFormaOrbitaVect(a_i, e_i, a_f, e_f, om_2, om_f, mu, OM_f, i_f, choice);

if choice
    [rr_1_i, vv_1_i] = parorb2rv(a_i, e_i, i_f, OM_f, om_2, 0, mu); % 1 = pericentro, 2 = apocentro
else
    [rr_1_i, vv_1_i] = parorb2rv(a_i, e_i, i_f, OM_f, om_2, pi, mu); % 1 = apocentro, 2 = pericentro
end



% manovra plot
dv_3_step=dv_3./number_of_frames;
dv_3_vect=(1:number_of_frames).*dv_3_step;

type=1;
plot_temp=plot3(rr_semiVect(end,1),rr_semiVect(end,2),rr_semiVect(end,3),'or');
for k=2:number_of_frames % without initial orbit
    j=j+1;  % global
    vv_1_i_post=vv_1_i+dv_3_vect(:,k);
    [a_tras, e_tras, i_tras, OM_tras, om_tras, theta_tras] = rv2parorb(rr_1_i, vv_1_i_post, mu);
    [rr_peri_tras, ~] = mat_parorb2rv(a_tras, e_tras, i_tras, OM_tras, om_tras, theta_vect, mu);
    % attenzione! velocità sbagliate ma non cambia...
    exportPng(rr_peri_tras,j,filename,export,type,s,frame_rotation_angle);
end
delete(plot_temp)



% semiOrb afsgdhgfjk
angle1=angle2;           % relative to the 1st orbit, rad
angle2=angle2+pi;      % relative to the 1st orbit, rad

[theta_vect] = calculateThetaVect(mu, a_tras, e_tras, T_size);

[rr_vect_complete, ~] = mat_parorb2rv(a_tras,e_tras,i_f,OM_f,om_2,theta_vect,mu); % complete orbit
[rr_semiVect] = semiOrb(rr_vect_complete,angle1,angle2,a_tras, e_tras, i_f, OM_f, om_2, mu);

type=0;
plot_temp=plot3(rr_vect_complete(:,1),rr_vect_complete(:,2),rr_vect_complete(:,3),'--m');
for k=1:length(rr_semiVect)
    j=j+1;
    rr_orb=rr_semiVect(1:k,:);
    exportPng(rr_orb,j,filename,export,type,s,frame_rotation_angle);
end
delete(plot_temp)


% plot trasferimento 2
angle = theta_tras+pi;
[rr_2_tras, vv_2_tras] = parorb2rv(a_tras, e_tras, i_tras, OM_tras, om_tras, angle, mu);

% manovra plot 2 gdhtjfyku
dv_4_step=dv_4./number_of_frames;
dv_4_vect=(1:number_of_frames).*dv_4_step;

type=1;
plot_temp=plot3(rr_semiVect(end,1),rr_semiVect(end,2),rr_semiVect(end,3),'or');
for k=2:number_of_frames % without initial orbit
    j=j+1;  % global
    vv_2_tras_post=vv_2_tras+dv_4_vect(:,k);
    [a_tras2, e_tras2, i_tras2, OM_tras2, om_tras2, ~] = rv2parorb(rr_2_tras, vv_2_tras_post, mu);
    [rr_peri_tras2, ~] = mat_parorb2rv(a_tras2, e_tras2, i_tras2, OM_tras2, om_tras2, theta_vect, mu);
    exportPng(rr_peri_tras2,j,filename,export,type,s,frame_rotation_angle);
end
delete(plot_temp)




% semiOrb quasi finales
angle1=angle2;           % relative to the 1st orbit, rad
angle2=theta_f;      % relative to the 1st orbit, rad

[theta_vect] = calculateThetaVect(mu, a_f, e_f, T_size);

[rr_vect_complete, vv_vect_complete] = mat_parorb2rv(a_f,e_f,i_f,OM_f,om_f,theta_vect,mu); % complete orbit
[rr_semiVect] = semiOrb(rr_vect_complete,angle1,angle2,a_f, e_f, i_f, OM_f, om_2, mu);

type=0;
plot_temp=plot3(rr_vect_complete(:,1),rr_vect_complete(:,2),rr_vect_complete(:,3),'--m');
for k=1:length(rr_semiVect)
    j=j+1;
    rr_orb=rr_semiVect(1:k,:);
    exportPng(rr_orb,j,filename,export,type,s,frame_rotation_angle);
end
delete(plot_temp)


% [rr_orb, vv_vect_complete] = mat_parorb2rv(a_f,e_f,i_f,OM_f,om_f,theta_vect,mu);
% x=rr_orb(:,1);
% y=rr_orb(:,2);
% z=rr_orb(:,3);
% frame1=plot3(x,y,z,'--b');

if export
    warning("Done!")
end

% --------------------------------------








% -------------- FUNCTIONS --------------

function exportPng(rr_vect,k,filename,export,type,s,frame_rotation_angle)
    x=rr_vect(:,1);
    y=rr_vect(:,2);
    z=rr_vect(:,3);
    
    if ~type
        plot3(x,y,z,'b');
        frame1=plot3(x(end),y(end),z(end),'or');
        rotate(s, [0 0 1],frame_rotation_angle,[0 0 0])
    else
        frame1=plot3(x,y,z,'--m');
    end

    pause(0.1)
    % Saving the figure
    if export
        name=append(filename,"_",num2str(k),".png");
        exportgraphics(gcf,name,'Resolution',300)
    end
    
    delete(frame1)
end


function [para1,para2,para3]=parametersSpread(number,para1_1_old,para1_2_old,para2_1_old,para2_2_old,para3_1_old,para3_2_old)
    para1=linspace(para1_1_old,para1_2_old,number);
    para2=linspace(para2_1_old,para2_2_old,number);
    para3=linspace(para3_1_old,para3_2_old,number);
end


function [export]=answerFunction(export)
    answer=0;
    while ~answer
        reply = input('Are you sure to create PNGs? [Y/N]:','s');
        if isempty(reply)
            reply = 'Y';
        end
        if strlength(reply)==1
            if reply=='n' || reply=='N'
                warning("'export' set to 0")
                export=0;
                answer=1;
            elseif reply=='y' || reply=='Y'
                warning("Generating PNGs...")
                answer=1;
            end
        end
    end
end

% ---------------------------------------