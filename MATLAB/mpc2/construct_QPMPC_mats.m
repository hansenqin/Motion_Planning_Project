function [S, M, G, T] = construct_QPMPC_mats(A_cellarray, B_cellarray, num_states, num_inputs, N)
%     This function takes the time varying A and B matirx, evaluated at each
%     point of the trajectory, and compute the matrices needed for QPMPC
% 
%     INPUTS:
%         - A_cellarray: num_states by N cellarray of A matrices
%         - B_cellarray: num_inputs by N cellarray of B matrices
%         - num_states: number of states
%         - num_inputs: number of inputs
%         - N: prediction horizon
 

    S_input = [{zeros(num_states,num_inputs)} A_cellarray'  B_cellarray'];
    S = getS_N50(S_input{:});

    M_input = A_cellarray;
    M = getM_N50(M_input{:});

    G = [S;-S;eye(N*num_inputs);-eye(N*num_inputs)];
    T = [-M;M;zeros(num_inputs*N,num_states);zeros(num_inputs*N,num_states)];
    
end