function L = f305_calc_path_length(matrix)
% Calculate node path length from a connectivity matrix
% Input: matrix - connectivity matrix (Psi2), indexed Psi2(target, trigger)
% Output: L - [n x 1] mean shortest (directed) path length from each node
%             to every other node it can reach; NaN if it reaches none
% Calculation performed by: BCT distance_bin (binary shortest paths),
% then averaging each row over reachable nodes (unreachable = inf, excluded)

% 1. recording with only 1 neuron in total won't have a valid matrix
if isempty(matrix)
    L = [];
    return;
end


% 2.Convert Psi2 to BCT format: A(i,j) = 1 if i -> j
% - abs: not accounting for excitatory/inhibitory sign
% - transpose: Psi2 rows are targets, BCT rows are sources
% - self connections removed
A = double(abs(matrix).' ~= 0);
A(1:size(A,1)+1:end) = 0;


% 3.Calculate: shortest path distances, then mean per source node
D = distance_bin(A);
D(1:size(D,1)+1:end) = NaN;    % exclude self
D(isinf(D)) = NaN;             % exclude unreachable nodes
L = mean(D, 2, 'omitnan');

end
