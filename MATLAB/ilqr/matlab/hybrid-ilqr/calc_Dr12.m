function DR1 = calc_Dr12(in1,in2,in3)
%CALC_DR12
%    DR1 = CALC_DR12(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    19-Nov-2021 19:55:05

L1 = in3(:,2);
L2 = in3(:,4);
m1 = in3(:,1);
m2 = in3(:,3);
q1 = in1(1,:);
q2 = in1(2,:);
q1_dot = in1(3,:);
q2_dot = in1(4,:);
t2 = cos(q1);
t3 = cos(q2);
t4 = sin(q1);
t5 = sin(q2);
t6 = q1+q2;
t7 = L1.^2;
t8 = L2.^2;
t11 = 1.0./L1;
t12 = 1.0./L2;
t9 = t2.^2;
t10 = cos(t6);
t13 = sin(t6);
t16 = m2.*t2.*t4.*2.0;
t14 = m2.*t9;
t15 = t10.^2;
t22 = L2.*m2.*t2.*t10.*2.0;
t28 = L2.*m2.*q1_dot.*t2.*t13.*2.0;
t29 = L2.*m2.*q2_dot.*t2.*t13.*2.0;
t30 = m2.*t2.*t3.*t10.*3.0;
t31 = m1.*t10.*t13.*2.0;
t32 = m2.*t10.*t13.*6.0;
t33 = m2.*t2.*t5.*t10.*3.0;
t34 = m2.*t3.*t4.*t10.*3.0;
t35 = m2.*t2.*t3.*t13.*3.0;
t38 = L2.*m2.*q1_dot.*t2.*t10.*-2.0;
t39 = L2.*m2.*q2_dot.*t2.*t10.*-2.0;
t46 = m2.*t2.*t8.*t10.*2.0;
t48 = m1.*q1_dot.*t2.*t7.*t10.*2.0;
t53 = m2.*q1_dot.*t2.*t7.*t10.*6.0;
t54 = m1.*q1_dot.*t2.*t7.*t13.*2.0;
t55 = m2.*q1_dot.*t2.*t8.*t13.*2.0;
t56 = m2.*q2_dot.*t2.*t8.*t13.*2.0;
t57 = m2.*q1_dot.*t2.*t7.*t13.*6.0;
t59 = L1.*m1.*q1_dot.*t10.*t13.*4.0;
t67 = m2.*q1_dot.*t2.*t8.*t10.*-2.0;
t68 = m2.*q2_dot.*t2.*t8.*t10.*-2.0;
t71 = L1.*m2.*q1_dot.*t2.*t3.*t10.*-3.0;
t72 = L1.*m2.*q1_dot.*t10.*t13.*1.2e+1;
t17 = m1.*t15;
t18 = L1.*L2.*t14.*2.0;
t19 = m2.*t15.*3.0;
t24 = q1_dot.*t22;
t25 = q2_dot.*t22;
t26 = L1.*L2.*q1_dot.*t14.*-2.0;
t27 = L1.*L2.*q2_dot.*t14.*-2.0;
t37 = L1.*m2.*q1_dot.*t15.*6.0;
t40 = -t30;
t41 = -t33;
t42 = -t34;
t43 = -t35;
t49 = q1_dot.*t46;
t50 = q2_dot.*t46;
t58 = L1.*q1_dot.*t30;
t60 = L1.*q1_dot.*t35;
t61 = -t46;
t62 = q1_dot.*t3.*t7.*t14.*3.0;
t63 = L1.*L2.*q2_dot.*t30;
t64 = L2.*t59;
t65 = L1.*L2.*q2_dot.*t35;
t69 = -t55;
t70 = -t56;
t74 = L2.*t72;
t75 = L2.*q1_dot.*t3.*t32;
t76 = L2.*q2_dot.*t3.*t32;
t79 = q1_dot.*t3.*t8.*t32;
t80 = q2_dot.*t3.*t8.*t32;
t20 = q1_dot.*t18;
t21 = q2_dot.*t18;
t23 = -t18;
t36 = L1.*q1_dot.*t17.*2.0;
t45 = L2.*t37;
t47 = L2.*t3.*t19;
t66 = t3.*t8.*t19;
t73 = -t62;
t81 = t14+t17+t19+t40;
t84 = t31+t32+t41+t43;
t85 = t16+t31+t32+t42+t43;
t44 = L2.*t36;
t51 = q1_dot.*t47;
t52 = q2_dot.*t47;
t77 = q1_dot.*t66;
t78 = q2_dot.*t66;
t82 = 1.0./t81;
t83 = t82.^2;
t86 = t36+t37+t38+t39+t51+t52+t71;
t87 = t26+t27+t44+t45+t48+t53+t63+t67+t68+t73+t77+t78;
DR1 = reshape([1.0,0.0,(t11.*t82.*(t28+t29-t59+t60-t72+L1.*q1_dot.*t34+L2.*m2.*q1_dot.*t4.*t10.*2.0+L2.*m2.*q2_dot.*t4.*t10.*2.0-L2.*m2.*q1_dot.*t3.*t10.*t13.*6.0-L2.*m2.*q2_dot.*t3.*t10.*t13.*6.0))./2.0+(t11.*t83.*t85.*t86)./2.0,(t11.*t12.*t82.*(t54+t57+t64+t65+t69+t70+t74+t79+t80+L1.*L2.*q2_dot.*t34+m1.*q1_dot.*t4.*t7.*t10.*2.0+m2.*q1_dot.*t4.*t7.*t10.*6.0-m2.*q1_dot.*t4.*t8.*t10.*2.0-m2.*q2_dot.*t4.*t8.*t10.*2.0-m2.*q1_dot.*t2.*t3.*t4.*t7.*6.0-L1.*L2.*m2.*q1_dot.*t2.*t4.*4.0-L1.*L2.*m2.*q2_dot.*t2.*t4.*4.0))./2.0-(t11.*t12.*t83.*t85.*t87)./2.0,0.0,1.0,t11.*t82.*(-t28-t29+t59+t72+t75+t76+L2.*q1_dot.*t5.*t19+L2.*q2_dot.*t5.*t19-L1.*m2.*q1_dot.*t2.*t5.*t10.*3.0-L1.*m2.*q1_dot.*t2.*t3.*t13.*3.0).*(-1.0./2.0)+(t11.*t83.*t84.*t86)./2.0,(t11.*t12.*t82.*(t54+t57+t64+t65+t69+t70+t74+t79+t80-q1_dot.*t5.*t7.*t14.*3.0+q1_dot.*t5.*t8.*t19+q2_dot.*t5.*t8.*t19+L1.*L2.*q2_dot.*t33))./2.0-(t11.*t12.*t83.*t84.*t87)./2.0,0.0,0.0,(t11.*t82.*(-t22+t47+L1.*t17.*2.0+L1.*m2.*t15.*6.0-L1.*m2.*t2.*t3.*t10.*3.0))./2.0,t11.*t12.*t82.*(t23+t61+t66+L1.*L2.*t17.*2.0-t3.*t7.*t14.*3.0+m1.*t2.*t7.*t10.*2.0+m2.*t2.*t7.*t10.*6.0+L1.*L2.*m2.*t15.*6.0).*(-1.0./2.0),0.0,0.0,t11.*t82.*(t22-L2.*m2.*t3.*t15.*3.0).*(-1.0./2.0),(t11.*t12.*t82.*(t18+t46-m2.*t3.*t8.*t15.*3.0-L1.*L2.*m2.*t2.*t3.*t10.*3.0))./2.0],[4,4]);
