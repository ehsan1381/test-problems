function [solution, relativeRemainder, U] = solvesystem(A, b)
   [U, c] = gausspivot(A, b);

   solution = substitution(U, c);
   relativeRemainder = norm(b - A*solution, 2);
end % function solvesystem



%%%%%%%%%%%
function [ U, c ] = gausspivot(A, b)
    S = [A  b];
    [m, n] = size(A);
    if m~=n
        error("Input matrix is not square.")
    end % if
    M = max(abs(A), [], 2);
    for j=1:n-1
        r = pivot(S, M, j);
        if r~=j
            rep = S(r, :);
            S(r, :) = S(j, :);
            S(j, :) = rep;
            temp = M(r);
            M(r) = M(j);
            M(j) = temp;
        end % if
        for i=j+1:n
            S(i, :) = S(i, :) - (S(i, j)/S(j, j)) * S(j, :);
        end % for
    end % for
    U = S(:, 1:n);
    c = S(:, n+1);

end % function gausspivot


%%%%%%%%%%%%%%
function [solution] = substitution(U, c)
    [m, n] = size(U);
    solution = zeros([m, 1]);
    solution(m) = c(m) / U(m, m);
    for i=n:-1:1
        solution(i) = (c(i) - U(i, i+1:n) * solution(i+1:n)) / U(i, i);
    end % for
end % function substitution

function [pivotIndex] = pivot(S, M, j)
    [m, n] = size(S);
    temp = S(1:m, 1:n-1) ./ M;
    [~, pivotIndex] = max(abs(temp(:, j)));

end % function pivot
