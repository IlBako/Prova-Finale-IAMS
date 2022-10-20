function [S] = TestAer(rr_vect_new,rr_vect_giusta_v,step)

dim=size(rr_vect_new,1);

% angoli
% rad=grad*(pi/180)

% dim=dim/2;

step=step*(180/pi);

theta_tot=0;
S=[];
for i=1:dim-1
    %theta_tot=theta_tot+step;

    r1_1=sqrt(rr_vect_new(i+1,1)^2+rr_vect_new(i+1,2)^2+rr_vect_new(i+1,3)^2);
    r2_1=sqrt(rr_vect_giusta_v(i+1,1)^2+rr_vect_giusta_v(i+1,2)^2+rr_vect_giusta_v(i+1,3)^2);
    sigma1=asind((r1_1/r2_1)*sind(step+theta_tot));
    

    r1_2=sqrt(rr_vect_new(i,1)^2+rr_vect_new(i,2)^2+rr_vect_new(i,3)^2);
    r2_2=sqrt(rr_vect_giusta_v(i,1)^2+rr_vect_giusta_v(i,2)^2+rr_vect_giusta_v(i,3)^2);
    sigma2=asind((r1_2/r2_2)*sind(theta_tot));

    sigma=abs(sigma1-sigma2);
    theta_tot=theta_tot+step;

    %S_i=((r2_1^2)*(cosd(sigma/2)*sind(sigma/2)))/2+((r2_2^2)*(cosd(sigma/2)*sind(sigma/2)))/2;
    S_i=0.5*r2_1*r2_2*sind(sigma);

    S=[S S_i];
end

end