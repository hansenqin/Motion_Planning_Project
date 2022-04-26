function U = qp_mpc(Q_bar, R_bar, S, M, G, T, W, x0, options, num_inputs)
    % This function evaluates the optimizal control sequence and returns
    % the first one


    H = S'*Q_bar*S+R_bar;
    q = S'*Q_bar*M*x0;
    
    % NOTE: QUADPROG WITH CONSTRAINTS CURRENTLY DO NOT WORK DUE TO A BUG.
    %     U = quadprog(H, 2*q', G, W+T*(x0-x_ref),[],[],[],[],[],options);

    U = quadprog(H, 2*q, [], [],[],[],[],[],[],options);
end