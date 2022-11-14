function [theta_vect] = calculateThetaVect(mu, a, e, T_size)
    
% [theta_vect] = calculateThetaVect(mu, a, e, T_size)
% 
% orbital parameters and T_size (size of the rr_vect that will be impl)

    T_tot=2*pi*sqrt(a^3/mu);
    T_vect=linspace(0,T_tot,T_size);
    
    theta_vect=[];
    for k=1:length(T_vect)
        t=T_vect(k);
        tp=T_tot/2;
        
        M=sqrt(mu/(a^3))*(t-tp);
    
        f=@(x) -M+x-e*sin(x);
        df=@(x) 1-e.*cos(x);
    
        [xvect,~]=newton(1,100,1e-8,f,df);
        E=xvect(end);
    
        theta = 2*atan(tan(E/2)/sqrt((1-e)/(1+e)));
    
        theta_vect=[theta_vect; theta];
    end
end