function simulate(states, inputs,M1, M2)
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
    params = [m; Izz; J; Dy; Cy; By; Ey; Dx; Cx; Bx; Ex; lf; lr; rw]; 
    curr_traj = [0 0 0 0 0 0 0];
    curr_inputs = [];
    figure(2)
    speed_plot = plot(0,0);

    for i=1:length(inputs.TrajectoryKeys)
        curr_inputs_ = M1(inputs.TrajectoryKeys{i});
        curr_traj = [curr_traj; M2(inputs.TrajectoryKeys{i})+[curr_traj(end, 1),curr_traj(end, 2),0,0,0,0,0]];
        curr_inputs = [curr_inputs; [curr_inputs_.Td curr_inputs_.Delta]];
        
    end
    figure(1)
    plot(curr_traj(:,1), curr_traj(:,2))
    hold on

    for j=1:length(curr_inputs(:,1))
        
        u_ = MPC(states, curr_traj, curr_inputs);
%         u_ = curr_inputs(j,:);
        u_(1,:)
        states = f_disc_fun(states,u_(1,:)',dt,params);
        [a_f, a_r, b_f, b_r] = get_slip(states(4), states(5), u_(1,2), states(6), states(7));
        figure(2)
        speed_plot.XData = [speed_plot.XData, dt*j];
        speed_plot.YData = [speed_plot.YData, states(4)];
        xlim([0, dt*j])
        ylim([0, 20.0])

        figure(1)
        plot_state([states(1) states(2) states(3)], 'r', 'x_0');
        hold on;
        drawnow;
        ylim([-10, 10])
%             pause(dt);
    end

end

function [a_f, a_r, b_f, b_r] = get_slip(u, v, delta, r, w)
        lf = 1.4;
        lr = 1.4;
        rw = 0.5;
        
        vf = v + lf*r;
        vr = v - lr*r;
    
    
        uvf = [u; vf];
    
    
        uv_f = rotmat(-delta)*uvf;
        u_f = uv_f(1);
        v_f = uv_f(2);
    
    
        %slip ratio
        b_f=(w+0.0001)/(u_f/rw+0.0001)-1;
        b_r=(w+0.0001)/(u/rw+0.0001)-1;
    
        %slip angle 
        a_f= -atan(v_f/sqrt((u_f+0.05)^2));
        a_r= -atan(vr/sqrt((u+0.05)^2));
end

