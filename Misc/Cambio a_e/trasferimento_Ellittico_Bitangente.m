function [dv_tot] = trasferimento_Ellittico_Bitangente(a_i, a_f, e_i, e_f, mu, type)

    all_types = {'pp', 'pa', 'ap', 'aa'};

    if nargin == 5
        type = all_types;
    elseif ~ismember(type, all_types)
        error("ATTENZIONE! type deve contenere solo uno o più di: " + ...
            "{'pp', 'pa', 'ap', 'aa'}");
    end

    dv_tot = [0 0 0 0];

    if(any(strcmp(type, 'pp')))
        r_P_trasf = a_i*(1-e_i^2)/(1+e_i);
        r_A_trasf = a_f*(1-e_f^2)/(1+e_f);
        a_trasf = (r_A_trasf+r_P_trasf)/2;
        e_trasf = (r_A_trasf-r_P_trasf)/(r_A_trasf+r_P_trasf);

        v_i = sqrt(mu/(a_i*(1-e_i^2)))*(1+e_i);
        v_1 = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1+e_trasf);
        v_2 = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1-e_trasf);
        v_f = sqrt(mu/(a_f*(1-e_f^2)))*(1+e_f);
        
        dv1 = abs(v_1 - v_i);
        dv2 = abs(v_f - v_2);
        dv_tot(1) = dv1 + dv2;
    end
    if(any(strcmp(type, 'pa')))
        r_P_trasf = a_i*(1-e_i^2)/(1+e_i);
        r_A_trasf = a_f*(1-e_f^2)/(1-e_f);
        a_trasf = (r_A_trasf+r_P_trasf)/2;
        e_trasf = (r_A_trasf-r_P_trasf)/(r_A_trasf+r_P_trasf);

        v_i = sqrt(mu/(a_i*(1-e_i^2)))*(1+e_i);
        v_1 = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1+e_trasf);
        v_2 = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1-e_trasf);
        v_f = sqrt(mu/(a_f*(1-e_f^2)))*(1-e_f);
        
        dv1 = abs(v_1 - v_i);
        dv2 = abs(v_f - v_2);
        dv_tot(2) = dv1 + dv2;
    end
    if(any(strcmp(type, 'ap')))
        r_A_trasf = a_i*(1-e_i^2)/(1-e_i);
        r_P_trasf = a_f*(1-e_f^2)/(1+e_f);
        a_trasf = (r_A_trasf+r_P_trasf)/2;
        e_trasf = (r_A_trasf-r_P_trasf)/(r_A_trasf+r_P_trasf);

        v_i = sqrt(mu/(a_i*(1-e_i^2)))*(1-e_i);
        v_1 = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1-e_trasf);
        v_2 = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1+e_trasf);
        v_f = sqrt(mu/(a_f*(1-e_f^2)))*(1+e_f);
        
        dv1 = abs(v_1 - v_i);
        dv2 = abs(v_f - v_2);
        dv_tot(3) = dv1 + dv2;
    end
    if(any(strcmp(type, 'aa')))
        r_P_trasf = a_i*(1-e_i^2)/(1-e_i);
        r_A_trasf = a_f*(1-e_f^2)/(1-e_f);
        a_trasf = (r_A_trasf+r_P_trasf)/2;
        e_trasf = (r_A_trasf-r_P_trasf)/(r_A_trasf+r_P_trasf);

        v_i = sqrt(mu/(a_i*(1-e_i^2)))*(1-e_i);
        v_1 = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1+e_trasf);
        v_2 = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1-e_trasf);
        v_f = sqrt(mu/(a_f*(1-e_f^2)))*(1-e_f);
        
        dv1 = abs(v_1 - v_i);
        dv2 = abs(v_f - v_2);
        dv_tot(4) = dv1 + dv2;
    end
    
    dv_tot = dv_tot(dv_tot~=0);

end