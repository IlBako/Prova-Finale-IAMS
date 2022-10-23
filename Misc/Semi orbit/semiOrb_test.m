%% semiOrb test

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
T_vect=linspace(0,T_tot,T_size+1);

theta_vect=[];
for k=1:length(T_vect)
    t=T_vect(k);
    tp=T_tot/2;

    M=sqrt(mu/(a^3))*(t-tp);

    f=@(x) -M+x-e*sin(x);
    df=@(x) 1-e.*cos(x);

    [xvect,~]=newton(1,100,1e-8,f,df);
    E=xvect(end);

    theta=2*atan(tan(E/2)/sqrt((1-e)/(1+e)));

    theta_vect=[theta_vect; theta];
end

[rr_vect, vv_vect] = mat_parorb2rv(a,e,i,OM,om,theta_vect, mu);
[rr_vect] = InvRR(rr_vect);

plot3(rr_vect(:,1),rr_vect(:,2),rr_vect(:,3))
hold on, grid on, grid minor

theta1=0.8*pi;
theta2=1.6*pi;

[rr_vect_new] = semiOrb(rr_vect,theta1,theta2,a, e, i, OM, om, mu);
view(120,20);
comet3(rr_vect_new(:,1),rr_vect_new(:,2),rr_vect_new(:,3))