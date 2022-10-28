function [th] = calculateTh(t, tp, mu, a, e)
    M=sqrt(mu/(a^3))*(t-tp);

    f=@(x) -M+x-e*sin(x);
    df=@(x) 1-e.*cos(x);

    [xvect,~]=newton(1,100,1e-8,f,df);
    E=xvect(end);

    th = 2*atan(tan(E/2)/sqrt((1-e)/(1+e)));
end