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
b_f=(w+0.0001)/(u_f/rw+0.0001)-1;
b_r=(w+0.0001)/(u/rw+0.0001)-1;

%     b_f = (w-u_f+0.0001)/max(sqrt((w+0.0001)^2), sqrt((u_f+0.0001)^2));
%     b_r = (w-u+0.0001)/max(sqrt((w+0.0001)^2), sqrt((u+0.0001)^2));
%slip angle 
a_f= -atan(v_f/sqrt((u_f+0.05)^2));
a_r= -atan(vr/sqrt((u+0.05)^2));

%Nonlinear Tire Dynamics
F_zf=lr/(lf+lr)*m*g;
F_zr=lf/(lf+lr)*m*g;
%     
%     phi_yf=(1-Ey)*(a_f)+(Ey/By)*atan(By*(a_f));
%     phi_yr=(1-Ey)*(a_r)+(Ey/By)*atan(By*(a_r));
%     
%     phi_xf=(1-Ex)*(b_f)+(Ex/Bx)*atan(Bx*(b_f));
%     phi_xr=(1-Ex)*(b_r)+(Ex/Bx)*atan(Bx*(b_r));
%     

%     F_yfw=F_zf*Dy*sin(Cy*atan(By*phi_yf));
%     F_yr=F_zr*Dy*sin(Cy*atan(By*phi_yr));
%     
%     F_xfw=F_zf*Dy*sin(Cy*atan(By*phi_xf));
%     F_xr=F_zr*Dy*sin(Cy*atan(By*phi_xr));
% 
F_yfw = F_zf*6.4762*a_f;
F_yr = F_zr*9.95*a_r;

F_xfw = F_zf*6.4130*b_f;
F_xr = F_zr*9.95*b_r;

f = [u*cos(h)-v*sin(h);  %x
     u*sin(h)+v*cos(h);  %y
     r;                    %h
     1/m*(cos(delta)*F_xfw-sin(delta)*F_yfw+F_xr)+v*r;
     1/m*(sin(delta)*F_xfw+cos(delta)*F_yfw+F_yr)-u*r;
     (lf*(sin(delta)*F_xfw+cos(delta)*F_yfw) - lr * F_yr)/Izz;
     (T_d-rw*F_xfw-rw*F_xr-80*w)/J];
 
 
% Eueler integration to define discrete update
f_disc = states + f*dt;

% Linearized discrete dynamical matrices
A_c = jacobian(f,states);
B_c = jacobian(f,inputs);


%% Write functions for the dynamics
calc_A_c = matlabFunction(A_c,'File', 'calc_A_c', 'Vars',[{states},{inputs},{parameters}]);
calc_B_c = matlabFunction(B_c,'File', 'calc_B_c', 'Vars',[{states},{inputs},{parameters}]);

f = matlabFunction(f, 'File', 'f_cont_fun', 'Vars',[{states},{inputs},{parameters}]);
f_disc = matlabFunction(f_disc,'File', 'f_disc_fun', 'Vars',[{states},{inputs},{dt},{parameters}]);