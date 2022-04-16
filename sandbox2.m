close all

m=1400;
Izz=2667;
By=0.07*180/pi;
Cy=1.3;
Dy=0.7;
Ey=-1.6;
Bx=0.27*180/pi;
Cx=1.3;
Dx=0.7;
Ex=-1.6;
lf=1.35;
lr=1.45;
rw=0.5;
J = 100;
dt = 0.05;
parameters = [m Izz J lf lr rw]; 

% symbolic_car_model();
%% Get xyh path

x1 = 0;
y1 = 0;

x2 = 100;
y2 = 20;

x1_dot = 0;
x2_dot = tan(pi/4);

A = [x1^3   x1^2  x1 1;
     x2^3   x2^2  x2 1;
     3*x1^2 2*x1  1  0;
     3*x2^2 2*x2  1  0;
     ];
 
b = [y1;y2;x1_dot;x2_dot];


a = A\b;

y_fun = @(x) a(1)*x.^3 + a(2)*x.^2 + a(3)*x + a(4);
dydx_fun = @(x) 3*a(1)*x.^2 + 2*a(2)*x.^1 + a(3);

x_pts = 1:0.1:x2;
y_pts = y_fun(x_pts);
h_pts = atan(dydx_fun(x_pts));  
total_sum = 0;
for i=2:length(x_pts)
    total_sum = total_sum + norm([x_pts(i)-x_pts(i-1), y_pts(i)-y_pts(i-1)]);
end

plot(x_pts, y_pts);
% figure
% plot(h_pts);
hold on


%% Finding points on line
dt = 0.05;
u1 = 30;
u2 = 30;
x_val = 0;
dudx = (u2-u1)/total_sum;



syms x
f = a(1)*x^3+a(2)*x^2+a(3)*x+a(4);
dfdx = diff(f,x);
integrand = sqrt(1+dfdx^2);

I_fun = matlabFunction(integrand);


xyh_list = [];
uvr_list = [];


x_old = 0-u1*dt;
y_old = y_fun(x_old);
h_old = atan(dydx_fun(x_old));

x_new = 0;
y_new = y_fun(x_new);
h_new = atan(dydx_fun(x_new));


while x_new < x2
    xyh_list(:,end+1) = [x_new; y_new; h_new];
    uvr_list(:,end+1) = [u1;0;(h_new-h_old)/dt];
    distance = u1*dt;
    u1 = u1+dudx*distance;
    
    x_old = x_new;
    y_old = y_fun(x_new);
    h_old = atan(dydx_fun(x_new));
    
    x_new = bin_search(I_fun, x_new, x_new+50, distance);
    y_new = y_fun(x_new);
    h_new = atan(dydx_fun(x_new));
    
end

% scatter(xyh_list(1,:), xyh_list(2,:));
% figure
% 
% scatter(xyh_list(1,:), u_list);


%% find control inputs
T_est = (uvr_list(1,2)-uvr_list(1,1))/dt*m*2;
delta_est = 0;
inputs = [T_est; delta_est];
inputs_list = [];

for i=2:length(uvr_list)

x1 = [xyh_list(:,i-1); uvr_list(:,i-1); uvr_list(1,i-1)*2];
x2 = [xyh_list(:,i); uvr_list(:,i); uvr_list(1,i)*2];

A_c = calc_A_c(x1, inputs, parameters);
B_c = calc_B_c(x1, inputs, parameters);
x_dot_e = f_cont_fun(x1, inputs, parameters);

rhs = (x2-x1)/dt-x_dot_e;


d_inputs = inv(B_c'*B_c)*B_c'*rhs;
inputs = inputs+d_inputs
inputs_list(:, end+1) = inputs;

end

%% test
i=2;
x1 = [xyh_list(:,i-1); uvr_list(:,i-1); uvr_list(1,i-1)*2];
x2 = [xyh_list(:,i); uvr_list(:,i); uvr_list(1,i)*2];

A_c = calc_A_c(x1, inputs, parameters);
B_c = calc_B_c(x1, inputs, parameters);
x_dot_e = f_cont_fun(x1, inputs, parameters);



%% function

function pivot = bin_search(I_fun, x1, x2, distance)
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





 
 
 



