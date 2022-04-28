function f_disc = f_disc_fun_MF(in1,in2,dt,in4)
%f_disc_fun_MF
%    F_DISC = f_disc_fun_MF(IN1,IN2,DT,IN4)

%    This function was generated by the Symbolic Math Toolbox version 9.0.
%    27-Apr-2022 18:42:56

Bx = in4(10,:);
By = in4(6,:);
Cy = in4(5,:);
Dy = in4(4,:);
Ex = in4(11,:);
Ey = in4(7,:);
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
t10 = 1.0./Bx;
t11 = 1.0./By;
t12 = Ex-1.0;
t13 = Ey-1.0;
t15 = 1.0./m;
t16 = 1.0./rw;
t22 = u+1.0./2.0e+1;
t27 = w+1.0e-4;
t9 = t2.*u;
t14 = t4.*u;
t17 = t7+v;
t18 = -t8;
t19 = 1.0./t6;
t20 = t16.*u;
t24 = t22.^2;
t21 = -t14;
t23 = t18+v;
t25 = t2.*t17;
t26 = t4.*t17;
t29 = 1.0./sqrt(t24);
t30 = t20+1.0e-4;
t28 = t9+t26;
t31 = t21+t25;
t33 = 1.0./t30;
t36 = -t29.*(t8-v);
t32 = t28+1.0./2.0e+1;
t34 = t16.*t28;
t37 = atan(t36);
t43 = t27.*t33;
t35 = t32.^2;
t39 = By.*t37;
t41 = t34+1.0e-4;
t42 = t13.*t37;
t45 = t43-1.0;
t38 = 1.0./sqrt(t35);
t40 = atan(t39);
t44 = 1.0./t41;
t47 = Bx.*t45;
t50 = t12.*t45;
t46 = Ey.*t11.*t40;
t49 = atan(t47);
t52 = t27.*t44;
t53 = -t38.*(t14-t25);
t48 = -t46;
t51 = Ex.*t10.*t49;
t54 = atan(t53);
t56 = t52-1.0;
t55 = -t51;
t57 = By.*t54;
t59 = Bx.*t56;
t61 = t13.*t54;
t62 = t12.*t56;
t67 = t42+t48;
t58 = atan(t57);
t60 = atan(t59);
t68 = By.*t67;
t72 = t50+t55;
t63 = Ey.*t11.*t58;
t64 = Ex.*t10.*t60;
t69 = atan(t68);
t73 = By.*t72;
t65 = -t63;
t66 = -t64;
t70 = Cy.*t69;
t74 = atan(t73);
t71 = sin(t70);
t75 = Cy.*t74;
t77 = t61+t65;
t78 = t62+t66;
t76 = sin(t75);
t79 = By.*t77;
t81 = By.*t78;
t80 = atan(t79);
t82 = atan(t81);
t83 = Cy.*t80;
t85 = Cy.*t82;
t84 = sin(t83);
t86 = sin(t85);
t87 = Dy.*lr.*m.*t2.*t19.*t84.*(9.81e+2./1.0e+2);
t88 = Dy.*lr.*m.*t4.*t19.*t86.*(9.81e+2./1.0e+2);
f_disc = [x+dt.*(t3.*u-t5.*v);y+dt.*(t5.*u+t3.*v);h+dt.*r;u+dt.*(r.*v-t15.*(Dy.*lf.*m.*t19.*t76.*(9.81e+2./1.0e+2)+Dy.*lr.*m.*t2.*t19.*t86.*(9.81e+2./1.0e+2)+Dy.*lr.*m.*t4.*t19.*t84.*(9.81e+2./1.0e+2)));v-dt.*(r.*u-t15.*(t87-t88+Dy.*lf.*m.*t19.*t71.*(9.81e+2./1.0e+2)));r+(dt.*(lf.*(t87-t88)-Dy.*lf.*lr.*m.*t19.*t71.*(9.81e+2./1.0e+2)))./Izz;w+(dt.*(T_d-w.*8.0e+1+Dy.*lf.*m.*rw.*t19.*t76.*(9.81e+2./1.0e+2)+Dy.*lr.*m.*rw.*t19.*t86.*(9.81e+2./1.0e+2)))./J];
