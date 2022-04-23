function out1 = calc_A_lin2(in1,in2,in3)
%CALC_A_LIN2
%    OUT1 = CALC_A_LIN2(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    19-Nov-2021 19:55:08

L1 = in3(:,2);
L2 = in3(:,4);
g = in3(:,5);
m1 = in3(:,1);
m2 = in3(:,3);
q1 = in1(1,:);
q2 = in1(2,:);
q1_dot = in1(3,:);
q2_dot = in1(4,:);
tau_1 = in2(1,:);
tau_2 = in2(2,:);
t2 = cos(q1);
t3 = cos(q2);
t4 = sin(q1);
t5 = sin(q2);
t6 = q1+q2;
t7 = L1.^2;
t8 = L1.^3;
t9 = L2.^2;
t10 = L2.^3;
t11 = q1_dot.^2;
t12 = q2_dot.^2;
t17 = 1.0./L2;
t13 = t2.^2;
t14 = t4.^2;
t15 = cos(t6);
t16 = 1.0./t7;
t18 = 1.0./t9;
t19 = sin(t6);
t23 = m2.*t2.*t4.*2.0;
t89 = L2.*m2.*t2.*t3.*t4.*t8.*t11.*3.0;
t107 = m2.*t2.*t4.*t7.*t9.*t11.*-2.0;
t20 = m2.*t13;
t21 = t15.^2;
t22 = t19.^2;
t28 = L1.*t2.*t15.*tau_2.*6.0;
t29 = L1.*t2.*t19.*tau_2.*6.0;
t30 = t7.*t13.*tau_2.*6.0;
t31 = m2.*t2.*t3.*t15.*3.0;
t33 = m1.*t15.*t19.*2.0;
t34 = m2.*t15.*t19.*6.0;
t35 = m2.*t2.*t5.*t15.*3.0;
t36 = m2.*t3.*t4.*t15.*3.0;
t37 = m2.*t2.*t3.*t19.*3.0;
t39 = L1.*L2.*t2.*t15.*tau_1.*6.0;
t40 = L1.*L2.*t2.*t19.*tau_1.*6.0;
t48 = L1.*L2.*t2.*t15.*tau_2.*1.2e+1;
t49 = L1.*L2.*t2.*t19.*tau_2.*1.2e+1;
t50 = L2.*t15.*t19.*tau_1.*1.2e+1;
t51 = L2.*t15.*t19.*tau_2.*1.2e+1;
t53 = L2.*t7.*t11.*t23;
t57 = L1.*m2.*q1_dot.*t2.*t9.*t19.*4.0;
t58 = L1.*m2.*q2_dot.*t2.*t9.*t19.*4.0;
t59 = L1.*m2.*q1_dot.*t2.*t10.*t19.*4.0;
t60 = L1.*m2.*q2_dot.*t2.*t10.*t19.*4.0;
t61 = L1.*m2.*q1_dot.*q2_dot.*t2.*t9.*t15.*4.0;
t62 = L1.*m2.*q1_dot.*q2_dot.*t2.*t10.*t15.*4.0;
t67 = t9.*t15.*t19.*tau_1.*1.2e+1;
t68 = t9.*t15.*t19.*tau_2.*1.2e+1;
t70 = L2.*g.*m1.*t7.*t13.*t15.*3.0;
t73 = L1.*m2.*t2.*t9.*t11.*t15.*2.0;
t74 = L1.*m2.*t2.*t9.*t12.*t15.*2.0;
t75 = L1.*m2.*t2.*t10.*t11.*t15.*2.0;
t76 = L1.*m2.*t2.*t10.*t12.*t15.*2.0;
t77 = L2.*g.*m1.*t7.*t13.*t19.*3.0;
t79 = L1.*m2.*t2.*t9.*t11.*t19.*2.0;
t80 = L2.*m1.*t4.*t8.*t11.*t15.*2.0;
t81 = L1.*m2.*t2.*t9.*t12.*t19.*2.0;
t82 = L1.*m2.*t2.*t10.*t11.*t19.*2.0;
t83 = L1.*m2.*t2.*t10.*t12.*t19.*2.0;
t85 = L2.*m2.*t4.*t8.*t11.*t15.*6.0;
t90 = L2.*m1.*t4.*t8.*t11.*t19.*2.0;
t91 = L2.*m2.*t4.*t8.*t11.*t19.*6.0;
t92 = L1.*m2.*q1_dot.*q2_dot.*t2.*t10.*t19.*-4.0;
t94 = t7.*t9.*t11.*t23;
t96 = L1.*L2.*g.*m1.*t2.*t15.*t19.*6.0;
t102 = -t89;
t109 = L2.*m2.*t4.*t5.*t7.*t11.*t15.*3.0;
t110 = L2.*m2.*t2.*t5.*t7.*t11.*t19.*3.0;
t111 = L2.*m2.*t3.*t4.*t7.*t11.*t19.*3.0;
t118 = L1.*g.*m1.*t2.*t9.*t15.*t19.*6.0;
t134 = m1.*q1_dot.*t7.*t9.*t15.*t19.*4.0;
t135 = m1.*q2_dot.*t7.*t9.*t15.*t19.*4.0;
t138 = m2.*q1_dot.*t2.*t3.*t7.*t9.*t19.*6.0;
t139 = m2.*q2_dot.*t2.*t5.*t7.*t9.*t15.*6.0;
t140 = m2.*q2_dot.*t2.*t3.*t7.*t9.*t19.*6.0;
t147 = L1.*m2.*q1_dot.*t3.*t9.*t15.*t19.*-6.0;
t148 = L1.*m2.*q2_dot.*t3.*t9.*t15.*t19.*-6.0;
t149 = L1.*m2.*q1_dot.*t3.*t10.*t15.*t19.*-6.0;
t150 = L1.*m2.*q2_dot.*t3.*t10.*t15.*t19.*-6.0;
t159 = m2.*q1_dot.*t7.*t9.*t15.*t19.*1.2e+1;
t160 = m2.*q2_dot.*t7.*t9.*t15.*t19.*1.2e+1;
t161 = L2.*m2.*t3.*t4.*t7.*t11.*t15.*-3.0;
t170 = m2.*t2.*t5.*t7.*t9.*t11.*t15.*6.0;
t172 = m2.*q1_dot.*q2_dot.*t2.*t5.*t7.*t9.*t15.*-6.0;
t173 = m2.*q1_dot.*q2_dot.*t2.*t3.*t7.*t9.*t19.*-6.0;
t174 = L1.*m2.*t3.*t9.*t11.*t15.*t19.*3.0;
t175 = L1.*m2.*t3.*t9.*t12.*t15.*t19.*3.0;
t176 = L1.*m2.*t3.*t10.*t11.*t15.*t19.*3.0;
t177 = L1.*m2.*t3.*t10.*t12.*t15.*t19.*3.0;
t181 = m2.*t2.*t3.*t7.*t9.*t11.*t19.*-3.0;
t182 = m2.*t2.*t5.*t7.*t9.*t12.*t15.*-3.0;
t183 = m2.*t2.*t3.*t7.*t9.*t12.*t19.*-3.0;
t24 = m1.*t21;
t25 = m2.*t21.*3.0;
t26 = L2.*t21.*tau_1.*6.0;
t27 = L2.*t21.*tau_2.*6.0;
t38 = -t28;
t41 = -t31;
t42 = -t35;
t43 = -t36;
t44 = -t37;
t45 = t9.*t21.*tau_1.*6.0;
t46 = t9.*t21.*tau_2.*6.0;
t47 = -t39;
t54 = -t50;
t63 = q2_dot.*t57;
t64 = q2_dot.*t59;
t66 = L1.*L2.*g.*m2.*t2.*t21.*-3.0;
t72 = L2.*g.*t7.*t15.*t20.*3.0;
t78 = L2.*g.*t7.*t19.*t20.*3.0;
t84 = L1.*m2.*q1_dot.*t5.*t9.*t21.*6.0;
t86 = L1.*m2.*q2_dot.*t5.*t9.*t21.*6.0;
t87 = L1.*m2.*q1_dot.*t5.*t10.*t21.*6.0;
t88 = L1.*m2.*q2_dot.*t5.*t10.*t21.*6.0;
t93 = L2.*t3.*t8.*t11.*t20.*3.0;
t95 = L2.*t5.*t8.*t11.*t20.*3.0;
t97 = L1.*L2.*g.*t2.*t34;
t99 = m1.*q1_dot.*q2_dot.*t7.*t9.*t22.*4.0;
t100 = -t82;
t101 = -t83;
t104 = L1.*m2.*q1_dot.*q2_dot.*t3.*t9.*t22.*6.0;
t106 = L1.*m2.*q1_dot.*q2_dot.*t3.*t10.*t22.*6.0;
t112 = m1.*t7.*t9.*t11.*t22.*2.0;
t113 = m1.*t7.*t9.*t12.*t22.*2.0;
t114 = m2.*t7.*t9.*t11.*t22.*6.0;
t115 = m2.*t7.*t9.*t12.*t22.*6.0;
t116 = m2.*q1_dot.*q2_dot.*t7.*t9.*t21.*1.2e+1;
t117 = m2.*q1_dot.*q2_dot.*t7.*t9.*t22.*1.2e+1;
t119 = L1.*g.*t2.*t9.*t34;
t120 = L1.*q1_dot.*t3.*t9.*t34;
t121 = L1.*q2_dot.*t3.*t9.*t34;
t122 = L1.*q1_dot.*t3.*t10.*t34;
t123 = L1.*q2_dot.*t3.*t10.*t34;
t125 = L1.*m2.*t3.*t9.*t11.*t22.*3.0;
t127 = L1.*m2.*t3.*t9.*t12.*t22.*3.0;
t129 = L1.*m2.*t3.*t10.*t11.*t22.*3.0;
t131 = L1.*m2.*t3.*t10.*t12.*t22.*3.0;
t132 = L1.*m2.*q1_dot.*q2_dot.*t5.*t10.*t21.*-6.0;
t133 = L2.*t7.*t11.*t31;
t136 = L2.*t7.*t11.*t35;
t137 = L2.*t7.*t11.*t36;
t143 = m2.*t7.*t9.*t11.*t21.*6.0;
t144 = m2.*t7.*t9.*t12.*t21.*6.0;
t145 = -t110;
t146 = q2_dot.*t134;
t151 = q1_dot.*t139;
t152 = q2_dot.*t138;
t153 = L1.*m2.*t5.*t10.*t11.*t21.*-3.0;
t154 = L1.*m2.*t5.*t10.*t12.*t21.*-3.0;
t157 = -t134;
t158 = -t135;
t162 = t7.*t9.*t11.*t33;
t163 = t7.*t9.*t12.*t33;
t164 = t7.*t9.*t11.*t34;
t165 = t7.*t9.*t12.*t34;
t166 = t7.*t9.*t11.*t36;
t167 = t7.*t9.*t11.*t37;
t168 = t7.*t9.*t12.*t35;
t169 = t7.*t9.*t12.*t37;
t171 = q2_dot.*t159;
t178 = q2_dot.*t147;
t179 = -t159;
t180 = -t160;
t184 = -t170;
t185 = -t174;
t186 = -t175;
t32 = -t27;
t52 = -t45;
t55 = L1.*L2.*g.*t2.*t24.*3.0;
t56 = L1.*L2.*g.*t2.*t25;
t69 = L1.*g.*t2.*t9.*t24.*3.0;
t71 = L1.*g.*t2.*t9.*t25;
t98 = q1_dot.*q2_dot.*t7.*t9.*t24.*4.0;
t103 = q2_dot.*t84;
t105 = q2_dot.*t87;
t108 = -t95;
t124 = L1.*t5.*t9.*t11.*t25;
t126 = L1.*t5.*t9.*t12.*t25;
t128 = L1.*t5.*t10.*t11.*t25;
t130 = L1.*t5.*t10.*t12.*t25;
t141 = t7.*t9.*t11.*t24.*2.0;
t142 = t7.*t9.*t12.*t24.*2.0;
t155 = q2_dot.*t120;
t156 = q2_dot.*t122;
t187 = t20+t24+t25+t41;
t190 = t33+t34+t42+t44;
t191 = t23+t33+t34+t43+t44;
t65 = -t55;
t188 = 1.0./t187;
t193 = t30+t46+t47+t48+t52+t69+t70+t71+t72+t80+t85+t92+t100+t101+t102+t107+t108+t132+t146+t153+t154+t156+t162+t163+t164+t165+t166+t171+t172+t173+t176+t177+t181+t182+t183+t184;
t189 = t188.^2;
t192 = t26+t32+t38+t53+t63+t65+t66+t79+t81+t103+t124+t126+t136+t161+t178+t185+t186;
out1 = reshape([0.0,0.0,(t16.*t17.*t188.*(t29+t51+t54+t61+t73+t74+t96+t97+t104-t109+t111+t125+t127+t145+L2.*t7.*t11.*t20.*2.0+L1.*t4.*t15.*tau_2.*6.0+L1.*L2.*g.*t4.*t24.*3.0+L1.*L2.*g.*t4.*t25-L2.*m2.*t7.*t11.*t14.*2.0-L1.*m2.*t4.*t9.*t11.*t19.*2.0-L1.*m2.*t3.*t9.*t11.*t21.*3.0-L1.*m2.*t4.*t9.*t12.*t19.*2.0-L1.*m2.*t3.*t9.*t12.*t21.*3.0-L1.*m2.*q1_dot.*q2_dot.*t4.*t9.*t19.*4.0-L1.*m2.*q1_dot.*q2_dot.*t3.*t9.*t21.*6.0-L2.*m2.*t2.*t3.*t7.*t11.*t15.*3.0-L1.*m2.*t5.*t9.*t11.*t15.*t19.*6.0-L1.*m2.*t5.*t9.*t12.*t15.*t19.*6.0-L1.*m2.*q1_dot.*q2_dot.*t5.*t9.*t15.*t19.*1.2e+1))./2.0+(t16.*t17.*t189.*t191.*t192)./2.0,(t16.*t18.*t188.*(t40-t49-t62+t67-t68-t75-t76-t77-t78-t90-t91-t93+t98-t99-t106-t112-t113-t114-t115+t116-t117-t118-t129-t131+t141+t142+t143+t144-t7.*t9.*t11.*t20.*2.0-t2.*t4.*t7.*tau_2.*1.2e+1+L1.*L2.*t4.*t15.*tau_1.*6.0-L1.*L2.*t4.*t15.*tau_2.*1.2e+1-L1.*g.*t4.*t9.*t24.*3.0+L1.*t3.*t10.*t11.*t25+L1.*t3.*t10.*t12.*t25+L1.*t5.*t10.*t11.*t34+L1.*t5.*t10.*t12.*t34+m2.*t7.*t9.*t11.*t14.*2.0-L1.*g.*m2.*t4.*t9.*t21.*3.0+L2.*m1.*t2.*t8.*t11.*t15.*2.0+L2.*m2.*t2.*t8.*t11.*t15.*6.0+L2.*m2.*t3.*t8.*t11.*t14.*3.0+L1.*m2.*t4.*t10.*t11.*t19.*2.0+L1.*m2.*t4.*t10.*t12.*t19.*2.0-L2.*g.*m1.*t2.*t4.*t7.*t15.*6.0-L2.*g.*m2.*t2.*t4.*t7.*t15.*6.0-L1.*g.*m2.*t2.*t9.*t15.*t19.*6.0+L1.*m2.*q1_dot.*q2_dot.*t4.*t10.*t19.*4.0+L1.*m2.*q1_dot.*q2_dot.*t3.*t10.*t21.*6.0+L2.*m2.*t2.*t4.*t5.*t8.*t11.*6.0-m2.*t2.*t3.*t7.*t9.*t12.*t15.*3.0+m2.*t4.*t5.*t7.*t9.*t11.*t15.*6.0+m2.*t4.*t5.*t7.*t9.*t12.*t15.*3.0+m2.*t2.*t5.*t7.*t9.*t11.*t19.*6.0+m2.*t2.*t5.*t7.*t9.*t12.*t19.*3.0+m2.*t3.*t4.*t7.*t9.*t12.*t19.*3.0+L1.*m2.*q1_dot.*q2_dot.*t5.*t10.*t15.*t19.*1.2e+1-m2.*q1_dot.*q2_dot.*t2.*t3.*t7.*t9.*t15.*6.0+m2.*q1_dot.*q2_dot.*t4.*t5.*t7.*t9.*t15.*6.0+m2.*q1_dot.*q2_dot.*t2.*t5.*t7.*t9.*t19.*6.0+m2.*q1_dot.*q2_dot.*t3.*t4.*t7.*t9.*t19.*6.0))./2.0+(t16.*t18.*t189.*t191.*t193)./2.0,0.0,0.0,(t16.*t17.*t188.*(t29+t51+t54+t61+t73+t74+t96+t97+t104+t109+t111+t125+t127+t133+t145-L1.*m2.*t5.*t9.*t11.*t15.*t19.*3.0-L1.*m2.*t5.*t9.*t12.*t15.*t19.*3.0-L1.*m2.*q1_dot.*q2_dot.*t5.*t9.*t15.*t19.*6.0))./2.0+(t16.*t17.*t189.*t190.*t192)./2.0,t16.*t18.*t188.*(-t40+t49+t62-t67+t68+t75+t76+t77+t78+t90+t91+t93-t98+t99+t106+t112+t113+t114+t115-t116+t117+t118+t119+t129+t131-t141-t142-t143-t144-L2.*m2.*t2.*t4.*t5.*t8.*t11.*3.0-L1.*m2.*t5.*t10.*t11.*t15.*t19.*3.0-L1.*m2.*t5.*t10.*t12.*t15.*t19.*3.0+m2.*t2.*t3.*t7.*t9.*t11.*t15.*9.0+m2.*t2.*t3.*t7.*t9.*t12.*t15.*6.0+m2.*t4.*t5.*t7.*t9.*t11.*t15.*3.0-m2.*t2.*t5.*t7.*t9.*t11.*t19.*9.0+m2.*t3.*t4.*t7.*t9.*t11.*t19.*3.0-m2.*t2.*t5.*t7.*t9.*t12.*t19.*6.0-L1.*m2.*q1_dot.*q2_dot.*t5.*t10.*t15.*t19.*6.0+m2.*q1_dot.*q2_dot.*t2.*t3.*t7.*t9.*t15.*1.2e+1-m2.*q1_dot.*q2_dot.*t2.*t5.*t7.*t9.*t19.*1.2e+1).*(-1.0./2.0)+(t16.*t18.*t189.*t190.*t193)./2.0,1.0,0.0,(t16.*t17.*t188.*(t57+t58+t84+t86+t147+t148+L2.*m2.*q1_dot.*t2.*t4.*t7.*4.0+L2.*m2.*q1_dot.*t2.*t5.*t7.*t15.*6.0-L2.*m2.*q1_dot.*t3.*t4.*t7.*t15.*6.0))./2.0,t16.*t18.*t188.*(t59+t60+t87+t88+t138+t139+t140+t149+t150+t157+t158+t179+t180+L2.*q1_dot.*t5.*t8.*t20.*6.0+m2.*q1_dot.*t2.*t4.*t7.*t9.*4.0-L2.*m1.*q1_dot.*t4.*t8.*t15.*4.0-L2.*m2.*q1_dot.*t4.*t8.*t15.*1.2e+1+L2.*m2.*q1_dot.*t2.*t3.*t4.*t8.*6.0+m2.*q1_dot.*t2.*t5.*t7.*t9.*t15.*1.2e+1-m2.*q1_dot.*t3.*t4.*t7.*t9.*t15.*6.0).*(-1.0./2.0),0.0,1.0,(t16.*t17.*t188.*(t57+t58+t84+t86+t147+t148))./2.0,t16.*t18.*t188.*(t59+t60+t87+t88+t138+t139+t140+t149+t150+t157+t158+t179+t180+m2.*q1_dot.*t2.*t5.*t7.*t9.*t15.*6.0).*(-1.0./2.0)],[4,4]);