%% test

clear, clc
close all

mu = 398600;
a = 13290;
e = 0.6855;
i = 0.9528;
OM = 2.5510;
om = 2.2540;

T_size=200;

theta_vect = calculateThetaVect(mu, a, e, T_size);

theta_vect=InvRR(theta_vect);

[rr, vv] = mat_parorb2rv(a, e, i, OM, om, theta_vect, mu);
plot3(rr(:,1),rr(:,2),rr(:,3))
grid on, grid minor, axis equal, hold on
plot3(rr(1,1),rr(1,2),rr(1,3),'o')
plot3(rr(end,1),rr(end,2),rr(end,3),'o')

n=0;
for i=1:length(theta_vect)
    for k=1:length(theta_vect)
        if theta_vect(i)==theta_vect(k) && i~=k
            n=n+1;
            disp(i)
        end
    end
end
disp(n)