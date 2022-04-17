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
dt = 0.05;
parameters = [m Izz J lf lr rw]; 


states = [0;0;0;30;0;-0.2481;60];
delta = [repmat(0.0, 1,50),repmat(0.2, 1, 250)];
T_d = 2000;

i=1;
while 1
    x = states(1);
    y = states(2);
    h = states(3);
    u = states(4);
    v = states(5);
    r = states(6);
    w = states(7);
    
    states = f_cont_fun(states, [inputs_list(1,i); inputs_list(2,i)], parameters)*dt+states;
    
    if mod(i,1)==0
        plot_state([states(1) states(2) states(3)], 'r', 'x_0');
        drawnow
        axis equal
    end
%     end
    hold on
    i = i+1;
    
end
    
    
    
    
    
    