function density = f301_calc_connectivity_density(matrix)
% Calculate connectivity density from a matrix using absolute values
% Input: matrix - connectivity matrix (Psi2)
% Output: density - connectivity density between 0 and 1
% Calculation performed by: all observed connections(AOC)/all possible
% connections(APC)
% - AOC = sum(abs(1s in Psi2))
% - APC = size of Psi2 (currently self connection is also counted)

% 1. recording with only 1 neuron in total won't have a valid matrix
if isempty(matrix)
    density = NaN;
    return;
end


% 2.Take abs: Not accounting for direction of connections currently
abs_matrix = abs(matrix);


% 3.Calculate: Connectivity density
APC = numel(abs_matrix);
AOC = sum(abs_matrix(:));
density = AOC/APC;


% Ensure density is between 0 and 1
if density>1
 print("got a density value >1, correcting to 1")
 density = 1;

end