
function u_ = MPC(curr_state, Y, U)
    N = 15;
    num_states = 7;
    num_inputs = 2;
    load dMatrices.mat
    A_lin_fun = Ad_;
    B_lin_fun = Bd_;
    

    x = curr_state(1);
    y = curr_state(2);
    h = curr_state(3);
    u = curr_state(4);
    v = curr_state(5);
    r = curr_state(6);
    w = curr_state(7);


    closest_traj_idx = get_closest([Y(:,1) Y(:,3)]', [x;y]);
    
     
    Y_used = Y(closest_traj_idx:closest_traj_idx+N-1, :);
    U_used = U(closest_traj_idx:closest_traj_idx+N-1, :);

    %% get linearized matrices
    xu_cell = num2cell([Y_used U_used],2);

    A_cell = cellfun(A_lin_fun, xu_cell, 'UniformOutput',false);
    B_cell = cellfun(B_lin_fun, xu_cell, 'UniformOutput',false);

    %% construct offline QP-MPC matrices
    
    W = [];
    
    Q = [10,    0,  0, 0, 0, 0, 0;
         0,    10,  0, 0, 0, 0, 0;
         0,     0, 100, 0, 0, 0, 0;
         0,     0,  0, 10,0, 0, 0;
         0,     0,  0, 0, 0, 0, 0;
         0,     0,  0, 0, 0, 100, 0
         0,     0,  0, 0, 0, 0, 10];
    R = [10, 0;
         0, 100];
     
    Q_bar = blkdiag(1000*kron(eye(N-1),Q),1000*Q);
    R_bar = blkdiag(10*kron(eye(N),R));

    %% MPC formulation 1 loop
    x0 = curr_state';
    options =  optimset('Display','off');

    %% Solve MPC
    
    [S, M, G, T] = construct_QPMPC_mats(A_cell(1:1+N-1), B_cell(1:1+N-1), num_states, num_inputs, N);
    U = qp_mpc(Q_bar, R_bar, S, M, G, T, W, x0' - Y_used(1,:)', options, num_inputs);
% 
%     v_ = U(1:num_inputs,1);
%     u_ = v_ + U_used(1,:)';
    v_ = U;
    u_ = v_ + reshape(U_used',[],1);
    u_ = reshape(u_,2,[])';
    

end


function idx = get_closest(a, b)

    [~,idx] = min(vecnorm(a-b));

end


