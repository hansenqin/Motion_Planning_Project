    clear
    
    m=1400;
    Izz=2667;
    By=0.13*180/pi;
    Cy=1.3;
    Dy=0.7;
    Ey=-1.6;
    Bx=0.20*180/pi;
    Cx=1.3;
    Dx=0.7;
    Ex=-1.6;
    lf=1.4;
    lr=1.4;
    rw=0.5;
    J = 100;
    dt = 0.05;
    g = 9.81;
    parameters = [m Izz J lf lr rw];
    


% 
%     F_zf=lr/(lf+lr)*m*g;
%     F_zr=lf/(lf+lr)*m*g;

    a_f = 0:0.01:0.4;
    a_r = 0:0.01:0.4;
    b_f = 0:0.01:0.4;
    b_r = 0:0.01:0.4;
    
    phi_yf=(1-Ey)*(a_f)+(Ey/By)*atan(By*(a_f));
    phi_yr=(1-Ey)*(a_r)+(Ey/By)*atan(By*(a_r));
    
    phi_xf=(1-Ex)*(b_f)+(Ex/Bx)*atan(Bx*(b_f));
    phi_xr=(1-Ex)*(b_r)+(Ex/Bx)*atan(Bx*(b_r));
      
    F_yfw=Dy*sin(Cy*atan(By*phi_yf));
    F_yr=Dy*sin(Cy*atan(By*phi_yr));
    
    F_xfw=Dy*sin(Cx*atan(Bx*phi_xf));
    F_xr=Dy*sin(Cx*atan(Bx*phi_xr));
    
    plot(a_f, F_yfw, 'r');
    hold on
    plot(b_f, F_xfw, 'b');

    F_yfw = 6.4762*a_f;
    F_yr = 6.4762*a_r;

    F_xfw = 9.95*b_f;
    F_xr = 9.95*b_r;
    
    plot(a_f, F_yfw, 'r');
    plot(b_f, F_xfw, 'b');