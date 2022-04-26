clear
load_constants

% num_itrs = 15;
% 
% 
% X = sym('x', [1 num_itrs],'real');
% Y = sym('y', [1 num_itrs],'real');
% H = sym('h', [1 num_itrs],'real');
% U = sym('u', [1 num_itrs],'real');
% V = sym('v', [1 num_itrs],'real');
% R = sym('r', [1 num_itrs],'real');
% W = sym('w', [1 num_itrs],'real');
% 
% Delta = sym('delta', [1 num_itrs-1]);
% Td = sym('Td', [1 num_itrs-1]);
% 
% Z1 = reshape([X;Y;H;U;V;R;W], [], 1);
% Z2 = reshape([Td;Delta], [], 1);
% 
% Z = [Z1;Z2];

%% calculating dg explicitly 
% idx = 1;
% % g = [];
% for i = 1:2:2*num_itrs
%     g_(i) = X(idx)*cos(-H(idx))-Y(idx)*sin(-H(idx));
%     g_(i+1) = -(X(idx)*cos(-H(idx))-Y(idx)*sin(-H(idx)));
%     idx = idx+1;
% end
%     
% dg = jacobian(g_, Z);


%% calculating dh explicitly 
% h = [X(1) U(1) Y(1) V(1) H(1) R(1)]';
% 
% idx = 2;
% for i = 7:6:6*num_itrs
% 
%     %generate input functions
%     delta_=Delta(idx-1);
%     F_x=Fx(idx-1);
% 
%     %slip angle functions in degrees
%     a_f=rad2deg(delta_f-atan2(V(idx-1)+a*R(idx-1), U(idx-1)));
%     a_r=rad2deg(-atan2((V(idx-1)-b*R(idx-1)), U(idx-1)));
% 
%     %Nonlinear Tire Dynamics
%     phi_yf=(1-Ey)*(a_f+Shy)+(Ey/By)*atan(By*(a_f+Shy));
%     phi_yr=(1-Ey)*(a_r+Shy)+(Ey/By)*atan(By*(a_r+Shy));
% 
%     F_zf=b/(a+b)*m*g;
%     F_yf=F_zf*Dy*sin(Cy*atan(By*phi_yf))+Svy;
% 
%     F_zr=a/(a+b)*m*g;
%     F_yr=F_zr*Dy*sin(Cy*atan(By*phi_yr))+Svy;
% 
%     F_total=sqrt((Nw*F_x)^2+(F_yr^2));
%     F_max=0.7*m*g;
%     
%     X_dot = U(idx-1)*cos(H(idx-1))-V(idx-1)*sin(H(idx-1));
%     U_dot = (-f*m*g+Nw*F_x-F_yf*sin(delta_f))/m+V(idx-1)*R(idx-1);
%     Y_dot = U(idx-1)*sin(H(idx-1))+V(idx-1)*cos(H(idx-1));
%     V_dot = (F_yf*cos(delta_f)+F_yr)/m-U(idx-1)*R(idx-1);
%     H_dot = R(idx-1);
%     R_dot = (F_yf*a*cos(delta_f)-F_yr*b)/Iz;
%     
%     h(i) = X(idx) - X(idx-1) - X_dot*0.02;
%     h(i+1) = U(idx) - U(idx-1) - U_dot*0.02;
%     h(i+2) = Y(idx) - Y(idx-1) - Y_dot*0.02;
%     h(i+3) = V(idx) - V(idx-1) - V_dot*0.02;
%     h(i+4) = H(idx) - H(idx-1) - H_dot*0.02;
%     h(i+5) = R(idx) - R(idx-1) - R_dot*0.02;
%     idx = idx+1;
% end
% 
% dh = vpa(jacobian(h, Z),3);




%% calculate jacobian of state equations

    
    x = sym('x', 'real');
    y = sym('y', 'real');
    h = sym('h', 'real');
    u = sym('u', 'real');
    v = sym('v', 'real');
    r = sym('r', 'real');
    w = sym('w', 'real');
    delta = sym('delta', 'real');
    Td = sym('Td', 'real');
    
    
    vf = v + lf*r;
    vr = v - lr*r;


    uvf = [u; vf];
    
    rot_mat = [cos(-delta) -sin(-delta);
               sin(-delta) cos(delta)];


    uv_f = rot_mat*uvf;
    u_f = uv_f(1);
    v_f = uv_f(2);


    %slip ratio
    b_f=(w+0.0001)/(u_f/rw+0.0001)-1;
    b_r=(w+0.0001)/(u/rw+0.0001)-1;

    %slip angle 
    a_f= -atan(v_f/sqrt((u_f+0.05)^2));
    a_r= -atan(vr/sqrt((u+0.05)^2));
    
    %Nonlinear Tire Dynamics
    phi_yf=(1-Ey)*(a_f)+(Ey/By)*atan(By*(a_f));
    phi_yr=(1-Ey)*(a_r)+(Ey/By)*atan(By*(a_r));
    
    phi_xf=(1-Ex)*(b_f)+(Ex/Bx)*atan(Bx*(b_f));
    phi_xr=(1-Ex)*(b_r)+(Ex/Bx)*atan(Bx*(b_r));
      
    F_yfw=Dy*sin(Cy*atan(By*phi_yf));
    F_yr=Dy*sin(Cy*atan(By*phi_yr));
    
    F_xfw=Dy*sin(Cx*atan(Bx*phi_xf));
    F_xr=Dy*sin(Cx*atan(Bx*phi_xr));
    
    
     x_dot = [u*cos(h)-v*sin(h);  %x
             u*sin(h)+v*cos(h);  %y
             r;                    %h
             1/m*(cos(delta)*F_xfw-sin(delta)*F_yfw+F_xr)+v*r;
             1/m*(sin(delta)*F_xfw+cos(delta)*F_yfw+F_yr)-u*r;
             (lf*(sin(delta)*F_xfw+cos(delta)*F_yfw) - lr * F_yr)/Izz;
             (Td-rw*F_xfw-rw*F_xr-80*w)/J];
    
    
%     X_dot = u_*cos(h_)-v_*sin(h_);
%     U_dot = (-f*m*g+Nw*Fx_-F_yf*sin(delta_))/m+v_*r_;
%     Y_dot = u_*sin(h_)+v_*cos(h_);
%     V_dot = (F_yf*cos(delta_)+F_yr)/m-u_*r_;
%     H_dot = r_;
%     R_dot = (F_yf*a*cos(delta_)-F_yr*b)/Iz;
%     
%     x_dot = [X_dot;U_dot;Y_dot;V_dot;H_dot;R_dot];
    
    J_A = vpa(jacobian(x_dot, [x y h u v r w]),3);
    J_B = vpa(jacobian(x_dot, [Td delta]),3);
    
    Ad = eye(length(J_A)) + 0.05*J_A;
    Bd = 0.05*J_B;
    
    Ad_ = matlabFunction(Ad, 'Vars', {[x y h u v r w Td delta]});
    Bd_ = matlabFunction(Bd, 'Vars', {[x y h u v r w Td delta]});
    
    save("dMatrices", 'Ad_', 'Bd_')
    
