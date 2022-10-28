function [dv_1, w_2, theta_2] = CambioPiano(a, e, i_1, OM_1, w_1, i_2, OM_2, mu)
    
    % delta OMEGA and delta i
    d_OM = OM_2-OM_1;
    d_i = i_2 - i_1;
    alpha = acos(cos(i_1)*cos(i_2)+sin(i_1)*sin(i_2)*cos(d_OM));
    % alpha = alpha * (-1)*(d_OM*alpha<0);
    
    % cos(u1) and cos(u2)
    c_u1 = -(cos(i_2) - cos(alpha)*cos(i_1))/(sin(alpha)*sin(i_1));
    c_u2 = (cos(i_1) - cos(alpha)*cos(i_2))/(sin(alpha)*sin(i_2));

    % sin(u1) and sin(u2)
    s_u1 = sin(d_OM)/sin(alpha)*sin(i_2);
    s_u2 = sin(d_OM)/sin(alpha)*sin(i_1);

    u1 = atan2(s_u1, c_u1);
    u2 = atan2(s_u2, c_u2);

    if d_OM>0 && d_i>0 || d_OM<0 && d_i<0
        theta_1 = u1 - w_1;
        theta_2 = theta_1;
        w_2 = u2 - theta_2;
    else
        theta_1 = 2*pi - u1 - w_1;
        theta_2 = theta_1;
        w_2 = 2*pi - u2 - theta_2;
    end

    if cos(theta_1) > 0
        theta_1 = theta_1+pi;
    end

    p = a*(1-e^2);
    v_theta = sqrt(mu/p)*(1+e*cos(theta_1));
    dv_1 = abs(2*v_theta*sin(alpha/2));

end