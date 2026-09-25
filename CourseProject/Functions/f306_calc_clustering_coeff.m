function C = f306_calc_clustering_coeff(matrix)
% Calculate node clustering coefficient from a connectivity matrix
% Input: matrix - connectivity matrix (Psi2), indexed Psi2(target, trigger)
% Output: C - [n x 1] clustering coefficient per node, between 0 and 1
% Calculation performed by: BCT clustering_coef_bd (directed, binary;
% Fagiolo 2007). Nodes without any triangle get C = 0.

% 1. recording with only 1 neuron in total won't have a valid matrix
if isempty(matrix)
    C = [];
    return;
end


% 2.Convert Psi2 to BCT format: A(i,j) = 1 if i -> j
% - abs: not accounting for excitatory/inhibitory sign
% - transpose: Psi2 rows are targets, BCT rows are sources
% - self connections removed (they would count as triangles)
A = double(abs(matrix).' ~= 0);
A(1:size(A,1)+1:end) = 0;


% 3.Calculate: clustering coefficient
C = clustering_coef_bd(A);

end
