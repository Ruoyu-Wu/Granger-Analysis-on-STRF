function CIJ = makefractalCIJ_matched(N, K, E, sz_cl)
% Hierarchical modular (fractal) network with exactly N nodes and K edges
% Same connection probabilities as BCT makefractalCIJ, but
% - N does not need to be a power of 2
% - exactly K edges are placed (makefractalCIJ gives a random K)
%
% Inputs:  N     - number of nodes
%          K     - number of edges (no self connections)
%          E     - connection density fall-off per hierarchical level
%          sz_cl - cluster size is 2^sz_cl (as in makefractalCIJ)
% Output:  CIJ   - [N x N] binary directed matrix, CIJ(i,j) = i -> j
%
% makefractalCIJ: P(i,j) = 1 / E^max(lvl(i,j) - sz_cl, 0), where lvl(i,j)
% is the hierarchical level at which nodes i & j first share a module
% (1 = same pair, 2 = same group of 4, ...). Here the K edges are drawn
% without replacement with weights P(i,j).

arguments
    N (1,1) double
    K (1,1) double
    E (1,1) double = 2
    sz_cl (1,1) double = 2
end

% 1. hierarchical level of every node pair
[j, i] = meshgrid(0:N-1);
lvl = zeros(N);
off = i ~= j;
lvl(off) = floor(log2(double(bitxor(i(off), j(off))))) + 1;

% 2. connection probabilities (no self connections)
P = 1 ./ E.^max(lvl - sz_cl, 0);
P(~off) = 0;

% 3. draw exactly K edges, weighted by P (Efraimidis & Spirakis 2006)
keys = log(rand(N)) ./ P;   % self connections -> -Inf, never drawn
[~, order] = sort(keys(:), 'descend');
CIJ = zeros(N);
CIJ(order(1:K)) = 1;
end
