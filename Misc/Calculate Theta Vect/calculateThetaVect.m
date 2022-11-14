function [theta_vect] = calculateThetaVect(mu, a, e, T_size)
    
% [theta_vect] = calculateThetaVect(mu, a, e, T_size)
% 
% orbital parameters and T_size (size of the rr_vect that will be impl)
% 
% The funcion incorporate also Newton and invRR for a final output

    T_tot=2*pi*sqrt(a^3/mu);
    T_vect=linspace(0,T_tot,T_size);
    
    theta_vect=[];
    for k=1:length(T_vect)
        t=T_vect(k);
        tp=T_tot/2;
        
        M=sqrt(mu/(a^3))*(t-tp);
    
        f=@(x) -M+x-e*sin(x);
        df=@(x) 1-e.*cos(x);
    
        [xvect,~]=newton(2,100,1e-8,f,df);
        E=xvect(end);
    
        theta = 2*atan(tan(E/2)/sqrt((1-e)/(1+e)));
    
        theta_vect=[theta_vect; theta];
    end
    theta_vect=InvRR(theta_vect);
end


% other functions

function [xvect,it]=newton(x0,nmax,toll,fun,dfun, mol)

    if (nargin == 5)
        mol = 1;
    end
    
    err = toll + 1;
    it = 0;
    xvect = x0;
    xv = x0;
    
    while (it< nmax && err> toll)
       dfx = dfun(xv);
       if dfx == 0
          error(' Arresto per azzeramento di dfun');
       else
          xn = xv - mol*fun(xv)/dfx;
          err = abs(xn-xv);
          xvect = [xvect; xn];
          it = it+1;
          xv = xn;
       end
    end
    
% only critical output
    if (it < nmax)
%         fprintf(' Convergenza al passo k : %d \n',it);
    else
        fprintf(' E` stato raggiunto il numero massimo di passi k : %d \n',it);
    end
%         fprintf(' Radice calcolata       : %-12.8f \n', xvect(end));

end


function [rr_vect] = InvRR(rr_vect)

    inversion=0;
    if size(rr_vect,1)<size(rr_vect,2)
        rr_vect=rr_vect';
        inversion=1;
    end
    
    dim=size(rr_vect,1);
    
    if rem(dim,2)==0
        for i=1:dim
            if i<=dim/2
                dummy(i,:)=rr_vect(dim/2+i,:);
            else
                dummy(i,:)=rr_vect(i-dim/2,:);
            end
        end
        dummy=[dummy; dummy(1,:)];
    else
        for i=1:dim
            if i<=floor(dim/2)
                dummy(i,:)=rr_vect(floor(dim/2)+i,:);
            else
                dummy(i,:)=rr_vect(i-floor(dim/2),:);
            end
        end
    end
    
    if inversion
        rr_vect=dummy';
    else
        rr_vect=dummy;
    end

end