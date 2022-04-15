clear all; close all;

%states
syms x y h u v r w

%inputs
syms T_d delta

%parameters
syms m Izz J Dy Cy By Ey Dx Cx Bx Ex lf lr rw dt
g = 9.81;

% Define the states and inputs
states = [x;y;h;u;v;r;w];
inputs = [T_d;delta];

% Store any physical parameters needed here e.g. mass, lengths...
% parameters = [m; Izz; J; Dy; Cy; By; Ey; Dx; Cx; Bx; Ex; lf; lr; rw]; 
parameters = [m Izz J lf lr rw]; 

% Define the dynamics

vf = v + lf*r;
vr = v - lr*r;


uvf = [u; vf];
uvr = [u; vr]';


uv_f = rotmat(-delta)*uvf;
u_f = uv_f(1);
v_f = uv_f(2);


%slip ratio
b_f=w/(u_f/rw+0.1)-1;
b_r=w/(u_f/rw+0.1)-1;

%slip angle 
a_f= -atan(v_f/(u_f+0.05)^2);
a_r= -atan(vr/(u+0.05)^2);

%Nonlinear Tire Dynamics
F_zf=lr/(lf+lr)*m*g;
F_zr=lf/(lf+lr)*m*g;

F_yfw = F_zf*3.3762*a_f;
F_yr = F_zr*3.3762*a_r;

F_xfw = F_zf*8.7130*b_f;
F_xr = F_zr*8.7130*b_r;

f = [u*cos(h)-v*sin(h);  %x
     u*sin(h)+v*cos(h);  %y
     r;                    %h
     1/m*(cos(delta)*F_xfw-sin(delta)*F_yfw+F_xr)+v*r;
     1/m*(sin(delta)*F_xfw+cos(delta)*F_yfw+F_yr)-u*r;
     (lf*(sin(delta)*F_xfw+cos(delta)*F_yfw) - lr * F_yr)/Izz;
     (T_d-rw*F_xfw-rw*F_xr)/J];

% Eueler integration to define discrete update
f_disc = states + f*dt;

% Linearized discrete dynamical matrices
A_disc = jacobian(f_disc,states);
B_disc = jacobian(f_disc,inputs);


%% Write functions for the dynamics
calc_A_disc = matlabFunction(A_disc,'Vars',[{states},{inputs},{dt},{parameters}]);
calc_B_disc = matlabFunction(B_disc,'Vars',[{states},{inputs},{dt},{parameters}]);

f = matlabFunction(f,'Vars',[{states},{inputs},{parameters}]);
f_disc = matlabFunction(f_disc,'Vars',[{states},{inputs},{dt},{parameters}]);