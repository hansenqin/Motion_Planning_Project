function dzdt=bike(t,x_,delta_f, T_desired)
x=x_(1);
u=x_(2);
y=x_(3);
v=x_(4);
h=x_(5);
r=x_(6);
w=x_(7);
uv_f = rotmat(-delta_f)*[u;v];
u_f = uv_f(1);
v_f = uv_f(2);


%constants
Nw=2;
f=0.01;
Iz=2667;
a=1.35;
b=1.45;
By=0.27;
Cy=1.2;
Dy=0.7;
Ey=-1.6;
Shy=0;
Svy=0;
m=1400;
g=9.806;
rw=0.4;


%generate input functions
% delta_f=interp1(T,U(:,1),t,'previous','extrap');
% F_x=interp1(T,U(:,2),t,'previous','extrap');

%slip ratio function
b_f=w/max(u_f^2+0.05, w^2+0.05);
b_r=w/max(u^2+0.05, w^2+0.05);

%slip angle functions in degrees
a_f=rad2deg(delta_f-atan2(v+a*r,u));
a_r=rad2deg(-atan2((v-b*r),u));

%Nonlinear Tire Dynamics
phi_yf=(1-Ey)*(a_f+Shy)+(Ey/By)*atan(By*(a_f+Shy));
phi_yr=(1-Ey)*(a_r+Shy)+(Ey/By)*atan(By*(a_r+Shy));

F_zf=b/(a+b)*m*g;
F_yf=F_zf*Dy*sin(Cy*atan(By*phi_yf))+Svy;

F_zr=a/(a+b)*m*g;
F_yr=F_zr*Dy*sin(Cy*atan(By*phi_yr))+Svy;

F_total=sqrt((Nw*F_x)^2+(F_yr^2));
F_max=0.7*m*g;

if F_total>F_max
    
    F_x=F_max/F_total*F_x;
  
    F_yr=F_max/F_total*F_yr;
end

%vehicle dynamics
dzdt= [u*cos(h)-v*sin(h);...
          (-f*m*g+Nw*F_x-F_yf*sin(delta_f))/m+v*r;...
          u*sin(h)+v*cos(h);...
          (F_yf*cos(delta_f)+F_yr)/m-u*r;...
          r;...
          (F_yf*a*cos(delta_f)-F_yr*b)/Iz];
end