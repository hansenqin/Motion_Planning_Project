function [inputs_list, total_distance, reference_traj] = generate_trajectories(x1, y1, u0, u1, dt)
    [a, total_distance] = get_spline(x1, y1);
    [xyh_list, uvr_list] = get_xyhuvr(x1, u0, u1, total_distance, a, dt);
    reference_traj = [xyh_list' uvr_list'];
    inputs_list = get_control_inputs(xyh_list, uvr_list, dt);
    
end


function [a, total_distance] = get_spline(x1, y1)
    x0 = 0;
    y0 = 0;

    x0_dot = 0;
    x1_dot = 0;

    A = [x0^3   x0^2  x0 1;
         x1^3   x1^2  x1 1;
         3*x0^2 2*x0  1  0;
         3*x1^2 2*x1  1  0;
         ];

    b = [y0;y1;x0_dot;x1_dot];


    a = A\b;

    y_fun = @(x) a(1)*x.^3 + a(2)*x.^2 + a(3)*x + a(4);
    dydx_fun = @(x) 3*a(1)*x.^2 + 2*a(2)*x.^1 + a(3);

    x_pts = 0:0.01:x1;
    y_pts = y_fun(x_pts);
    total_distance = 0;
    for i=2:length(x_pts)
        total_distance = total_distance + norm([x_pts(i)-x_pts(i-1), y_pts(i)-y_pts(i-1)]);
    end
end

function [xyh_list, uvr_list] = get_xyhuvr( x1, u1, u2, total_distance, a, dt)
    dudx = (u2-u1)/total_distance;
    y_fun = @(x) a(1)*x.^3 + a(2)*x.^2 + a(3)*x + a(4);
    dydx_fun = @(x) 3*a(1)*x.^2 + 2*a(2)*x.^1 + a(3);


    syms x
    f = a(1)*x^3+a(2)*x^2+a(3)*x+a(4);
    dfdx = diff(f,x);
    integrand = sqrt(1+dfdx^2);
    
    I_fun = matlabFunction(integrand+0*x);
    if sum(a==0)==4
        I_fun = @(x)1+0*x;
    end
    

    xyh_list = [];
    uvr_list = [];


    x_old = 0-u1*dt;
    y_old = y_fun(x_old);
    h_old = atan(dydx_fun(x_old));

    x_new = 0;
    y_new = y_fun(x_new);
    h_new = atan(dydx_fun(x_new));
    h_old = h_new;

    while x_new < x1

        xyh_list(:,end+1) = [x_new; y_new; h_new];
        uvr_list(:,end+1) = [u1;0;(h_new-h_old)/dt*1.0];

        distance = u1*dt;
        u1 = u1+dudx*distance;

        x_old = x_new;
        y_old = y_fun(x_new);
        h_old = atan(dydx_fun(x_new));

        x_new = binary_search(I_fun, x_new, x_new+50, distance);
        y_new = y_fun(x_new);
        h_new = atan(dydx_fun(x_new));

    end
%     hold on
%     scatter(xyh_list(1,:), xyh_list(2,:));
end

function inputs_list = get_control_inputs(xyh_list, uvr_list, dt)
    m=1400;
    Izz=2667;
    lf=1.35;
    lr=1.45;
    rw=0.5;
    J = 100;
    dt = 0.1;
    parameters = [m Izz J lf lr rw]; 

    T_est = (uvr_list(1,2)-uvr_list(1,1))/dt*m*2;
    % T_est = -1000000;
    delta_est = 0.0;
    inputs = [T_est; delta_est];
    inputs_list = [];
    x1 = [xyh_list(:,1); uvr_list(:,1); uvr_list(1,1)*2];
    options = optimoptions('fmincon','Display','off','Algorithm','sqp');
    for i=2:length(uvr_list)

        x2 = [xyh_list(:,i); uvr_list(:,i); uvr_list(1,i)*2];

        Q = eye(7);
        Q(1,1) = 10;
        Q(2,2) = 10;
        Q(3,3) = 10000;
        Q(4,4) = 10;
        Q(5,5) = 0;
        Q(6,6) = 10000;
        Q(7,7) = 10;

        fun = @(u) (f_disc_fun(x1, [u(1);u(2)], dt, parameters)-x2)'*Q*(f_disc_fun(x1, [u(1);u(2)], dt, parameters)-x2);
        inputs = fmincon(fun, inputs, [], [], [],[],[],[],[],options);
        x1 = f_disc_fun(x1, inputs, dt, parameters);
        inputs_list(:, end+1) = inputs;

    end
end


function pivot = binary_search(I_fun, x1, x2, distance)
    thresh = 0.001;
    starting_point = x1;

    while(1)
        pivot = (x1+x2)/2;
        I = integral(I_fun, starting_point, pivot);
        if abs(I-distance) < thresh
            return;
        end
        
        if I>distance
            x2 = pivot;
        elseif I<distance
            x1 = pivot;
        end
    end
    
end

