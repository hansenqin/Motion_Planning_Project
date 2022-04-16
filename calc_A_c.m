function A_c = calc_A_c(in1,in2,in3)
%CALC_A_C
%    A_C = CALC_A_C(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    16-Apr-2022 14:57:57

Izz = in3(:,2);
J = in3(:,3);
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
t9 = lf.^2;
t12 = 1.0./Izz;
t13 = 1.0./J;
t15 = 1.0./m;
t16 = 1.0./rw;
t21 = u+1.0./2.0e+1;
t10 = t4.^2;
t11 = t2.*u;
t14 = t4.*u;
t17 = t7+v;
t18 = -t8;
t19 = 1.0./t6;
t25 = 1.0./t21.^2;
t26 = 1.0./t21.^3;
t28 = (t8-v).^2;
t20 = -t14;
t22 = t18+v;
t23 = t2.*t17;
t24 = t4.*t17;
t27 = t25.^2;
t29 = t11+t24;
t30 = t20+t23;
t32 = (t14-t23).^2;
t34 = t27.*t28;
t31 = t29+1.0./2.0e+1;
t33 = t16.*t29;
t38 = t34+1.0;
t35 = 1.0./t31.^2;
t36 = 1.0./t31.^3;
t40 = t33+1.0./1.0e+1;
t43 = 1.0./t38;
t37 = t35.^2;
t39 = t2.*t35;
t41 = t4.*t35;
t44 = 1.0./t40;
t47 = t2.*t36.*(t14-t23).*-2.0;
t48 = t4.*t36.*(t14-t23).*-2.0;
t50 = t4.*t36.*(t14-t23).*2.0;
t54 = lf.*lr.*m.*t19.*t25.*t43.*3.3120522e+1;
t42 = lf.*t39;
t45 = t44.^2;
t46 = t32.*t37;
t51 = lf.*t48;
t52 = lf.*t50;
t55 = -t54;
t60 = t41+t47;
t61 = t39+t50;
t49 = t46+1.0;
t56 = lr.*m.*t10.*t16.*t19.*t45.*w.*8.547453e+1;
t57 = lr.*m.*t2.*t4.*t16.*t19.*t45.*w.*8.547453e+1;
t62 = t42+t52;
t53 = 1.0./t49;
t58 = -t57;
t59 = lf.*t56;
t63 = lr.*m.*t2.*t19.*t53.*t60.*3.3120522e+1;
t64 = lr.*m.*t2.*t19.*t53.*t61.*3.3120522e+1;
t65 = lr.*m.*t2.*t19.*t53.*t62.*3.3120522e+1;
mt1 = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-t5.*u-t3.*v,t3.*u-t5.*v,0.0,0.0,0.0,0.0,0.0,t3,t5,0.0,-t15.*(lr.*m.*t4.*t19.*t53.*t60.*3.3120522e+1+lf.*m.*t2.*t16.*t19.*t45.*w.*8.547453e+1+lr.*m.*t2.^2.*t16.*t19.*t45.*w.*8.547453e+1),-r-t15.*(t57-t63+lf.*m.*t19.*t26.*t43.*(t8-v).*6.6241044e+1)];
mt2 = [-t12.*(lf.*(t57-t63)-lf.*lr.*m.*t19.*t26.*t43.*(t8-v).*6.6241044e+1),t13.*(lf.*m.*t2.*t19.*t45.*w.*8.547453e+1+lr.*m.*t2.*t19.*t45.*w.*8.547453e+1),-t5,t3,0.0,r-t15.*(t57-lr.*m.*t4.*t19.*t53.*t61.*3.3120522e+1+lf.*m.*t4.*t16.*t19.*t45.*w.*8.547453e+1),-t15.*(t56+t64+lf.*m.*t19.*t25.*t43.*3.3120522e+1),t12.*(t54-lf.*(t56+t64))];
mt3 = [t13.*(lf.*m.*t4.*t19.*t45.*w.*8.547453e+1+lr.*m.*t4.*t19.*t45.*w.*8.547453e+1),0.0,0.0,1.0,v-t15.*(lf.*t57-lr.*m.*t4.*t19.*t53.*t62.*3.3120522e+1+m.*t4.*t9.*t16.*t19.*t45.*w.*8.547453e+1),-u-t15.*(t55+t59+t65),-t12.*(lf.*(t59+t65)+lr.*t54),t13.*(m.*t4.*t9.*t19.*t45.*w.*8.547453e+1+lf.*lr.*m.*t4.*t19.*t45.*w.*8.547453e+1),0.0,0.0,0.0];
mt4 = [t15.*(lf.*m.*t19.*t44.*8.547453e+1+lr.*m.*t2.*t19.*t44.*8.547453e+1),lr.*t4.*t19.*t44.*8.547453e+1,lf.*lr.*m.*t4.*t12.*t19.*t44.*8.547453e+1,-t13.*(lf.*m.*rw.*t19.*t44.*8.547453e+1+lr.*m.*rw.*t19.*t44.*8.547453e+1)];
A_c = reshape([mt1,mt2,mt3,mt4],7,7);
