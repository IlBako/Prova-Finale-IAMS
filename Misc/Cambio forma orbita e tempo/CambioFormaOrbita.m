function [dv_3, dv_4, dt_4] = CambioFormaOrbita(a_i, e_i, a_f, e_f, w_i, w_f, mu)

p_i=a_i*(1-e_i^2);                              % initial p
p_f=a_f*(1-e_f^2);                              % final p

% v_p and v_a starting orbit
v_p_i=sqrt(mu/p_i)*(1+e_i);
v_a_i=sqrt(mu/p_i)*(1-e_i);
% r_p and r_a starting orbit
r_p_i=p_i/(1+e_i);
r_a_i=p_i/(1-e_i);

% v_p and v_a final orbit
v_p_f=sqrt(mu/p_f)*(1+e_f);
v_a_f=sqrt(mu/p_f)*(1-e_f);
% r_p and r_a starting orbit
r_p_f=p_f/(1+e_f);
r_a_f=p_f/(1-e_f);


if w_i==w_f
    if e_i==e_f
        % pericentro
        dv_3=sqrt(2*mu*(1/r_p_i-1/(2*a_f)))-sqrt(2*mu*(1/r_p_i-1/(2*a_i)));
        % apocentro
        dv_4=sqrt(2*mu*(1/r_a_i-1/(2*a_f)))-sqrt(2*mu*(1/r_a_i-1/(2*a_i)));
    else
        if r_a_i<r_a_f
            % pericentro
            a_f2=(r_p_i+r_a_f)/2;
            dv_3=sqrt(2*mu*(1/r_p_i-1/(2*a_f2)))-sqrt(2*mu*(1/r_p_i-1/(2*a_i)));
            % apocentro
            a_i2=a_f2;
            dv_4=sqrt(2*mu*(1/r_a_i-1/(2*a_f)))-sqrt(2*mu*(1/r_a_i-1/(2*a_i2)));
        else
            % pericentro
            a_f2=(r_p_i+r_a_f)/2;
            dv_3=-(sqrt(2*mu*(1/r_p_i-1/(2*a_f2)))-sqrt(2*mu*(1/r_p_i-1/(2*a_i))));
            % apocentro
            a_i2=a_f2;
            dv_4=sqrt(2*mu*(1/r_a_i-1/(2*a_f)))-sqrt(2*mu*(1/r_a_i-1/(2*a_i2)));
        end
    end
else
    error("da implementare")
end


dt_4=0; % ancora da implementare
    
end