function pts = point_distribution(pt_i, pt_f, density)

    num = size(density,1);
    avg = (pt_i+pt_f)/num;

    pts = zeros(num, 1);
    pts(1) = pt_i;

    for i=1:num-1
        pts(i+1) = pts(i) + max(avg, avg/density(i));
    end
end