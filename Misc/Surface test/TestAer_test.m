%% prova

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.3855;
i = 0.9528;
OM = 2.5510;
om = 2.2540;

theta_vect = (0:0.0001:(2*pi))';
[rr_vect_OG, vv_vect] = Mat_parorb2rv(a,e,i,OM,om,theta_vect, mu);

[rr]=InvVel(rr_vect_OG,a,e);
[rr_vect_giusta] = InvRR(rr);

[rr_vect_OG] = InvRR(rr_vect_OG);

step=0.0001;
[S] = TestAer(rr_vect_OG,rr_vect_giusta,step);

plot((1:length(S)),S)

%A=sqrt(rr_vect_giusta(:,1).^2+rr_vect_giusta(:,2).^2+rr_vect_giusta(:,3).^2);
%B=sqrt(rr_vect_OG(:,1).^2+rr_vect_OG(:,2).^2+rr_vect_OG(:,3).^2);