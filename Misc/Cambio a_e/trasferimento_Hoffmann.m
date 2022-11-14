function [dv] = trasferimento_Hoffmann(a_i, a_f, mu)

    if a_i > a_f
        r_A_trasf = a_i;
        r_P_trasf = a_f;
    else
        r_P_trasf = a_i;
        r_A_trasf = a_f;
    end

    a_trasf = (r_A_trasf + r_P_trasf)/2;
    e_trasf = (r_A_trasf - r_P_trasf)/(r_A_trasf + r_P_trasf);
    
    v_i = sqrt(mu/a_i);
    v_P_trasf = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1+e_trasf);
    v_A_trasf = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1-e_trasf);
    v_f = sqrt(mu/a_f);

    if a_i > a_f
        dv1 = abs(v_A_trasf - v_i);
        dv2 = abs(v_f - v_P_trasf);
    else
        dv1 = abs(v_P_trasf-v_i);
        dv2 = abs(v_f - v_A_trasf);
    end

    

    dv = dv1 + dv2;

end