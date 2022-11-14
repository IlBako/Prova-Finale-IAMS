function [] = trasferimento_Secante(a_i, a_f, e_i, e_f, mu, varargin)

    all_types = {'pp', 'pa', 'ap', 'aa'};

    % Input handling

    p = inputParser;
    addRequired(p, 'a_i', @(x) isnumeric(x));
    addRequired(p, 'a_f', @(x) isnumeric(x));
    addRequired(p, 'e_i', @(x) isnumeric(x));
    addRequired(p, 'e_f', @(x) isnumeric(x));
    addRequired(p, 'mu', @(x) isnumeric(x));

    addParameter(p, 'ra', 0);
    addParameter(p, 'ae', []);
    addParameter(p, 'type', all_types);

    parse(p, a_i, a_f, e_i, e_f, mu, varargin{:});

    if p.Results.ra == 0 && length(p.Results.ae) ~= 2
        error("Errore nell'orbita di trasferimento, si prega di inserire dati vaidi!");
    end

    % Transfer Orbit characterization

    dv_tot = [0 0 0 0];

    if(any(strcmp(type, 'pp')))
        r_P_trasf = a_i*(1-e_i^2)/(1+e_i);

        if p.Results.ra ~= 0
            r_A_trasf = p.Results.ra;
            a_trasf = (r_A_trasf+r_P_trasf)/2;
            e_trasf = (r_A_trasf-r_P_trasf)/(r_A_trasf+r_P_trasf);
        else
            a_trasf = p.Results.ae(1);
            e_trasf = p.Results.ae(2);
            r_A_trasf = 2*a_trasf-r_P_trasf;
        end

        v_i = sqrt(mu/(a_i*(1-e_i^2)))*(1+e_i);
        v_1 = sqrt(mu/(a_trasf*(1-e_trasf^2)))*(1+e_trasf);
        % https://www.orbiter-forum.com/threads/calculating-intesection-of-two-orbits.35645/
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