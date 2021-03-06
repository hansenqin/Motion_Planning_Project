function draw_circle_constraint()
% xout: collection of state vectors at each time, output from ode45
% dt: (difference in time between each row of xout, generated by calling
% ode45 with the argument [tstart:dt:tfinal];)

% Define axis window
xmin = -2;
xmax = 2;
ymin = 3;
ymax = 7;

% Draw contact surfaces
x_a = linspace(xmin, xmax,500);
y_a = linspace(ymin, ymax,500);
[X,Y] = meshgrid(x_a,y_a);
a1 = Y;
% a2 = X+Y+1;
% a2 = 0.1*X + Y - 2;
% a2 = compute_a2(X,Y);
a2 = (X).^2 + (Y-5).^2 - 2^2;
% contour(X,Y,a1,[0,0], 'k'); hold on;

% Only want 1 contact mode for now
contour(X,Y,a2,[0,0], 'k'); hold on;
hold on
end