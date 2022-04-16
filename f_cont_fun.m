function f = f_cont_fun(in1,in2,in3)
%F_CONT_FUN
%    F = F_CONT_FUN(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    16-Apr-2022 14:58:01

Izz = in3(:,2);
J = in3(:,3);
T_d = in2(1,:);
delta = in2(2,:);
h = in1(3,:);
lf = in3(:,4);
lr = in3(:,5);
m = in3(:,1);
r = in1(6,:);
rw = in3(:,6);
u = in1(4,:);
v = in1(5,:);
w = in1(7,:);
t2 = cos(delta);
t3 = cos(h);
t4 = sin(delta);
t5 = sin(h);
t6 = lf+lr;
t7 = lf.*r;
t8 = lr.*r;
t11 = 1.0./m;
t12 = 1.0./rw;
t17 = u+1.0./2.0e+1;
t9 = t2.*u;
t10 = t4.*u;
t13 = t7+v;
t14 = -t8;
t15 = 1.0./t6;
t21 = 1.0./t17.^2;
t16 = -t10;
t18 = t14+v;
t19 = t2.*t13;
t20 = t4.*t13;
t25 = -t21.*(t8-v);
t22 = t9+t20;
t23 = t16+t19;
t26 = atan(t25);
t24 = t22+1.0./2.0e+1;
t27 = t12.*t22;
t28 = 1.0./t24.^2;
t29 = t27+1.0./1.0e+1;
t30 = 1.0./t29;
t33 = -t28.*(t10-t19);
t31 = t30.*w;
t34 = atan(t33);
t32 = t31-1.0;
t36 = lr.*m.*t2.*t15.*t34.*3.3120522e+1;
t35 = lr.*m.*t4.*t15.*t32.*8.547453e+1;
mt1 = [t3.*u-t5.*v,t5.*u+t3.*v,r,r.*v+t11.*(lf.*m.*t15.*t32.*8.547453e+1+lr.*m.*t2.*t15.*t32.*8.547453e+1+lr.*m.*t4.*t15.*t34.*3.3120522e+1),-r.*u-t11.*(-t35+t36+lf.*m.*t15.*t26.*3.3120522e+1),(lf.*(t35-t36)+lf.*lr.*m.*t15.*t26.*3.3120522e+1)./Izz];
mt2 = [-(-T_d+lf.*m.*rw.*t15.*t32.*8.547453e+1+lr.*m.*rw.*t15.*t32.*8.547453e+1)./J];
f = reshape([mt1,mt2],7,1);
