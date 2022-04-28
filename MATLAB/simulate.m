function simulate(states, inputs,M1, M2, friction_array)
    m=1400;
    Izz=2667;
    By=0.13*180/pi/6;
    Cy=1.3;
    Dy=0.7*6;
    Ey=-1.6;
    Bx=0.20*180/pi/6;
    Cx=1.3;
    Dx=0.7*6;
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



    subplot(4,1,1)
    ylabel('Y Position (m)')
    xlabel('X Position (m)')
    hold on
    
    subplot(4,1,2);
    speed_plot = plot(0,0,'LineWidth',2);
    ylabel('speed')
    xlabel('X Position (m)')

    subplot(4,1,3);
    hold on
    af_plot = plot(0,0,'LineWidth',2);
    af_ub_plot = plot(0,0,'LineWidth',1, 'LineStyle','--', 'Color','k');
    af_lb_plot = plot(0,0,'LineWidth',1, 'LineStyle','--', 'Color','k');
    ylabel('slip angle')
    xlabel('X Position (m)')

    subplot(4,1,4);
    hold on
    bf_plot = plot(0,0,'LineWidth',2);
    bf_ub_plot = plot(0,0,'LineWidth',1, 'LineStyle','--', 'Color','k');
    bf_lb_plot = plot(0,0,'LineWidth',1, 'LineStyle','--', 'Color','k');
    ylabel('slip ratio')
    xlabel('X Position (m)')

    syms A B C D E x
    MF = D*sin(C*atan(B*x-E*(B*x-atan(B*x))));
    d_MF = diff(MF, x);

    for i=1:length(inputs.TrajectoryKeys)
        curr_inputs_ = M1(inputs.TrajectoryKeys{i});
        curr_traj = [curr_traj; M2(inputs.TrajectoryKeys{i})+[curr_traj(end, 1),curr_traj(end, 2),0,0,0,0,0]];
        curr_inputs = [curr_inputs; [curr_inputs_.Td curr_inputs_.Delta]];
        
    end

    curr_traj = [curr_traj; M2(inputs.TrajectoryKeys{1})+[curr_traj(end, 1),curr_traj(end, 2),0,0,0,0,0]];
    curr_inputs = [curr_inputs; [repmat(3000,35,1) zeros(35,1)]];

    for j=1:length(curr_inputs(:,1))
        
        u_ = MPC(states, curr_traj, curr_inputs);
%         u_ = curr_inputs(j,:);
        u_(1,:)
        curr_mu = friction_array(floor(states(1)/50)+1, floor(abs(states(2)+4)/4)+1);
        if curr_mu == -1
            curr_mu = 0.9;
        end
        disp(curr_mu);

        params = [m; Izz; J; Dy*curr_mu; Cy; By/curr_mu; Ey; Dx*curr_mu; Cx; Bx/curr_mu; Ex; lf; lr; rw]; 

        states = f_disc_fun_MF(states,u_(1,:)',dt,params);
        
        [a_f, a_r, b_f, b_r] = get_slip(states(4), states(5), u_(1,2), states(6), states(7));
        [af_bound, bf_bound] = get_slip_bounds(curr_mu, MF, d_MF);

        subplot(4,1,2);
        speed_plot.XData = [speed_plot.XData, states(1)];
        speed_plot.YData = [speed_plot.YData, states(4)];
        xlim([0, 500])
        ylim([0, 20.0])

        subplot(4,1,3);
        af_plot.XData = [af_plot.XData, states(1)];
        af_plot.YData = [af_plot.YData, a_f];
        af_ub_plot.XData = [af_ub_plot.XData, states(1)];
        af_lb_plot.XData = [af_lb_plot.XData, states(1)];
        af_ub_plot.YData = [af_ub_plot.YData, af_bound];
        af_lb_plot.YData = [af_lb_plot.YData, -af_bound];
        xlim([0, 500])
        ylim([-1, 1])

        subplot(4,1,4);
        bf_plot.XData = [bf_plot.XData, states(1)];
        bf_plot.YData = [bf_plot.YData, b_f];
        bf_ub_plot.XData = [bf_ub_plot.XData, states(1)];
        bf_lb_plot.XData = [bf_lb_plot.XData, states(1)];
        bf_ub_plot.YData = [bf_ub_plot.YData, bf_bound];
        bf_lb_plot.YData = [bf_lb_plot.YData, -bf_bound];
        xlim([0, 500])
        ylim([-1, 1])

        subplot(4,1,1);
        plot_state([states(1) states(2) states(3)], 'r', 'x_0');
        hold on;
        drawnow;
        ylim([-10, 10])

    end
    subplot(4,1,1)
    plot(curr_traj(:,1), curr_traj(:,2), 'LineWidth',2);
    
end


function [af_bound, bf_bound] = get_slip_bounds(mu, MF, d_MF)
    By=0.13*180/pi/6/mu;
    Cy=1.3;
    Dy=0.7*6*mu;
    Ey=-1.6;
    Bx=0.20*180/pi/6/mu;
    Cx=1.3;
    Dx=0.7*6*mu;
    Ex=-1.6;
    syms A B C D E x
    temp_dMF_x = matlabFunction(subs(d_MF, [B C D E], [Bx Cx Dx Ex]));
    temp_dMF_y = matlabFunction(subs(d_MF, [B C D E], [By Cy Dy Ey]));

    f_fun_x = @(x)(temp_dMF_x(x)-temp_dMF_x(0)*0.1)^2;
    f_fun_y = @(x)(temp_dMF_y(x)-temp_dMF_y(0)*0.1)^2;

    options = optimoptions('fsolve','Display','none');

    af_bound = fsolve(f_fun_y, 0.1,options);
    bf_bound = fsolve(f_fun_x, 0.1,options);

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

