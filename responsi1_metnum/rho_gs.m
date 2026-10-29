function rho = rho_gs(A)
% Jari-jari spektral matriks iterasi Gauss-Seidel T = -(D+L)^(-1) U
% Iterasi konvergen jika rho < 1.
    D = diag(diag(A));
    L = tril(A, -1);
    U = triu(A, 1);
    T = -(D + L) \ U;
    rho = max(abs(eig(T)));
end
