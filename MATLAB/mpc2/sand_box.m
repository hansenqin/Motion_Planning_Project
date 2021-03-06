close all
%%
%constants
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
parameters = [m Izz J lf lr rw];
% 
% %slip angle functions in degrees
% a_f=-1:0.02:1;
% a_r=-1:0.02:1;
% 
% %Nonlinear Tire Dynamics
% phi_yf=(1-Ey)*(a_f+Shy)+(Ey/By)*atan(By*(a_f+Shy));
% phi_yr=(1-Ey)*(a_r+Shy)+(Ey/By)*atan(By*(a_r+Shy));
% 
% F_zf=b/(a+b)*m*g;
% F_zr=a/(a+b)*m*g;
% 
% F_yf=F_zf*Dy*sin(Cy*atan(By*phi_yf))+Svy;
% F_yr=F_zr*Dy*sin(Cy*atan(By*phi_yr))+Svy;
% 
% plot(a_f, F_yf);
x_ = [];
y_ = [];
h_ = [];
u_ = [];
v_ = [];
r_ = [];
w_ = [];

states = [0;0;0;20;0;0;20];
delta = [repmat(0.2, 1,250),repmat(-0.2, 1,250)];

T_d = 1500;

for i=1:1000
    i
    x = states(1);
    y = states(2);
    h = states(3);
    u = states(4);
    v = states(5);
    r = states(6);
    w = states(7);
    
%     delta = 0;
%     delta = 0;
    
    
    
    % Define the dynamics
    vf = v + lf*r;
    vr = v - lr*r;


    uvf = [u; vf];
    uvr = [u; vr]';


    uv_f = rotmat(-delta(i))*uvf;
    u_f = uv_f(1);
    v_f = uv_f(2);


    %slip ratio
    b_f=w/(u_f/rw+0.1)-1;
    b_r=w/(u/rw+0.1)-1;

%     
%     b_f = 0;
%     b_r = 0;

    %slip angle 
    a_f= -atan(v_f/sqrt(u_f+0.05)^2);
    a_r= -atan(vr/sqrt(u+0.05)^2);

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
         1/m*(cos(delta(i))*F_xfw-sin(delta(i))*F_yfw+F_xr)+v*r;
         1/m*(sin(delta(i))*F_xfw+cos(delta(i))*F_yfw+F_yr)-u*r;
         (lf*(sin(delta(i))*F_xfw+cos(delta(i))*F_yfw) - lr * F_yr)/Izz;
         (T_d-rw*F_xfw-rw*F_xr)/J]
    
     
    states = states +f*dt;
    x_(end+1) = states(1);
    y_(end+1) = states(2);
    h_(end+1) = states(3);
    u_(end+1) = states(4);
    v_(end+1) = states(5);
    r_(end+1) = states(6);
    w_(end+1) = states(7);
    
%     if mod(i,10) == 0
        plot_state([states(1) states(2) states(3)], 'r', 'x_0');
        drawnow
        axis equal

%     end
    hold on
    
end








