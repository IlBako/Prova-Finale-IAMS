function plotApsidalAxis(a, e, i, OM, w, mu)
    r_peri = parorb2rv(a, e, i, OM, w, 0, mu);
    r_apo = parorb2rv(a, e, i, OM, w, pi, mu);

    line([r_peri(1) r_apo(1)], [r_peri(2) r_apo(2)], [r_peri(3) r_apo(3)], 'LineStyle', '--', 'Color', 'black', 'LineWidth', 1.25);
end