function simulate(states, inputs, dt, params)

    for i=1:length(inputs(:,1))
        states = f_disc_fun(states,inputs(i,:)',dt,params);
        if mod(i,10)==0
            plot_state(states);
            hold on;
        end
    end

end

