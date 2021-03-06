function f_disc = f_disc_fun(in1,in2,dt,in4)
%F_DISC_FUN
%    F_DISC = F_DISC_FUN(IN1,IN2,DT,IN4)

%    This function was generated by the Symbolic Math Toolbox version 9.0.
%    26-Apr-2022 16:27:29

Izz = in4(2,:);
J = in4(3,:);
T_d = in2(1,:);
delta = in2(2,:);
h = in1(3,:);
lf = in4(12,:);
lr = in4(13,:);
m = in4(1,:);
r = in1(6,:);
rw = in4(14,:);
u = in1(4,:);
v = in1(5,:);
w = in1(7,:);
x = in1(1,:);
y = in1(2,:);
t2 = cos(delta);
t3 = cos(h);
t4 = sin(delta);
t5 = sin(h);
t6 = lf+lr;
t7 = lf.*r;
t8 = lr.*r;
t11 = 1.0./m;
t12 = 1.0./rw;
t18 = u+1.0./2.0e+1;
t23 = w+1.0e-4;
t9 = t2.*u;
t10 = t4.*u;
t13 = t7+v;
t14 = -t8;
t15 = 1.0./t6;
t16 = t12.*u;
t20 = t18.^2;
t17 = -t10;
t19 = t14+v;
t21 = t2.*t13;
t22 = t4.*t13;
t25 = 1.0./sqrt(t20);
t26 = t16+1.0e-4;
t24 = t9+t22;
t27 = t17+t21;
t29 = 1.0./t26;
t32 = -t25.*(t8-v);
t28 = t24+1.0./2.0e+1;
t30 = t12.*t24;
t33 = atan(t32);
t36 = t23.*t29;
t31 = t28.^2;
t35 = t30+1.0e-4;
t38 = t36-1.0;
t34 = 1.0./sqrt(t31);
t37 = 1.0./t35;
t39 = t23.*t37;
t40 = -t34.*(t10-t21);
t41 = atan(t40);
t42 = t39-1.0;
t43 = lr.*m.*t4.*t15.*t42.*9.76095e+1;
t44 = lr.*m.*t2.*t15.*t41.*6.3531522e+1;
mt1 = [x+dt.*(t3.*u-t5.*v);y+dt.*(t5.*u+t3.*v);h+dt.*r;u+dt.*(r.*v+t11.*(lf.*m.*t15.*t38.*9.76095e+1+lr.*m.*t2.*t15.*t42.*9.76095e+1+lr.*m.*t4.*t15.*t41.*6.3531522e+1));v-dt.*(r.*u+t11.*(-t43+t44+lf.*m.*t15.*t33.*6.3531522e+1));r+(dt.*(lf.*(t43-t44)+lf.*lr.*m.*t15.*t33.*6.3531522e+1))./Izz];
mt2 = [w-(dt.*(-T_d+w.*8.0e+1+lf.*m.*rw.*t15.*t38.*9.76095e+1+lr.*m.*rw.*t15.*t42.*9.76095e+1))./J];
f_disc = [mt1;mt2];
