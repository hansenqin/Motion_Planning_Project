function G1 = calc_g12(in1,in2,in3)
%CALC_G12
%    G1 = CALC_G12(IN1,IN2,IN3)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    19-Nov-2021 19:55:06

L1 = in3(:,2);
L2 = in3(:,4);
q1 = in1(1,:);
q2 = in1(2,:);
G1 = -L2.*sin(q1+q2)-L1.*sin(q1)-5.0./4.0;
