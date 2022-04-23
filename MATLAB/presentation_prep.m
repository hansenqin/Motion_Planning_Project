%% single state lattice
figure
hold on

plot([20, 20], [-7, 7], 'k')
plot([40, 40], [-7, 7], 'k')
plot([60, 60], [-7, 7], 'k')
plot([80, 80], [-7, 7], 'k')
plot([100, 100], [-7, 7], 'k')


for x2 = 20:20:100
   for y2 = -6:2:6
        x1 = 0;
        y1 = 0;
        
        plot([0, 90], [y2, y2], 'k')

%         x2 = 100;
%         y2 = 7;

        x1_dot = 0;
        x2_dot = tan(0);

        A = [x1^3   x1^2  x1 1;
             x2^3   x2^2  x2 1;
             3*x1^2 2*x1  1  0;
             3*x2^2 2*x2  1  0;
             ];

        b = [y1;y2;x1_dot;x2_dot];


        a = A\b;

        y_fun = @(x) a(1)*x.^3 + a(2)*x.^2 + a(3)*x + a(4);
        dydx_fun = @(x) 3*a(1)*x.^2 + 2*a(2)*x.^1 + a(3);

        x_pts = 1:0.01:x2;
        y_pts = y_fun(x_pts);
        h_pts = atan(dydx_fun(x_pts));  
        total_sum = 0;
        for i=2:length(x_pts)
            total_sum = total_sum + norm([x_pts(i)-x_pts(i-1), y_pts(i)-y_pts(i-1)]);
        end

        plot(x_pts, y_pts, 'Color', [0 0.4470 0.7410], 'LineWidth', 3);
%         figure
%         plot(h_pts);
   end
end