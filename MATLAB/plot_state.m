function p = plot_state(state, color, legend_entry)
    x = state(1);
    y = state(2);
    h = state(3);
    rob_len = 0.7;
    rob_width = 0.4;
    half_len = rob_len / 2;
    half_wid = rob_width / 2;
    arrow_dist = rob_len;
    tip_len = 0.25*arrow_dist;
    tip_ang = 3*pi/4;
    s0 = [0; 0];
    s1 = [arrow_dist; 0];
    s2 = s1 + tip_len * [cos(tip_ang); sin(tip_ang)];
    s3 = s1;
    s4 = s1 + tip_len * [cos(-tip_ang); sin(-tip_ang)];
    corner_pts = [ -half_len -half_wid; -half_len  half_wid; ...
                    half_len  half_wid;  half_len -half_wid;
                   -half_len -half_wid]';
    half_len = rob_len / 10;
    half_wid = half_len;
    corner_pts2 = [ -half_len -half_wid; -half_len  half_wid; ...
                    half_len  half_wid;  half_len -half_wid;
                   -half_len -half_wid]';            
    arrow_pts = [ s0 s1 s2 s3 s4 ];
    arrow_pts(1,:) = arrow_pts(1,:) - 0.35;
    nan_col = [NaN; NaN];
    pts_untransformed = [arrow_pts nan_col corner_pts nan_col corner_pts2];
    rotation_matrix = [cos(h) -sin(h); sin(h) cos(h)];
    pts = rotation_matrix * pts_untransformed + [x; y];
    p = plot(pts(1,:), pts(2,:), color, ...
             'LineWidth', 2.0, ...
             'DisplayName', legend_entry);
end

