function [theta_1, theta_2] = find_intersection(a_1, a_2, e_1, e_2)
    x = (a_1 - a_2 - a_1*e_1^2 + a_2*e_2^2)/(e_1 - e_2);
    
    y2 = (a_1^2 - (x + a_1*e_1)^2)*(1 - e_1^2);

    r = sqrt(x^2 + y2);

    theta_1 = acos(1/e_1*((a_1*(1-e_1^2))/r - 1));
    
    theta_2 = acos(1/e_2*((a_2*(1-e_2^2))/r - 1));

end