function f = calc_f(in1,in2,in3)
%CALC_F
%    F = CALC_F(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.7.
%    15-Apr-2022 01:00:22

theta = in1(4,:);
theta_dot = in2(2,:);
v = in1(3,:);
v_dot = in2(1,:);
f = [v.*cos(theta);v.*sin(theta);v_dot;theta_dot];
