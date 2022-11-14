function dt_12 = CalcoloTempi(a, e, mu, theta_1, theta_2)

    th_mult = sqrt((1-e)/(1+e));
    E1 = 2*atan(th_mult*tan(theta_1/2));
    E2 = 2*atan(th_mult*tan(theta_2/2));
    
    E1 = (2*pi)*(E1<0) + E1;
    E2 = (2*pi)*(E2<0) + E2;

    t_mult = sqrt(a^3/mu);
    t1 = t_mult*(E1 - e*sin(E1));
    t2 = t_mult*(E2 - e*sin(E2));

    if theta_1 > theta_2
        T_orb = 2*pi*sqrt(a^3/mu);
        dt_12 = (T_orb - t1) + t2;
    else
        dt_12 = t2 - t1;
    end
    
end