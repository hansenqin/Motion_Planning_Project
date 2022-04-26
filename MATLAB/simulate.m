function simulate(states, inputs,M)
    m=1400;
    Izz=2667;
    lf=1.35;
    lr=1.45;
    rw=0.5;
    J = 100;
    dt = 0.1;
    params = [m Izz J lf lr rw]; 

    for i=1:length(inputs.TrajectoryKeys)
        curr_traj = M(inputs.TrajectoryKeys{i});
        curr_inputs = [curr_traj.Td curr_traj.Delta];

        for j=1:length(curr_inputs(:,1))
            states = f_disc_fun(states,curr_inputs(j,:)',dt,params);
            plot_state([states(1) states(2) states(3)], 'r', 'x_0');
            hold on;
            pause(dt);
        end
    end

end

