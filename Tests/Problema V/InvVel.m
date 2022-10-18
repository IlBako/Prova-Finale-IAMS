function [rr]=InvVel(rr_vect,a,e)

rp=(a*(1-e^2))/(1+e);
distanza=2*(a-rp);

angolo1=rr_vect(1,1)/rp;
angolo2=rr_vect(1,2)/rp;
angolo3=rr_vect(1,3)/rp;

rr_vect(:,1)=rr_vect(:,1)+distanza*angolo1;
rr_vect(:,2)=rr_vect(:,2)+distanza*angolo2;
rr_vect(:,3)=rr_vect(:,3)+distanza*angolo3;

rr_vect(:,1)=-rr_vect(:,1);
rr_vect(:,2)=-rr_vect(:,2);
rr_vect(:,3)=-rr_vect(:,3);

rr=rr_vect;

end