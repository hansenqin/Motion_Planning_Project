function [F_yfw_max, F_yr_max, F_xfw_max, F_xr_max]=test_simulate(inputs_list, u1, dt)
    
    m=1400;
    Izz=2667;
    By=0.07*180/pi;
    Cy=1.3;
    Dy=0.7;
    Ey=-1.6;
    Bx=0.27*180/pi;
    Cx=1.3;
    Dx=0.7;
    Ex=-1.6;
    lf=1.35;
    lr=1.45;
    rw=0.5;
    J = 100;
    g = 9.81;
    parameters = [m Izz J lf lr rw]; 
    
    
    states = [0;0;0;u1;0;0;2*u1];
    delta = [repmat(0.0, 1,50),repmat(0.2, 1, 250)];
    T_d = 4000;
    
    
    F_yfw_max = 0;
    F_yr_max = 0;
    F_xfw_max = 0;
    F_xr_max = 0;
    i=1;
    for i=1:length(inputs_list(2,:))
        x = states(1);
        y = states(2);
        h = states(3);
        u = states(4);
        v = states(5);
        r = states(6);
        w = states(7);
        
        vf = v + lf*r;
        vr = v - lr*r;
    
    
        uvf = [u; vf];
        uvr = [u; vr]';
    
    
        uv_f = rotmat(-inputs_list(2,i))*uvf;
        u_f = uv_f(1);
        v_f = uv_f(2);
    
    
        %slip ratio
        b_f=(w+0.0001)/(u_f/rw+0.0001)-1;
        b_r=(w+0.0001)/(u/rw+0.0001)-1;
    
        %slip angle 
        a_f= -atan(v_f/sqrt((u_f+0.05)^2));
        a_r= -atan(vr/sqrt((u+0.05)^2));
    
        %Nonlinear Tire Dynamics
        F_zf=lr/(lf+lr)*m*g;
        F_zr=lf/(lf+lr)*m*g;
        %     
        %     phi_yf=(1-Ey)*(a_f)+(Ey/By)*atan(By*(a_f));
        %     phi_yr=(1-Ey)*(a_r)+(Ey/By)*atan(By*(a_r));
        %     
        %     phi_xf=(1-Ex)*(b_f)+(Ex/Bx)*atan(Bx*(b_f));
        %     phi_xr=(1-Ex)*(b_r)+(Ex/Bx)*atan(Bx*(b_r));
        %     
    
        %     F_yfw=F_zf*Dy*sin(Cy*atan(By*phi_yf));
        %     F_yr=F_zr*Dy*sin(Cy*atan(By*phi_yr));
        %     
        %     F_xfw=F_zf*Dy*sin(Cy*atan(By*phi_xf));
        %     F_xr=F_zr*Dy*sin(Cy*atan(By*phi_xr));
        % 
        F_yfw = F_zf*6.4762*a_f;
        F_yr = F_zr*6.4762*a_r;
    
        F_xfw = F_zf*9.95*b_f;
        F_xr = F_zr*9.95*b_r;
        
        F_yfw_max = max(abs(F_yfw), F_yfw_max);
        F_yr_max = max(abs(F_yr), F_yr_max);
    
        F_xfw_max = max(abs(F_xfw), F_xfw_max);
        F_xr_max = max(abs(F_xr), F_xr_max);
        
        states = f_cont_fun(states, [inputs_list(1,i); inputs_list(2,i)], parameters)*dt+states;
        
        
        if mod(i,1)==0
            plot_state([states(1) states(2) states(3)], 'r', 'x_0');
            states(4)
            drawnow
        end
    %     end
        hold on
        ylim([-10, 10])
        
    end
end
    
    
    
    
    
    