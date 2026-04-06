function density = f301_calc_connectivity_density(matrix)
% Calculate connectivity density from a matrix using absolute values
% Input: matrix - connectivity matrix (Psi2)
% Output: density - connectivity density between 0 and 1

if isempty(matrix)
    density = NaN;
    return;
end

% Ensure matrix is 2D
if ndims(matrix) > 2
    warning('Matrix has more than 2 dimensions, using first 2 dimensions');
    matrix = matrix(:,:,1);
end

% Take absolute values
abs_matrix = abs(matrix);

% Calculate density (excluding diagonal if square matrix)
if size(abs_matrix, 1) == size(abs_matrix, 2)
    % Square matrix: exclude diagonal (self-connections)
    n_connections = numel(abs_matrix) - size(abs_matrix, 1);
    n_possible = n_connections; % total possible connections excluding diagonal
    n_actual = sum(abs_matrix(:)) - sum(diag(abs_matrix));
else
    % Non-square matrix: include all elements
    n_connections = numel(abs_matrix);
    n_possible = n_connections;
    n_actual = sum(abs_matrix(:));
end

% Calculate density (avoid division by zero)
if n_possible > 0
    density = n_actual / n_possible;
else
    density = 0;
end

% Ensure density is between 0 and 1
if density>1
 print("got a density value >1, correcting to 1")
 density = 1;

end